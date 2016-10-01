package com.example.zhonggou;

import java.util.ArrayList;

import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListView;

import com.example.zhonggou.AnimalListAdapter.AddressClickListener;
import com.example.zhonggou.AsyncUrlRequest.urlCallback;
import com.google.gson.Gson;

@SuppressLint("NewApi")
public class FragmentB extends Fragment implements AddressClickListener {

	private ListView listView;
	Button btn1;
	Button btn2;
	private String[] areas = new String[] {};
	private String[] distance = new String[] {};
	private RadioOnClick radioOnClick = new RadioOnClick(1);
	private int pageindex = 0;

	Gson gson = new Gson();
	private int selecttype = 0;
	private int selectarea = 0;
	private int selectdistance = 0;
	private ArrayList<JsonShopDetailBean> items = new ArrayList<JsonShopDetailBean>();

	boolean isloadarea = false;
	boolean isloaddistance = false;

	private ProgressDialog progress;

	static FragmentB newInstance() {
		FragmentB newFragment = new FragmentB();
		return newFragment;

	}

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		Bundle bundle = getArguments();
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {

		progress = ProgressDialog.show(getActivity(), "", "loading...");
		View view = inflater.inflate(R.layout.fragment2, container, false);

		// select view

		btn1 = (Button) view.findViewById(R.id.selectbtn1);
		btn2 = (Button) view.findViewById(R.id.selectbtn2);
		btn1.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				AlertDialog ad = new AlertDialog.Builder(FragmentB.this
						.getActivity(), R.style.FullScreenDialog)
						.setSingleChoiceItems(areas, radioOnClick.getIndex(),
								radioOnClick).create();
				ad.getListView();
				ad.show();
				selecttype = 0;
			}
		});
		btn2.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				AlertDialog ad = new AlertDialog.Builder(FragmentB.this
						.getActivity(), R.style.FullScreenDialog)
						.setSingleChoiceItems(distance,
								radioOnClick.getIndex(), radioOnClick).create();
				ad.getListView();
				ad.show();
				selecttype = 1;
			}
		});

		// list view

		listView = (ListView) view.findViewById(R.id.locallist_lv);
		listView.setOnScrollListener(new ListView.OnScrollListener() {
			@Override
			public void onScrollStateChanged(AbsListView view, int scrollState) {
			}

			@Override
			public void onScroll(AbsListView view, int firstVisibleItem,
					int visibleItemCount, int totalItemCount) {
				Log.d("selflogout",
						"getLastVisiblePosition "
								+ listView.getLastVisiblePosition());
				Log.d("selflogout", "totalItemCount " + totalItemCount);
				if (totalItemCount > 0) {
					if ((int) listView.getLastVisiblePosition() == (totalItemCount - 1)) {
						pageindex++;
						Log.d("selflogout", "pageindex " + pageindex);
						requestListViewData(pageindex);
					}
				}
			}
		});

		listView.setClickable(true);
		listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
			@Override
			public void onItemClick(AdapterView<?> adapter, View view,
					int position, long arg) {
				Log.i("selflogout", "OnItemClickListener");
				Intent intent = new Intent(getActivity(), WebViewActivity.class);
				JsonShopDetailBean itemData = items.get(position);
				intent.putExtra("shopurl", itemData.getDetailUrl());
				startActivity(intent);
			}
		});

		// 从api读取并加载单选框内容

		AsyncUrlRequest urlreq = new AsyncUrlRequest();
		String urlstrarea = urlreq.loadURL(999, macro.serverURL
				+ "wap/select_api.php?action=industry", new urlCallback() {
			public void urlLoaded(String ustr, int position) {
				isloadarea = true;
				JsonSelectBean status = gson.fromJson(ustr,
						JsonSelectBean.class);
				areas = status.getResult();
				System.out.println("status=" + status.getResult());
				if (isloadarea && isloaddistance) {
					requestListViewData(pageindex);
				}
			}
		});
		String urlstrdistance = urlreq.loadURL(999, macro.serverURL
				+ "wap/select_api.php?action=distance", new urlCallback() {
			public void urlLoaded(String ustr, int position) {
				isloaddistance = true;
				JsonSelectBean status = gson.fromJson(ustr,
						JsonSelectBean.class);
				distance = status.getResult();
				System.out.println("status=" + status.getResult());
				if (isloadarea && isloaddistance) {
					requestListViewData(pageindex);
				}
			}
		});

		return view;
	}

	/**
	 * 点击单选框事件
	 */
	class RadioOnClick implements DialogInterface.OnClickListener {
		private int index;

		public RadioOnClick(int index) {
			this.index = index;
		}

		public void setIndex(int index) {
			this.index = index;
		}

		public int getIndex() {
			return index;
		}

		public void onClick(DialogInterface dialog, int whichButton) {
			setIndex(whichButton);
			onSelectClicked(whichButton);
			dialog.dismiss();
		}
	}

	public void onSelectClicked(int index) {
		if (selecttype == 0) {
			selectarea = index;
		} else if (selecttype == 1) {
			selectdistance = index;
		}

		pageindex = 0;
		items = new ArrayList<JsonShopDetailBean>();
		requestListViewData(pageindex);
	}

	public void requestListViewData(int page) {
		progress.show();
		AsyncUrlRequest urlreq = new AsyncUrlRequest();
		String urlstrarea = urlreq.loadURL(999, macro.serverURL
				+ "wap/coord_api.php?coordx="
				+ LocationManager.getInstance().coordlo + "&coordy="
				+ LocationManager.getInstance().coordla + "&page=" + page
				+ "&industry=" + areas[selectarea] + "&distance="
				+ distance[selectdistance], new urlCallback() {
			public void urlLoaded(String ustr, int position) {
				progress.dismiss();
				JsonShopBean status = gson.fromJson(ustr, JsonShopBean.class);
				if (status.getResult().size() > 0) {
					items.addAll(status.getResult());
					System.out.println("status=" + items);
					setupListView();
				}

			}
		});
	}

	public void setupListView() {
		AnimalListAdapter adapter = new AnimalListAdapter(this.getActivity(),
				items, listView, this);
		listView.setAdapter(adapter);
		adapter.refresh(items);
	}

	@Override
	public void addressclickListener(View v) {
		// TODO Auto-generated method stub
		Log.i("selflogout", "addressclickListener");
		Intent intent = new Intent(getActivity(), MapActivity.class);
		JsonShopDetailBean itemData = items.get((Integer) (v.getTag()));
		intent.putExtra("shopgpsla", itemData.getCoordy());
		intent.putExtra("shopgpslo", itemData.getCoordx());
		startActivity(intent);
	}

	@Override
	public void onDestroy() {
		super.onDestroy();
	}

}

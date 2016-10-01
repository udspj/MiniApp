package com.example.zhonggou;

import java.util.ArrayList;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.example.zhonggou.AsyncImageTask.ImageCallback;

class ViewHolder {
	public ImageView shopicon;
	public TextView shoptitle;
	public TextView shopdescription;
	public TextView shopaddress;
	public TextView shopgps;
	public Button mapbtn;
}

public class AnimalListAdapter extends BaseAdapter implements OnClickListener {

	// 自定义接口，用于回调按钮点击事件到Activity
	public interface AddressClickListener {
		public void addressclickListener(View v);
	}

	private LayoutInflater mInflater = null;
	private ArrayList<JsonShopDetailBean> mList;
	private AsyncImageTask imageTask;
	private ListView listView;
	private AddressClickListener addressListener;

	public AnimalListAdapter(Context context,
			ArrayList<JsonShopDetailBean> list, ListView listView,
			AddressClickListener listener) {
		super();
		mList = list;
		this.listView = listView;
		imageTask = new AsyncImageTask();
		mInflater = (LayoutInflater) context
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		addressListener = listener;
	}

	public void refresh(ArrayList<JsonShopDetailBean> list) {
		mList = list;
		notifyDataSetChanged();
	}

	@Override
	public int getCount() {
		// TODO Auto-generated method stub
		return mList.size();
	}

	@Override
	public Object getItem(int position) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long getItemId(int position) {
		// TODO Auto-generated method stub
		return position;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {

		ViewHolder holder = null;
		if (convertView == null) {
			holder = new ViewHolder();
			convertView = mInflater.inflate(R.layout.user, null);
			holder.shopicon = (ImageView) convertView
					.findViewById(R.id.shopicon);
			holder.shoptitle = (TextView) convertView
					.findViewById(R.id.shoptitle);
			holder.shopdescription = (TextView) convertView
					.findViewById(R.id.shopdescription);
			holder.shopaddress = (TextView) convertView
					.findViewById(R.id.shopaddress);
			holder.shopgps = (TextView) convertView.findViewById(R.id.shopgps);
			holder.mapbtn = (Button) convertView.findViewById(R.id.mapbtn);

			convertView.setTag(holder);
		} else {
			holder = (ViewHolder) convertView.getTag();
		}

		JsonShopDetailBean itemData = mList.get(position);

		holder.shopicon.setImageResource(R.drawable.icon120);
		holder.shoptitle.setText(itemData.getName());
		holder.shopdescription.setText(itemData.getTitle());
		holder.shopaddress.setText(itemData.getAddr());
		holder.shopgps
				.setText(String.valueOf(Math.floor(itemData.getDistance() / 1000))
						+ "m");
		holder.shopicon.setTag(position);
		holder.mapbtn.setOnClickListener(this);
		holder.mapbtn.setTag(position);

		Drawable drawable = imageTask.loadImage(position, itemData.getThumb(),
				new ImageCallback() {
					public void imageLoaded(Drawable image, int position) {
						if (image != null) {
							ImageView imageView = (ImageView) listView
									.findViewWithTag(position);
							if (imageView != null) {
								imageView.setImageDrawable(image);
							}
						}
					}
				});

		holder.shopicon.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				System.out.println("Click on the speaker image on ListItem ");
			}
		});

		return convertView;
	}

	// implements OnClickListener
	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		addressListener.addressclickListener(arg0);
	}

}

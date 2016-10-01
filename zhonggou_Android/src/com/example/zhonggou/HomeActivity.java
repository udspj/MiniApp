package com.example.zhonggou;

import java.util.ArrayList;

import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.BitmapDrawable;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.view.ViewPager;
import android.support.v4.widget.DrawerLayout;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

public class HomeActivity extends FragmentActivity {
	ImageButton backBtn;
	ImageButton moreBtn;
	TextView titleLabel;
	PopupWindow popupWindow;

	private ImageButton tv_tab_1, tv_tab_2, tv_tab_3, tv_tab_4;
	private ViewPager mPager;
	private ArrayList<Fragment> fragmentsList;

	private DrawerLayout drawer_layout;
	private WebView left_drawer;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);

		requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
		setContentView(R.layout.activity_home);
		getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE,
				R.layout.titlebar);

		drawer_layout = (DrawerLayout) findViewById(R.id.drawer_layout);
		left_drawer = (WebView) findViewById(R.id.left_drawer);
		left_drawer.loadUrl("https://www.baidu.com/");
		left_drawer.setWebViewClient(new WebViewClient() {
			@Override
			public boolean shouldOverrideUrlLoading(WebView view, String url) {
				view.loadUrl(url);
				return true;
			}

			@Override
			public void onPageFinished(WebView view, String url) {
				super.onPageFinished(view, url);
			}
		});

		backBtn = (ImageButton) findViewById(R.id.backbtn);
		backBtn.setBackgroundResource(R.drawable.more_btn_icon);
		backBtn.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				drawer_layout.openDrawer(left_drawer);
			}
		});
		titleLabel = (TextView) findViewById(R.id.titlelabel);
		titleLabel.setText("app名称");
		moreBtn = (ImageButton) findViewById(R.id.morebtn);
		moreBtn.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				LayoutInflater layoutInflater = (LayoutInflater) getSystemService(HomeActivity.this.LAYOUT_INFLATER_SERVICE);
				View view = layoutInflater
						.inflate(R.layout.activity_home, null);
				showPopupView(view);
			}
		});

		InitBottomButtons();
		InitViewPagers();

	}

	/**
	 * 获取底栏中的控件并添加监听事件
	 */
	private void InitBottomButtons() {
		tv_tab_1 = (ImageButton) findViewById(R.id.tv_tab_1);
		tv_tab_2 = (ImageButton) findViewById(R.id.tv_tab_2);
		tv_tab_3 = (ImageButton) findViewById(R.id.tv_tab_3);
		tv_tab_4 = (ImageButton) findViewById(R.id.tv_tab_4);

		tv_tab_1.setOnClickListener(new MyOnClickListener(0));
		tv_tab_2.setOnClickListener(new MyOnClickListener(1));
		tv_tab_3.setOnClickListener(new MyOnClickListener(2));
		tv_tab_4.setOnClickListener(new MyOnClickListener(3));
	}

	/**
	 * 初始化ViewPager
	 */
	private void InitViewPagers() {
		// 获取布局中的viewpager控件
		mPager = (ViewPager) findViewById(R.id.vPager);
		// Fragment容器
		fragmentsList = new ArrayList<Fragment>();

		// 生成每个tab对应的fragment
		Fragment fragment1 = FragmentA.newInstance();
		Fragment fragment2 = FragmentB.newInstance();
		Fragment fragment3 = FragmentC.newInstance();
		Fragment fragment4 = FragmentD.newInstance();
		// 添加到Fragment容器中
		fragmentsList.add(fragment1);
		fragmentsList.add(fragment2);
		fragmentsList.add(fragment3);
		fragmentsList.add(fragment4);
		// 给ViewPager添加适配器
		mPager.setAdapter(new MyFragmentPagerAdapter(
				getSupportFragmentManager(), fragmentsList));
		// 设置默认的视图为第0个
		mPager.setCurrentItem(0);
		// 给Viewpager添加监听事件
		// mPager.setOnPageChangeListener(new MyOnPageChangeListener());
	}

	private void showPopupView(View v) {
		LinearLayout layout = new LinearLayout(this);
		layout.setOrientation(LinearLayout.VERTICAL);
		layout.setBackgroundColor(Color.BLACK);

		String[] areas = new String[] { "扫描二维码", "分享好友", "关于我们", "检查新版本" };
		for (int i = 0; i < 4; i++) {
			Button btn = new Button(this);
			btn.setText(areas[i]);
			btn.setBackgroundColor(Color.BLACK);
			btn.setTextColor(Color.WHITE);
			btn.setOnClickListener(new popupOnClickListener(i));
			layout.addView(btn);
		}

		popupWindow = new PopupWindow(layout, 200, 300);

		popupWindow.setFocusable(true);
		popupWindow.setOutsideTouchable(true);
		popupWindow.setBackgroundDrawable(new BitmapDrawable());

		int[] location = new int[2];
		v.getLocationOnScreen(location);

		popupWindow.showAtLocation(v, Gravity.RIGHT | Gravity.TOP, location[0]
				- popupWindow.getWidth(), location[1] + 160);
	}

	/**
	 * 自定义监听类 如此定义监听类，可以实现共用。
	 */
	public class MyOnClickListener implements View.OnClickListener {
		private int index = 0;

		public MyOnClickListener(int i) {
			index = i;
		}

		@Override
		public void onClick(View v) {
			// 设置ViewPager的当前view
			mPager.setCurrentItem(index);
		}
	};

	public class popupOnClickListener implements View.OnClickListener {
		private int index = 0;

		public popupOnClickListener(int i) {
			index = i;
		}

		@Override
		public void onClick(View v) {
			if (index == 0) {
				Log.i("selflogout", "000000");
			} else if (index == 1) {
				Intent intent = new Intent(HomeActivity.this,
						ShareActivity.class);
				startActivity(intent);
			} else if (index == 2) {
				Intent intent = new Intent(HomeActivity.this,
						AboutActivity.class);
				startActivity(intent);
			}
		}
	};

	public interface MyTouchListener {
		public void onTouchEvent(MotionEvent event);
	}

	// 保存MyTouchListener接口的列表
	private ArrayList<MyTouchListener> myTouchListeners = new ArrayList<HomeActivity.MyTouchListener>();

	/**
	 * 提供给Fragment通过getActivity()方法来注册自己的触摸事件的方法
	 * 
	 * @param listener
	 */
	public void registerMyTouchListener(MyTouchListener listener) {
		myTouchListeners.add(listener);
	}

	/**
	 * 提供给Fragment通过getActivity()方法来取消注册自己的触摸事件的方法
	 * 
	 * @param listener
	 */
	public void unRegisterMyTouchListener(MyTouchListener listener) {
		myTouchListeners.remove(listener);
	}

	/**
	 * 分发触摸事件给所有注册了MyTouchListener的接口
	 */
	@Override
	public boolean dispatchTouchEvent(MotionEvent ev) {
		for (MyTouchListener listener : myTouchListeners) {
			listener.onTouchEvent(ev);
		}
		return super.dispatchTouchEvent(ev);
	}
}

package com.example.zhonggou;

import android.content.Context;
import android.util.Log;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;
import com.baidu.mapapi.map.MyLocationData;

public class LocationManager {

	private static LocationManager instance = null;
	LocationClient mLocClient;
	public MyLocationListenner myListener = new MyLocationListenner();
	public float coordla = 0;
	public float coordlo = 0;

	public static LocationManager getInstance() {
		if (instance == null) {
			instance = new LocationManager();
		}
		return instance;
	}

	public void trace() {
		Log.i("selflogout", "ttttrace");
	}

	public void initLocation(Context context) {
		mLocClient = new LocationClient(context);
		mLocClient.registerLocationListener(myListener);
		LocationClientOption option = new LocationClientOption();
		option.setOpenGps(true);
		option.setCoorType("bd09ll"); // 设置坐标类型
		option.setScanSpan(1000);
		mLocClient.setLocOption(option);
		mLocClient.start();
	}

	/**
	 * 定位SDK监听函数
	 */
	public class MyLocationListenner implements BDLocationListener {

		@Override
		public void onReceiveLocation(BDLocation location) {
			MyLocationData locData = new MyLocationData.Builder()
					.accuracy(location.getRadius()).direction(0)
					.latitude(location.getLatitude())
					.longitude(location.getLongitude()).build();
			coordlo = (float) locData.longitude;
			coordla = (float) locData.latitude;
			Log.i("selflogout", String.valueOf(locData.latitude));
			Log.i("selflogout", String.valueOf(locData.longitude));
			Log.i("selflogout", String.valueOf(locData.speed));
			Log.i("selflogout", String.valueOf(locData.direction));
			Log.i("selflogout", String.valueOf(locData.accuracy));
		}

		public void onReceivePoi(BDLocation poiLocation) {
		}
	}
}

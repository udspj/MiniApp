package com.example.zhonggou;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.view.View.OnClickListener;
import android.widget.ImageButton;
import android.widget.TextView;

import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;
import com.baidu.mapapi.SDKInitializer;
import com.baidu.mapapi.map.BaiduMap;
import com.baidu.mapapi.map.BitmapDescriptor;
import com.baidu.mapapi.map.BitmapDescriptorFactory;
import com.baidu.mapapi.map.MapStatus;
import com.baidu.mapapi.map.MapStatusUpdate;
import com.baidu.mapapi.map.MapStatusUpdateFactory;
import com.baidu.mapapi.map.MapView;
import com.baidu.mapapi.map.MarkerOptions;
import com.baidu.mapapi.map.OverlayOptions;
import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.map.MyLocationConfiguration;
import com.baidu.mapapi.map.MyLocationConfiguration.LocationMode;
import com.baidu.mapapi.map.MyLocationData;
import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;

public class MapActivity extends Activity {
	MapView mMapView;
	BaiduMap mBaiduMap;
	ImageButton backBtn;
	TextView titleLabel;
	ImageButton moreBtn;
	
	// 定位相关
	LocationClient mLocClient;
    public MyLocationListenner myListener = new MyLocationListenner();
	
	@Override  
    protected void onCreate(Bundle savedInstanceState) {  
        super.onCreate(savedInstanceState);   

        SDKInitializer.initialize(getApplicationContext());  
        
		requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
        setContentView(R.layout.activity_map); 
        getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE,R.layout.titlebar);

		backBtn = (ImageButton)findViewById(R.id.backbtn);
		backBtn.setOnClickListener(new OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        });
		titleLabel = (TextView)findViewById(R.id.titlelabel);
		titleLabel.setText("");
		moreBtn = (ImageButton)findViewById(R.id.morebtn);
		moreBtn.setVisibility(View.INVISIBLE);
		
      //获取地图控件引用  
        mMapView = (MapView) findViewById(R.id.bmapView);
        
        mBaiduMap = mMapView.getMap();
        mBaiduMap.setMyLocationConfigeration(new MyLocationConfiguration(LocationMode.NORMAL, true, BitmapDescriptorFactory.fromResource(R.drawable.self)));
        
        // 开启定位图层
        mBaiduMap.setMyLocationEnabled(true);
        // 定位初始化
        mLocClient = new LocationClient(this);
        mLocClient.registerLocationListener(myListener);
        LocationClientOption option = new LocationClientOption();
        option.setOpenGps(true);// 打开gps
        option.setCoorType("bd09ll"); // 设置坐标类型
        option.setScanSpan(1000);
        mLocClient.setLocOption(option);
        mLocClient.start();
        
        Intent intent=getIntent();
        LatLng point = new LatLng(intent.getFloatExtra("shopgpsla", (float) 0.0),intent.getFloatExtra("shopgpslo", (float) 0.0));//(39.963175, 116.400244); 
        BitmapDescriptor bitmap = BitmapDescriptorFactory.fromResource(R.drawable.shop); 
        OverlayOptions option1 = new MarkerOptions() .position(point) .icon(bitmap);   
        mBaiduMap.addOverlay(option1);
        
        MapStatus mMapStatus = new MapStatus.Builder()
        .target(point)
        .zoom(12)
        .build();
        MapStatusUpdate mMapStatusUpdate = MapStatusUpdateFactory.newMapStatus(mMapStatus);
        mBaiduMap.setMapStatus(mMapStatusUpdate);
    } 
	 
    @Override  
    protected void onDestroy() {  
        mLocClient.stop();
        mBaiduMap.setMyLocationEnabled(false);
        mMapView.onDestroy();
        mMapView = null;
        super.onDestroy();
    }  
    @Override  
    protected void onResume() {  
        super.onResume();  
        mMapView.onResume();  
        }  
    @Override  
    protected void onPause() {  
        super.onPause();  
        mMapView.onPause();  
        }  
    
    
    /**
     * 定位SDK监听函数
     */
    public class MyLocationListenner implements BDLocationListener {

    	@Override
        public void onReceiveLocation(BDLocation location) {
            MyLocationData locData = new MyLocationData.Builder()
                    .accuracy(location.getRadius())
                    .direction(0).latitude(location.getLatitude())
                    .longitude(location.getLongitude()).build();
            mBaiduMap.setMyLocationData(locData);
        }

        public void onReceivePoi(BDLocation poiLocation) {
        }
    }
}

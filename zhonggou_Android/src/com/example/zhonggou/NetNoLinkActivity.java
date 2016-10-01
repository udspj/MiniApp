package com.example.zhonggou;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.provider.Settings;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
import android.widget.Toast;

public class NetNoLinkActivity extends Activity {

	Button Btn1;
	Button Btn2;
	Button Btn3;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_netnolink);

		Btn1 = (Button) findViewById(R.id.buttonin);
		Btn1.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				if (isConnect(NetNoLinkActivity.this) == false) {
					Toast toast = Toast.makeText(getApplicationContext(),
							"网络未链接，请设置网络链接！", Toast.LENGTH_SHORT);
					toast.show();
				} else {
					Intent intent = new Intent(NetNoLinkActivity.this,
							HomeActivity.class);
					startActivity(intent);
				}
			}
		});

		Btn2 = (Button) findViewById(R.id.buttonnetset);
		Btn2.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				Intent intent = new Intent(
						Settings.ACTION_AIRPLANE_MODE_SETTINGS);
				startActivity(intent);
			}
		});

		Btn3 = (Button) findViewById(R.id.buttonout);
		Btn3.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				Intent intent = new Intent(NetNoLinkActivity.this,
						MainActivity.class);
				intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
				startActivity(intent);
			}
		});
	}

	public static boolean isConnect(Context context) {
		try {
			ConnectivityManager connectivity = (ConnectivityManager) context
					.getSystemService(Context.CONNECTIVITY_SERVICE);
			if (connectivity != null) {
				NetworkInfo info = connectivity.getActiveNetworkInfo();
				if (info != null && info.isConnected()) {
					if (info.getState() == NetworkInfo.State.CONNECTED) {
						return true;
					}
				}
			}
		} catch (Exception e) {
			Log.v("error", e.toString());
		}
		return false;
	}

}

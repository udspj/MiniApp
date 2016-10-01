package com.example.zhonggou;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;

import com.google.gson.Gson;

public class MainActivity extends Activity {

	Button gotoBtn;
	Handler Handler;
	Gson gson = new Gson();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_main);

		gotoBtn = (Button) findViewById(R.id.buttonlogin);
		gotoBtn.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				if (macro.isConnect(MainActivity.this) == false) {
					Log.i("selflogout", "nolink23333");
					Intent intent = new Intent(MainActivity.this,
							NetNoLinkActivity.class);
					startActivity(intent);
				} else {
					Log.i("selflogout", "linked!!!1");
					Intent intent = new Intent(MainActivity.this,
							HomeActivity.class);
					startActivity(intent);
				}
			}
		});

		LocationManager.getInstance().initLocation(getApplication());

	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

}

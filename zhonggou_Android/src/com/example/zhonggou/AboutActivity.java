package com.example.zhonggou;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.ImageButton;
import android.widget.TextView;

public class AboutActivity extends Activity {

	ImageButton backBtn;
	TextView titleLabel;
	ImageButton moreBtn;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);

		requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
		setContentView(R.layout.activity_about);
		getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE,
				R.layout.titlebar);

		backBtn = (ImageButton) findViewById(R.id.backbtn);
		backBtn.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				finish();
			}
		});
		titleLabel = (TextView) findViewById(R.id.titlelabel);
		titleLabel.setText("关于我们");
		moreBtn = (ImageButton) findViewById(R.id.morebtn);
		moreBtn.setVisibility(View.INVISIBLE);
	}

}

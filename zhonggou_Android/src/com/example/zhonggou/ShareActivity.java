package com.example.zhonggou;

import android.app.Activity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.TextView;

public class ShareActivity extends Activity {

	final int mMaxLength = 140;
	ImageButton backBtn;
	TextView titleLabel;
	ImageButton moreBtn;

	EditText editext;
	TextView textlength;
	Button loginbtn;
	Button sendbtn;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);

		requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
		setContentView(R.layout.activity_share);
		getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE,
				R.layout.titlebar);

		backBtn = (ImageButton) findViewById(R.id.backbtn);
		backBtn.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				finish();
			}
		});
		titleLabel = (TextView) findViewById(R.id.titlelabel);
		titleLabel.setText("分享");
		moreBtn = (ImageButton) findViewById(R.id.morebtn);
		moreBtn.setVisibility(View.INVISIBLE);

		loginbtn = (Button) findViewById(R.id.buttonsend);
		loginbtn.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {

			}
		});

		textlength = (TextView) findViewById(R.id.editextlength);
		textlength.setText(0 + "/" + mMaxLength);

		editext = (EditText) findViewById(R.id.edittext);
		editext.addTextChangedListener(new TextWatcher() {
			@Override
			public void onTextChanged(CharSequence s, int start, int before,
					int count) {
				// TODO Auto-generated method stub
				String str = s.toString();
				int length = str.length();
				textlength.setText(length + "/" + mMaxLength);
			}

			@Override
			public void afterTextChanged(Editable arg0) {
				// TODO Auto-generated method stub

			}

			@Override
			public void beforeTextChanged(CharSequence arg0, int arg1,
					int arg2, int arg3) {
				// TODO Auto-generated method stub

			}
		});
	}

}

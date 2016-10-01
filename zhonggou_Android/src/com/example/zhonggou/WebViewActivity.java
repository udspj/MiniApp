package com.example.zhonggou;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ImageButton;
import android.widget.TextView;

public class WebViewActivity extends Activity {

	WebView mWebView;
	ImageButton backBtn;
	TextView titleLabel;
	ImageButton moreBtn;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
		setContentView(R.layout.activity_webview);
		getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE,
				R.layout.titlebar);

		backBtn = (ImageButton) findViewById(R.id.backbtn);
		backBtn.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				finish();
			}
		});
		titleLabel = (TextView) findViewById(R.id.titlelabel);
		titleLabel.setText("");
		moreBtn = (ImageButton) findViewById(R.id.morebtn);
		moreBtn.setVisibility(View.INVISIBLE);

		mWebView = (WebView) findViewById(R.id.webView);

		Intent intent = getIntent();
		if (intent != null) {
			mWebView.loadUrl(intent.getStringExtra("shopurl"));

			WebSettings mWebSettings = mWebView.getSettings();
			mWebSettings.setSupportZoom(true);
			mWebSettings.setLoadWithOverviewMode(true);
			mWebSettings.setUseWideViewPort(true);
			mWebSettings.setDefaultTextEncodingName("GBK");
			mWebSettings.setLoadsImagesAutomatically(true);
		}

		mWebView.setWebViewClient(new WebViewClient() {
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
	}

}

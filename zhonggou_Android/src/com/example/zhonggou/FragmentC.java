package com.example.zhonggou;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class FragmentC extends Fragment {

	WebView mWebView;

	static FragmentC newInstance() {
		FragmentC newFragment = new FragmentC();
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
		WebView mWebView = (WebView) inflater.inflate(R.layout.fragment1,
				container, false);
		mWebView.getSettings().setJavaScriptEnabled(false);
		mWebView.getSettings().setSupportZoom(false);
		mWebView.getSettings().setBuiltInZoomControls(false);
		mWebView.getSettings().setDefaultFontSize(18);
		mWebView.loadUrl("https://www.baidu.com/");
		mWebView.setWebViewClient(new WebViewClient() {
			@Override
			public boolean shouldOverrideUrlLoading(WebView view, String url) {
				view.loadUrl(url);
				return true;
			}
		});

		return mWebView;
	}

	@Override
	public void onDestroy() {
		super.onDestroy();
	}

}

package com.example.zhonggou;

import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;

import android.os.Handler;
import android.os.Message;
import android.util.Log;

public class AsyncUrlRequest {

	public AsyncUrlRequest() {
		super();
	}

	public String loadURL(final int id, final String url,
			final urlCallback callback) {
		final Handler handler = new Handler() {
			public void handleMessage(Message msg) {
				int statusCode = msg.what;
				if (statusCode == 200) {
					String result = msg.obj.toString();
					callback.urlLoaded(result, id);
					Log.i("selflogout", "handler");
					Log.i("selflogout", result);
					// do other business
				} else {
					// throw exception or show error message
				}
			}
		};

		new Thread() {
			@Override
			public void run() {
				String result = "";
				HttpGet httpGet = new HttpGet(url);
				HttpResponse response = null;
				try {
					response = new DefaultHttpClient().execute(httpGet);
				} catch (ClientProtocolException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				int statusCode = response.getStatusLine().getStatusCode();
				if (statusCode == 200) {
					HttpEntity entity = response.getEntity();
					try {
						result = EntityUtils.toString(entity, HTTP.UTF_8);
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				Log.i("selflogout", result);
				Message msg = handler.obtainMessage(statusCode, result);
				msg.sendToTarget();
			}
		}.start();

		return null;
	};

	public interface urlCallback {
		public void urlLoaded(String obj, int id);
	}
}

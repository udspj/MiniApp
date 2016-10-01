package com.example.zhonggou;

import java.io.IOException;
import java.io.InputStream;
import java.lang.ref.SoftReference;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import android.graphics.drawable.Drawable;
import android.os.Handler;
import android.os.Message;

public class AsyncImageTask {

	private Map<String, SoftReference<Drawable>> imageMap;

	public AsyncImageTask() {
		super();
		this.imageMap = new HashMap<String, SoftReference<Drawable>>();
	}

	public Drawable loadImage(final int id, final String imageUrl,
			final ImageCallback callback) {

		// 主线程更新图片
		final Handler handler = new Handler() {
			public void handleMessage(Message message) {
				callback.imageLoaded((Drawable) message.obj, id);
			}
		};

		// 加载图片的线程
		new Thread() {
			public void run() {
				Drawable drawable = AsyncImageTask.loadImageByUrl(imageUrl);
				imageMap.put(imageUrl, new SoftReference<Drawable>(drawable));
				Message message = handler.obtainMessage(0, drawable);
				handler.sendMessage(message);
			}
		}.start();
		return null;
	}

	public static Drawable loadImageByUrl(String imageUrl) {
		URL url = null;
		InputStream inputStream = null;
		try {
			url = new URL(imageUrl);
			inputStream = (InputStream) url.getContent();
			Drawable drawable = Drawable.createFromStream(inputStream, "src");
			return drawable;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (inputStream != null)
					inputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	// 利用接口回调，更新图片UI
	public interface ImageCallback {
		public void imageLoaded(Drawable obj, int id);
	}

}

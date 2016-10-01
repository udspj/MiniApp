package com.example.zhonggou;

import java.util.ArrayList;

public class JsonShopBean {

	protected JsonShopMetaBean meta;
	protected ArrayList<JsonShopDetailBean> result;

	public JsonShopMetaBean getMeta() {
		return meta;
	}

	public void setMeta(JsonShopMetaBean meta) {
		this.meta = meta;
	}

	public ArrayList<JsonShopDetailBean> getResult() {
		return result;
	}

	public void setResult(ArrayList<JsonShopDetailBean> result) {
		this.result = result;
	}
}

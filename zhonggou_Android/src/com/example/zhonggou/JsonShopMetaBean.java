package com.example.zhonggou;

public class JsonShopMetaBean {
	
	protected int status;
	protected String msg;
	protected int total_count;
	protected int page_total;

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	@Override
	public String toString() {
		return "JsonMetaBean [status=" + status + ", msg=" + msg + ", total_count=" + total_count + ", page_total=" + page_total + "]";
	}
}

package com.example.zhonggou;

public class JsonMetaBean {
	
	protected int status;
	protected String msg;

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
		return "JsonMetaBean [status=" + status + ", msg=" + msg + "]";
	}

}

/**
 * 
 */
package com.thinkgem.jeesite.modules.sys.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * @author yu
 *
 */
public class UploadData {
	private String src;
	private String title;
	private String info;
	private String flag;
	private List<String> list = new ArrayList<String>();
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public List<String> getList() {
		return list;
	}

	public void setList(List<String> list) {
		this.list = list;
	}
}

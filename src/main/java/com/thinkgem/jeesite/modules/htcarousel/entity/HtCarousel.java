/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.htcarousel.entity;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 轮播图Entity
 * @author hy
 * @version 2020-03-21
 */
public class HtCarousel extends DataEntity<HtCarousel> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 名称
	private Integer isUse;		// 是否启用
	private String url;		// url
	private String location;		// 轮播位置
	private String photo;		// photo
	private Integer sort;  //排序
	
	public HtCarousel() {
		super();
	}

	public HtCarousel(String id){
		super(id);
	}

	@Length(min=1, max=64, message="名称长度必须介于 1 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@NotNull(message="是否启用不能为空")
	public Integer getIsUse() {
		return isUse;
	}

	public void setIsUse(Integer isUse) {
		this.isUse = isUse;
	}
	
	@Length(min=0, max=1000, message="url长度必须介于 0 和 1000 之间")
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	@Length(min=1, max=5, message="轮播位置长度必须介于 1 和 5 之间")
	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}
	
	@Length(min=1, max=1000, message="photo长度必须介于 1 和 1000 之间")
	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
}
package com.thinkgem.jeesite.modules.sys.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * @Author HY
 * @Description 用户信息拓展表
 * @Date 2020/5/19 14:22
 * @Version 1.0
 */
public class UserExp implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;
    private String lat;//经纬度
    private String lng;//经纬度
    private String jl; //距离
    private String area; //区域
    private String cheer; //助威语
    private String nation;//国家
    private String province; //省
    private String city; //城市
    private String address; //详细地址
    private Date cheerDate;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public String getLng() {
        return lng;
    }

    public void setLng(String lng) {
        this.lng = lng;
    }

    public String getJl() {
        return jl;
    }

    public void setJl(String jl) {
        this.jl = jl;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getCheer() {
        return cheer;
    }

    public void setCheer(String cheer) {
        this.cheer = cheer;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getCheerDate() {
        return cheerDate;
    }

    public void setCheerDate(Date cheerDate) {
        this.cheerDate = cheerDate;
    }
}

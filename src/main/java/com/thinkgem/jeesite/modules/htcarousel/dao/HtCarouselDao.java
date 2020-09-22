/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.htcarousel.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.htcarousel.entity.HtCarousel;

/**
 * 轮播图DAO接口
 * @author hy
 * @version 2020-03-21
 */
@MyBatisDao
public interface HtCarouselDao extends CrudDao<HtCarousel> {
	
}
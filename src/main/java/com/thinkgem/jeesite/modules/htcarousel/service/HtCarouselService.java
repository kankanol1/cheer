/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.htcarousel.service;

import java.util.List;

import com.thinkgem.jeesite.common.utils.CacheUtils;
import com.thinkgem.jeesite.modules.htcarousel.utils.HtCarouselUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.htcarousel.entity.HtCarousel;
import com.thinkgem.jeesite.modules.htcarousel.dao.HtCarouselDao;

/**
 * 轮播图Service
 * @author hy
 * @version 2020-03-21
 */
@Service
@Transactional(readOnly = true)
public class HtCarouselService extends CrudService<HtCarouselDao, HtCarousel> {

	public HtCarousel get(String id) {
		return super.get(id);
	}
	
	public List<HtCarousel> findList(HtCarousel htCarousel) {
		return super.findList(htCarousel);
	}
	
	public Page<HtCarousel> findPage(Page<HtCarousel> page, HtCarousel htCarousel) {
		return super.findPage(page, htCarousel);
	}
	
	@Transactional(readOnly = false)
	public void save(HtCarousel htCarousel) {
		super.save(htCarousel);
		CacheUtils.remove(HtCarouselUtils.CACHE_TpCarousel_MAP);
	}
	
	@Transactional(readOnly = false)
	public void delete(HtCarousel htCarousel) {
		super.delete(htCarousel);
	}
	
}
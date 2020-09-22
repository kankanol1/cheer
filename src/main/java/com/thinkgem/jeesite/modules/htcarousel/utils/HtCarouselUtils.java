package com.thinkgem.jeesite.modules.htcarousel.utils;

import com.thinkgem.jeesite.common.utils.CacheUtils;
import com.thinkgem.jeesite.common.utils.SpringContextHolder;
import com.thinkgem.jeesite.modules.htcarousel.dao.HtCarouselDao;
import com.thinkgem.jeesite.modules.htcarousel.entity.HtCarousel;

import java.util.List;

/**
 * @program: htwsq
 * @description: 轮播图
 * @author: Mr.Wang
 * @create: 2020-03-21 23:19
 **/

public class HtCarouselUtils {
    private static HtCarouselDao tpCarouselDao = SpringContextHolder.getBean(HtCarouselDao.class);
    public static final String CACHE_TpCarousel_MAP = "TpCarousel";


    public static List<HtCarousel> getTpCarouselList(){
        @SuppressWarnings("unchecked")
        List<HtCarousel> list = (List<HtCarousel>) CacheUtils.get(CACHE_TpCarousel_MAP);
        if (list==null){
            HtCarousel tpCarousel = new HtCarousel();
            tpCarousel.setIsUse(1);
            list = tpCarouselDao.findAllList(tpCarousel);
            CacheUtils.put(CACHE_TpCarousel_MAP, list);
        }
        return list;
    }
}

/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.htcarousel.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.htcarousel.entity.HtCarousel;
import com.thinkgem.jeesite.modules.htcarousel.service.HtCarouselService;

/**
 * 轮播图Controller
 * @author hy
 * @version 2020-03-21
 */
@Controller
@RequestMapping(value = "${adminPath}/htcarousel/htCarousel")
public class HtCarouselController extends BaseController {

	@Autowired
	private HtCarouselService htCarouselService;
	
	@ModelAttribute
	public HtCarousel get(@RequestParam(required=false) String id) {
		HtCarousel entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = htCarouselService.get(id);
		}
		if (entity == null){
			entity = new HtCarousel();
		}
		return entity;
	}
	
	/*@RequiresPermissions("htcarousel:htCarousel:view")*/
	@RequestMapping(value = {"list", ""})
	public String list(HtCarousel htCarousel, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<HtCarousel> page = htCarouselService.findPage(new Page<HtCarousel>(request, response), htCarousel); 
		model.addAttribute("page", page);
		return "modules/htcarousel/htCarouselList";
	}

	/*@RequiresPermissions("htcarousel:htCarousel:view")*/
	@RequestMapping(value = "form")
	public String form(HtCarousel htCarousel, Model model) {
		model.addAttribute("htCarousel", htCarousel);
		return "modules/htcarousel/htCarouselForm";
	}

	@RequiresPermissions("htcarousel:htCarousel:edit")
	@RequestMapping(value = "save")
	public String save(HtCarousel htCarousel, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, htCarousel)){
			return form(htCarousel, model);
		}
		htCarouselService.save(htCarousel);
		addMessage(redirectAttributes, "保存轮播图成功");
		return "redirect:"+Global.getAdminPath()+"/htcarousel/htCarousel/?repage";
	}
	
	@RequiresPermissions("htcarousel:htCarousel:edit")
	@RequestMapping(value = "delete")
	public String delete(HtCarousel htCarousel, RedirectAttributes redirectAttributes) {
		htCarouselService.delete(htCarousel);
		addMessage(redirectAttributes, "删除轮播图成功");
		return "redirect:"+Global.getAdminPath()+"/htcarousel/htCarousel/?repage";
	}

}
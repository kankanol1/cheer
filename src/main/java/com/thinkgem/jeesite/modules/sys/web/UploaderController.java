package com.thinkgem.jeesite.modules.sys.web;/**
 * Created by HY on 2018/12/2.
 */

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.web.BaseController;

import com.thinkgem.jeesite.modules.sys.entity.UploadData;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.mp.api.WxMpService;
import org.apache.commons.io.FileUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Map;

/**
 * @program: jeesite
 * @description: 微信
 * @author: Mr.HY
 * @create: 2018-12-02 08:41
 **/
@Controller
@RequestMapping(value = "${adminPath}")
public class UploaderController extends BaseController {

    @Autowired
    private WxMpService wxMpService;

    /*
    * 图片上传
    * */
    @RequestMapping(value = {"uploadFile"})
    @ResponseBody
    public UploadData uploadFileOther(@RequestParam("fileVal")MultipartFile[] test2, HttpServletRequest request, HttpServletResponse response) {
      //  JSONObject object = new JSONObject();

        String str1 = request.getContextPath();

        DateTime dateTime = new DateTime();
        String currentFolder = "/"+dateTime.toString("yyyy-MM") + "/" ;
        String filePath = "";
        String fileNames = "";
        for (MultipartFile multipartFile : test2){
            String myFileName = multipartFile.getOriginalFilename();
            String path = Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + UserUtils.getUser().getId() + (currentFolder != null ? currentFolder : "");
            path.replaceAll( "\\\\ ",   "/");
            File file1 = new File(path);//添加了自动创建目录的功能
            ((File) file1).mkdir();
            //重命名上传后的文件名
            String fileName =myFileName.substring(0,myFileName.lastIndexOf(".")) + "_" + System.currentTimeMillis() + "." + myFileName.substring(myFileName.lastIndexOf(".") + 1);
            filePath += str1+ Global.USERFILES_BASE_URL + UserUtils.getUser().getId() + (currentFolder != null ? currentFolder : "")+fileName;
            filePath.replaceAll( "\\\\ ",   "/");
            fileNames += fileName;
            File targetFile = new File(path, fileName);
            if (!targetFile.exists()) {
                targetFile.mkdirs();
            }

            //保存
            try {
                multipartFile.transferTo(targetFile);
            } catch (Exception e) {
                e.printStackTrace();

            }
        }
        UploadData data = new UploadData();
       // Map<String, String> map = BaiDuVerifyUtil.ImgVerify(filePath);
   /*     if("0".equals(map.get("spam"))){
            data.setSrc(filePath);
        }else {*/
            data.setFlag("0");
            data.setInfo("啥没有");
            data.setSrc(filePath);
       /* }*/
        return  data;
    }
    @RequestMapping(value = {"wxDown"})
    @ResponseBody
    public UploadData uploadFileOther(String ids,Boolean storageLong,HttpServletRequest request){
        String str1 = request.getContextPath();

        //创建图片保存父级路径
        String headUrl=Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL;
        String dateUrl = DateUtils.formatDate(new Date(),"yyyyMM");
        String parUrl = headUrl+(storageLong?"long/":"short/")+dateUrl;
        File file1 = new File(parUrl);//添加了自动创建目录的功能
        if(!file1.exists()){
            file1.mkdirs();
        }

        UploadData data = new UploadData();

        //文件发布路径
        String[] split = ids.split(",");
        for(int i=0;i<split.length;i++){
            try {
                File file = wxMpService.getMaterialService().mediaDownload(split[i]);

                String fileName = split[i]+file.getName().substring(file.getName().lastIndexOf("."));
                String filePath =  str1+ Global.USERFILES_BASE_URL+(storageLong?"long/":"short/")+dateUrl+"/"+fileName;
                File saveFile = new File(parUrl,fileName);
                try {
                    FileUtils.copyFile(file,saveFile);
                    file.delete();
                    data.getList().add(filePath);
                    data.setFlag("1");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } catch (WxErrorException e) {
                e.printStackTrace();
            }
        }

        return data;
    }
}

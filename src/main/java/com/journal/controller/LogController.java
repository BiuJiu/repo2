package com.journal.controller;

import com.github.pagehelper.PageInfo;
import com.journal.bean.InfoDTO;
import com.journal.bean.Log;
import com.journal.bean.User;
import com.journal.service.LogService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

@Controller
public class LogController {
    @Autowired
    private LogService logService;
    @ResponseBody
    @RequestMapping("/log")
    public InfoDTO getLogsToJson(HttpServletRequest req,@RequestParam(value = "pageNumber",defaultValue = "1") Integer pageNumber,
                                 @RequestParam(value = "pageSize",defaultValue = "5") Integer pageSize,
                                 @RequestParam String userid,@RequestParam String keyword){
        System.out.println("pageSize"+pageSize+" keyword "+keyword+" userid "+userid);

        PageInfo<Log> pageInfo = logService.getPageLogs(pageNumber, pageSize,userid,keyword);
        return InfoDTO.success().addData("pageInfo", pageInfo);
    }

    @RequestMapping("/tolog")
    public String toJson(Model model){
        return "admin/log/index";
    }

    @RequestMapping("/addlog")
    public String toinsertlog(Model model){
        return "admin/log/insert";
    }

    @RequestMapping("/log/uploader")
    @ResponseBody
    public InfoDTO uploader(@RequestParam(value="file")MultipartFile pictureFile, HttpServletRequest request, String pOwner)  throws IOException {
        InfoDTO info = new InfoDTO();


        // pictureURL是数据库里picture_url的值，这里用到一个封装的工具类UploadUtil

        String pictureURL= this.imageUpload(pictureFile, request);

        //获取上传时的文件名
        String pictureName = FilenameUtils.getName(pictureFile.getOriginalFilename());

        // 把图片数据保存到数据库

        if (pictureURL != "") {
            System.out.println("上传成功");
            info.setCode("1000");info.setMsg(pictureURL);
            return info;
        }
        System.out.println("上传失败");
        info.setCode("300");
        info.setMsg("上传失败");

        return info;
    }

    public String imageUpload(@RequestParam(value="file") MultipartFile file,HttpServletRequest req){
        // 获取要上传的目标位置，即是项目的upload文件夹所在的绝对路径
        //如果添加了tomcat的虚拟映射路径，需要先新建一个upload文件夹
        HttpSession session = req.getSession();
        String path = session.getServletContext().getRealPath("upload");
        session.setAttribute("logPath",path);
//        File f = new File(path);
//        if(!f.exists()){
//
//        }
        // 获取文件的扩展名
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
        String filename = UUID.randomUUID().toString().replaceAll("-", "")+"."+ ext;
        // 写入文件成功之后，返回的数据，也就是数据库里要存的文件的url
        String src="upload/"+filename;
        File targetFile= new File(path,filename);
        System.out.println(path);
        try {
            if(!targetFile.exists()){
                targetFile.mkdirs();
                //写入文件
                file.transferTo(targetFile);
            }
            return src;
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        //写入文件失败，则返回空字符串
        return "";
    }
    @RequestMapping("/insertLog")
    @ResponseBody
    public InfoDTO insertLog(ServletRequest request, ServletResponse response,Log log){
        System.out.println("插入日志");
        System.out.println("content "+log.getContent()+"title "+log.getTitle()+"userid "+log.getUserid()+"thumbimg "+log.getThumbimg());
        HttpServletRequest req=(HttpServletRequest)request;
        HttpSession session = req.getSession();
        User user=(User) session.getAttribute("USER");
        log.setUserid(user.getId());
        log.setAdd_time(new Date().getTime());
        System.out.println("content "+log.getContent()+"title "+log.getTitle()+"userid "+log.getUserid()+"thumbimg "+log.getThumbimg());
        int res = logService.insertLog(log);
        if(res>0){
           return InfoDTO.success();
        }else{
            return InfoDTO.fail();
        }
    }



    @RequestMapping("/delLog/{id}")
    @ResponseBody
    public InfoDTO delLog(@PathVariable("id") Integer id){

        int res = logService.delLog(id);
        if(res>0){
            return InfoDTO.success();
        }else{
            return InfoDTO.fail();
        }
    }

    @RequestMapping("/toEditLog/{id}")
    @ResponseBody
    public ModelAndView toEditLog(@PathVariable("id") String id){
        Log loginfo = logService.toEditLog(id);
        InfoDTO infoDTO = InfoDTO.success().addData("logoinfo",loginfo);
        System.out.println(loginfo);
        ModelAndView modelAndView = new ModelAndView("admin/log/insert");
        modelAndView.addObject("detail",loginfo);
        return modelAndView;
    }

    @RequestMapping("/updateLog")
    @ResponseBody
    public InfoDTO updateLog(ServletRequest request, ServletResponse response,Log log){
        HttpServletRequest req=(HttpServletRequest)request;
        HttpSession session = req.getSession();
        User user=(User) session.getAttribute("USER");
        log.setUserid(user.getId());
        log.setAdd_time(new Date().getTime());
        int res = logService.updateLog(log);
        if(res>0){
            return InfoDTO.success();
        }else{
            return InfoDTO.fail();
        }
    }


}

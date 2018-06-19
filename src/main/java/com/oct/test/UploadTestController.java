package com.oct.test;

import com.oct.base.util.FileUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UploadTestController {

    @GetMapping("/preUpload")
    public String preUpload(){
        System.out.println(1);
        return "common/index";
    }

    @PostMapping("/testupload")
    @ResponseBody
    public String testupload(@RequestParam("file")MultipartFile file, String name){
        String fileName = file.getName();
        System.out.println(file.getOriginalFilename());
        System.out.println(String.format("filename=%s",fileName));
        System.out.println(String.format("name=%s",name));

       fileName = FileUtil.uploadFile(file,"E://log/");

        return fileName;
    }
}

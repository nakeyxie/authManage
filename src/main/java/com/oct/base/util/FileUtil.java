package com.oct.base.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;

public class FileUtil {
    private static final Logger LOGGER = LoggerFactory.getLogger(FileUtil.class);


    /**
     * 文件上传
     * @param file  文件
     * @param filePath  存储路径
     * @return 返回生成的文件名
     */
    public static String uploadFile(MultipartFile file, String filePath){
        String oldFileName = file.getOriginalFilename();
        String suffix = oldFileName.substring(oldFileName.lastIndexOf("."));
        String newFileName = UUID.getUUID()+suffix;

        File localFile = new File(filePath+File.separator+newFileName);

        try {
            file.transferTo(localFile);
        } catch (IOException e) {
            e.printStackTrace();
            LOGGER.error("文件上传失败--->{}",e);
        }
        return newFileName;
    }
}

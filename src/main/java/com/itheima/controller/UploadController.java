package com.itheima.controller;

import com.itheima.pojo.Result;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@RestController
public class UploadController {

    private static final Logger log = LoggerFactory.getLogger(UploadController.class);

    @PostMapping("/upload")
    public Result upload(MultipartFile file) throws IOException {
        log.info("文件上传: {}", file.getOriginalFilename());

        String uploadDir = "uploads";
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String originalFilename = file.getOriginalFilename();
        String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
        String newFileName = UUID.randomUUID() + ext;

        file.transferTo(new File(dir, newFileName));

        String url = "/uploads/" + newFileName;
        log.info("文件上传成功, url: {}", url);

        return Result.success(url);
    }

}

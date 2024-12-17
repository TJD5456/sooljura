package com.khedu.sooljura.common.vo;

import com.oreilly.servlet.multipart.FileRenamePolicy;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class MyRenamePolicy implements FileRenamePolicy {
    @Override
    public File rename(File originFile) {
        long currentTime = System.currentTimeMillis();
        int ranNum = new Random().nextInt(10000) + 1;
        String str = "_" + String.format("%05d", ranNum);
        String name = originFile.getName();
        String ext = null;
        int dot = name.lastIndexOf(".");

        if (dot != -1) {
            ext = name.substring(dot);
        } else {
            ext = "";
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String fileName = sdf.format(new Date(currentTime)) + str + ext;

        return new File(originFile.getParent(), fileName);
    }
}

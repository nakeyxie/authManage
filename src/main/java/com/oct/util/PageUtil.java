package com.oct.util;

import com.github.pagehelper.PageHelper;

public class PageUtil {

    public static void pageHelperPre(Integer page,Integer limit){
        int start = (page-1)*limit+1;
        PageHelper.startPage(start,limit);
    }
}

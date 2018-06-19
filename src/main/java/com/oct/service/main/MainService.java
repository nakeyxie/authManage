package com.oct.service.main;

import com.oct.dto.response.accessManage.MenuTreeDTO;

import java.util.List;

public interface MainService {

    List<MenuTreeDTO> getMenu(Integer id);

    boolean hasUrlAcl(String servletPath);
}

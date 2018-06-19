package com.oct.service.accessManage;

import com.oct.dto.request.accessManage.RoleParam;
import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.entity.accessManage.SysRole;

import java.util.List;

public interface SysRoleService {

    List<LayUITreeDto> list();

    List<LayUITreeDto> aclList(Integer roleId);

    List<LayUITreeDto> userList(Integer roleId);

    void save(RoleParam param);

    SysRole getById(Integer id);

    void delete(Integer id);
}

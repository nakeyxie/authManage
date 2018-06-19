package com.oct.service.accessManage;

import com.oct.dto.request.accessManage.AclModuleParam;
import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.entity.accessManage.SysAclModule;

import java.util.List;

public interface SysAclModuleService {


    List<LayUITreeDto> list();

    SysAclModule selectById(Integer aclModuleId);

    void save(AclModuleParam param);

    void delete(String aclModuleIds);
}

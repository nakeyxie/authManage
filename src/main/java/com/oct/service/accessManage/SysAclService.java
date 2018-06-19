package com.oct.service.accessManage;

import com.oct.dto.request.accessManage.AclParam;
import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.entity.accessManage.SysAcl;

import java.util.List;

public interface SysAclService {

    List<SysAcl> listByAclModuleId(Integer aclModuleId, Integer page, Integer limit);

    void update(SysAcl acl);

    SysAcl selectById(Integer aclId);

    void saveAcl(AclParam param);

    void delete(String aclIds);


}

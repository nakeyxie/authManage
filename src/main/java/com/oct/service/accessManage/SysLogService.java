package com.oct.service.accessManage;

import com.oct.entity.accessManage.*;
import org.springframework.stereotype.Service;

public interface SysLogService {

    void saveDeptLog(SysDept before, SysDept after);

    void saveUserLog(SysUser before, SysUser after);

    void saveAclModuleLog(SysAclModule before, SysAclModule after) ;

    void saveAclLog(SysAcl before, SysAcl after) ;

    void saveRoleLog(SysRole before, SysRole after);
}

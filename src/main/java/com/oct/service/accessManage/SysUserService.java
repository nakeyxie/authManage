package com.oct.service.accessManage;

import com.oct.dto.request.accessManage.UserParam;
import com.oct.entity.accessManage.SysUser;

import java.util.List;

public interface SysUserService {

    /**
     * 添加用户
     */
    void  saveUser(UserParam param);

    /**
     * 登陆
     */
    SysUser login(String account,String password);

    /**
     * 查询全部用户
     */
    List<SysUser> selectAll();

    /**
     * 根据部门Id查询用户
     */
    List<SysUser> listByDeptId(String deptId,Integer page,Integer limit);

    SysUser selectById(Integer id);

    void update(SysUser user);

    void delete(String userIds);

    List<SysUser> query(String param, Integer page, Integer limit);
}

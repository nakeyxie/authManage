package com.oct.controller.main;

import com.oct.filter.annotation.Auth;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/menu")
public class MenuController {
    /**
     * 跳转到用户管理页
     */
    @GetMapping("/user/preUserList")
    public String preUserList(){
        return "accessManage/user/userList";
    }

    /**
     * 跳转到权限管理页面
     */
    @GetMapping("/cal/preAclManage")
    public String preAclManage(){
        return "accessManage/acl/aclManage";
    }

    /**
     * 跳转到角色管理页面
     */
    @GetMapping("/role/preRoleManage")
    public String preRoleManage(){
        return "accessManage/role/roleManage";
    }

    @GetMapping("/preNoAuth")
    @Auth(verifyLogin=false,verifyUrl=false)
    public String preNoAuth(){
        return "error/noAuth";
    }
}

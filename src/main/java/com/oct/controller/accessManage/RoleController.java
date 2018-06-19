package com.oct.controller.accessManage;

import com.oct.common.JsonResult;
import com.oct.dto.request.accessManage.RoleParam;
import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.filter.annotation.Auth;
import com.oct.service.accessManage.SysRoleAclService;
import com.oct.service.accessManage.SysRoleService;
import com.oct.service.accessManage.SysRoleUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/role")
@Slf4j
public class RoleController {

    @Autowired
    private SysRoleService roleService;
    @Autowired
    private SysRoleAclService roleAclService;
    @Autowired
    private SysRoleUserService roleUserService;

    @GetMapping("/list")
    @ResponseBody
    @Auth(verifyUrl=false)
    public List<LayUITreeDto> list(){
        return roleService.list();
    }

    @GetMapping("/{id}")
    @ResponseBody
    public JsonResult getById(@PathVariable("id") Integer id){
        return JsonResult.success(roleService.getById(id));
    }

    @GetMapping("/aclList")
    @ResponseBody
    @Auth(verifyUrl=false)
    public List<LayUITreeDto> aclList(Integer roleId){
        return roleService.aclList(roleId);
    }

    @GetMapping("/userList")
    @ResponseBody
    @Auth(verifyUrl=false)
    public List<LayUITreeDto> userList(Integer roleId){
        return roleService.userList(roleId);
    }

    @PostMapping("/save")
    @ResponseBody
    public JsonResult save(RoleParam param){
        roleService.save(param);
        return JsonResult.success();
    }
    @DeleteMapping("/delete/{id}")
    @ResponseBody
    public JsonResult delete(@PathVariable("id") Integer id){
        roleService.delete(id);
        return JsonResult.success();
    }

    @PostMapping("/saveRoleAcl")
    @ResponseBody
    public  JsonResult saveRoleAcl(Integer roleId,String aclIds){
        roleAclService.save(roleId,aclIds);
        return JsonResult.success();
    }
    @PostMapping("/saveRoleUser")
    @ResponseBody
    public  JsonResult saveRoleUser(Integer roleId,String userIds){
        roleUserService.save(roleId,userIds);
        return JsonResult.success();
    }
}

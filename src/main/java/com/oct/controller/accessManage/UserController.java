package com.oct.controller.accessManage;

import com.oct.common.JsonResult;
import com.oct.dto.request.accessManage.UserParam;
import com.oct.entity.accessManage.SysUser;
import com.oct.filter.annotation.Auth;
import com.oct.service.accessManage.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {


    @Autowired
    private SysUserService sysUserService;

    @GetMapping("/preUserAdd")
    public String preUserAdd(){
        return "accessManage/user/userAdd";
    }
    @GetMapping("/preAdd")
    public String preAdd(Integer userId, HttpServletRequest request){
        if(userId != null){//修改
            request.setAttribute("user",sysUserService.selectById(userId));
        }
        return "accessManage/user/userAdd";
    }

    @GetMapping("/list/{deptIds}")
    @ResponseBody
    @Auth(verifyUrl=false)
    public JsonResult listByDeptId(@PathVariable("deptIds") String deptIds,Integer page,Integer limit){
        List<SysUser> list = sysUserService.listByDeptId(deptIds,page,limit);
        return JsonResult.successPage(list);
    }

    @PostMapping("/save")
    @ResponseBody
    public JsonResult save(UserParam param){
        sysUserService.saveUser(param);
        return JsonResult.success();
    }

    @PutMapping("/status/{id}")
    @ResponseBody
    public JsonResult updateStatus(@PathVariable("id") Integer id,Integer status){
        SysUser user = SysUser.builder().id(id).status(status).build();
        sysUserService.update(user);
        return JsonResult.success();
    }

    @DeleteMapping("/delete/{userIds}")
    @ResponseBody
    public JsonResult delete(@PathVariable("userIds") String userIds){
        sysUserService.delete(userIds);
        return JsonResult.success();
    }

    @GetMapping("/query/{param}")
    @ResponseBody
    public JsonResult query(@PathVariable("param") String param,Integer page,Integer limit){
        List<SysUser> list = sysUserService.query(param,page,limit);
        return JsonResult.successPage(list);
    }
}

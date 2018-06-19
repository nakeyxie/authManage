package com.oct.controller.accessManage;

import com.oct.common.JsonResult;
import com.oct.dto.request.accessManage.AclModuleParam;
import com.oct.dto.request.accessManage.DeptParam;
import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.filter.annotation.Auth;
import com.oct.service.accessManage.SysAclModuleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/aclModule")
@Slf4j
public class AclModuleController {

    @Autowired
    private SysAclModuleService aclModuleService;

    @GetMapping("/tree")
    @ResponseBody
    @Auth(verifyUrl=false)
    public List<LayUITreeDto> list(){
        return aclModuleService.list();
    }
    @GetMapping("/preAdd")
    public String preAdd(Integer aclModuleId, HttpServletRequest request){
        if(aclModuleId != null){//修改
            request.setAttribute("aclModule",aclModuleService.selectById(aclModuleId));
        }
        return "accessManage/acl/aclModuleAdd";
    }

    @PostMapping("/save")
    @ResponseBody
    public JsonResult save(AclModuleParam param){
        aclModuleService.save(param);
        return JsonResult.success();
    }

    @DeleteMapping("/delete/{aclModuleIds}")
    @ResponseBody
    public JsonResult delete(@PathVariable("aclModuleIds") String aclModuleIds){
        aclModuleService.delete(aclModuleIds);
        return JsonResult.success();
    }
}

package com.oct.controller.accessManage;

import com.oct.common.JsonResult;
import com.oct.dto.request.accessManage.AclParam;
import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.entity.accessManage.SysAcl;
import com.oct.filter.annotation.Auth;
import com.oct.service.accessManage.SysAclService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/acl")
@Slf4j
public class AclController {

    @Autowired
    private SysAclService aclService;

    @GetMapping("/preAdd")
    public String preAdd(Integer aclId, HttpServletRequest request){
        if(aclId != null){//修改
            request.setAttribute("acl",aclService.selectById(aclId));
        }
        return "accessManage/acl/aclAdd";
    }
    @GetMapping("/list/{aclModuleId}")
    @ResponseBody
    @Auth(verifyUrl=false)
    public JsonResult listByAclModuleId(@PathVariable("aclModuleId") Integer aclModuleId, Integer page, Integer limit){
        List<SysAcl> list = aclService.listByAclModuleId(aclModuleId,page,limit);
        return JsonResult.successPage(list);
    }

    @PutMapping("/status/{id}")
    @ResponseBody
    public JsonResult updateStatus(@PathVariable("id") Integer id,Integer status){
        SysAcl acl = SysAcl.builder().id(id).status(status).build();
        aclService.update(acl);
        return JsonResult.success();
    }

    @PostMapping("/save")
    @ResponseBody
    public JsonResult save(AclParam param){
        aclService.saveAcl(param);
        return JsonResult.success();
    }

    @DeleteMapping("/delete/{aclIds}")
    @ResponseBody
    public JsonResult delete(@PathVariable("aclIds") String aclIds){
        aclService.delete(aclIds);
        return JsonResult.success();
    }


}

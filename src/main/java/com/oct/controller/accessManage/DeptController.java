package com.oct.controller.accessManage;

import com.oct.common.JsonResult;
import com.oct.dto.request.accessManage.DeptParam;
import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.filter.annotation.Auth;
import com.oct.service.accessManage.SysDeptService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/dept")
@Slf4j
public class DeptController {

    @Autowired
    private SysDeptService deptService;

    @GetMapping("/tree")
    @ResponseBody
    @Auth(verifyUrl=false)
    public List<LayUITreeDto> list(){
        return deptService.list();
    }

    @GetMapping("/preAdd")
    public String preAdd(Integer deptId, HttpServletRequest request){
        if(deptId != null){//修改
            request.setAttribute("dept",deptService.selectById(deptId));
        }
        return "accessManage/user/deptAdd";
    }

    @PostMapping("/save")
    @ResponseBody
    public JsonResult save(DeptParam dept){
        deptService.save(dept);
        return JsonResult.success();
    }

    @DeleteMapping("/delete/{deptIds}")
    @ResponseBody
    public JsonResult delete(@PathVariable("deptIds") String deptIds){
        deptService.delete(deptIds);
        return JsonResult.success();
    }
}

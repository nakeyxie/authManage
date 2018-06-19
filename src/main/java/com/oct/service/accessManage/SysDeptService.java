package com.oct.service.accessManage;

import com.oct.dto.request.accessManage.DeptParam;
import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.entity.accessManage.SysDept;

import java.util.List;

public interface SysDeptService {
    /**
     * 获取部门树
     */
    List<LayUITreeDto> list();

    SysDept selectById(Integer deptId);

    void save(DeptParam dept);

    void delete(String deptIds);
}

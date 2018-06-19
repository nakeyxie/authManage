package com.oct.service.accessManage.impl;

import com.google.common.base.Preconditions;
import com.oct.common.RequestHolder;
import com.oct.dto.request.accessManage.DeptParam;
import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.entity.accessManage.SysDept;
import com.oct.exception.ParamException;
import com.oct.repository.accessManage.SysDeptMapper;
import com.oct.repository.accessManage.SysUserMapper;
import com.oct.service.accessManage.SysDeptService;
import com.oct.service.accessManage.SysLogService;
import com.oct.util.BeanValidator;
import com.oct.util.IpUtil;
import com.oct.util.tree.LayUiTreeUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
@Slf4j
public class SysDeptServiceImpl implements SysDeptService {

    @Autowired
    private SysDeptMapper sysDeptMapper;
    @Autowired
    private SysLogService sysLogService;
    @Autowired
    private SysUserMapper sysUserMapper;

    /**
     * 获取部门树
     */
    @Override
    public List<LayUITreeDto> list() {
        List<LayUITreeDto> list = sysDeptMapper.selectAll();
        return LayUiTreeUtil.getTree(list);
    }

    @Override
    public SysDept selectById(Integer deptId) {
        return sysDeptMapper.selectByPrimaryKey(deptId);
    }

    /**
     * 添加或修改部门
     */
    @Override
    public void save(DeptParam param) {
        BeanValidator.check(param);
        if(checkExist(param.getParentId(), param.getName(), param.getId())) {
            throw new ParamException("同一层级下存在相同名称的部门");
        }

        SysDept dept = SysDept.builder().name(param.getName()).parentId(param.getParentId())
                .seq(param.getSeq()).remark(param.getRemark()).build();
        dept.setOperator(RequestHolder.getCurrentUser().getUsername());
        dept.setOperateIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()));
        dept.setOperateTime(new Date());

        if(param.getId() == null ){//添加
            sysDeptMapper.insertSelective(dept);
            sysLogService.saveDeptLog(null, dept);
        }else{//修改
            dept.setId(param.getId());
            SysDept before = sysDeptMapper.selectByPrimaryKey(param.getId());
            Preconditions.checkNotNull(before, "待更新的部门不存在");
            sysDeptMapper.updateByPrimaryKeySelective(dept);
            sysLogService.saveDeptLog(before,dept);
        }
    }

    /**
     * 删除部门
     */
    @Override
    public void delete(String deptIds) {
        if(StringUtils.isBlank(deptIds)){
            throw new ParamException("请选择要删除的部门");
        }
        String[] s = deptIds.split(",");
        Integer[] ids = new Integer[s.length];
        for(int i=0;i<s.length;i++){
            ids[i] = Integer.parseInt(s[i]);
        }

        Integer n = sysUserMapper.selectCountByDeptId(ids);
        if(n>0){
            throw new ParamException("部门下存在员工，无法被删除");
        }
        sysDeptMapper.deleteManyByPrimaryKeys(ids);
    }

    private boolean checkExist(Integer parentId, String deptName, Integer deptId) {
        return sysDeptMapper.countByNameAndParentId(parentId, deptName, deptId) > 0;
    }
}

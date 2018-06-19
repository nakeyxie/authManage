package com.oct.repository.accessManage;

import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.entity.accessManage.SysRoleAcl;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public interface SysRoleAclMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysRoleAcl record);

    int insertSelective(SysRoleAcl record);

    SysRoleAcl selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysRoleAcl record);

    int updateByPrimaryKey(SysRoleAcl record);

    List<LayUITreeDto> selectByRoleId(@Param("roleId") Integer roleId);

    List<Integer> selectAclListByRoleIds(@Param("roleIds") List<Integer> roleIds);

    void deleteByRoleId(Integer roleId);

    void batchInsert(@Param("roleAclList") List<SysRoleAcl> roleAclList);

    List<Integer> getAclIdListByRoleIdList(@Param("roleIdList") List<Integer> roleIdList);
}
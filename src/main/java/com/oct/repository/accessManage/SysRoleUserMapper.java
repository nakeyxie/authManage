package com.oct.repository.accessManage;

import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.entity.accessManage.SysRoleUser;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.ibatis.annotations.Param;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public interface SysRoleUserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysRoleUser record);

    int insertSelective(SysRoleUser record);

    SysRoleUser selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysRoleUser record);

    int updateByPrimaryKey(SysRoleUser record);

    List<LayUITreeDto> selectByRoleId(@Param("roleId") Integer roleId);

    List<Integer> selectUserListByRoleIds(@Param("roleIds") List<Integer> roleIds);

    void deleteByRoleId(@Param("roleId") int roleId);

    void batchInsert(@Param("roleUserList") List<SysRoleUser> roleUserList);

    List<Integer> getRoleIdListByUserId(@Param("userId") int userId);
}
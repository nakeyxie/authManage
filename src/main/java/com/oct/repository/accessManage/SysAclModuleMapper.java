package com.oct.repository.accessManage;

import com.oct.dto.query.sys.MenuQueryDto;
import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.entity.accessManage.SysAclModule;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.ibatis.annotations.Param;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SysAclModuleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysAclModule record);

    int insertSelective(SysAclModule record);

    SysAclModule selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysAclModule record);

    int updateByPrimaryKey(SysAclModule record);

    /**
     * 查询全部菜单
     */
    List<MenuQueryDto> selectAll();

    /**
     * 根据UserId查询菜单
     */
    List<MenuQueryDto> selectMenuByUserId(@Param("userId") Integer userId);

    /**
     * layUi树形菜单
     */
    List<LayUITreeDto> selectAllForTree();

    Integer countByNameAndParentId(@Param("parentId") Integer parentId,@Param("name") String name,@Param("id") Integer id);

    Integer queryExistAclByAclModuleIds(@Param("ids") Integer... ids);

    void deleteManyByPrimaryKeys(@Param("ids") Integer[] ids);
}
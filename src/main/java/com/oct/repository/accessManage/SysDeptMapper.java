package com.oct.repository.accessManage;

import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.entity.accessManage.SysDept;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SysDeptMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysDept record);

    int insertSelective(SysDept record);

    SysDept selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysDept record);

    int updateByPrimaryKey(SysDept record);

    List<LayUITreeDto> selectAll();

    /**
     *  查询同一层级下存在相同名称的部门
     */
    int countByNameAndParentId(@Param("parentId") Integer parentId, @Param("name") String name, @Param("id") Integer id);
    /**
     * 批量删除
     */
    int deleteManyByPrimaryKeys(@Param("deptIds") Integer... deptIds);
}
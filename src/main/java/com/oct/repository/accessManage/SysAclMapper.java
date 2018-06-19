package com.oct.repository.accessManage;

import com.oct.entity.accessManage.SysAcl;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SysAclMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysAcl record);

    int insertSelective(SysAcl record);

    SysAcl selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysAcl record);

    int updateByPrimaryKey(SysAcl record);

    List<SysAcl> selectByAclModuleId(Integer aclModuleId);

    int countByNameAndAclModuleId(@Param("aclModuleId") int aclModuleId, @Param("name") String name, @Param("id") Integer id);

    void deleteManyByPrimaryKeys(@Param("ids") Integer... ids);

    List<SysAcl> getByIdList(@Param("idList") List<Integer> idList);
}
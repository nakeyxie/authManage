package com.oct.entity.accessManage;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;

import lombok.*;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * sys_role_acl
 * @author 
 */
@Table(name="sys_role_acl")
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SysRoleAcl implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 角色id
     */
    @NotEmpty
    private Integer roleId;

    /**
     * 权限id
     */
    @NotEmpty
    private Integer aclId;

    /**
     * 操作者
     */
    @NotEmpty
    private String operator;

    /**
     * 最后一次更新的时间
     */
    @NotEmpty
    private Date operateTime;

    /**
     * 最后一次更新者的ip
     */
    @NotEmpty
    private String operateIp;

    private static final long serialVersionUID = 1L;


}
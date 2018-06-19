package com.oct.entity.accessManage;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;

import lombok.*;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * sys_acl
 * @author 
 */
@Table(name="sys_acl")
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SysAcl implements Serializable {
    /**
     * 权限id
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 权限码
     */
    @NotEmpty
    private String code;

    /**
     * 权限名称
     */
    @NotEmpty
    private String name;

    /**
     * 权限所在的权限模块id
     */
    @NotEmpty
    private Integer aclModuleId;

    /**
     * 请求的url, 可以填正则表达式
     */
    @NotEmpty
    private String url;

    /**
     * 类型，1：菜单，2：按钮，3：其他
     */
    @NotEmpty
    private Integer type;

    /**
     * 状态，1：正常，2：冻结
     */
    @NotEmpty
    private Integer status;

    /**
     * 权限在当前模块下的顺序，由小到大
     */
    @NotEmpty
    private Integer seq;

    /**
     * 备注
     */
    private String remark;

    /**
     * 操作者
     */
    @NotEmpty
    private String operator;

    /**
     * 最后一次更新时间
     */
    @NotEmpty
    private Date operateTime;

    /**
     * 最后一个更新者的ip地址
     */
    @NotEmpty
    private String operateIp;

    private static final long serialVersionUID = 1L;

    private String aclModuleName;

}
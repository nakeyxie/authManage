package com.oct.entity.accessManage;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;

import lombok.*;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * sys_role
 * @author 
 */
@Table(name="sys_role")
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SysRole implements Serializable {
    /**
     * 角色id
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotEmpty
    private String name;

    /**
     * 角色的类型，1：管理员角色，2：其他
     */
    @NotEmpty
    private Integer type;

    /**
     * 状态，1：可用，0：冻结
     */
    @NotEmpty
    private Integer status;

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
     * 最后一次更新的时间
     */
    @NotEmpty
    private Date operateTime;

    /**
     * 最后一次更新者的ip地址
     */
    @NotEmpty
    private String operateIp;

    private static final long serialVersionUID = 1L;


}
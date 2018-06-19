package com.oct.entity.accessManage;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;

import lombok.*;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * sys_dept
 * @author 
 */
@Table(name="sys_dept")
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SysDept implements Serializable {
    /**
     * 部门id
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 部门名称
     */
    @NotEmpty
    private String name;

    /**
     * 上级部门id
     */
    @NotEmpty
    private Integer parentId;

    /**
     * 部门层级
     */
    @NotEmpty
    private String level;

    /**
     * 部门在当前层级下的顺序，由小到大
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
     * 最后一次操作时间
     */
    @NotEmpty
    private Date operateTime;

    /**
     * 最后一次更新操作者的ip地址
     */
    @NotEmpty
    private String operateIp;

    private static final long serialVersionUID = 1L;

}
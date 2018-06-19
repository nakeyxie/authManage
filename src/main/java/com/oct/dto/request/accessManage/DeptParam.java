package com.oct.dto.request.accessManage;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.Min;

@Getter
@Setter
@ToString
public class DeptParam {
    /**
     * 部门id
     */
    private Integer id;

    /**
     * 部门名称
     */
    @NotBlank(message = "部门名称不能为空")
    @Length(max = 15, min = 2, message = "部门名称长度需要在2-15个字之间")
    private String name;

    /**
     * 上级部门id
     */
    private Integer parentId = 0;

    /**
     * 部门在当前层级下的顺序，由小到大
     */
    @Min(value = 0,message = "顺序为正整数")
    private Integer seq;

    /**
     * 备注
     */
    @Length(min = 0, max = 200, message = "备注长度需要在200个字以内")
    private String remark;

}

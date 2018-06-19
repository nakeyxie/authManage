package com.oct.dto.response.accessManage;


import lombok.*;
import lombok.experimental.Accessors;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Accessors(chain = true)
public class LayUITreeDto {
    private Integer id;
    private String name;
    private Integer parentId;
    private boolean checked = false;
    private boolean spread = false;
    private List<LayUITreeDto> children;


    private Integer checkedNumber;//数据库查出为1时 checked赋值为true
    private Integer type = 0;//状态值，（例如：查出所有权限时，type=1标记为权限点，为了确保不将权限模块与角色关联）
}

package com.oct.dto.response.accessManage;

import lombok.*;
import lombok.experimental.Accessors;

import java.util.List;

@Getter
@Setter
@ToString
@NoArgsConstructor
@Accessors(chain = true)
public class MenuTreeDTO {

    private String title;
    private String icon;
    private String href;
    private Boolean spread = false;//false关闭true展开
    private List<MenuTreeDTO> children;

}

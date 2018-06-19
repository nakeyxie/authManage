package com.oct.dto.query.sys;

import lombok.*;
import lombok.experimental.Accessors;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@ToString
public class MenuQueryDto {
    private Integer id;
    private String name;
    private String href;
    private String icon;
    private Integer parentId;

}

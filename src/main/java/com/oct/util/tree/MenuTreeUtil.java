package com.oct.util.tree;

import com.oct.common.RequestHolder;
import com.oct.dto.query.sys.MenuQueryDto;
import com.oct.dto.response.accessManage.MenuTreeDTO;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

public class MenuTreeUtil {



    public static List<MenuTreeDTO> getMenuTree(List<MenuQueryDto> data){
        HttpServletRequest request = RequestHolder.getCurrentRequest();
        List<MenuTreeDTO> result = new ArrayList<MenuTreeDTO>();
        List<MenuQueryDto> list = data;
        for(MenuQueryDto m : data){
            if(m.getParentId() == 0){
                List<MenuTreeDTO> childs = getAllChilds(m.getId(),list,request);
                MenuTreeDTO parent = new MenuTreeDTO();
                parent.setChildren(childs).setTitle(m.getName()).setHref(request.getContextPath()+m.getHref()).setIcon(m.getIcon()).setSpread(false);
                result.add(parent);
            }
        }

        return result;
    }
    private static List<MenuTreeDTO> getAllChilds(Integer parentUid,List<MenuQueryDto> data,HttpServletRequest request){
        List<MenuTreeDTO> childs = new ArrayList<MenuTreeDTO>();
        List<MenuQueryDto> list = data;
        for(MenuQueryDto m:data){
            Integer parentUidNew = m.getParentId();
            if(parentUid.equals(parentUidNew)){
                MenuTreeDTO child = new MenuTreeDTO();
                child.setTitle(m.getName()).setHref(request.getContextPath()+m.getHref()).setIcon(m.getIcon()).setSpread(false);
                if(existChild(m.getId(),list)){
                    List<MenuTreeDTO> child_two = getAllChilds(m.getId(), list ,request);
                    child.setChildren(child_two);
                }
                childs.add(child);
            }
        }
        return childs;
    }
    private static boolean existChild(Integer parentUid,List<MenuQueryDto> list){
        for(MenuQueryDto m:list){
            if(parentUid.equals(m.getParentId())){
                return true;
            }
        }
        return false;
    }

}

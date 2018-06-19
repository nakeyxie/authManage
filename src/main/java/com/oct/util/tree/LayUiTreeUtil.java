package com.oct.util.tree;

import com.google.common.collect.Lists;
import com.google.common.collect.Multimap;
import com.oct.dto.response.accessManage.LayUITreeDto;

import java.util.ArrayList;
import java.util.List;

public class LayUiTreeUtil {


    public static List<LayUITreeDto> getTree(List<LayUITreeDto> data){
        List<LayUITreeDto> result = new ArrayList<LayUITreeDto>();
        List<LayUITreeDto> list = data;
        for(LayUITreeDto m : data){
            if(m.getParentId() == 0){
                List<LayUITreeDto> childs = getAllChilds(m.getId(),list,null);
                m.setChildren(childs);
                result.add(m);
            }
        }

        return result;
    }
    private static List<LayUITreeDto> getAllChilds(Integer parentUid, List<LayUITreeDto> data,Multimap<Integer,LayUITreeDto> moduleIdAclMap){
        List<LayUITreeDto> childs = new ArrayList<LayUITreeDto>();
        List<LayUITreeDto> list = data;
        for(LayUITreeDto m:data){
            Integer parentUidNew = m.getParentId();
            if(parentUid.equals(parentUidNew)){

                if(existChild(m.getId(),list)){
                    List<LayUITreeDto> child_two = getAllChilds(m.getId(), list,moduleIdAclMap);
                    m.setChildren(child_two);

                }else {
                    if(moduleIdAclMap != null)  m.setChildren(Lists.newArrayList(moduleIdAclMap.get(m.getId())));
                }
                childs.add(m);
            }
        }
        return childs;
    }
    private static boolean existChild(Integer parentUid,List<LayUITreeDto> list){
        for(LayUITreeDto m:list){
            if(parentUid.equals(m.getParentId())){
                return true;
            }
        }
        return false;
    }

    public static List<LayUITreeDto> getAclTree(List<LayUITreeDto> aclModuleList, Multimap<Integer,LayUITreeDto> moduleIdAclMap) {
        List<LayUITreeDto> result = new ArrayList<LayUITreeDto>();
        List<LayUITreeDto> list = aclModuleList;
        for(LayUITreeDto m : aclModuleList){
            if(m.getParentId() == 0){

                List<LayUITreeDto> childs = getAllChilds(m.getId(),list,moduleIdAclMap);
                m.setChildren(childs);
                if(moduleIdAclMap.get(m.getId()) != null)  m.getChildren().addAll(Lists.newArrayList(moduleIdAclMap.get(m.getId())));
                result.add(m);

            }
        }

        return result;
    }
}

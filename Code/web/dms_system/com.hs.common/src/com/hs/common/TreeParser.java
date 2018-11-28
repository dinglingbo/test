package com.hs.common;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class TreeParser {
	public static <E extends TreeEntity<E>> List<E> getTreeList(String topId, List<E> entityList) {
        List<E> resultList=new ArrayList<E>();
        
        //获取顶层元素集合
        String parentId;
        for (E entity : entityList) {
            parentId=entity.getParentId();
            if(parentId==null||topId.equals(parentId)){
                resultList.add(entity);
            }
        }
        
        //获取每个顶层元素的子数据集合
        for (E entity : resultList) {
            entity.setChildrenMenuTreeNodeList(getSubList(entity.getMenuPrimeKey(),entityList));
        }
        
        return resultList;
    }

	private  static  <E extends TreeEntity<E>>  List<E> getSubList(String id, List<E> entityList) {
        List<E> childList=new ArrayList<E>();
        String parentId;
        
        //子集的直接子对象
        for (E entity : entityList) {
            parentId=entity.getParentId();
            if(id.equals(parentId)){
                childList.add(entity);
            }
        }
        
        //子集的间接子对象
        for (E entity : childList) {
            entity.setChildrenMenuTreeNodeList(getSubList(entity.getMenuPrimeKey(), entityList));
        }
        
        //递归退出条件
        if(childList.size()==0){
            return null;
        }
        
        return childList;
    }
	
	public static <E extends TreeEntity<E>> List<E> clearTree(List<E> entityList){
		boolean ck = false;
		Iterator<E> iter = entityList.iterator();  
		while(iter.hasNext()){  
		    E s = iter.next(); 
		    List<E> list = s.getChildrenMenuTreeNodeList();
		    String linkAction = s.getLinkAction();
		    boolean cl = list == null || list.size()==0;
		    if(linkAction == null) {
		    	if(cl) {
			        iter.remove();
		    	} else {
		    		ck = clearSubList(list);
		    		if(ck) {
				        iter.remove();
		    		}
		    	}
		    } else {
		    	if(cl) {
		    	} else {
		    		ck = clearSubList(list);
		    	}
		    }
		    
		}  
				
		return entityList;
	}
	
	public static <E extends TreeEntity<E>> boolean clearSubList(List<E> entityList){
		List<E> childList=new ArrayList<E>();
		int l = entityList.size();
		
		Iterator<E> iter = entityList.iterator();
		boolean ck = false;
		while(iter.hasNext()){  
		    E s = iter.next(); 
		    List<E> list = s.getChildrenMenuTreeNodeList();
		    String linkAction = s.getLinkAction();
		    boolean cl = list == null || list.size()==0;
		    if(linkAction == null) {
		    	if(cl) {
		    		childList.add(s);
			        iter.remove();
		    	} else {
		    		ck = clearSubList(list);
		    		if(ck) {
		    			childList.add(s);
				        iter.remove();
		    		}
		    	}
		    } else {
		    	if(cl) {
		    	} else {
		    		ck = clearSubList(list);
		    	}
		    }
		    
		}  
		        
        //递归退出条件
        if(childList.size()==l){
            return true;
        }
		
		return false;
	}

	public static void main(String[] args) {
        /*List<Menu> list=new ArrayList<Menu>();
        Menu menu1=new Menu();
        menu1.setMenuPrimeKey("1");
        menu1.setParentId("0");
        menu1.setMenuName("菜单1");
        list.add(menu1);
        
        Menu menu2=new Menu();
        menu2.setMenuPrimeKey("2");
        menu2.setParentId("0");
        menu2.setMenuName("菜单2");
        list.add(menu2);
        
        Menu menu3=new Menu();
        menu3.setMenuPrimeKey("3");
        menu3.setParentId("1");
        menu3.setMenuName("菜单11");
        list.add(menu3);
        
        Menu menu4=new Menu();
        menu4.setMenuPrimeKey("4");
        menu4.setParentId("3");
        menu4.setMenuName("菜单111");
        list.add(menu4);
        
        List<Menu> menus=TreeParser.getTreeList("0",list);
        System.out.println(menus);*/
    }

}

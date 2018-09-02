package com.hsapi.part.common;

import java.util.ArrayList;
import java.util.List;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;
import edu.emory.mathcs.backport.java.util.Arrays;

@Bizlet("")
public class ListUtils {

	@Bizlet("")
	public List<DataObject> appendList(List<DataObject> list, DataObject o) {
	  
		if(list==null){
	    	list = new ArrayList<DataObject>();
		}
		list.add(o);
		

		return list;
	}
	
	@Bizlet("")
	public DataObject[] listToArray(List<DataObject> list) {
		
		int size = list.size();
		DataObject[]  arr = new DataObject[size];
		
		/*for (int i = 0; i < size; i++) {
			arr[i] = list.get(i);
			
		}*/
		arr=list.toArray(arr);
	   
		return arr;
	}
	
	@Bizlet("")
	public List<DataObject> arrayToList(DataObject[] arr) {
		
		List<DataObject> list = Arrays.asList(arr); 
			   
		return list;
	}
	

}

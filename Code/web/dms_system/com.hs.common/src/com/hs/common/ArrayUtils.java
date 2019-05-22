package com.hs.common;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.eos.system.annotation.Bizlet;





import commonj.sdo.DataObject;

@Bizlet("")
public class ArrayUtils {

	@Bizlet("")
	public static DataObject[] add2Array(DataObject sourceDO, DataObject[] dos) {
		List<DataObject> list = new ArrayList<DataObject>(Arrays.asList(dos));
		list.add(sourceDO);
		return list.toArray(new DataObject[list.size()]);
	}

	@Bizlet("")
	public static DataObject[] add2Array(DataObject[] a, DataObject[] b,String compField) {
		List<DataObject> list = new ArrayList<DataObject>(Arrays.asList(a));
		Boolean exists=false;
		for (DataObject dataObject : new ArrayList<DataObject>(Arrays.asList(b))) {
			exists=false;
			if(compField!=null && compField!=""){
				for (DataObject obj : list) {
					if(obj.getString(compField).equals(dataObject.getString(compField))){
						exists=true;
						break;
					}				
				}
			}
			if(!exists){
				list.add(dataObject);
			}
		}

		return list.toArray(new DataObject[list.size()]);
	}
	
	@Bizlet("")
	public static HashMap[] settleMetalSpray(Integer serviceId) {
		DataObject criteria = com.eos.foundation.data.DataObjectUtil
				.createDataObject("com.primeton.das.criteria.criteriaType");
    	criteria.set("_entity", "com.hsapi.repair.data.rps.RpsItem");
    	criteria.set("_expr[1]/serviceId", serviceId);
    	criteria.set("_expr[1]/_op", "=");
    	criteria.set("_expr[2]/billPackageId", 0);
    	criteria.set("_expr[2]/_op", "=");
    	criteria.set("_expr[3]/sourceId", 3);
    	criteria.set("_expr[3]/_op", "=");
    	DataObject[] result = com.eos.foundation.database.DatabaseUtil
    	.queryEntitiesByCriteriaEntity("repair", criteria);
    	
    	if(result.length <= 0) {
    		return null;
    	}else {
    		String itemCode = "";//工单项目编码      XTCZ001002
    		String itemName = "";//工单项目名称      拆装左前保险杠
    		String msCode = "";//项目名称编码 
    		String msName = "";//项目名称
    		String typeCode = "";//维修动作编码
    		ArrayList<HashMap> arrayList = new ArrayList<HashMap>();
    		for(int i=0; i<result.length; i++) {
    			DataObject temp = result[i];
    			itemCode = temp.getString("itemCode");
    			itemName = temp.getString("itemName");
    			msCode = itemCode.substring(7, 10);
    			typeCode = itemCode.substring(4, 7);
    			if(typeCode.equals("005")) {  //喷漆项目
    				msName = itemName.substring(0, itemName.length() - 2);
    			}else {
    				msName = itemName.substring(2, itemName.length());
    			}
    			
    			//判断名称是否已经存在,如果已经存在，更新记录的维修动作或是是否喷漆； 需要钣金的价格，喷漆的价格
    			arrayList = putMSItem(temp, arrayList, msName, msCode, typeCode); 
    		}
    		
    		return arrayList.toArray(new HashMap[arrayList.size()]);
    	}
    	
	}
	
	private static ArrayList putMSItem(DataObject item, ArrayList nameList, String name, String code, String typeCode) {
		//msCode    msName typeCode isPaint 
		//项目名称编码  项目名称  维修动作编码  是否喷漆
		//ido itemIdo itemCodeo itemNameo itemTimeo unitPriceo amto rateo discountAmto  subtotalo    
		// 钣金                                  
		//idt itemIdt itemCodet itemNamet itemTimet unitPricet amtt ratet discountAmtt  subtotalt
		// 喷漆
		boolean check = false;				
		for(int i=0; i< nameList.size(); i++) {
			HashMap nameObj = (HashMap) nameList.get(i);
			boolean isPain = false;
			if(name.equals(nameObj.get("msName"))) {
				check = true;
				//已经存在就更新已有的记录数据   typeCode == 005
				if(typeCode.equals("005")) {
					nameObj.put("idt", item.get("id"));
					nameObj.put("itemIdt", item.get("itemId"));
					nameObj.put("itemCodet", item.get("itemCode"));
					nameObj.put("itemNamet", item.get("itemName"));
					nameObj.put("itemTimet", item.get("itemTime"));
					nameObj.put("unitPricet", item.get("unitPrice"));
					nameObj.put("amtt", item.get("amt"));
					nameObj.put("ratet", item.get("rate"));
					nameObj.put("discountAmtt", item.get("discountAmt"));
					nameObj.put("subtotalt", item.get("subtotal"));
					nameObj.put("isPaint", 1);
					String action =  (String) nameObj.get("typeCode");
					if(action  == null || action.equals("")){
						nameObj.put("typeCode", null);
					}
					
				}else {
					nameObj.put("ido", item.get("id"));
					nameObj.put("itemIdo", item.get("itemId"));
					nameObj.put("itemCodeo", item.get("itemCode"));
					nameObj.put("itemNameo", item.get("itemName"));
					nameObj.put("itemTimeo", item.get("itemTime"));
					nameObj.put("unitPriceo", item.get("unitPrice"));
					nameObj.put("amto", item.get("amt"));
					nameObj.put("rateo", item.get("rate"));
					nameObj.put("discountAmto", item.get("discountAmt"));
					nameObj.put("subtotalo", item.get("subtotal"));
					nameObj.put("typeCode", typeCode);
					//不存在时，已经把“isPaint”设置进去，key不存在没有值的情况
					Integer paint =  (Integer) nameObj.get("isPaint");
					int isnum = paint.intValue();
					if(isnum == 1){
						nameObj.put("isPaint", 1);
					}else{
						nameObj.put("isPaint", 0);
					}
					/*if()

					   {

					            resultKey = str.getValue();

					   }*/
					
				}
				
				nameList.set(i, nameObj);
				
			} else {
				continue;
			}
		}
		
		//不存在则组装数据存入nameList   typeCode == 005
		if(!check) {
			HashMap hm = new HashMap();
			
			if(typeCode.equals("005")) {
				hm.put("msCode", code);
				hm.put("msName", name);
				hm.put("typeCode", null);
				hm.put("idt", item.get("id"));
				hm.put("itemIdt", item.get("itemId"));
				hm.put("itemCodet", item.get("itemCode"));
				hm.put("itemNamet", item.get("itemName"));
				hm.put("itemTimet", item.get("itemTime"));
				hm.put("unitPricet", item.get("unitPrice"));
				hm.put("amtt", item.get("amt"));
				hm.put("ratet", item.get("rate"));
				hm.put("discountAmtt", item.get("discountAmt"));
				hm.put("subtotalt", item.get("subtotal"));
				hm.put("isPaint", 1);
			}else {
				hm.put("msCode", code);
				hm.put("msName", name);
				hm.put("typeCode", typeCode);
				hm.put("ido", item.get("id"));
				hm.put("itemIdo", item.get("itemId"));
				hm.put("itemCodeo", item.get("itemCode"));
				hm.put("itemNameo", item.get("itemName"));
				hm.put("itemTimeo", item.get("itemTime"));
				hm.put("unitPriceo", item.get("unitPrice"));
				hm.put("amto", item.get("amt"));
				hm.put("rateo", item.get("rate"));
				hm.put("discountAmto", item.get("discountAmt"));
				hm.put("subtotalo", item.get("subtotal"));
				hm.put("isPaint", 0);
			}
			nameList.add(hm);
		}
		
		return nameList;
	}
	
	@Bizlet("")
	public static DataObject[] add2ArrayExcludeI(DataObject[] a, DataObject[] b,String columnField) {
		List<DataObject> list = new ArrayList<DataObject>(Arrays.asList(a));
		Boolean exists=false;
		for (DataObject dataObject : new ArrayList<DataObject>(Arrays.asList(b))) {
			exists=false;
			for (DataObject obj : list) {
				if(obj.getInt(columnField) == dataObject.getInt(columnField)){
					exists=true;
					break;
				}				
			}
			if(!exists){
				list.add(dataObject);
			}
		}

		return list.toArray(new DataObject[list.size()]);
	}
	
	@Bizlet("")
	public static Float[] propertyToFloatArr(DataObject[] b,String propertyName) {
		List t = new ArrayList();
		for (DataObject obj : b) {
			Float value = obj.getFloat(propertyName);
			t.add(value);		
		}
		
		return (Float[]) t.toArray(new Float[t.size()]);
	}
	
	@Bizlet("")
	public static Float addFloatColumn(DataObject[] b,String propertyName) {
		float i = 0;
		for (DataObject obj : b) {
			Float value = obj.getFloat(propertyName);
			if(value==null){
				value = (float) 0;
			}
			i = i + value;		
		}
		
		return i;
	}

	@Bizlet("")
	public static double addDoubleColumn(DataObject[] b,String propertyName) {
		double  i = 0;
		for (DataObject obj : b) {
			double value = obj.getDouble(propertyName);
			i =  sumValue(i,value);	
		}
		return i;
	}
	
	//减
	@Bizlet("")
	public static double sub(double v1,double v2){
		BigDecimal b1 = new BigDecimal(Double.toString(v1));
		BigDecimal b2 = new BigDecimal(Double.toString(v2));
		return b1.subtract(b2).doubleValue();
		}
	
	//乘
	@Bizlet("")
	public static double mul(double v1,double v2){
		BigDecimal b1 = new BigDecimal(Double.toString(v1));
		BigDecimal b2 = new BigDecimal(Double.toString(v2));
		return b1.multiply(b2).doubleValue();
		}
	
	//加
	@Bizlet("")
	public static double sumValue(double d1,double d2){
		BigDecimal b1=new BigDecimal(Double.toString(d1));
		BigDecimal b2=new BigDecimal(Double.toString(d2));
		return b1.add(b2).doubleValue();
	}
	
	@Bizlet("")
	public static String[] propertyToStringArr(DataObject[] b,String propertyName) {
		List t = new ArrayList();
		for (DataObject obj : b) {
			String value = obj.getString(propertyName);
			t.add(value);		
		}
		
		return (String[]) t.toArray(new String[t.size()]);
	}
	
	@Bizlet("")
	public static String[] propertyToStringArr(HashMap[] b,String propertyName) {
		List t = new ArrayList();
		for (HashMap h : b) {
			String value = h.get(propertyName).toString();
			t.add(value);		
		}
		
		return (String[]) t.toArray(new String[t.size()]);
	}
	
	@Bizlet("")
	public static String propertyHashToString(HashMap map) {
		String keys = "";
		if(map == null) return "";
		List t = new ArrayList();
		Set set = map.keySet();
		
		for(Iterator iter = set.iterator(); iter.hasNext();){
		   String key = (String)iter.next();
		   if(keys == ""){
			   keys = key;
		   }else{
			   keys += "," + key;
		   }
		}
		
		return keys;
	}
	@Bizlet("")
	public static String[] propertyHashToStringArr(HashMap map) {
		String keys = "";
		if(map == null) return null;
		List t = new ArrayList();
		Set set = map.keySet();
		
		for(Iterator iter = set.iterator(); iter.hasNext();){
		   String key = (String)iter.next();
		   t.add(key);
		}
		return (String[]) t.toArray(new String[t.size()]);
	}
	
	@Bizlet("")
	public static String longArray2String(long[] ids) {
		StringBuilder sb = new StringBuilder();
		long l = 0L;
		for (int i = 0; i < ids.length; i++) {
			l = ids[i];
			sb.append(String.valueOf(l));
			if (i < ids.length - 1) {
				sb.append(",");
			}
		}
		return sb.toString();
	}
	
	@Bizlet("")
	public static String judgeExists(DataObject[] a, DataObject[] b,String compField, String promptField) {
		//判断a的对象有没有在b中
		String promptStr = null;
		List<DataObject> list = new ArrayList<DataObject>(Arrays.asList(a));
		for (DataObject dataObject : new ArrayList<DataObject>(Arrays.asList(b))) {
			for (DataObject obj : list) {
				if(obj.getString(compField).equals(dataObject.getString(compField))){
					promptStr += dataObject.getString(promptField) + ';';
					break;
				}				
			}
		}

		return promptStr;
	}
	
	@Bizlet("")
	public static Object[] add2PojoArray(Object[] a, Object[] b) {
		List<Object> list = new ArrayList<Object>(Arrays.asList(a));
		Boolean exists=false;
		for (Object dataObject : new ArrayList<Object>(Arrays.asList(b))) {
			list.add(dataObject);
		}
		
		// 临时集合
	    List listTemp = new ArrayList();
	    for (int i = 0;i < list.size(); i++) {
	     // 保存不为空的元素	      
	    
	      if (list.get(i) != null) {
	        listTemp.add(list.get(i));
	      }
	    }

		return listTemp.toArray(new Object[listTemp.size()]);
	}
	
	@Bizlet("")
	public static Object[] add2PojoArray(Object sourceDO, Object[] dos) {
		List<Object> list = new ArrayList<Object>(Arrays.asList(dos));
		list.add(sourceDO);
		return list.toArray(new Object[list.size()]);
	}
	
	@Bizlet("")
	public static Object[] concatArray(List a) {
		// 临时集合
	    List listTemp = new ArrayList();
	    
		for (int i = 0;i < a.size(); i++) {
	      if (a.get(i) != null) {
	    	  List<Object> l = (List<Object>) a.get(i);
	    	  for (int j = 0;j < l.size(); j++) {
    	      if (l.get(j) != null) {
    	    	  listTemp.add(l.get(j));
    	      }
    	    }
	      }
	    }
		
		return listTemp.toArray(new Object[listTemp.size()]);
	}
	
	@Bizlet("")
	public static Object[] moveArrayOfEL(Object[] dos, int s, int e) {
		Object o = dos[s];
		dos[s] = dos[e];
		dos[e] = o;
		return dos;
	}
	
	@Bizlet("")
	public static Object[] remove(Object[] pros, Integer index) {

		List<Object> list = new ArrayList<Object>(Arrays.asList(pros));
		
		list.remove(list.get(index));
		return list.toArray(new Object[list.size()]);
	}
	@Bizlet("")
	public List propertyToArrEntity(Object[] b,String propertyName) {
		List t = new ArrayList();
		for (Object obj : b) {
			Object o = this.getFieldValueByName(propertyName, obj);
			
			t.add(o);		

		}
		
		return t;
	}
	
	/** 
	 * ����������ȡ����ֵ 
	 * */  
	   private Object getFieldValueByName(String fieldName, Object o) {  
	       try {    
	           String firstLetter = fieldName.substring(0, 1).toUpperCase();    
	           String getter = "get" + firstLetter + fieldName.substring(1);    
	           Method method = o.getClass().getMethod(getter, new Class[] {});    
	           Object value = method.invoke(o, new Object[] {});    
	           return value;    
	       } catch (Exception e) {  
	    	   System.out.println(e.getMessage()); 
	           return null;    
	       }    
	   }   
	     
	   /** 
	    * ��ȡ���������� 
	    * */  
	   @Bizlet("")
	   private String[] getFiledName(Object o){  
	    Field[] fields=o.getClass().getDeclaredFields();  
	        String[] fieldNames=new String[fields.length];  
	    for(int i=0;i<fields.length;i++){  
	        System.out.println(fields[i].getType());  
	        fieldNames[i]=fields[i].getName();  
	    }  
	    return fieldNames;  
	   }  
	     
	   /** 
	    * ��ȡ��������(type)��������(name)������ֵ(value)��map��ɵ�list 
	    * */  
	   @Bizlet("")
	   private List getFiledsInfo(Object o){  
		    Field[] fields=o.getClass().getDeclaredFields();  
		        String[] fieldNames=new String[fields.length];  
		        List list = new ArrayList();  
		        Map infoMap=null;  
		    for(int i=0;i<fields.length;i++){  
		        infoMap = new HashMap();  
		        infoMap.put("type", fields[i].getType().toString());  
		        infoMap.put("name", fields[i].getName());  
		        infoMap.put("value", getFieldValueByName(fields[i].getName(), o));  
		        list.add(infoMap);  
		    }  
		    return list;  
	   }  
	     
	   /** 
	    * ��ȡ�������������ֵ������һ���������� 
	    * */  
	   @Bizlet("")
	   public Object[] getFiledValues(Object o){  
		    String[] fieldNames=this.getFiledName(o);  
		    Object[] value=new Object[fieldNames.length];  
		    for(int i=0;i<fieldNames.length;i++){  
		        value[i]=this.getFieldValueByName(fieldNames[i], o);  
		    }  
		    return value;  
	   } 
	   
	   
	   @Bizlet("")
		public static Long getColumnValue(String entityName, String column, HashMap p) {

			DataObject cond = com.eos.foundation.data.DataObjectUtil
					.createDataObject("com.primeton.das.criteria.criteriaType");
			cond.set("_entity", entityName);
			cond.set("_expr[1]/iCompcode", p.get("iCompcode"));
			cond.set("_expr[1]/_op", "=");
			cond.set("_expr[2]/iYear", p.get("iYear"));
			cond.set("_expr[2]/_op", "=");
			
			//Date d = com.eos.foundation.common.utils.DateUtil.getJVMDate();
			//String dt = com.eos.foundation.common.utils.DateUtil.format(d, "yyyy-MM-dd");
			
			//cond.set("_expr[2]/_min", dt);
			//cond.set("_expr[2]/_pattern", "yyyy-MM-dd");
			
			cond.set("_select/_field", column);

			DataObject[] result = com.eos.foundation.database.DatabaseUtil
					.queryEntitiesByCriteriaEntity("budget", cond);

			if (result != null && result.length > 0) {
				Long tk = result[0].getLong(column);
				//String tk = result[0].getString("max_" + maxColumn);
				//String t = String.format("%5d", (Long.parseLong(tk.substring(15) + 1)));
				//return tk.substring(0, 15) + t;
				return tk;
			} else {
				return null;
			}

		}
	   
	   
	   @Bizlet("")
		public static HashMap[] add2Array(HashMap sourceDO, HashMap[] dos) {
			List<HashMap> list = new ArrayList<HashMap>(Arrays.asList(dos));
			list.add(sourceDO);
			return list.toArray(new HashMap[list.size()]);
		}
	   
	   @Bizlet("")
		public static HashMap[] add2Array(HashMap sourceDO, HashMap[] dos,int index) {
			List<HashMap> list = new LinkedList<HashMap>(Arrays.asList(dos));
			list.add(index,sourceDO);
			return list.toArray(new HashMap[list.size()]);
		}
	   
	   @Bizlet("")
		public static boolean checkIntValue(DataObject a, DataObject[] b,String columnField) {
			Boolean exists=false;
			for (DataObject dataObject : new ArrayList<DataObject>(Arrays.asList(b))) {
				exists=false;
				if(a.getInt(columnField) == dataObject.getInt(columnField)){
					exists=true;
					break;
				}	
			}

			return exists;
		}
	   
	   @Bizlet("")
		public static boolean checkStringValue(DataObject a, DataObject[] b,String columnField) {
			Boolean exists=false;
			for (DataObject dataObject : new ArrayList<DataObject>(Arrays.asList(b))) {
				exists=false;
				if(a.getString(columnField).equals(dataObject.getString(columnField))){
					exists=true;
					break;
				}	
			}

			return exists;
		}
	   
	   
	   @Bizlet("")
		public static String[] str2Array(String str, String splitFlag) {
		   if(str != null && str != ""){
			   if(splitFlag != null && splitFlag != ""){
				   String[] arr = str.split(splitFlag);

			       return arr; 
			   }else{
				   return null;
			   }
		   }

		   return null;
		}
	   

}


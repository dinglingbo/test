package com.hsapi.cloud.part.common;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
			for (DataObject obj : list) {
				if(obj.getString(compField).equals(dataObject.getString(compField))){
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
			i = i + value;		
		}
		
		return i;
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
	   
	  

}

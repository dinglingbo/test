package com.harsons.hscp.common.util;

import java.util.Arrays;
import java.util.Collection;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;
import java.util.stream.Collectors;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.springframework.util.ObjectUtils;
//import org.springframework.util.comparator.Comparators;

/**
 * 字符串操作工具类
 * 
 */
public class StringUtils {

    public static String toString(Object str) {
        return str == null ? "" : String.valueOf(str);
    }
    
    /**
     * 判断传入的字符串是否为{@code null}
     */
    public static boolean isNull(Object str) {
        return str == null;
    }

    /**
     * 判断传入的字符串是否不为{@code null}
     */
    public static boolean isNotNull(Object str) {
        return !isNull(str);
    }

    /**
     * 判断传入的字符串是否为空串
     */
    public static boolean isEmpty(Object str) {
        if (str == null)
            return true;
        else
            return toString(str).equals("");
    }

    /**
     * 判断传入的字符串是否不为空串
     */
    public static boolean isNotEmpty(Object str) {
        return !isEmpty(str);
    }

    /**
     * 判断指定的对象是否为空白字符串。
     * 
     * 空白字符串的标准是： 1) null; 2) 空字符串（""）; 3) 只包空白字符，不包含任何可见字符
     */
    public static boolean isBlank(Object str) {
        if (str == null)
            return true;
        else
            return toString(str).trim().equals("");
    }

    /**
     * 判断指定的对象是否不为空白字符串。
     * 
     */
    public static boolean isNotBlank(Object str) {
        return !isBlank(str);
    }
    
    /**
     * 判断指定的列表中是否有空字串符Null
     */
    public static boolean hasNull(Object[] objs) {
        return hasNull(Arrays.asList(objs));
    }
    
    /**
     * 判断指定的列表中是否有空字串符Null
     */
    public static boolean hasNull(Collection<?> objs) {
        if (objs == null)
            return true;

        for (Object obj : objs) {
            if (obj == null) {
                return true;
            }
        }

        return false;
    }
      
    /**
     * 判断指定的列表中是否有空字符串
     */
    public static boolean hasEmpty(Object[] objs) {
        if (objs == null)
            return true;
        
        return hasEmpty(Arrays.asList(objs));
    }

    /**
     * 判断指定的列表中是否有空字符串
     */
    public static boolean hasEmpty(Collection<?> objs) {
        if (objs == null)
            return true;

        for (Object obj : objs) {
            if (isEmpty(obj)) {
                return true;
            }
        }

        return false;
    }

    /**
     * 判断指定的列表中是否有空白字符串
     */
    public static boolean hasBlank(Object[] objs) {
        if (objs == null)
            return true;
        
        return hasBlank(Arrays.asList(objs));
    }
    
    /**
     * 判断指定的列表中是否有空白字符串
     */
    public static boolean hasBlank(Collection<?> objs) {
        if (objs == null)
            return true;

        for (Object obj : objs) {
            if (isBlank(obj)) {
                return true;
            }
        }

        return false;
    }

    /**
     * 判断指定的列表中是否有指定的字符串，不忽略大小写
     */
    public static boolean hasStr(Object[] objs, String str) {
        if (objs == null || str == null)
            return false;
        
        return hasStr(Arrays.asList(objs), str);
    }
    
    /**
     * 判断指定的列表中是否有指定的字符串，不忽略大小写
     */
    public static boolean hasStr(Collection<?> objs, String str) {
        if (objs == null || str == null)
            return false;

        for (Object obj : objs) {
            if (str.equals(toString(obj))) {
                return true;
            }
        }

        return false;
    }
    
    /**
     * 判断指定的列表中是否有指定的字符串，忽略大小写
     */
    public static boolean hasText(Object[] objs, String str) {
        if (objs == null || str == null)
            return false;
        
        return hasText(Arrays.asList(objs), str);
    }
    
    /**
     * 判断指定的列表中是否有指定的字符串，忽略大小写
     */
    public static boolean hasText(Collection<?> objs, String str) {
        if (objs == null || str == null)
            return false;

        for (Object obj : objs) {
            if (str.equalsIgnoreCase(toString(obj))) {
                return true;
            }
        }

        return false;
    }

    /**
     * 转换列表为指定分隔符分隔的字符串
     */
    public static String join(Collection<?> list, String delim, String prefix, String suffix, boolean ignoreNull) {
        if (CollectionUtils.isEmpty(list)) {
            return "";
        }
        
        delim = delim == null ? "" : delim;
        prefix = prefix == null ? "" : prefix;
        suffix = suffix == null ? "" : suffix;
        
        Collection<?> sortList;
        try {
            sortList = list.stream()
                    .sorted()
                    .collect(Collectors.toList());//Comparators.nullsLow()
        } catch (Exception e) {
            // the list sort failed. ignore and continue 
            sortList = list;
        }
        
        StringBuilder sb = new StringBuilder();
        for (Object obj : sortList) {
            if (obj == null && ignoreNull)
                continue;
            
            if (sb.length() > 0) {
                sb.append(",");
            }
            
            sb.append(prefix);
            
            if (obj instanceof Collection) {
                sb.append(join((Collection<?>)obj,  delim, prefix, suffix, ignoreNull));
            } else if (obj instanceof Object[]) {
                sb.append(join((Object[])obj,  delim, prefix, suffix, ignoreNull));
            } else if (obj instanceof Map) {
                sb.append("{");
                sb.append(join((Map<?, ?>)obj, delim, prefix, suffix, ignoreNull));
                sb.append("}");
            } else {
                sb.append(ObjectUtils.nullSafeToString(obj));
            }
            
            sb.append(suffix);
        }
        
        return sb.toString();
    }

    /**
     * 转换列表为指定分隔符分隔的字符串
     */
    public static String join(Collection<?> list, String delim, String prefix, String suffix) {
        return join(list, delim, prefix, suffix, false);
    }

    /**
     * 转换列表为指定分隔符分隔的字符串
     */
    public static String join(Collection<?> list, String delim) {
        return join(list, delim, "", "");
    }

    /**
     * 转换列表为逗号分隔符分隔的字符串
     */
    public static String join(Collection<?> list) {
        return join(list, ",");
    }

    /**
     * 转换数组为指定分隔符分隔的字符串
     */
    public static String join(Object[] arr, String delim, String prefix, String suffix, boolean ignoreNull) {
        return join(Arrays.asList(arr), delim, prefix, suffix, ignoreNull);
    }

    /**
     * 转换数组为指定分隔符分隔的字符串
     */
    public static String join(Object[] arr, String delim, String prefix, String suffix) {
        return join(arr, delim, prefix, suffix, false);
    }

    /**
     * 转换数组为指定分隔符分隔的字符串
     */
    public static String join(Object[] arr, String delim) {
        return join(arr, delim, "", "");
    }

    /**
     * 转换数组为逗号分隔符分隔的字符串
     */
    public static String join(Object[] arr) {
        return join(arr, ",");
    }

    /**
     * 转换map为指定分隔符分隔的字符串
     */
    @SuppressWarnings("unchecked")
	public static String join(Map<?, ?> map, String delim, String prefix, String suffix, boolean ignoreNull) {
        if (MapUtils.isEmpty(map)) {
            return "";
        }
        
        Map<Object, Object> sortMap;
        
        if (map instanceof TreeMap) {
            sortMap = (Map<Object, Object>)map;
        } else {
            sortMap = new TreeMap<Object, Object>();
            sortMap.putAll(map);
        }

        StringBuilder sb = new StringBuilder();
        
        for(Map.Entry<?, ?> entry : sortMap.entrySet()) {
        	Object k = entry.getKey();
        	Object v = entry.getValue();
        	
        	if ((k == null || v == null) && ignoreNull) {
        		continue;
        	}
            
            if (sb.length() > 0) {
                sb.append("&");
            }
            
            sb.append(String.valueOf(k));
            sb.append("=");
            sb.append(prefix);
            
            if (v instanceof Collection) {
                sb.append(join((Collection<?>)v, delim, prefix, suffix, ignoreNull));
            } else if (v instanceof Object[]) {
                sb.append(join((Object[])v, delim, prefix, suffix, ignoreNull));
            } else if (v instanceof Map) {
                sb.append("{");
                sb.append(join((Map<?, ?>)v, delim, prefix, suffix, ignoreNull));
                sb.append("}");
            } else {
                sb.append(ObjectUtils.nullSafeToString(v));
            }
            
            sb.append(suffix);
        }
        /*map.forEach((k, v) -> {
            if ((k == null || v == null) && ignoreNull) return;
                    
            if (sb.length() > 0) {
                sb.append(delim);
            }
            
            sb.append(String.valueOf(k));
            sb.append("=");
            sb.append(prefix);
            
            if (v instanceof Collection) {
                sb.append(join((Collection<?>)v, delim, prefix, suffix, ignoreNull));
            } else if (v instanceof Object[]) {
                sb.append(join((Object[])v, delim, prefix, suffix, ignoreNull));
            } else if (v instanceof Map) {
                sb.append("{");
                sb.append(join((Map<?, ?>)v, delim, prefix, suffix, ignoreNull));
                sb.append("}");
            } else {
                sb.append(ObjectUtils.nullSafeToString(v));
            }
            
            sb.append(suffix);
        });*/

        return sb.toString();
    }
    
    /**
     * 转换map为指定分隔符分隔的字符串
     */
    public static String join(Map<?, ?> map, String delim, String prefix, String suffix) {
        return join(map, delim, prefix, suffix, false);
    }
    
    /**
     * 转换map为指定分隔符分隔的字符串
     */
    public static String join(Map<?, ?> map, String delim) {
        return join(map, delim, "", "");
    }

    /**
     * 转换map为逗号分隔符分隔的字符串
     */
    public static String join(Map<?, ?> map) {
        return join(map, ",");
    }

    /**
     * 将列表排序后，再转换为指定分隔符分隔的字符串
     */
    public static String sortJoin(Collection<?> list, String delim, String prefix, String suffix, boolean ignoreNull) {
        if (CollectionUtils.isEmpty(list)) {
            return "";
        }
        
        delim = delim == null ? "" : delim;
        prefix = prefix == null ? "" : prefix;
        suffix = suffix == null ? "" : suffix;
        
        Collection<?> sortList;
        try {
            sortList = list.stream()
                    .sorted()
                    .collect(Collectors.toList());//Comparators.nullsLow()
        } catch (Exception e) {
            // the list sort failed. ignore and continue 
            sortList = list;
        }

        StringBuilder sb = new StringBuilder();
        for (Object obj : sortList) {
            if (obj == null && ignoreNull)
                continue;
            
            if (sb.length() > 0) {
                sb.append(delim);
            }
            
            sb.append(prefix);
            
            if (obj instanceof Collection) {
                sb.append(sortJoin((Collection<?>)obj, ",", prefix, suffix, ignoreNull));
            } else if (obj instanceof Object[]) {
                sb.append(sortJoin((Object[])obj, ",", prefix, suffix, ignoreNull));
            } else if (obj instanceof Map) {
                sb.append("{");
                sb.append(sortJoin((Map<?, ?>)obj, delim, prefix, suffix, ignoreNull));
                sb.append("}");
            } else {
                sb.append(ObjectUtils.nullSafeToString(obj));
            }
            
            sb.append(suffix);
        }
        
        return sb.toString();
    }

    /**
     * 将列表排序后，再转换为指定分隔符分隔的字符串
     */
    public static String sortJoin(Collection<?> list, String delim, String prefix, String suffix) {
        return sortJoin(list, delim, prefix, suffix, false);
    }

    /**
     * 将列表排序后，再转换为指定分隔符分隔的字符串
     */
    public static String sortJoin(Collection<?> list, String delim) {
        return sortJoin(list, delim, "", "");
    }

    /**
     * 将列表排序后，再转换为逗号分隔符分隔的字符串
     */
    public static String sortJoin(Collection<?> list) {
        return sortJoin(list, ",");
    }

    /**
     * 将数组排序后，再转换为指定分隔符分隔的字符串
     */
    public static String sortJoin(Object[] arr, String delim, String prefix, String suffix, boolean ignoreNull) {
        return join(Arrays.asList(arr), delim, prefix, suffix, ignoreNull);
    }

    /**
     * 将数组排序后，再转换为指定分隔符分隔的字符串
     */
    public static String sortJoin(Object[] arr, String delim, String prefix, String suffix) {
        return join(arr, delim, prefix, suffix, false);
    }

    /**
     * 将数组排序后，再转换为指定分隔符分隔的字符串
     */
    public static String sortJoin(Object[] arr, String delim) {
        return join(arr, delim, "", "");
    }

    /**
     * 将map按key排序后，再转换为指定分隔符分隔的字符串
     */
    @SuppressWarnings("unchecked")
    public static String sortJoin(Map<?, ?> map, String delim, String prefix, String suffix, boolean ignoreNull) {
        if (MapUtils.isEmpty(map)) {
            return "";
        }
        
        Map<Object, Object> sortMap;
        
        if (map instanceof TreeMap) {
            sortMap = (Map<Object, Object>)map;
        } else {
            sortMap = new TreeMap<Object, Object>();
            sortMap.putAll(map);
        }
        
        StringBuilder sb = new StringBuilder();

        for(Map.Entry<?, ?> entry : sortMap.entrySet()) {
        	Object k = entry.getKey();
        	Object v = entry.getValue();
        	
        	if ((k == null || v == null) && ignoreNull) {
        		continue;
        	}
            
            if (sb.length() > 0) {
                sb.append(delim);
            }
            
            sb.append(String.valueOf(k));
            sb.append("=");
            sb.append(prefix);
            
            if (v instanceof Collection) {
                sb.append(join((Collection<?>)v, ",", prefix, suffix, ignoreNull));
            } else if (v instanceof Object[]) {
                sb.append(join((Object[])v, ",", prefix, suffix, ignoreNull));
            } else if (v instanceof Map) {
                sb.append("{");
                sb.append(join((Map<?, ?>)v, delim, prefix, suffix, ignoreNull));
                sb.append("}");
            } else {
                sb.append(ObjectUtils.nullSafeToString(v));
            }
            
            sb.append(suffix);
        }
        /*sortMap.forEach((k, v) -> {
            if ((k == null || v == null) && ignoreNull) return;
                    
            if (sb.length() > 0) {
                sb.append(delim);
            }
            
            sb.append(String.valueOf(k));
            sb.append("=");
            sb.append(prefix);
            
            if (v instanceof Collection) {
                sb.append(sortJoin((Collection<?>)v,  ",", prefix, suffix, ignoreNull));
            } else if (v instanceof Object[]) {
                sb.append(sortJoin((Object[])v,  ",", prefix, suffix, ignoreNull));
            } else if (v instanceof Map) {
                sb.append("{");
                sb.append(sortJoin((Map<?, ?>)v, delim, prefix, suffix, ignoreNull));
                sb.append("}");
            } else {
                sb.append(ObjectUtils.nullSafeToString(v));
            }
            
            sb.append(suffix);
        });*/

        return sb.toString();

    }

    /**
     * 将map按key排序后，再转换为指定分隔符分隔的字符串
     */
    public static String sortJoin(Map<?, ?> map, String delim, String prefix, String suffix) {
        return sortJoin(map, delim, prefix, suffix, false);
    }
    
    /**
     * 将map按key排序后，再转换为指定分隔符分隔的字符串
     */
    public static String sortJoin(Map<?, ?> map, String delim) {
        return sortJoin(map, delim, "", "");
    }

    /**
     * 将map按key排序后，再转换为逗号分隔符分隔的字符串
     */
    public static String sortJoin(Map<?, ?> map) {
        return sortJoin(map, ",");
    }

    /**
     * 将 MAP 对象中的列表属性（包括数组）值合并。
     * @param map
     */
    public static void joinListValues(Map<String, Object> map) {
        if (MapUtils.isEmpty(map)) return;
        for (Entry<String, Object> entry : map.entrySet()) {
            Object value = entry.getValue();
            if (value != null) {
                if (value instanceof Collection) {
                    entry.setValue(join((Collection<?>) value));
                }
                if (value.getClass().isArray()) {
                    entry.setValue(join((Object[]) value));
                }
            }
        }
    }
    
    /**
     * 子字符串出现的个数
     */
    public static int getSubStrCount(String str, String subStr) {
        int count = 0;
        int index = 0;
        while ((index = str.indexOf(subStr, index)) != -1) {
            index = index + subStr.length();
            count++;
        }
        return count;
    }

    /**
     * 替换字符串
     */
    public static String replace(String inString, String oldPattern, String newPattern) {
        if (isNotEmpty(inString) && isNotEmpty(oldPattern) && newPattern != null) {
            int index = inString.indexOf(oldPattern);
            if (index == -1) {
                return inString;
            } else {
                int capacity = inString.length();
                if (newPattern.length() > oldPattern.length()) {
                    capacity += 16;
                }

                StringBuilder sb = new StringBuilder(capacity);
                int pos = 0;

                for (int patLen = oldPattern.length(); index >= 0; index = inString.indexOf(oldPattern, pos)) {
                    sb.append(inString.substring(pos, index));
                    sb.append(newPattern);
                    pos = index + patLen;
                }

                sb.append(inString.substring(pos));
                return sb.toString();
            }
        } else {
            return inString;
        }
    }
    
}

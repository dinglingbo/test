/**
 * 
 */
package com.hs.timer;

import com.eos.system.annotation.Bizlet;

/** 
 * @author 作者 ding: 
 * @version 创建时间：2018年12月10日 下午7:23:14 
 * 基础数据定时维护--套餐，项目的使用次数
 */
@Bizlet("")
public class RpbUtils {

	public static void main(String[] args) {
		String contentString = "sdfsd abc---abc <a href='http://www.hao123.com'>" +
				"http://www.hao123.com</a><img title='img' src='abc' />" +
				"sdfsdfds";
		contentString=contentString.replaceAll("<a href[^>]*>", "");
		contentString=contentString.replaceAll("</a>", "");
		contentString=contentString.replaceAll("<img[^>]*/>", " ");
		System.out.println(contentString);
	}
}

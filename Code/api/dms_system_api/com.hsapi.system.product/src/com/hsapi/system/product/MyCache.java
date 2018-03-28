/**
 * 
 */
package com.hsapi.system.product;

import com.eos.system.annotation.Bizlet;

/**
 * @author Guine
 * @date 2018-03-28 15:07:42
 * 
 */
@Bizlet("")
public class MyCache {
	private String id; // id
	private String customId; // 自定义ID
	private String name;// 中文名称

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}

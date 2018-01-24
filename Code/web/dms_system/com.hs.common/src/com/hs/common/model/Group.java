package com.hs.common.model;

import java.util.HashMap;
import java.util.Map;

public class Group {

	private Map<String, String> configValues = new HashMap<String, String>();

	public Group() {}

	public Group(Map<String, String> configValues) {
		this.configValues = configValues;
	}
	
	public boolean containsKey(String key){
		return this.configValues.containsKey(key);
	}
	
	public void setConfigValue(String key, String val){
		this.configValues.put(key, val);
	}
	
	public String getConfigValue(String key) {
		return this.configValues.get(key);
	}

	@Override
	public String toString() {
		return "Group [configValues=" + configValues + "]";
	}
	
}

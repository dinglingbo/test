package com.hs.common.model;

import java.util.HashMap;
import java.util.Map;

public class Module {

	private Map<String, Group> groups = new HashMap<String, Group>();

	public Module() {}

	public Module(Map<String, Group> groups) {
		this.groups = groups;
	}
	
	public boolean containsKey(String key){
		return this.groups.containsKey(key);
	}
	
	public void setGroup(String key, Group group){
		this.groups.put(key, group);
	}
	
	public Group getGroup(String key){
		return this.groups.get(key);
	}

	@Override
	public String toString() {
		return "Module [groups=" + groups + "]";
	}
	
}

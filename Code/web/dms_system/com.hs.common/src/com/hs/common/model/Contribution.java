package com.hs.common.model;

import java.util.HashMap;
import java.util.Map;

public class Contribution {

	private Map<String, Module> modules = new HashMap<String, Module>();

	public Contribution() {}

	public Contribution(Map<String, Module> modules) {
		this.modules = modules;
	}

	public boolean containsKey(String key){
		return this.modules.containsKey(key);
	}
	
	public void setModule(String key, Module module) {
		this.modules.put(key, module);
	}
	
	public Module getModule(String key) {
		return this.modules.get(key);
	}

	@Override
	public String toString() {
		return "Contribution [modules=" + modules + "]";
	}
	
}

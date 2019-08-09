package com.huasheng.usersWechat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import com.eos.system.utility.StringUtil;
import com.eos.system.annotation.Bizlet;

public class DataUtil {
	
	
	@Bizlet
	public HashMap[] changeMainMenu(HashMap[] button, HashMap[] tempLines){
		
		List tempList = new ArrayList();
		
		String[] tempArr = new String[0]; 
		
		for(HashMap but : button){
			for(HashMap line : tempLines){
				if(but.get("mainId").equals(line.get("mainId"))){
					tempList.add(line);
					but.put("sub_button", tempList.toArray());
				}
			}
		}
		System.out.println(button.toString());
		return button;
		
	}

}

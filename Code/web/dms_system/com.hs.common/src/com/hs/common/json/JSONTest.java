/*******************************************************************************
 * $Header$
 * $Revision$
 * $Date$
 *
 *==============================================================================
 *
 * Copyright (c) 2001-2006 Primeton Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2013-3-11
 *******************************************************************************/


package com.hs.common.json;

import com.eos.data.datacontext.UserObject;
import com.eos.foundation.data.DataObjectUtil;
import commonj.sdo.DataObject;



public class JSONTest {

   public static void main(String[] args){
	   UserObject u= new UserObject();
	   u.setUserId("7499");
	   u.setSessionId("73a05e2f-35fd-334c-8483-8e551311f957");
	   
	   DataObject mpRoles = DataObjectUtil.createDataObject("com.vplus.data.sys.MpRoles");
	   mpRoles.set("roleId", 3389);
	   mpRoles.set("roleCode", "ROLE3389");
	   u.getAttributes().put("mpRoles", mpRoles);
	   
	   net.sf.json.JSONObject netJson = net.sf.json.JSONObject.fromObject(u);
	   String u1=netJson.toString();
	   System.out.println(u1);
   }
}

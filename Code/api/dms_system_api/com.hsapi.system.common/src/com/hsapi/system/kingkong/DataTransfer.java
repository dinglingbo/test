package com.hsapi.system.kingkong;

import java.util.UUID;

import com.google.gson.Gson;
import com.kingdee.bos.webapi.sdk.K3CloudApi;
import com.kingdee.bos.webapi.sdk.OperateParam;
import com.kingdee.bos.webapi.sdk.OperatorResult;
import com.kingdee.bos.webapi.sdk.SaveParam;
import com.kingdee.bos.webapi.sdk.SaveResult;

public class DataTransfer {

	public static void main(String[] args) throws Exception {
		K3CloudApi api = new K3CloudApi("http://epc.youfan.pub/k3cloud/"); 
		Customer c = new Customer();
		c.setFNumber("BC");
		c.setFName("客户名称-A" + UUID.randomUUID().toString());
		c.setFShortName("客户简称-A" + UUID.randomUUID().toString());
		OperateParam op = new OperateParam();
		op.setCreateOrgId("0");
		op.setIds("");
		op.setNumbers(null);
		OperatorResult sRet = api.view("BD_MATERIAL",op);
		if (sRet.isSuccessfully()) {
			Gson gson = new Gson();
			System.out.println(
					String.format("%s", gson.toJson(sRet.getResult().getResponseStatus().getSuccessEntitys())));
		} else {
			System.out.println(" ");
		}

		// 保存客户信息
				SaveResult rRet = api.save("BD_Customer", new SaveParam<Customer>(c));
				if (rRet.isSuccessfully()) {
					Gson gson = new Gson();
					System.out.println(
							String.format("%s", gson.toJson(rRet.getResult().getResponseStatus().getSuccessEntitys())));
				} else {
					System.out.println(" ");
				}


	}

}

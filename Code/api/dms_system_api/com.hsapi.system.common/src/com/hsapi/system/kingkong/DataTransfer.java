package com.hsapi.system.kingkong;

import com.kingdee.bos.webapi.sdk.K3CloudApi;

public class DataTransfer {

	public static void main(String[] args) {
		// TODO 自动生成的方法存根
		K3CloudApiClient client = new K3CloudApiClient("http://epc.youfan.pub/k3cloud/"); 
		var loginResult = client.ValidateLogin("5dbfa35df56027","Administrator","888888",2052);
		var resultType = JObject.Parse(loginResult)["LoginResultType"].Value<int>();
	}

}

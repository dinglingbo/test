package com.huasheng.usersWechat;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.eos.system.annotation.Bizlet;
import com.wechat.Tool.WechatCommonTool;

/**
 * 门店二维码
 * @author lidongsheng
 *
 */
@Bizlet("")
public class StoreCode {
	
	/**
	 * 
	 * @param storeId  门店主键id
	 * @return
	 * 
	 * 公众号二维码ticket值，用于生成公众号二维码图片
	 * 
	 */
	@Bizlet("")
	public String storeWenChatCode(int storeId){
  		JSONObject json=new JSONObject();
  		/**
  		 * 二维码类型，QR_SCENE为临时的整型参数值，QR_STR_SCENE为临时的字符串参数值，QR_LIMIT_SCENE为永久的整型参数值，QR_LIMIT_STR_SCENE为永久的字符串参数值
  		 */
  		json.put("action_name", "QR_LIMIT_SCENE");
  		
  		JSONObject sceneJson=new JSONObject();
  		sceneJson.put("scene_id", storeId);//场景值ID，临时二维码时为32位非0整型，永久二维码时最大值为100000（目前参数只支持1--100000）
  		
  		JSONObject actionInfoJson=new JSONObject();
  		actionInfoJson.put("scene", sceneJson);//二维码详细信息
  		json.put("action_info", actionInfoJson);
  		
  		String resjson=WechatCommonTool.transferJsonInterface("https://api.weixin.qq.com/cgi-bin/qrcode/create",ReceiveToken.getAccessToken(),json.toJSONString());
  		JSONObject resData=JSONObject.parseObject(resjson);
  		return resData.getString("ticket");
     }
	
	
}

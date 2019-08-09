package weixin.popular.bean.xmlmessage;

import java.util.HashMap;

import com.alibaba.fastjson.JSONObject;
import com.huasheng.usersWechat.WeChatImageTextMessAge;

import weixin.popular.bean.message.message.Message;
import weixin.popular.bean.message.message.TextMessage;

public class XMLImgMessage extends XMLMessage {

	private static final long serialVersionUID = 2457998440521370652L;

	private String media_id;
	
	private String ipHttp="http://qxy60.hszb.harsons.cn/dms";

	//单图文
	public XMLImgMessage(String toUserName, String fromUserName, HashMap mapData) throws Exception {
		super(toUserName, fromUserName, "image");
		JSONObject jsonObject = WeChatImageTextMessAge.UploadMeida("image",ipHttp+mapData.get("fodderPath"));//上传图片
		this.media_id = jsonObject.getString("media_id");
	}

	@Override
	public String subXML() {
		return "<Image><MediaId><![CDATA[" + media_id + "]]></MediaId></Image>";
	}
	
	

	@Override
	public Message convert() {
		return new TextMessage(toUserName, media_id);
	}

}
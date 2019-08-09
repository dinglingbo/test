package weixin.popular.bean.xmlmessage;

import java.util.HashMap;

import weixin.popular.bean.message.message.Message;
import weixin.popular.bean.message.message.TextMessage;

public class XMLArticleMessage extends XMLMessage {

	private static final long serialVersionUID = 2457998440521370652L;

	private Integer articleCount ;
	
	private String title;
	
	private String description;
	
	private String picurl;
	
	private String url;
	
	private String ipHttp="http://qxy60.hszb.harsons.cn/dms";

	//单图文
	public XMLArticleMessage(String toUserName, String fromUserName, HashMap mapData) {
		super(toUserName, fromUserName, "news");
		this.articleCount = 1;
		this.title = (String) mapData.get("imageTextTitle");
		this.description = (String) mapData.get("imageTextDescribe");
		this.picurl = ipHttp+mapData.get("fodderPath");
		this.url = (String) mapData.get("imageTextSource");
	}

	@Override
	public String subXML() {
		return  "<ArticleCount>"+articleCount+"</ArticleCount><Articles>"+
					"<item>"+
						"<Title><![CDATA["+title+"]]></Title>"+
						"<Description><![CDATA["+description+"]]></Description>"+
						"<PicUrl><![CDATA["+picurl+"]]></PicUrl>"+
						"<Url><![CDATA["+url+"]]></Url>"+
					"</item>"+
				" </Articles>" ;
	}
	
	

	@Override
	public Message convert() {
		return new TextMessage(toUserName, title);
	}

}
package com.huasheng.usersWechat;


/**
 * 
 * 上传图文消息素材的类
 * @author lidongsheng
 *
 */
public class GraphicMessage {
	
	//thumb_media_id			是	图文消息缩略图的media_id，可以在基础支持-上传多媒体文件接口中获得
	private String thumb_media_id;
	
	//author					否	图文消息的作者
	private String author;
	
	//title						是	图文消息的标题
	private String title;
	
	//content_source_url		否	在图文消息页面点击“阅读原文”后的页面，受安全限制，如需跳转Appstore，可以使用itun.es或appsto.re的短链服务，并在短链后增加 #wechat_redirect 后缀。
	private String content_source_url;
	
	//content					是	图文消息页面的内容，支持HTML标签。具备微信支付权限的公众号，可以使用a标签，其他公众号不能使用，如需插入小程序卡片，可参考下文。
	private String content;
	
	@Override
	public String toString() {
		return "{"
				+ (thumb_media_id != null ? "thumb_media_id=" + thumb_media_id
						+ ", " : "")
				+ (author != null ? "author=" + author + ", " : "")
				+ (title != null ? "title=" + title + ", " : "")
				+ (content_source_url != null ? "content_source_url="
						+ content_source_url + ", " : "")
				+ (content != null ? "content=" + content + ", " : "")
				+ (digest != null ? "digest=" + digest + ", " : "")
				+ "show_cover_pic=" + show_cover_pic + ", need_open_comment="
				+ need_open_comment + ", only_fans_can_comment="
				+ only_fans_can_comment + "}";
	}

	//digest					否	图文消息的描述，如本字段为空，则默认抓取正文前64个字
	private String digest;
	
	//show_cover_pic			否	是否显示封面，1为显示，0为不显示
	private int show_cover_pic;
	
	//need_open_comment			否	Uint32 是否打开评论，0不打开，1打开
	private int need_open_comment;
	
	//only_fans_can_comment		否	Uint32 是否粉丝才可评论，0所有人可评论，1粉丝才可评论
	private int only_fans_can_comment;
	
	public GraphicMessage() {
	
	}
	
	//全部参数的构造方法
	public GraphicMessage(String thumb_media_id,String author,String title,String content_source_url,String content,String digest,int show_cover_pic,int need_open_comment,int only_fans_can_comment) {
		this.thumb_media_id=thumb_media_id;
		this.author=author;
		this.title=title;
		this.content_source_url=content_source_url;
		this.content=content;
		this.digest=digest;
		this.show_cover_pic=show_cover_pic;
		this.need_open_comment=need_open_comment;
		this.only_fans_can_comment=only_fans_can_comment;
	}
	
	//必须传入的参数构造方法
	public GraphicMessage(String thumb_media_id,String title,String content) {
		this.thumb_media_id=thumb_media_id;
		this.title=title;
		this.content=content;
	}
	
	public String getThumb_media_id() {
		return thumb_media_id;
	}

	public void setThumb_media_id(String thumb_media_id) {
		this.thumb_media_id = thumb_media_id;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent_source_url() {
		return content_source_url;
	}

	public void setContent_source_url(String content_source_url) {
		this.content_source_url = content_source_url;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDigest() {
		return digest;
	}

	public void setDigest(String digest) {
		this.digest = digest;
	}

	public int getShow_cover_pic() {
		return show_cover_pic;
	}

	public void setShow_cover_pic(int show_cover_pic) {
		this.show_cover_pic = show_cover_pic;
	}

	public int getNeed_open_comment() {
		return need_open_comment;
	}

	public void setNeed_open_comment(int need_open_comment) {
		this.need_open_comment = need_open_comment;
	}

	public int getOnly_fans_can_comment() {
		return only_fans_can_comment;
	}

	public void setOnly_fans_can_comment(int only_fans_can_comment) {
		this.only_fans_can_comment = only_fans_can_comment;
	}

}

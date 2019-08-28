/**
 * 
 */
package com.hsweb.system.auth;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.data.datacontext.UserObject;
import com.eos.system.annotation.Bizlet;
import com.primeton.das.entity.impl.hibernate.mapping.Map;

/**
 * @author dlb
 * @date 2019-08-28 14:20:19
 *
 */
@Bizlet("")
public class NestTab extends TagSupport{
		private String name = "";
		private String value = "";
		public void setName(String name) {
			this.name = name;
		}
		
		public void setValue(String value) {
			this.value = value;
		}
		
		public int doStartTag() throws JspException {
			IMUODataContext muo = DataContextManager.current().getMUODataContext();
		    UserObject uo = (UserObject) muo.getUserObject();		    
	        String 	loginName = (String) uo.get("loginName");
	        JspWriter out = pageContext.getOut();
			//String username = (String)pageContext.getSession().getAttribute(name);
			if(name == "test1"){
				try {
					out.println("<a class='nui-button' plain='true' onclick='search' id='addStationBtn'>"+
							"<span class='fa fa-refresh fa-lg'></span>&nbsp;刷新"+
						"</a>"+
						"<a class='nui-button' plain='true' onclick='addShareUrl' id='addStationBtn'>"+
						"	<span class='fa fa-plus fa-lg'></span>&nbsp;新增"+
						"</a>"+
						"<a class='nui-button' plain='true' onclick='delShareUrl' id='addStationBtn'>"+
						"	<span class='fa fa-close fa-lg'></span>&nbsp;删除"+
						"</a>"+
						"<a class='nui-button' plain='true' onclick='saveShare' id='saveStationBtn'>"+
						"	<span class='fa fa-save fa-lg'></span>&nbsp;保存"+
						"</a>");
				} catch (IOException e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}
				return EVAL_BODY_INCLUDE; //自动将标签体包含到输出流（因为顶级标签的标签体是一子标签，还要进行该子标签的标签处理）
			}else{
				return SKIP_BODY; //跳过标签体，不处理
			}
		}
}

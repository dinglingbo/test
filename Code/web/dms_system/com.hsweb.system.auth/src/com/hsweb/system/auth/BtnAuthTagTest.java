/**
 * 
 */
package com.hsweb.system.auth;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.eos.system.annotation.Bizlet;

/**
 * @author dlb
 * @date 2019-08-28 12:00:57
 *
 */
/**
 * 自定义自结束标签，不含标签体。
 *
 * 1、在自定义的类中，重写了父类TagSupport 的两个方法：doStartTag()、doEndTag()，在容器遇到标记开始时会运行doStartTag()，遇到标记结束时运行doEndTag()方法；
 * 2、doStartTag（）方法的返回值：通常可以取两个值：
 *      EVAL_BODY_INCLUDE——包含标记体，本例中要编写自结束标记所以不使用该值；
 *      SKIP_BODY——跳过标记体，即不处理标记体，开发自结束标记应该使用该值。
 * 3、doEndTag（）方法的返回值：通常可以取两个值：
 *      SKIP_PAGE——返回这个值，则终止页面执行；
 *      EVAL_PAGE——返回该值则处理完当前标记后，JSP 页面中止运行。
 */
@Bizlet("")
public class BtnAuthTagTest extends TagSupport{

	/**
     *
     */

/*
     * 在WEB 容器遇到标签开始时，该方法会运行。
     * 该方法可以自行定义，也可以不定义。不定义该方法则遇到开始标签什么都不做
     * */
	public int doStartTag() throws JspException {
		try {
			//得到网络输出流,pageContext 是从父类继承过来的成员
			JspWriter out = pageContext.getOut();
			//向网页输出内容
			out.println("<h4>开始执行doStartTag()......</h4>");
			//输出5 条水平线;
			for(int i=1; i<=5; i++){
				out.println("<hr>");
			}
	   } catch (Exception e) {
		 e.printStackTrace();
	   }
		//return EVAL_BODY_INCLUDE; //处理标记体
		return Tag.SKIP_BODY; //跳过标记体;
	}

	/*
     * 在WEB 容器遇到标签结束时，该方法会运行。
     * 该方法可以自行定义，也可以不定义。不定义该方法则遇到结束标签什么都不做
     * */
	public int doEndTag() throws JspException {
		try {
			JspWriter out=pageContext.getOut();
			out.println("<h3>开始执行doEndTag().....</h3>.");
		} catch (Exception e) {
			e.printStackTrace();
		}
		//return Tag.SKIP_PAGE; //返回这个值，则终止页面执行;

		return EVAL_PAGE;
	}
		
	/**
	 * @param args
	 * @author dlb
	 */
	public static void main(String[] args) {
		// TODO 自动生成的方法存根

	}

}

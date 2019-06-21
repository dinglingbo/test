<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@page import="com.eos.system.utility.StringUtil"%>
<%@ include file="/common/sysCommon.jsp"%>		
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-06-21 10:07:51
  - Description:
-->
<head>
<title>更新日志详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
    	body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, input, p {
		    margin: 0;
		    padding: 0;
		    font-family: "微软雅黑", "宋体","黑体", Arial, simsun, Verdana, Lucida, Helvetica, sans-serif;
		    font-size: 14px;
		    font-style: normal;
		    font-weight: normal;
		    ont-variant: normal;
		}

    	.Journal{background:#fff;min-height:100%;margin:0 auto;max-width:1024px;}
    	.color999 {color: #999;}
    </style>
</head>
<body style="background:#eee;" >

	<div id="main" class="Journal" style="min-height: 625px;"></div>
	
	

	<script type="text/javascript">
    	nui.parse();
    	
    	var id = "<%= StringUtil.htmlFilter(request.getParameter("id")) %>";
    	var show = "<%= StringUtil.htmlFilter(request.getParameter("show")) %>";
		load(id, show);
    	function load(id, show) {
	    	var json = {
	    		id: id,
	    		show: show,
	    		token: token
	    	};
	    	nui.ajax({
				url: apiPath + sysApi + "/com.hsapi.system.employee.slog.getSysUpdateLog.biz.ext",
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					var data = text.data;
					var date = data.recordDate;
						date = new Date(date);
						date = format(date, "yyyy-MM-dd");
					var itemHtml = "";
					var content = data.content;
					if(content != null && content != "") {
						var title = "<h2 style='font-size:26px; padding:18px 10px 5px 18px;'>"+data.title+"</h2>"
						          + "<h4 class='color999' style='height:32px; border-bottom:1px #dcdcdc dotted; "
						          + "margin-bottom:10px; font-size:16px;margin-left:18px'>更新日期："+date+"</h4>";
													          
						itemHtml+= title + content;
						
						/* if(show == "true") {
							var btn = "<h4 style='margin: 0px; padding: 0px; font-weight: normal;  "
									+ "	          font-variant-numeric: normal; font-variant-east-asian: normal;'> "
									+ "		<a href='"+webPath + sysDomain+"/com.hs.common.updateLogDetail.flow?id="+data.id+"&show=true'  "
									+ "		        target='_blank' style='text-decoration-line: none; transition: all 0.4s ease 0s; "
									+ "		        font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 16px; "
									+ "		        color: rgb(87, 140, 205); display: block; width: 200px; height: 40px; "
									+ "		        line-height: 40px; text-align: center; border-radius: 5px; "
									+ "		        margin: 10px 0px 0px 5px; background: rgb(220, 225, 229);'> "
									+ "		        点击查看优化详情 "
									+ "		</a> "
									+ "	</h4> ";
							itemHtml += btn;
						} */
						
					}
					
					var mainDiv = document.getElementById("main");
					mainDiv.innerHTML=itemHtml;
					
				}
			});
	    }
    </script>
</body>
</html>
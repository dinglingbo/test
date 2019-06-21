<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-06-21 11:18:25
  - Description:
-->
<head>
<title>Title</title>
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
		.color999 { color: #999; }
		.font13 { font-size: 13px; }
		.sysupdate{padding:10px 18px;height:auto;overflow:auto;}
		.fr{float:right;}
		a.qctz{ background:#f4f8fb url(../images/laba.png) no-repeat; border:1px #578ccd solid; border-radius:5px; color:#578ccd; font-size:15px; height:34px; line-height:34px; padding:0 13px 0 33px;}
		a.qctz:hover{ background-color:#578ccd;color:#fff;}
	</style>
    
</head>
<body >

	<div id="main" class="sysupdate" style="height:450px;"></div>
	<div>
		<a id="wxbtnsettle" style="    width: 120px;
							height: 40px;
							font-size: 18px;
							background: #3f84b5;
							color: #fff;
							text-align: center;
							display: block;
							border-radius: 5px;
							line-height: 2;
							text-decoration: none;
							margin: auto;
							margin-top: 10px;" 
							href="javascript:void(0)" onclick="ok()">我已知晓</a>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var updateLog = null;
    	
    	function setInitData(data) {
    		updateLog = data;
    		var date = data.recordDate;
				date = new Date(date);
				date = format(date, "yyyy-MM-dd");
			var itemHtml = "";
			var content = data.content;
			if(content != null && content != "") {
				var title = "<h4 style='height:58px; border-bottom:1px #dcdcdc dotted; margin:10px 0; "
				          + "       font-size:20px;'> "
					      + "      <a href='javascript:' onclick='openDetail()'  "
					      + "      class='fr qctz' style='text-decoration:none; background-image:none;  "
					      + "      padding:0 18px;'>点击查看优化详情</a>"+data.title+"<br> "
					      + "      <font class='color999 font13' style='margin-top:5px;'>更新日期："+date+"</font>  "
					      + "  </h4>";
											          
				itemHtml+= title + content;
				
			}
			
			var mainDiv = document.getElementById("main");
			mainDiv.innerHTML=itemHtml;
    	}
    	
    	function openDetail() {
    		window.open(webPath + sysDomain+"/com.hs.common.updateLogDetail.flow?id="+updateLog.id+"&show=true","_blank"); 
    	}
    	
    	function ok() {
    		nui.ajax({
				url: apiPath + sysApi + "/com.hsapi.system.tenant.employee.updateSysmsgSign.biz.ext",
				type: 'POST',
				data: {token:token},
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					closeWindow("cal");
				}
			});
    	}
    	
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
  <title>结算单模板设置</title>
<body>
	<script type="text/javascript">
    	nui.parse();
    	 
    </script>
    <style type="text/css">
	.js_bill{float:left; margin:0 20px 20px 10px;}
	 .js_bill dl{ padding:5px; background:#f4f8fb; position:relative;margin: auto;}
	.js_bill dl img{ width:280px; height:360px;}
	.js_bill h3{text-align:center; background:#f4f8fb; height:28px; font-size:15px;margin: auto;}
	.js_bill dl dt{ position:absolute; z-index:1; left:0; top:0;  filter: alpha(Opacity=70); -moz-opacity: 0.7; opacity: 0.7; background:#000; width:100%; height:calc(100% + 28px); display:none}
	.js_bill dl dd{position:absolute; z-index:2; top:50%; left:12%; width:50%; height:40px; margin-top:-6px; display:none}
	.js_bill dl dd a{ display:block; height:40px; line-height:40px; border-radius:5px; background:#ff9600; text-align:center; text-decoration:none; color:#fff; font-size:15px;}
	.js_bill dl dd a:hover{ background:#578ccd;}
	.js_bill dl:hover dt, .js_bill dl:hover dd{ display:block;}
	.js_bill dl.xz{ background:#32b400;}
	.js_bill dl.xz p{ position:absolute; z-index:1; right:5px; top:5px; height:31px;margin: auto;}
	.js_bill dl.xz p i{ width:12px; height:31px; display:block; float:left; }
	.js_bill dl.xz p font{ background:#32b400; color:#fff; height:31px; display:block; float:left; line-height:26px; padding:0 12px 0 10px;}
	.js_bill h3.xz{ background:#32b400; color:#fff;}
	.js_bill ul{ text-align:center; padding:10px 0px;margin:0px}
	.js_bill ul li{ width:90px; display:inline-block;}
	.js_bill ul li a{ display:block;  width:54px; height:28px; line-height:28px; border-radius:4px; text-decoration:none; color:#578ccd; padding-left:0px; margin:0 auto;}
	.js_bill ul li a.eye{ background-position:10px -32px;}
	.js_bill ul li a:hover{ background-color:#dce1e5;} 
    </style>
    <div style="margin-top:15px;">
            <div class="js_bill">
                <dl class="xz"><p><i></i><font>默认模板</font></p><img src="<%= request.getContextPath() %>/config/img/sys1.png" /></dl>
                <h3 class="xz">系统模板1</h3>
                <ul><li><a onclick="showPrint(1)" class="eye">预览</a></li></ul>
            </div>
                    <div class="js_bill">
                <dl><dt></dt><dd><a href="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/previewTemplate2.jsp" name="setdefault" templateid="1">设为默认</a></dd><img src="<%= request.getContextPath() %>/config/img/sys2.png" /></dl>
                <h3>系统模板2</h3>
                <ul><li><a onclick="showPrint(2)" class="eye">预览</a></li></ul>
            </div>
            <div class="js_bill">
                <dl><dt></dt><dd><a href="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/previewTemplate3.jsp" name="setdefault" templateid="3">设为默认</a></dd><img src="<%= request.getContextPath() %>/config/img/sys3.png" /></dl>
                <h3>系统模板3</h3>
                <ul><li><a onclick="showPrint(3)" class="eye">预览</a>
               <!--  <a class="eye"><i class="fa fa-eye" aria-hidden="true"></i>预览</a>  -->
                </li></ul>
            </div>
            <div class="js_bill">
                <dl><dt></dt><dd><a href="javascript:;" name="setdefault" templateid="4">设为默认</a></dd><img src="<%= request.getContextPath() %>/config/img/sys4.png" /></dl>
                <h3>系统模板4</h3>
                <ul><li><a onclick="showPrint(4)" class="eye">预览</a></li></ul>
            </div>
            <div class="js_bill">
                <dl><dt></dt><dd><a href="javascript:;" name="setdefault" templateid="5">设为默认</a></dd><img src="<%= request.getContextPath() %>/config/img/sys5.png" /></dl>
                <h3>系统模板5</h3>
                <ul><li><a onclick="showPrint(5)" class="eye">预览</a></li></ul>
            </div>
    </div>
    <div style="padding-top:32px;"></div> 
    <script type="text/javascript">
      var webBaseUrl = webPath + contextPath + "/";
       $(document).ready(function (){
		
        });
        function showPrint(e){
          var url = null;
          if(e==1){
             url = webBaseUrl + "repair/RepairBusiness/Reception/previewTemplate1.jsp?token=" + token;
          }
          if(e==2){
             url = webBaseUrl + "repair/RepairBusiness/Reception/previewTemplate2.jsp?token=" + token;
          }
          if(e==3){
             url = webBaseUrl + "repair/RepairBusiness/Reception/previewTemplate3.jsp?token=" + token;
          }
          if(e==4){
             url = webBaseUrl + "repair/RepairBusiness/Reception/previewTemplate4.jsp?token=" + token;
          }
          if(e==5){
             url = webBaseUrl + "repair/RepairBusiness/Reception/previewTemplate5.jsp?token=" + token;
          }
          nui.open({
    		url : url,
    		title : "",
    		width : '100%',
    		height : '100%',
    		allowDrag : true,
    		allowResize : true,
    		onload : function() {
    			var iframe = this.getIFrameEl();
                iframe.contentWindow.updatRowSetData(params);//显示该显示的功能
               // iframe.contentWindow.setViewData(dock, dodelck, docck);
    		},
    		ondestroy : function(action) {
    			
    		}
    	});
        
        }
    </script>
</body>
</html>
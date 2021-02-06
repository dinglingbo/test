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
            <div class="js_bill" id="temp1">
                <dl>
                 <div id="temp1_div1">
                    <dt></dt><dd><a onclick="save(1)" name="setdefault" templateid="1">设为默认</a></dd>
                 </div>
                 <div id="temp1_div2" style="display: none">
                     <p><i></i><font>默认模板</font></p>
                 </div>
                <img src="<%= request.getContextPath() %>/config/img/sys1.png" />
                </dl>
                <h3>系统模板1</h3>
                <ul><li><a href="<%= request.getContextPath() %>/com.hsweb.RepairBusiness.previewTemplate1.flow" target='_blank' class="eye">预览</a></li></ul>
            </div>
            <div class="js_bill" id="temp2">
                <dl>
                 <div id="temp2_div1" >
                    <dt></dt><dd><a onclick="save(2)" name="setdefault" templateid="2">设为默认</a></dd>
                 </div>
                
                 <div id="temp2_div2" style="display: none">
                     <p><i></i><font>默认模板</font></p>
                 </div>
                 
                 <img src="<%= request.getContextPath() %>/config/img/sys2.png" />
                </dl>
                <h3>系统模板2</h3>
                <ul><li><a href="<%= request.getContextPath() %>/com.hsweb.RepairBusiness.previewTemplate2.flow" target='_blank' class="eye">预览</a></li></ul>
            </div>
            <div class="js_bill" id="temp3">
                <dl>
               
                <div id="temp3_div1">
                    <dt></dt><dd><a onclick="save(3)" name="setdefault" templateid="3">设为默认</a></dd>
                 </div>
                 <div id="temp3_div2" style="display: none">
                     <p><i></i><font>默认模板</font></p>
                 </div>
                
                <img src="<%= request.getContextPath() %>/config/img/sys3.png" />
                </dl>
                <h3>系统模板3</h3>
                <ul><li><a href="<%= request.getContextPath() %>/com.hsweb.RepairBusiness.previewTemplate3.flow" target='_blank' class="eye">预览</a>
                </li></ul>
            </div>
            <div class="js_bill" id="temp4">
                <dl>
                <div id="temp4_div1" >
                    <dt></dt><dd><a onclick="save(4)" name="setdefault" templateid="4">设为默认</a></dd>
                 </div>
                 <div id="temp4_div2" style="display: none">
                     <p><i></i><font>默认模板</font></p>
                 </div>
                <img src="<%= request.getContextPath() %>/config/img/sys4.png" />
                </dl>
                <h3>系统模板4</h3>
                <ul><li><a href="<%= request.getContextPath() %>/com.hsweb.RepairBusiness.previewTemplate4.flow" target='_blank' class="eye">预览</a></li></ul>
            </div>
            <div class="js_bill" id="temp5">
                <dl>
               <div id="temp5_div1" >
                    <dt></dt><dd><a onclick="save(5)" name="setdefault" templateid="5">设为默认</a></dd>
                 </div>
                 <div id="temp5_div2" style="display: none">
                     <p><i></i><font>默认模板</font></p>
                 </div>
                <img src="<%= request.getContextPath() %>/config/img/sys5.png" />
                </dl>
                <h3>系统模板5</h3>
                <ul><li><a href="<%= request.getContextPath() %>/com.hsweb.RepairBusiness.previewTemplate5.flow" target='_blank' class="eye">预览</a></li></ul>
            </div>
            <div class="js_bill" id="temp6">
                <dl>
               <div id="temp6_div1" >
                    <dt></dt><dd><a onclick="save(6)" name="setdefault" templateid="6">设为默认</a></dd>
                 </div>
                 <div id="temp6_div2" style="display: none">
                     <p><i></i><font>默认模板</font></p>
                 </div>
                <img src="<%= request.getContextPath() %>/config/img/sys6.png" />
                </dl>
                <h3>系统模板6</h3>
                <ul><li><a href="<%= request.getContextPath() %>/com.hsweb.RepairBusiness.previewTemplate6.flow" target='_blank' class="eye">预览</a></li></ul>
            </div>
    </div>
    <div style="padding-top:32px;"></div> 
    <script type="text/javascript">
      var webBaseUrl = webPath + contextPath + "/";
       $(document).ready(function (){
          doSearch();
        });
        
        function doSearch(){
           getComParamsList();
        } 
        var billParams = {};
        var comParamsUrl = apiPath + sysApi + "/com.hsapi.system.config.paramSet.queryBillParams.biz.ext";
        function getComParamsList(){
            var params = {isDisabled:0};
		    nui.ajax({
				url : comParamsUrl,
		        type : "post",
		        async:false,
				data : JSON.stringify({
					params : params,
					token: token
				}),
				success : function(data) {
		            data = data || {};
		            billParams = data.billParams;
					if (billParams) {
					   var repairSettPrintUrl = billParams.repairSettPrintUrl;
					   if(repairSettPrintUrl){
					       setStyle(repairSettPrintUrl);
					   }
		
					} 
				},
				error : function(jqXHR, textStatus, errorThrown) {
					// nui.alert(jqXHR.responseText);
					console.log(jqXHR.responseText);
				}
			});
       }
       var saveUrl = apiPath + sysApi + "/com.hsapi.system.config.paramSet.saveBillParams.biz.ext";
       function save(e){
           var repairSettPrintUrl = null;
           if(e==1){
              repairSettPrintUrl = "/com.hsweb.print.settlement.flow";
           }
           if(e==2){
              repairSettPrintUrl = "/com.hsweb.print.settlementPart.flow";
           }
           if(e==3){
              repairSettPrintUrl = "/com.hsweb.print.settlement3.flow";
           }
           if(e==4){
              repairSettPrintUrl = "/com.hsweb.print.settlement4.flow";
           }
           if(e==5){
              repairSettPrintUrl = "/com.hsweb.print.settlement5.flow";
           }
           if(e==6){
              repairSettPrintUrl = "/com.hsweb.print.settlement6.flow";
           }
           nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '保存中...'
           });
           var temp = {"keyidId":"repairSettPrintUrl",keyidValue:repairSettPrintUrl};
           var params = [];
           params.push(temp);
		    nui.ajax({
				url : saveUrl,
		        type : "post",
		        async:false,
				data : JSON.stringify({
					billParams : params,
					token: token
				}),
				success : function(data) {
					
					if(data.errCode=="S"){
					   parent.showMsg("设置成功","S");
					   doSearch();
					}else{
					   parent.showMsg("设置成功","S");
					}
					nui.unmask(document.body);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					// nui.alert(jqXHR.responseText);
					console.log(jqXHR.responseText);
					nui.unmask(document.body);
				}
			});
       }
       var oldStr = null;
       function setStyle(repairSettPrintUrl){
           var str = null;
           if(repairSettPrintUrl == "/com.hsweb.print.settlement.flow"){
              str = "temp1";
           }
           if(repairSettPrintUrl == "/com.hsweb.print.settlementPart.flow"){
              str = "temp2";
           }
           if(repairSettPrintUrl == "/com.hsweb.print.settlement3.flow"){
              str = "temp3";
           }
           if(repairSettPrintUrl == "/com.hsweb.print.settlement4.flow"){
              str = "temp4";
           }
           if(repairSettPrintUrl == "/com.hsweb.print.settlement5.flow"){
              str = "temp5";
           }
           if(repairSettPrintUrl == "/com.hsweb.print.settlement6.flow"){
              str = "temp6";
           }
           if(str){
              //先把原来选择的去掉样式
               if(oldStr){
                   var oldStr1 = oldStr + "_div1";
	               var oldStr2 = oldStr + "_div2";
	               var oldStr3 = "#" + oldStr + " dl";
	               var oldStr4 = "#" + oldStr + " h3";
		           document.getElementById(oldStr1).style.display = "";
		           document.getElementById(oldStr2).style.display = "none";
				   $(oldStr3).removeClass("xz");
				   $(oldStr4).removeClass("xz");
               }
               var str1 = str + "_div1";
               var str2 = str + "_div2";
               var str3 = "#" + str + " dl";
               var str4 = "#" + str + " h3";
	           document.getElementById(str1).style.display = "none";
	           document.getElementById(str2).style.display = "";
			   $(str3).addClass("xz");
			   $(str4).addClass("xz");
			   oldStr = str;
           }
       }
        
    </script>
</body>
</html>
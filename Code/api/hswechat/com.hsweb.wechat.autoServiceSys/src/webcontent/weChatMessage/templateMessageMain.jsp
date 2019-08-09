<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-02-21 09:11:16
  - Description:
-->
<head>
<title>模板消息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	<div class="nui-toolbar" style="padding:0px;">
       <table style="width: 100%; border: 1px solid #e3e3e3;padding-left:5px;border-top: 0px;">						
			<tr>
				<td style="font-size: 9pt;display: flex;">
					<a class="nui-button" onclick="queryTemplateData()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查看详情</a> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-fit" >
		<div id="templateData" class="nui-datagrid" style="height:100%;" allowResize="true"
	        dataField="templateDataArray" pageSize="12" showPager="false" showPageInfo="true" allowCellSelect="false" multiSelect="false">
            <div property="columns">
            	<div type="checkcolumn" width="20" >选择</div>
            	<div type="indexcolumn" width="25" >序列</div>
            	<div field="templateId" headerAlign="center" align="center" >模板ID</div>
            	<div field="title" headerAlign="center" align="center"  >模板标题</div>
            	<div field="primaryIndustry"  headerAlign="center" align="center"  >一级行业</div>
            	<div field="deputyIndustry"  headerAlign="center" align="center"  >二级行业</div>
            </div>
        </div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	var templateData = nui.get("templateData");
    	
    	$(function(){
    		templateData.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.queryWeChatTemplateMess.biz.ext");
			templateData.load({token:token});
		});
		
		//点击查看详情
		function queryTemplateData(){
			var row = templateData.getSelected();
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/weChatMessage/templateInfor.jsp",
					title: "模板详情",
					width: 900,
					height: 400,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							templateData:row
						};
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						
					}
				});
			}else{
				nui.alert("请选择一条模板消息数据");
			}
		}
		
    </script>
</body>
</html>
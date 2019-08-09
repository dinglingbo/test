<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/autoServiceSys/common/wechatCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2018-12-26 16:08:41
  - Description:
-->
<head>
<title>门店管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
   <style type="text/css">
                body {
        margin: 0; 
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%; 
        overflow: hidden;
        font-family: "微软雅黑";
    }
	    .mini-checkboxlist{
	    	padding-top:2px;
	    }
	    table{
	    	font-size: 12px;
	    }
	    .labeltext{
	    	font-family:Verdana;
	    	line-height: 25px;
	    }
	    .inputLeft{
	    	margin-right: 6px;
	    }
	    .mini-grid-cell{
	    	height: 32px;
	    }
    </style>
</head>
<style>

</style>
<body >
	<div id="form1" class="nui-form"  >
	<div class="nui-toolbar" style="padding:0px;">
		<table style="width: 100%; ">						
			<tr>
				<td style="font-size: 12px;">
					<label class="labeltext" >门店名称：</label>
					<input name="storeName" class="nui-textbox inputLeft"  />
					<a class="nui-button" onclick="search()" plain="true" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a> 
					<a class="nui-button" onclick="reset()" plain="true" ><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>
					 <span class="separator"></span>
					<a class="nui-button" onclick="add()" plain="true" ><span class="fa fa-plus fa-lg"></span>&nbsp;门店添加</a>
					<a class="nui-button" onclick="edit()" plain="true" ><span class="fa fa-edit fa-lg"></span>&nbsp;门店编辑</a>
					<a id="deleteStore" class="nui-button" onclick="deleteStore" plain="true" ><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
				</td>
			</tr>
		</table>
	</div>
	</div>	
	<div class="nui-fit" >
		<div id="storeGrid" class="nui-datagrid" style="height:100%;" allowResize="true"
	       	onpreload="onbeforeloadStore"  onrowclick="rowclick" dataField="storeData" pageSize="12" showPageInfo="true" multiSelect="false" allowCellSelect="false" >
            <div property="columns">
            	<div type="checkcolumn" >选择</div>
            	<div field="storeName" headerAlign="center" align="center" width="60" >微信门店名称</div>
            	<div field="name" headerAlign="center" align="center" width="60" >公司名称</div>
            	<div field="storeBusinessBeginTime" headerAlign="center"  width="50" align="center" >门店营业开始时间</div>
            	<div field="storeBusinessEndTime" headerAlign="center"  width="50" align="center" >门店营业结束时间</div>
            	<div field="tel" headerAlign="center" align="center"   width="60" >门店电话</div>
            	<div field="address" headerAlign="center" align="left"  width="160" >门店地址</div>
            	<div field="creator" headerAlign="center"  width="40" align="center" >创建人</div>
            	<div field="createDate" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" width="60">创建时间</div>
            	<div field="modifier" headerAlign="center"  width="40" align="center" >更改人</div>
            	<div field="modifyDate" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" width="60">更改时间</div>
            	<div field="storeCodeTicket" headerAlign="center"  width="68" align="center" renderer="onStoreCodeTicket" >门店微信公众号二维码</div>
            </div>
        </div>
	</div>

		
	
	<script type="text/javascript">
		nui.parse();
		var pathapi=apiPath+wechatApi;
		var pathweb=webPath+wechatDomain;
		var storeGrid = nui.get("storeGrid");
    	/* var urlString = "http://qxy60.hszb.harsons.cn/systemApi"; */
    	var urlString=apiPathUrl+sysApi;
    	
    	$(function(){
    		storeGrid.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStore.biz.ext?token="+token);
			storeGrid.load({token:token});
			
		});
		
		//二维码
		function onStoreCodeTicket(e){
			return '<a  href="javascript:void()" class="storeCode'+e.record.storeId+'" ticket="'+e.value+'" style="text-decoration: none;border: 1px solid #2779AA;border-radius: 10px;padding: 4px;font-size: 11px;color: #6279BB;" onclick="openWechtCode(\'storeCode'+e.record.storeId+'\')" >点击查看</a>';
		}
		
		function openWechtCode(className){
			var classNames="."+className;
			var ticket=$(classNames).attr("ticket");
			window.open("https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket="+ticket);
		}
		
		//删除门店
		function deleteStore(){
			var row = storeGrid.getSelected();
			if(row){
				var storeData={
					storeId:row.storeId
				};
				var json=nui.encode({storeData:storeData});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.deleteStoreInfo.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.errCode == "S"){
							showMsg("删除成功","S");
							storeGrid.reload();
						}else{
							showMsg("删除失败","E");
						}
					}
				});
			}else{
				showMsg("请选择一条数据","W");
			}
		}
		
		//选择行的时候触发
		function rowclick(e){
			var record=e.record;
			if(record.storeBool){
				$("#deleteStore").show();
			}else{
				$("#deleteStore").hide();
			}
		}
		
		//查询
		function onbeforeloadStore(e){
			var arrayData = e.data;
			for(var a=0;a<arrayData.length;a++){
				var params={
					orgid:arrayData[a].orgid
				};
				var json=nui.encode({params:params,token:token});
				nui.ajax({
					url: urlString+"/com.hsapi.system.basic.organization.getCompanyAll.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						console.log(text);
						var companyList=text.companyList;
						arrayData[a].name=companyList[0].name;
						arrayData[a].address=companyList[0].address;
						arrayData[a].tel=companyList[0].tel;
					}
				});
			}
		}
		
		//搜索
    	function search(){
    		var formData = new nui.Form("#form1").getData(false, false);
        	storeGrid.load({storeName:formData.storeName,token:token});
    	}
		
		//清空
    	function reset(){
    		var form = new nui.Form("#form1");
			form.reset();
    	}
    	
    	//新增
		function add() {
			nui.open({
				url: pathweb+"/autoServiceSys/storeManagement/addStoreMain.jsp",
				title: "添加门店",
				width: 700,
				height: 640,
				onload: function() { //弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {
						pageType: "add"
					}; //传入页面的json数据
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function(action) { //弹出页面关闭前
					console.log(action);
					if(action == 'saveSuccess') {
						showMsg("添加成功","S");
						storeGrid.reload();
					}else if(action == "saveFail"){
						showMsg("添加失败","E");
					}
				}
			});
		}
		
		//编辑
		function edit() {
			var row = storeGrid.getSelected();
			if(row){
				nui.open({
					url: pathweb+"/autoServiceSys/storeManagement/addStoreMain.jsp",
					title: "添加门店",
					width: 700,
					height: 640,
					onload: function() { //弹出页面加载完成
						var iframe = this.getIFrameEl();
						var data = {
							pageType: "edit",
							storeData:row
						}; //传入页面的json数据
						iframe.contentWindow.setFormData(data);
					},
					ondestroy: function(action) { //弹出页面关闭前
						if(action == 'saveSuccess') {
							showMsg("编辑成功","S");
							storeGrid.reload();
						}else if(action == "saveFail"){
							showMsg("编辑失败","E");
						}
					}
				});
			}else{
				showMsg("请选择一条门店数据","W");
			}
			
		}
	</script>
</body>
</html>
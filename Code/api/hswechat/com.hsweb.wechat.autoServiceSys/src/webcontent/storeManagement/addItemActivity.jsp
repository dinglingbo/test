<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/autoServiceSys/common/wechatCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String webcssPath = webPath + wechatDomain;
 %>
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-03-20 16:01:55
  - Description:
-->
<head>
<title>项目活动添加</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
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
	    .mini-panel{
	    	z-index: 99;
	    }
	    .imgA{
	    	height: 150px;
    		width: 140px;
    		display: table-cell;
    		text-align: center;
    		vertical-align: middle;
    		border: 1px solid #DFDFDF;
   			background: url(<%=webcssPath %>/autoServiceSys/images/bg.png) no-repeat scroll center 0px transparent;
	    }
	    .divImg{
	    	width: 120px;
    		margin: auto;
	    }
	    .imgStyle{
	    	border: none;
		    max-width: 100%;
		    height: auto;
		    vertical-align: middle;
	    }
	    .windowsss{
	    	z-index: 100;
	    	margin: auto;
	    	position: absolute;
	    	top: 0;
	    	left: 0;
	    	right: 0;
	    	bottom: 0;
	    }
	    .imgList{
	    	overflow: auto;
	    	border: 1px solid #B8B8B8;
		    border-radius: 5%;
		    height: 500px;
		    width: 315px;
		    padding: 10px;
	    }
	    .imgListA{
	    	display: flex;
	    	border-bottom: 2px solid #f2f5f7;
	    }
	    .imgListOneDiv{
	    	background: none repeat scroll 0 0 rgba(229, 229, 229, 0.85);
    		position: absolute;
    		width: 278px;
    		
    		height: 182px;
    		padding-top: 50px;
	    }
	    .imgListone{
		    width: 28px;
    		height: 28px;
    		position: relative;
    		margin-left: 35%;
    		cursor: pointer;
	    }
	    .imgListtwo{
		   	width: 28px;
    		height: 28px;
    		position: relative;
    		margin-left: 5%;
    		cursor: pointer;
	    }
	    label{
	    	font-size: 13px;
	    }
    </style>
</head>
<body>
	
	<div class="nui-toolbar" style="padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
	</div>
	
	<div class="form" id="storeItemActivityInfoForm" name="storeEmpInfoForm" style="height:85%;left:0;right:0;margin: 0 auto;display: flex;padding: 10px;padding-right: 25px;">
		<input class="nui-textbox" name="pageType" id="pageType" visible="false"/>
		<input class="nui-textbox" name="itemActivityId" id="itemActivityId" visible="false"/>
		<table style="width:100%;margin-left: 30px;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
				<tr>
					<td class="nui-form-label" colspan="1" style="width: 20%;" >
						<label>活动照片:<span style='color:red'>建议尺寸（414像素*519像素）</label>
					</td>
					<td colspan="3">
						<a href="#" class="imgA">
							<div class="divImg" >
								<img id="imgshowOnly" alt="" src="#" class="imgStyle" >
							</div>
						</a>
						<form id="uploadOnly" action="" target="hidden_frameOnly" method="post" enctype="multipart/form-data" style="display:none;" >
							<input id="fileImageOnly" type="file" size="30" accept="image/png,image/jpeg" name="fileselect[]">
						</form>
						<iframe name='hidden_frameOnly' id="hidden_frameOnly" style="display:none;" ></iframe>
					</td>
				</tr>
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>门店：</label>
				</td>
				<td colspan="3">
					<input id="storeId" name="storeId" class="nui-combobox" onvaluechanged="OnStore" required="true" style="margin-right: 30px;"  textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1">
					<label>项目活动标题：</label>
				</td>
				<td colspan="1">
					<input class="nui-textbox tabwidth" name="itemActivityTitle" id="itemActivityTitle" required="true"/>
				</td>
				<td class="nui-form-label" colspan="1" >
					<label>服务项目：</label>
				</td>
				<td colspan="1" >
					<input id="serviceItemId" name="serviceItemId" class="nui-buttonedit" required="true" style="margin-right: 30px;" onbuttonclick="serviceItemIdclick" />
					<input id="serviceItemName" name="serviceItemName" class="nui-textbox" " style="margin-right: 30px;display:none;" />
				</td>
			</tr>
			
		</table>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
		var pathweb=webPath+wechatDomain;
    	var storeId = nui.get("storeId");
    	
    	$(function(){
    		//$("#uploadOnly").attr("action", pathweb+"/autoServiceSys/storeManagement/uploadImage.jsp");
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			storeId.select(0);
		});
		
		
		//传输数据
		function setFormData(info){
			var data=nui.clone(info);
			nui.get("pageType").setValue(data.pageType);
			//console.log(data);
			if(data.pageType == "edit"){
				var form = new nui.Form("#storeItemActivityInfoForm"); //将普通form转为nui的form
				form.setData(data.storeItemActivityData);
				nui.get("pageType").setValue(data.pageType);
				$('#imgshowOnly').get(0).src = data.storeItemActivityData.itemUrl;
				nui.get("serviceItemId").setText(data.storeItemActivityData.serviceItemName);
				nui.get("serviceItemId").setValue(data.storeItemActivityData.serviceItemId);
			}else{
				nui.get("storeId").setText(data.storeName);
				nui.get("storeId").setValue(data.storeId);
			}
		}
		
		//门店名称
		function OnStore(){
			nui.get("serviceItemId").setText("");
			nui.get("serviceItemId").setValue("");
		}
		
		//服务项目点击选择
		function serviceItemIdclick(){
			if(!nui.get("storeId").getValue()){
				showMsg("请先选择门店","W");
				return;
			}
			nui.open({
				url: pathweb+"/autoServiceSys/weChatCardCoupon/itemsChoose.jsp",
				title: "项目选择",
				width: 960,
				height: 420,
				onload: function() { //弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {
						storeId:nui.get("storeId").getValue()
					};
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function(action) { //弹出页面关闭前
					var iframe = this.getIFrameEl();
					var data=iframe.contentWindow.getFormData();
					nui.get("serviceItemId").setValue(data.serviceItemId);
					nui.get("serviceItemId").setText(data.serviceItemName);
					nui.get("serviceItemName").setValue(data.serviceItemName);
				}
			});
		}
		
		//保存
		function save(){
			var form = new nui.Form("#storeItemActivityInfoForm");
			form.setChanged(false);
    		form.validate();
			if(form.isValid() == false) return;
			var data = form.getData(false, true);
			//console.log(data);
			
			//员工照片的验证
			if( $("#fileImageOnly")[0].files.length == 0 && nui.get("pageType").getValue() == "add"){
				showMsg("活动照片不能为空","W");
				return;
			}
			data.tenantId=nui.get("storeId").getSelected().tenantId;
			//检验门店活动项目和标题是否重复
			var json=nui.encode({storeId:data.storeId,serviceItemId:data.serviceItemId,itemActivityTitle:data.itemActivityTitle});
			nui.ajax({
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreItemActivity.judgeStoreItemActivity.biz.ext?token="+token,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text){
					if( ( text.resturns && nui.get("pageType").getValue() == "add" ) || ( text.resturns && nui.get("pageType").getValue() == "edit" ) || ( !text.resturns && nui.get("pageType").getValue() == "edit" && text.itemActivityId == data.itemActivityId ) ){
						var fileImageOnly = $('#fileImageOnly').get(0).files[0];
						if(fileImageOnly){
							/* $("#uploadOnly").submit();//图片上传		
							$('#hidden_frameOnly').load(function(){
								var text=$(this).contents().find("body").text();//获得上传之后返回的参数
								var imagerData=nui.decode(text);
								data.itemUrl=imagerData.pictureUrl;
								saveStoreItemActivity(data);
							}); */
							//上传活动图片
							uploadImageFiles(fileImageOnly,data);
						}else{
							saveStoreItemActivity(data);
						}
					}else{
						showMsg(text.message,"W");
					}
				}
			});
			
		}
		
		//上传文件
		function uploadImageFiles(fileImageOnly,data){
			nui.ajax({
				url: webPathUrl+"/dms/com.hs.common.login.getQNAccessToken.biz.ext?token="+token,
				type: 'POST',
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text){
					var token = text.token;
					//文件上传
					var uploadImageformData = new FormData();
	                uploadImageformData.append("file",fileImageOnly);
	                uploadImageformData.append("token",token);
	                $.ajax({
	                    url: "http://up-z2.qiniup.com",
	                    type: "POST",
	                    data: uploadImageformData,
	                    contentType: false,
	                    processData: false,
	                    success: function (fileDatas) {
	                    	data.itemUrl = uploadImageUrl + fileDatas.hash;
							saveStoreItemActivity(data);
	                    },
	                    error: function () {
	                        showMsg("图片上传失败,请重新选择","W");
	                    }
	                });
				}
			});
		}
		
		//保存
		function saveStoreItemActivity(data){
			if(nui.get("pageType").getValue() == "add"){
				var json=nui.encode({storeItemActivity:data});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreItemActivity.addStoreItemActivity.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.errCode == "S"){
							CloseWindow("saveSuccess");
						}else{
							CloseWindow("saveFail");
						}
					}
				});
			}else if(nui.get("pageType").getValue() == "edit"){
				var json=nui.encode({storeItemActivity:data});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreItemActivity.editStoreItemActivity.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.errCode == "S"){
							CloseWindow("editSuccess");
						}else{
							CloseWindow("editFail");
						}
					}
				});
			}
			
		}
		
		
		//图片选择预览
		$(".imgA").click(function(){
			$("#fileImageOnly").click();
		});
		
		
		//在input file内容改变的时候触发事件
    	$('#fileImageOnly').change(function(){
    		if( $('#fileImageOnly').get(0).files.length == 0 ){
    			$("#imgshowOnly").attr("src", pathweb+"/autoServiceSys/images/add_img.png");
    			return;
    		}
    		//获取input file的files文件数组;$('#filed')获取的是jQuery对象，.get(0)转为原生对象;这边默认只能选一个，但是存放形式仍然是数组，所以取第一个元素使用[0];
      		var file = $('#fileImageOnly').get(0).files[0];
    		//创建用来读取此文件的对象
      		var reader = new FileReader();
    		//使用该对象读取file文件
      		reader.readAsDataURL(file);
    		//读取文件成功后执行的方法函数
      		reader.onload=function(e){
	    		//读取成功后返回的一个参数e，整个的一个进度事件
	        	//console.log(e);
	    		//选择所要显示图片的img，要赋值给img的src就是e中target下result里面的base64编码格式的地址
	        	$('#imgshowOnly').get(0).src = e.target.result;
      		}
    	});
		
		//取消
		function onCancel() {
			CloseWindow("cancel");
		}
		
		//关闭窗口
		function CloseWindow( action ) {
			if(action == "close" && form.isChanged()) {
				if(confirm("数据被修改了，是否先保存？")) {
					saveData();
				}
			}
			if(window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				window.close();
		}
    </script>
</body>
</html>
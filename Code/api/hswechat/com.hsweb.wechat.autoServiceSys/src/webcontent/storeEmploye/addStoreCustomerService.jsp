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
<title>添加客服</title>
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
		<!-- 员工选择 -->
		<div id="advancedOrgWin" class="nui-window windowsss"
		     title="员工选择" style="width:530px;height:430px;margin: 3% 10%;"
		     showModal="true"
		     showHeader="false"
		     allowResize="false"
		     style="padding:2px;border-bottom:0;"
		     allowDrag="true">
		     <div class="nui-toolbar" >
		        <table style="width:100%;">
		            <tr>
		                <td style="width:100%;">
		                    <input class="nui-textbox" id="employeNamess" name="employeNamess" onenter="searchOrg" width="160px" emptyText="请输入员工姓名">
		                    <a class="nui-button" iconCls="" plain="true" onclick="searchOrg" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
		                    <a class="nui-button" iconCls="" plain="true" onclick="addCustomerServiceEmp" id=""><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
		                    <a class="nui-button" iconCls="" plain="true" onclick="onOrgClose" id=""><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
		                </td>
		            </tr>
		        </table>
		    </div>
		   <div class="nui-fit" style="padding-left: 3px; padding-right: 3px; padding-bottom: 3px; height:88%;">
		    	<div id="moreOrgGrid" class="nui-datagrid" style="height:100%;" allowResize="true"
			       	 dataField="storeEmployeDataArray" onrowdblclick="addCustomerServiceEmp" pageSize="12" showPageInfo="true" multiSelect="false" allowCellSelect="false" >
		            <div property="columns">
		            	<div type="checkcolumn" >选择</div>
		            	<div field="employeName" headerAlign="center" align="center" width="60" >员工姓名</div>
		            	<div field="employePhone" headerAlign="center"  width="50" align="center" >手机号</div>
		            	<div field="employePosition" headerAlign="center" align="center" renderer="onEmployePosition"  width="60" >职务</div>
		            </div>
		        </div>
		    </div>
		</div>
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
	
	<div class="form" id="storeEmpInfoForm" name="storeEmpInfoForm" style="height:85%;left:0;right:0;margin: 0 auto;display: flex;padding: 10px;padding-right: 25px;">
		<input class="nui-textbox" name="pageType" id="pageType" visible="false"/>
		<input class="nui-textbox" name="serviceId" id="serviceId" visible="false"/>
		<table style="width:100%;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>门店：</label>
				</td>
				<td colspan="1">
					<input id="storeId" name="storeId" class="nui-combobox" required="true" style="margin-right: 30px;" onvaluechanged="OnStoreId" textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
				</td>
				<td class="nui-form-label" colspan="1" >
					<label>员工选择：</label>
				</td>
				<td colspan="1">
					<input class="nui-buttonedit" id="employeName" name="employeName" textname="employeName" emptyText="请选择员工" onbuttonclick="selectCustomer" selectOnFocus="true" required="true"  />
					<input class="nui-textbox" name="employeId" id="employeId" visible="false"/>
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" >
					<label>客服类别：</label>
				</td>
				<td colspan="1">
					<div id="serviceType" name="serviceType" class="nui-radiobuttonlist" textField="text" valueField="id" required="true" repeatLayout="none" value="1" data='[{"id":1,"text":"服务客服"},{"id":2,"text":"技术客服"}]' />
				</td>
				<td class="nui-form-label" colspan="1"  >
					<label>可管理人数：</label>
				</td>
				<td colspan="3">
					<input class="nui-spinner" name="serviceMaxNumber" id="serviceMaxNumber" required="true" minValue="1" onvalidation="OnServiceMaxNumber" />
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" style="width: 20%;" >
					<label>微信二维码:<span style='color:red'>(推荐尺寸为:430像素*430像素)</label>
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
			
		</table>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
		var pathweb=webPath+wechatDomain;
    	var storeId = nui.get("storeId");
    	var moreOrgGrid = nui.get("moreOrgGrid");
    	var manageNumber = 0;
    	
    	
    	$(function(){
    		//$("#uploadOnly").attr("action", pathweb+"/autoServiceSys/storeManagement/uploadImage.jsp");
    		moreOrgGrid.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreEmploye.queryStoreEmploye.biz.ext");
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			storeId.select(0);
			searchOrg();
		});
		
		
		//传输数据
		function setFormData(info){
			var data=nui.clone(info);
			nui.get("pageType").setValue(data.pageType);
			if(data.pageType == "edit"){
				var form = new nui.Form("#storeEmpInfoForm"); //将普通form转为nui的form
				form.setData(data.customeerServiceEmpDataArray);
				manageNumber = data.customeerServiceEmpDataArray.manageNumber;
				nui.get("pageType").setValue(data.pageType);
				$('#imgshowOnly').get(0).src = data.customeerServiceEmpDataArray.employeWechatImg;
				nui.get("employeName").setText(data.customeerServiceEmpDataArray.employeName);
				nui.get("employeName").setValue(data.customeerServiceEmpDataArray.employeName);
			}
		}
		
		//验证可管理人数不能小于管理人数
		function OnServiceMaxNumber(e){
			if (e.isValid) {
                if ( e.value == 0) {
                    e.errorText = "不能为零";
                    e.isValid = false;
                }else if( nui.get("pageType").getValue() == "edit" && e.value < Number(manageNumber) ){
                	e.errorText = "可管理人数不能小于管理人数";
                    e.isValid = false;
                }
            }
		}
		
		//职务
		function onEmployePosition(e){
			return e.value == 1 ? "客服" : "技师";
		}
		
		//保存
		function save(){
			var form = new nui.Form("#storeEmpInfoForm");
			form.setChanged(false);
    		form.validate();
			if(form.isValid() == false) return;
			var data = form.getData(false, true);
			
			//员工照片的验证
			if( $("#fileImageOnly")[0].files.length == 0 && nui.get("pageType").getValue() == "add"){
				showMsg("微信二维码不能为空","W");
				return;
			}
			
			//检验员工下的客服是否重复
			var json=nui.encode({storeId:data.storeId,employeId:data.employeId});
			nui.ajax({
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreEmploye.judgeCustomerServiceEmp.biz.ext?token="+token,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text){
					if( ( text.resturns && nui.get("pageType").getValue() == "add" ) || ( text.resturns && nui.get("pageType").getValue() == "edit" ) || ( !text.resturns && nui.get("pageType").getValue() == "edit" && text.serviceId == data.serviceId ) ){
						var fileImageOnly = $('#fileImageOnly').get(0).files[0];
						if(fileImageOnly){
							/* $("#uploadOnly").submit();//图片上传		
							$('#hidden_frameOnly').load(function(){
								var text=$(this).contents().find("body").text();//获得上传之后返回的参数
								var imagerData=nui.decode(text);
								data.employeWechatImg=imagerData.pictureUrl;
								saveCustomerServiceEmploye(data);
							}); */
							//二维码上传
							uploadImageFiles(fileImageOnly,data);
						}else{
							saveCustomerServiceEmploye(data);
						}
					}else{
						showMsg("门店下已有此员工,请重新选择","W");
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
	                    	data.employeWechatImg = uploadImageUrl + fileDatas.hash;
							saveCustomerServiceEmploye(data);
	                    },
	                    error: function () {
	                        showMsg("图片上传失败,请重新选择","W");
	                    }
	                });
				}
			});
		}
		
		//保存员工信息
		function saveCustomerServiceEmploye(data){
			if(nui.get("pageType").getValue() == "add"){
				var json=nui.encode({customerServiceEmp:data});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreEmploye.addCustomerServiceEmp.biz.ext?token="+token,
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
				var json=nui.encode({customerServiceEmp:data});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStoreEmploye.editCustomerServiceEmp.biz.ext?token="+token,
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
		
		//选择门店
		function OnStoreId(){
			nui.get("employeName").setValue("");
			nui.get("employeName").setText("");
			nui.get("employeId").setValue("");
		}
		
		
		//取消
		function onOrgClose(){
			$("#advancedOrgWin").hide();
			nui.get("employeNamess").setValue("");
		}
		
		//选择车道系统员工
		function selectCustomer(){
			$("#advancedOrgWin").show();
	    	searchOrg();
	    }
		
		//查询车道系统员工信息
		function searchOrg(){
			var storeData=storeId.getSelected();
			var params = {};
		    params.employeName = nui.get("employeNamess").getValue();
		    params.storeId = storeData.storeId+"";
		    params.employePosition=1;
			moreOrgGrid.load({map:params,token:token});
		}
		
		//选择员工
		function addCustomerServiceEmp(){
			var row = moreOrgGrid.getSelected();
			if(row){
				nui.get("employeName").setValue(row.employeName);
				nui.get("employeName").setText(row.employeName);
				nui.get("employeId").setValue(row.employeId);
				
				nui.get("employeNamess").setValue("");
				$("#advancedOrgWin").hide();
			}else{
				showMsg("请选择一条员工数据","W");
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
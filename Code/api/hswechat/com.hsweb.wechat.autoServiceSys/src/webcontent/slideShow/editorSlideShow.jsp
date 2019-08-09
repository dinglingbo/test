<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<% String webcssPath = webPath + wechatDomain; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-01-08 08:31:38
  - Description:
-->
<head>
<title>添加门店</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
	    .mini-checkboxlist{
	    	padding-top:2px;
	    }
	    body{
	    	font-size:12px;
	    }
	    .imgA{
	    	height: 180px;
    		width: 360px;
    		display: table-cell;
    		text-align: center;
    		vertical-align: middle;
    		border: 1px solid #DFDFDF;
   			background: url(<%=webcssPath %>/autoServiceSys/images/bg.png) no-repeat scroll center 0px transparent;
	    }
	    .divImg{
	    	width: 360px;
    		height:180px
    		
	    }
	    .imgStyle{
	    	border: none;
		    max-width: 100%;
		    height: 180px;
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
	    	font-size: 14px;
	    }
    </style>
</head>
<body>

	<div class="nui-fit">
	
		<!-- 车道系统门店选择 -->
		<div id="advancedOrgWin" class="nui-window windowsss"
		     title="公司选择" style="width:530px;height:340px;"
		     showModal="true"
		     showHeader="false"
		     allowResize="false"
		     style="padding:2px;border-bottom:0;"
		     allowDrag="true">
		     <div class="nui-toolbar" >
		        <table style="width:100%;">
		            <tr>
		                <td style="width:100%;">
		                    <input class="nui-textbox" id="orgidOrName" name="orgidOrName" width="160px" emptyText="请输入店号或公司名">
		                    <a class="nui-button" iconCls="" plain="true" onclick="searchOrg()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
		                    <a class="nui-button" iconCls="" plain="true" onclick="addOrg" id=""><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
		                    <a class="nui-button" iconCls="" plain="true" onclick="onOrgClose" id=""><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
		                </td>
		            </tr>
		        </table>
		    </div>
		    <div class="nui-fit">
		          <div id="moreOrgGrid" class="nui-datagrid" style="width:100%;height:100%;"
		               selectOnLoad="true"
		               showPager="false"
		               dataField="orgList"
		               onrowdblclick="addOrg"
		               allowCellSelect="true"
		               editNextOnEnterKey="true"
		               allowCellWrap = true
		               allowCellSelect="true" 
		               multiSelect="false"
		               url="">
		              <div property="columns">
		              	<div type="checkcolumn" width="15" class="mini-radiobutton" header="选择"></div>
		                <div field="orgcode" name="orgid" width="15" align="center"  visible="true" headerAlign="center" header="企业号"></div>
		                <div field="orgname" name="orgname" width="" align="center"  headerAlign="center" header="公司名称"></div>
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
    	<div style="margin-top:40px;">
			<span style="padding-left:180px;font-size:18px">轮播图</span>
		</div>
		<div style="margin-top: 5px;">
			<span style="font-size: 15px;color: red;padding-left:75px"">轮播图建议尺寸（414像素*180像素）</span>
		</div>
    	<div class="form" id="showFrom" name="showFrom" style="height:90%;left:0;right:0;margin: 0 auto;display: flex;padding-top: 10px;padding-left: 10px;">
			<table style="width:100%;margin-left: 30px;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
				<tr>
					<td colspan="4">
						<a href="#" class="imgA">
							<div class="divImg" >
								<img id="imgshowOnly" alt="" src="#" class="imgStyle" >
							</div>
						</a>
						<form id="uploadOnly" action="" target="hidden_frameOnly" method="post" enctype="multipart/form-data" style="display:none;" >
							<input id="fileImageOnly" type="file" size="30" accept="image/png,image/jpeg" name="fileselect[]">
							<button type="button" id="fileSubmitOnly" onclick="uploadOnlyFile()" >确认上传文件</button>
						</form>
						<iframe name='hidden_frameOnly' id="hidden_frameOnly" style="display:none;" ></iframe>
						
						<input class="nui-textbox" name="pageType" id="pageType" visible="false"/>
					</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1" style="width: 15%;" >
						<label>轮播图标题:</label>
					</td>
					<td colspan="3">
						<input class="nui-textbox tabwidth" name="storeName" id="storeName" required="true"/>
					</td>
				</tr>
				<tr>
								<td class="nui-form-label" colspan="1" style="width: 25%;" >
									<label>门店选择：</label>
								</td>
								<td colspan="1">
									<input id="storeId" name="storeId" class="nui-combobox" required="true" style="margin-right: 30px;" textField="storeName" value="" url="com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext" valueField="storeId" dataField="wechatStoreData" />
								</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1" style="width: 15%;" >
						<label>图片跳转地址:</label>
					</td>
					<td colspan="3">
						<input class="nui-textbox tabwidth" name="storeName" id="storeName" required="true"/>
					</td>
				</tr>
				<tr>
					<td>
						<form id="upload" action="" target="hidden_frame" method="post" enctype="multipart/form-data" style="display:none;" >
							<input id="fileImage0" class="fileImage0 images" type="file" size="30" accept="image/png,image/jpeg" name="fileImage0">
							<button type="button" id="fileSubmit" onclick="uploadFile()" >确认上传文件</button>
						</form>
						<iframe name='hidden_frame' id="hidden_frame" style="display:none;" ></iframe>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	


	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	
    	$(function(){
    		init();
		});
		
		function init(){
			$("#imgshowOnly").attr("src", pathweb+"/autoServiceSys/images/add_img.png");
			$("#uploadOnly").attr("action", pathweb+"/autoServiceSys/storeManagement/uploadImage.jsp");
		    $("#upload").attr("action", pathweb+"/autoServiceSys/storeManagement/uploadImage.jsp");
		}
		
		//页面间传输json数据
		function setFormData(data) {
			var infos = nui.clone(data);
			nui.get("pageType").setValue(infos.pageType);
			if(infos.pageType == "edit"){
				var form = new nui.Form("#dataform1"); //将普通form转为nui的form
				form.setData(infos.storeData);
			}
			/*//跨页面传递的数据对象，克隆后才可以安全使用
			var infos = nui.clone(data);
			//nui.get("pageType").setValue(infos.pageType);
			console.log(infos);
			if(infos.pageType == "edit"){
				var form = new nui.Form("#dataform1"); //将普通form转为nui的form
				form.setData(infos);
				nowrestaurantName=infos.restaurant.restaurantName;
				nui.get("restaurantEmpId").setValue(infos.restaurant.restaurantEmpId);
				nui.get("restaurantEmpId").setText(infos.restaurant.restaurantEmpName);
				form.setChanged(false);
			} */
		}
		
		//保存
		function save(){
			var form = new nui.Form("#showFrom");
			form.setChanged(false);
			
    		form.validate();
			if(form.isValid() == false) return;
			var data = form.getData(false, true);
			
			
			//门店图片的验证
			if( $("#fileImageOnly")[0].files.length == 0 ){
				nui.alert("轮播图不能为空");
				return;
			}
			
			//门店图片上传			
			$("#uploadOnly").submit();
			$('#hidden_frameOnly').load(function(){
				var text=$(this).contents().find("body").text();//获得上传之后返回的参数
				var imagerData=nui.decode(text);
				data.storePicture=imagerData.pictureUrl;
			});
		}
		
		//图片选择预览
		$(".imgA").click(function(){
			$("#fileImageOnly").click();
		});
		
		//单文件上传,点击上传文件事件
		function uploadOnlyFile(){
			$("#uploadOnly").submit();
			$('#hidden_frameOnly').load(function(){
				var text=$(this).contents().find("body").text();//获得上传之后返回的参数
				//console.log(text,nui.decode(text));
			});
			
		}
		
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
	        	console.log(e);
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
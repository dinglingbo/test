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
  - Date: 2019-01-08 08:31:38
  - Description:
-->
<head>
<title>添加轮播图</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
	    .mini-checkboxlist{
	    	padding-top:2px;
	    }
	    body{
	    	font-size:12px;
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
	    
	    .imgListContent::-webkit-scrollbar { 
	    	background: #F2F5F7;
    		border-radius: 100%;
	    }
	    
	    .imgListContent::-webkit-scrollbar-thumb{
	    	display: block;
		    margin: 0 auto;
		    border-radius: 10px;
		    background: #ccc;
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
	<!-- 项目选择 -->
	<div id="advancedOrgWin" class="nui-window windowsss"
	     title="项目选择" style="width:480px;height:70px;"
	     showModal="true"
	     showHeader="false"
	     allowResize="false"
	     style="padding:2px;border-bottom:0;"
	     allowDrag="true">
		<div class="nui-toolbar" style="height:68%;">
	    	<table style="height:100%;">
				<tr style="width:100%;">
					<td class="nui-form-label" colspan="1" style="width: 18%;" >
						<label>服务项目：</label>
					</td>
					<td colspan="1" >
						<input id="numData" name="numData" class="nui-textbox" " style="margin-right: 30px;display:none;" />
						<input id="serviceItemId" name="serviceItemId" class="nui-buttonedit" style="margin-right: 30px;" onvaluechanged="onserviceItemIdChanged" onbuttonclick="serviceItemIdclick" />
						<input id="serviceItemName" name="serviceItemName" class="nui-textbox" " style="margin-right: 30px;display:none;" />
						<a class="nui-button" iconCls="" plain="true" onclick="addOrg" id=""><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
	                    <a class="nui-button" iconCls="" plain="true" onclick="onOrgClose" id=""><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
					</td>
				</tr>
				
			</table>
		</div>
	</div>
	
	<div class="nui-fit">
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
    	<div class="form" id="showInForm" name="showInForm" style="height:90%;left:0;right:0;margin: 0 auto;display: flex;padding-top: 10px;padding-left: 10px;">
			
			<table style="width: 50%;margin-left: 30px;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
				<tr>
					<td class="nui-form-label" colspan="1" style="width: 25%;" >
						<label>轮播图图片:</label>
					</td>
					<td colspan="3">
						<a href="#" class="imgA">
							<div class="divImg" >
								<img id="imgshowOnly" alt="" src="#" class="imgStyle" >
							</div>
						</a>
						<div style="font-size: 12px;color:red;">建议尺寸（414像素*180像素）</div>
						<form id="uploadOnly" action="" target="hidden_frameOnly" method="post" enctype="multipart/form-data" style="display:none;" >
							<input id="fileImageOnly" type="file" size="30" accept="image/png,image/jpeg" name="fileselect[]">
							<button type="button" id="fileSubmitOnly" onclick="uploadOnlyFile()" >确认上传文件</button>
						</form>
						<iframe name='hidden_frameOnly' id="hidden_frameOnly" style="display:none;" ></iframe>
						
						<input class="nui-textbox" name="pageType" id="pageType" visible="false"/>
						<input class="nui-textbox" name="wxbSlideshowId" id="wxbSlideshowId" visible="false"/>
					</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1" >
						<label>门店：</label>
					</td>
					<td colspan="3">
						<input id="storeId" name="storeId" class="nui-combobox" required="true" style="margin-right: 30px;"  textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
					</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1">
						<label>项目活动标题：</label>
					</td>
					<td colspan="1">
						<input class="nui-textbox tabwidth" name="wxbTitle" id="wxbTitle" required="true"/>
					</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1">
						<label>轮播图顺序：</label>
					</td>
					<td colspan="1">
						<input class="nui-textbox tabwidth" name="wxbOrder" id="wxbOrder" required="true"/>
					</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1" >
						<label>是否启用：</label>
					</td>
					<td colspan="3">
						<div id="slideshowState" name="slideshowState" class="nui-radiobuttonlist" textField="text" valueField="id" required="true" repeatLayout="none" value="0" data='[{"id":0,"text":"未启用"},{"id":1,"text":"启用"}]' />
					</td>
				</tr>
				<tr>
					<td id="uploadMeny" >
						<form id="upload0" action="" target="hidden_frame0" num="0" method="post" enctype="multipart/form-data" style="display:none;" >
							<input id="fileImage0" class="fileImage0 images" num="0" type="file" size="30" accept="image/png,image/jpeg" name="fileImage0">
							<button type="button" id="fileSubmit0" onclick="uploadFile()" >确认上传文件</button>
						</form>
						<iframe name='hidden_frame0' id="hidden_frame0" style="display:none;" ></iframe>
					</td>
				</tr>
			</table>
			
			<div style="display:flew;" >
				<div style="text-align: center;" >
					<label>轮播活动图片</label>
					<span style='color:red;font-size: 13px;'>(建议尺寸：414像素*519像素)</span>
				</div>
	    		<div class="imgList imgListContent" >
					<div class="add" style="display: block;padding: 4px;">
						<a href="javascript:;" class="addImage tc sub-add-btn" style="display: flex;border: 2px dotted #B8B8B8;border-radius: 5px 5px 5px 5px;color: #222222;line-height: 70px;text-align: center;text-decoration: none;">
							<div class="vm dib sub-add-icon" style="background: url(<%=webcssPath %>/autoServiceSys/images/imageAdd.png);height: 18px;margin-right: 5px;width: 18px;margin-top: 25px;margin-left: 36%;background-size: 18px;"></div>
							添加图片
						</a>
					</div>
	    		</div>
			</div>
			
			
		</div>
	</div>
	
	


	<script type="text/javascript">
    	nui.parse();
    	var pathapi=apiPath+wechatApi;
    	var pathweb=webPath+wechatDomain;
    	var storeId = nui.get("storeId");
    	var oldImage=[];
    	
    	
    	$(function(){
    		$("#imgshowOnly").attr("src", pathweb+"/autoServiceSys/images/add_img.png");
    		storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
			storeId.select(0);
		});
		
		//页面间传输json数据
		function setFormData(data) {
			var infos = nui.clone(data);
			nui.get("pageType").setValue(infos.pageType);
			nui.get("storeId").setEnabled(false);
			if(infos.pageType == "add")nui.get("storeId").setValue(infos.storeId);
			if(infos.pageType == "edit"){
				var form = new nui.Form("#showInForm"); //将普通form转为nui的form
				form.setData(infos.slideShowData);
				nui.get("pageType").setValue(infos.pageType);
				nui.get("storeId").setValue(infos.slideShowData.storeId);
				//console.log(infos.slideShowData);
				$('#imgshowOnly').get(0).src = infos.slideShowData.pictureUrl;
				var slideDetailArray = infos.slideShowData.slideDetailArray;
				oldImage=slideDetailArray;
				for(var a=0; a<=slideDetailArray.length;a++){
	      			if( a > 0 && a != slideDetailArray.length){
	      				var htmlString='<form id="upload'+index+'" action="" slideshowDetailId="'+slideDetailArray[a].slideshowDetailId+'" num="'+index+'" target="hidden_frame'+index+'" method="post" enctype="multipart/form-data" style="display:none;" >';
		      			if(slideDetailArray[a].slideshowDetailType == "2"){
		      				htmlString='<form id="upload'+index+'" action="" slideshowDetailId="'+slideDetailArray[a].slideshowDetailId+'" serviceItemId="'+slideDetailArray[a].serviceItemId+'" serviceItemName="'+slideDetailArray[a].serviceItemName+'" num="'+index+'" target="hidden_frame'+index+'" method="post" enctype="multipart/form-data" style="display:none;" >';
		      			}
		      			htmlString+='<input id="fileImage'+index+'" name="fileImage'+index+'" class="images fileImage'+index+'" num="'+index+'" type="file" size="30" accept="image/png,image/jpeg" >';
		      			htmlString+='<button type="button" id="fileSubmit" onclick="uploadFile()" >确认上传文件</button>';
		      			htmlString+='</form>';
		      			$("#uploadMeny").append(htmlString);
		      			$("#uploadMeny").append('<iframe name="hidden_frame'+index+'" id="hidden_frame'+index+'" style="display:none;" ></iframe>');
		      			var html=imageHtml(slideDetailArray[a].slideshowPictureUrl,index);
	      				$(".add").before(html);
		      			editDelete(index);
		      			$("#upload"+index).attr("class","uploadImagers");
	      				$("#upload"+index).attr("action", pathweb+"/autoServiceSys/storeManagement/uploadImage.jsp");
		      			mouseImage();
	      			}else if(a == 0){
	      				var html=imageHtml(slideDetailArray[a].slideshowPictureUrl,index);
	      				$(".add").before(html);
		      			editDelete(index);
	      				$("#upload0").attr("class","uploadImagers");
	      				$("#upload0").attr("action", pathweb+"/autoServiceSys/storeManagement/uploadImage.jsp");
	      				$("#upload0").attr("serviceItemId",slideDetailArray[a].serviceItemId);
						$("#upload0").attr("serviceItemName",slideDetailArray[a].serviceItemName);
						$("#upload0").attr("slideshowDetailId",slideDetailArray[a].slideshowDetailId);
	      			}
	      			index++;
	      			if( a == slideDetailArray.length ){
	      				var htmlString='<form id="upload'+index+'" action="" num="'+index+'" target="hidden_frame'+index+'" method="post" enctype="multipart/form-data" style="display:none;" >';
		      			htmlString+='<input id="fileImage'+index+'" name="fileImage'+index+'" num="'+index+'" class="images fileImage'+index+'" type="file" size="30" accept="image/png,image/jpeg" >';
		      			htmlString+='<button type="button" id="fileSubmit" onclick="uploadFile()" >确认上传文件</button>';
		      			htmlString+='</form>';
		      			$("#uploadMeny").append(htmlString);
		      			$("#uploadMeny").append('<iframe name="hidden_frame'+index+'" id="hidden_frame'+index+'" style="display:none;" ></iframe>');
		      			mouseImage();
	      			}
				}
				
				
			}
		}
		
		//服务项目改变
		function onserviceItemIdChanged(){
			if( nui.get("serviceItemId").getValue() == "" ){
				nui.get("serviceItemName").setValue("");
			}
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
		
		
		//门店详情图片的编辑事件
		function editDelete(indexss){
			//编辑选择的图片
	    	$(".imgEdit"+indexss).click(function(){
	    		var num=$(this).attr("num");
	    		var imageClass=".fileImage"+num;
				$(imageClass).unbind("change");
				$(imageClass).bind("change",function(){
					var file = $('.fileImage'+num).get(0).files[0];
		      		var reader = new FileReader();
		      		reader.readAsDataURL(file);
		      		reader.onload=function(e){
		      			if(nui.get("pageType").getValue() == "edit"){
		      				$("#upload"+index).removeAttr("slideshowDetailId");
		      				$("#upload"+index).attr("class","editUploadImagers");
		      			}
		      			$(".imageshow"+num).attr("src",e.target.result);
		      		}
		    	});
		    	$(".fileImage"+num).click();
	    	});
	    	
		}
		
		var messAge = "";
		//保存
		function save(){
			var form = new nui.Form("#showInForm");
			form.setChanged(false);
    		form.validate();
			if(form.isValid() == false) return;
			var data = form.getData(false, true);
			
			//轮播图图片的验证
			if( $("#fileImageOnly")[0].files.length == 0 && nui.get("pageType").getValue() == "add"){
				showMsg("轮播图图片不能为空","W");
				return;
			}
			//轮播图详情图片的验证
			if( $(".imgListA").length == 0 ){
				showMsg("轮播活动图片不能为空","W");
				return;
			}
			//检验轮播图标题和顺序是否重复
			var json=nui.encode({storeId:data.storeId,wxbTitle:data.wxbTitle,wxbOrder:data.wxbOrder,editWxbSlideshowId:data.wxbSlideshowId});
			nui.ajax({
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatSlideShow.judgeStoreSlide.biz.ext?token="+token,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					if( ( text.resturns && nui.get("pageType").getValue() == "add" ) || ( text.resturns && nui.get("pageType").getValue() == "edit" ) || ( !text.resturns && nui.get("pageType").getValue() == "edit" && text.wxbSlideshowId == data.wxbSlideshowId ) ){
						messAge = nui.loading("保存中 ....", "系统提示");
						//获取上传的token
						nui.ajax({
							url: webPathUrl+"/dms/com.hs.common.login.getQNAccessToken.biz.ext?token="+token,
							type: 'POST',
							cache: false,
							async: false,
							contentType: 'text/json',
							success: function(text){
								var imageToken = text.token;
								var fileImageOnly = $('#fileImageOnly').get(0).files[0];
								if(fileImageOnly){
									//上传轮播图图片的文件
									uploadImageFiles(fileImageOnly,data,imageToken);
								}else{
									if(nui.get("pageType").getValue() == "add"){
				                		uploadOnlyStoreInfoImage(data,imageToken);
				                	}else if(nui.get("pageType").getValue() == "edit"){
				                		uploadOnlyStoreInfoImageEdit(data,imageToken);
				                	}
								}
							}
						});
						
					}else{
						showMsg(text.message,"W");
					}
					
				}
			});
			
			
		}
		
		//上传轮播图图片的文件
		function uploadImageFiles(fileImageOnly,data,imageToken){
			//文件上传
			var uploadImageformData = new FormData();
            uploadImageformData.append("file",fileImageOnly);
            uploadImageformData.append("token",imageToken);
            $.ajax({
                url: "http://up-z2.qiniup.com",
                type: "POST",
                data: uploadImageformData,
                contentType: false,
                processData: false,
                success: function (fileDatas) {
                	data.pictureUrl = uploadImageUrl + fileDatas.hash;
                	if(nui.get("pageType").getValue() == "add"){
                		uploadOnlyStoreInfoImage(data,imageToken);
                	}else if(nui.get("pageType").getValue() == "edit"){
                		uploadOnlyStoreInfoImageEdit(data,imageToken);
                	}
                },
                error: function () {
                    showMsg("图片上传失败,请重新选择","W");
                }
            });
	                
		}
		
		//编辑时轮播图详情上传
		function uploadOnlyStoreInfoImageEdit(data,imageToken){
			var length=$(".images").length-1;
			var uploadImageArray=[];
			var pictureArrayData=[];
			$(".images").each(function(i,n){//过滤出有文件的数组
				if(Boolean($(n)[0].files[0]) ){//有文件的代码
					var datass={
						fileImageOnly:$(n)[0].files[0],
						num:Number( $(n).attr("num") )
					};
					uploadImageArray.push(datass);
				}
				if(i == length && uploadImageArray.length > 0 ){
					for(var a=0;a<uploadImageArray.length;a++){//循环上传图片
						var imageType=uploadImageArray[a].fileImageOnly.type;
						var uploadImageformData = new FormData();
		                uploadImageformData.append("file",uploadImageArray[a].fileImageOnly);
		                uploadImageformData.append("token",imageToken);
		                uploadImageformData.append("x:index",a);
		                uploadImageformData.append("x:num",uploadImageArray[a].num);
		                uploadImageformData.append("x:pictureName",uploadImageArray[a].fileImageOnly.name);
		                uploadImageformData.append("x:pictureType",imageType.split("/")[1]);
		                uploadImageformData.append("x:pictureSize",uploadImageArray[a].fileImageOnly.size);
		                $.ajax({
		                    url: "http://up-z2.qiniup.com",
		                    type: "POST",
		                    data: uploadImageformData,
		                    contentType: false,
		                    processData: false,
		                    success: function (fileDatas) {
		                    	var num = Number( fileDatas["x:num"] );
		                    	var datas={
									serviceItemId: $("#upload"+num).attr("serviceitemid"),
									slideshowPictureUrl: uploadImageUrl + fileDatas.hash,
									slideshowDetailType: 1,
									slideshowDetailSequence: num
								}
								if($("#upload"+num).attr("serviceitemid"))datas.slideshowDetailType = 2;
								pictureArrayData.push(datas);
								if( fileDatas["x:index"] == uploadImageArray.length-1){
									editSlideFirst(data,pictureArrayData);
								}
		                    },
		                    error: function () {
		                        showMsg("门店详情图片上传失败,请重新选择或者保存","W");
		                    }
		                });
					}
				}else if(i == length){
					editSlideFirst(data,pictureArrayData);
				}
			});	
			
		}
		
		
		//添加时轮播图详情上传
		function uploadOnlyStoreInfoImage(data,token){
			var length=$(".images").length-1;
			var uploadImageArray=[];
			var pictureArrayData=[];
			$(".images").each(function(i,n){//过滤出有文件的数组
				if(Boolean($(n)[0].files[0]) ){//有文件的代码
					var datass={
						fileImageOnly:$(n)[0].files[0],
						num:Number( $(n).attr("num") )
					};
					uploadImageArray.push(datass);
				}
				if(i == length && uploadImageArray.length > 0 ){
					for(var a=0;a<uploadImageArray.length;a++){//循环上传图片
						var imageType=uploadImageArray[a].fileImageOnly.type;
						var uploadImageformData = new FormData();
		                uploadImageformData.append("file",uploadImageArray[a].fileImageOnly);
		                uploadImageformData.append("token",token);
		                uploadImageformData.append("x:index",a);
		                uploadImageformData.append("x:num",uploadImageArray[a].num);
		                uploadImageformData.append("x:pictureName",uploadImageArray[a].fileImageOnly.name);
		                uploadImageformData.append("x:pictureType",imageType.split("/")[1]);
		                uploadImageformData.append("x:pictureSize",uploadImageArray[a].fileImageOnly.size);
		                $.ajax({
		                    url: "http://up-z2.qiniup.com",
		                    type: "POST",
		                    data: uploadImageformData,
		                    contentType: false,
		                    processData: false,
		                    success: function (fileDatas) {
		                    	var num = Number( fileDatas["x:num"] );
		                    	var datas={
									serviceItemId: $("#upload"+num).attr("serviceitemid"),
									slideshowPictureUrl: uploadImageUrl + fileDatas.hash,
									slideshowDetailType: 1,
									slideshowDetailSequence: num
								}
								if($("#upload"+num).attr("serviceitemid"))datas.slideshowDetailType = 2;
								pictureArrayData.push(datas);
								if( fileDatas["x:index"] == uploadImageArray.length-1){
									addSlideShow(data,pictureArrayData);
								}
		                    },
		                    error: function () {
		                        showMsg("门店详情图片上传失败,请重新选择或者保存","W");
		                    }
		                });
					}
				}else if(i == length){
					addSlideShow(data,pictureArrayData);
				}
			});	
			
		}
		
		//保存轮播图详情信息
		function addSlideShow(slideShowData,pictureArrayData){
			slideShowData.tenantId=nui.get("storeId").getSelected().tenantId;
			var json=nui.encode({slideShowData:slideShowData,slideShowDetailArray:pictureArrayData});
			nui.ajax({
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatSlideShow.addSlideShow.biz.ext?token="+token,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					nui.hideMessageBox(messAge);//关闭提示
					if(text.errCode == "S"){
						CloseWindow("saveSuccess");
					}else{
						CloseWindow("saveFail");
					}
				}
			});
			
		}
		
		//编辑轮播图
		function editSlideFirst(data,slideshowDetailArray){
			//console.log("新增的",slideshowDetailArray);
			var deleteSlidesArray=[];
			var editSlidesArray=[];
			//编辑时赋上去的
			var boolEdites=true;
			for(var a=0;a<oldImage.length;a++){
				var boolEdit=true;
				$(".uploadImagers").each(function(i,n){
					var num = Number( $(n).attr("num") );
					if( oldImage[a].slideshowDetailId == $("#upload"+num).attr("slideshowDetailId") ){
						boolEdit=false;
					}
					if( i == $(".uploadImagers").length-1 && boolEdit){
						var slidesDatas={slideshowDetailId:oldImage[a].slideshowDetailId};
						deleteSlidesArray.push(slidesDatas);
					}
					if( boolEdites){
						var editDatas={
							slideshowDetailId:$(n).attr("slideshowDetailId"),
							serviceItemId:$(n).attr("serviceItemId")
						}
						if(editDatas.serviceItemId){
							editDatas.slideshowDetailType = "2";
						}else{
							editDatas.slideshowDetailType = "1";
						};
						editSlidesArray.push(editDatas);
					}
					if( i == $(".uploadImagers").length-1){
						boolEdites=false;
					}
					if( i == $(".uploadImagers").length-1 && a == oldImage.length-1 ){
						//console.log("删除的",deleteSlidesArray);
						//console.log("编辑的",editSlidesArray);
						var urlStr=pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatSlideShow.editSlideShow.biz.ext?token="+token;
						editWechatStore(urlStr,data,slideshowDetailArray,deleteSlidesArray,editSlidesArray);
					}
				});
				
			}
		}
		
		
		
		//编辑数据
		function editWechatStore(urlStr,slideShowData,slideshowDetailArray,deleteSlidesArray,editSlidesArray){
			var json=nui.encode({slideShowData:slideShowData,slideshowDetailArray:slideshowDetailArray,deleteSlidesArray:deleteSlidesArray,editSlidesArray:editSlidesArray});
			nui.ajax({
				url: urlStr,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					nui.hideMessageBox(messAge);//关闭提示
					if(text.errCode == "S"){
						CloseWindow("saveSuccess");
					}else{
						CloseWindow("saveFail");
					}
				}
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
	        	//console.log(e);
	    		//选择所要显示图片的img，要赋值给img的src就是e中target下result里面的base64编码格式的地址
	        	$('#imgshowOnly').get(0).src = e.target.result;
      		}
    	});
    	
    	
		
		//门店选择框取消事件
		function onOrgClose(){
			$("#advancedOrgWin").hide();
			nui.get("serviceItemId").setValue("");
	    	nui.get("serviceItemName").setValue("");
	    	nui.get("serviceItemId").setText("");
		}
		
		//确定选择的服务项目
		function addOrg(){
			$("#advancedOrgWin").hide();
			var num = nui.get("numData").getValue();
			$("#upload"+num).attr("serviceItemId",nui.get( "serviceItemId").getValue() );
			$("#upload"+num).attr("serviceItemName",nui.get( "serviceItemName").getValue() );
			nui.get("serviceItemId").setValue("");
			nui.get("serviceItemId").setText("");
	    	nui.get("serviceItemName").setValue("");
		}
		
		
		//添加门店详情图片预览
		var index=0;
		$(".addImage").click(function(){
			imagerChange();
			$(".fileImage"+index).click();
		});
		
		//添加门店详情图片预览
		function imagerChange(){
			var imageClass=".fileImage"+index;
			$(imageClass).unbind("change");
			$(imageClass).bind("change",function(){
				var file = $('.fileImage'+index).get(0).files[0];
	      		var reader = new FileReader();
	      		reader.readAsDataURL(file);
	      		reader.onload=function(e){
	      			var html=imageHtml(e.target.result,index);
	      			$(".add").before(html);
	      			editDelete(index);
	      			if(nui.get("pageType").getValue() == "add"){
	      				$("#upload"+index).attr("class","uploadImagers");
	      			}else if(nui.get("pageType").getValue() == "edit"){
	      				$("#upload"+index).attr("class","editUploadImagers");
	      			}
	      			$("#upload"+index).attr("action", pathweb+"/autoServiceSys/storeManagement/uploadImage.jsp");
	      			index++;
	      			var htmlString='<form id="upload'+index+'" action="" num="'+index+'" target="hidden_frame'+index+'" method="post" enctype="multipart/form-data" style="display:none;" >';
	      			htmlString+='<input id="fileImage'+index+'" name="fileImage'+index+'" num="'+index+'" class="images fileImage'+index+'" type="file" size="30" accept="image/png,image/jpeg" >';
	      			htmlString+='<button type="button" id="fileSubmit" onclick="uploadFile()" >确认上传文件</button>';
	      			htmlString+='</form>';
	      			$("#uploadMeny").append(htmlString);
	      			$("#uploadMeny").append('<iframe name="hidden_frame'+index+'" id="hidden_frame'+index+'" style="display:none;" ></iframe>');
	      			mouseImage();
	      		}
	    	});
	    	
		}
    	
    	
    	//门店详情图片多文件上传,点击上传文件事件
		function uploadFile(){
			var length=$(".images").length-1;
			$(".images").each(function(i,n){
				if( !Boolean($(n)[0].files[0]) ){//删除多余的文件上传代码
					$(n).remove();
				}
				if( length == i ){
					$("#upload").submit();
					$('#hidden_frame').load(function(){
						var text=$(this).contents().find("body").text();//获得上传之后返回的参数
					});
				}
			});
			
		}
    	
    	
		//添加门店详情图片
		function imageHtml(imageUrl,indexss){
			var html="";
			var imagerText="imagers"+indexss;
			var imagerShow="imageshow"+indexss;
			html+='<a href="#" class="imgListA '+imagerText+'">';
			html+='		<div class="" style="position: relative;" >';
			if(nui.get("pageType").getValue() == "edit"){
				html+='		<div class="imgListOneDiv" style="display:none;text-align: center;" >';
				html+='			<img id="" alt="" src="'+pathweb+'/autoServiceSys/images/deleteImage.png" class="imgListtwo imgDelete" num="'+indexss+'" >';
				html+='			<img id="" alt="" src="'+pathweb+'/autoServiceSys/images/addItem.png" class="imgListtwo itemEdit" style="width: 25px;height: 25px;" num="'+indexss+'" >';
			}else{
				html+='		<div class="imgListOneDiv" style="display:none;" >';
				html+='			<img id="" alt="" src="'+pathweb+'/autoServiceSys/images/imageEdit.png" class="imgListone imgEdit'+indexss+'" num="'+indexss+'" >';
				html+='			<img id="" alt="" src="'+pathweb+'/autoServiceSys/images/deleteImage.png" class="imgListtwo imgDelete" num="'+indexss+'" >';
				html+='			<img id="" alt="" src="'+pathweb+'/autoServiceSys/images/addItem.png" class="imgListtwo itemEdit" style="width: 25px;height: 25px;" num="'+indexss+'" >';
			}
			html+='		</div>';
			html+='			<img id="" alt="" src="'+imageUrl+'" class="imgStyle '+imagerShow+'" >';
			
			html+='		</div>';
			html+='</a>';
			return html;
		};
		
		
		
		/* 门店详情图片事件 */
		function mouseImage(){
			//鼠标移动到图片上时触发
			$(".imgListA").mouseover(function(){
				$(this).css("cursor","default");
				$(this).find(".imgListOneDiv").show();
				var height = $(this).find(".imgStyle").height();
				var width = $(this).find(".imgStyle").width();
				$( $(this).find(".imgListOneDiv") ).css("height",height+"px");
				$( $(this).find(".imgListOneDiv") ).css("width",width+"px");
				var heightTo=height/2;
				if( heightTo>20 ){
					heightTo-=20;
					$( $(this).find(".imgListOneDiv") ).css("padding-top",heightTo+"px");
				}else{
					$( $(this).find(".imgListOneDiv") ).css("padding-top",heightTo+"px");
				}
			});
			
			//鼠标从图片上离开时触发
			$(".imgListA").mouseout(function(){
				$(this).css("cursor","pointer");
				$(this).find(".imgListOneDiv").hide();
				
			});
			
			//删除选择的图片
	    	$(".imgDelete").click(function(){
	    		var num=$(this).attr("num");
	    		/* if(nui.get("pageType").getValue() == "edit" && $( ".fileImage"+( Number(num) + 1 ) ).attr("imageId")){
	    			var oldImageId=$( ".fileImage" + ( Number(num) + 1 ) ).attr("imageId");
	    			var data={ pictureId : Number(oldImageId) };
	    			deleteImage.push(data);
	    			$("#upload"+num).remove();
	    			$(".imagers"+num).remove();
	    		}else{ */
	    			$("#upload"+num).remove();
	    			$(".imagers"+num).remove();
	    		//}
	    		
	    	});
	    	$(".itemEdit").unbind("click");
	    	//项目添加
	    	$(".itemEdit").click(function(){
	    		var num=$(this).attr("num");
	    		nui.get("numData").setValue(num);
	    		nui.get("serviceItemId").setValue( $("#upload"+num).attr("serviceItemId") ? $("#upload"+num).attr("serviceItemId") : "" );
	    		nui.get("serviceItemId").setText( $("#upload"+num).attr("serviceItemName") ? $("#upload"+num).attr("serviceItemName") : "" );
	    		nui.get("serviceItemName").setValue( $("#upload"+num).attr("serviceItemName") ? $("#upload"+num).attr("serviceItemName") : "" );
	    		$("#advancedOrgWin").show();
	    	});
		}
		
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
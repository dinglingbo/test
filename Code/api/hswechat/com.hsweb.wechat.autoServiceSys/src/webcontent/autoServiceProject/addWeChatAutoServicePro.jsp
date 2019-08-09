<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/autoServiceSys/common/wechatCommon.jsp"%>
<% String webcssPath = webPath + wechatDomain; %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-02-12 16:16:24
  - Description:
-->
<head>
<title>添加微信服务项目</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
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
	    body .mini-tabs-plain .mini-tabs-scrollCt{
	    	background-color: DEEDF7;
	    }
	    .mini-tabs-position-top .mini-tabs-plain .mini-tabs-header{
	    	margin-top: 4px;
	    }
	    .mini-checkboxlist{
	    	padding-top:2px;
	    }
	    table{
	    	font-size: 12px;
	    }
    </style>
</head>
<body>
	

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
    	
    	<div class="form" id="basicInfoForm" name="basicInfoForm" style="height:85%;left:0;right:0;margin: 0 auto;display: flex;padding-top: 10px;padding-left: 10px;">
    		
    		<div style="display:flew;" >
				<div style="text-align: center;" >
					<label>项目简介</label>
					<span style="color:red;font-size: 12px;">(建议尺寸：414像素*519像素)</span>
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
			
			<input class="nui-textbox" name="pageType" id="pageType" visible="false"/>
			<input class="nui-textbox" name="serviceItemId" id="serviceItemId" visible="false"/>
			<input class="nui-textbox" name="itemType" id="itemType" visible="false"/>
			<input class="nui-textbox" name="carModelId" id="carModelId" visible="false"/>
			<input class="nui-textbox" name="cardPeriodValidity" id="cardPeriodValidity" visible="false"/>
			<input class="nui-textbox" name="cardTotalAmt" id="cardTotalAmt" visible="false"/>
			<input class="nui-textbox" name="cardName" id="cardName" visible="false"/>
			
			<input class="nui-textbox" name="itemPrice" id="itemPrice" visible="false"/>
			<input class="nui-textbox" name="itemQty" id="itemQty" visible="false"/>
			<table style="width:100%;margin-left: 30px;border-collapse: separate;border-spacing: 0px 14px;" class="nui-form-table">
				<tr>
					<td class="nui-form-label" colspan="1" style="width: 25%;" >
						<label>项目图片:</label>
					</td>
					<td colspan="3">
						<a href="#" class="imgA">
							<div class="divImg" >
								<img id="imgshowOnly" alt="" src="#" class="imgStyle" >
							</div>
						</a>
						<div style="font-size: 12px;color:red;">(建议尺寸：414像素*180像素)</div>
						<form id="uploadOnly" action="" target="hidden_frameOnly" method="post" enctype="multipart/form-data" style="display:none;" >
							<input id="fileImageOnly" type="file" size="30" accept="image/png,image/jpeg" name="fileselect[]">
							<button type="button" id="fileSubmitOnly" onclick="uploadOnlyFile()" >确认上传文件</button>
						</form>
						<iframe name='hidden_frameOnly' id="hidden_frameOnly" style="display:none;" ></iframe>
					</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1" style="" >
						<label>微信门店:</label>
					</td>
					<td colspan="3">
						<input id="storeId" name="storeId" class="nui-combobox" onvaluechanged="OnStoreId" required="true" style="margin-right: 30px;" textField="storeName" value="" valueField="storeId" dataField="wechatStoreData" />
					</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1" style="" >
						<label>项目类型:</label>
					</td>
					<td colspan="3">
						<div id="serviceItemType" name="serviceItemType" class="nui-radiobuttonlist" textField="text" onvaluechanged="OnServiceItemTypechanged" valueField="id" repeatLayout="none" value="1" data='[{"id":1,"text":"服务项目"},{"id":2,"text":"套餐卡项目"}]' />
					</td>
				</tr>
				<tr class="commonServiceItem" >
					<td class="nui-form-label" colspan="1" style="" >
						<label>业务类型:</label>
					</td>
					<td colspan="1" >
						<input id="serviceTypeId" name="serviceTypeId" class="nui-combobox" onvaluechanged="OnValueChanged" style="margin-right: 30px;" textField="name" value="" valueField="id" dataField="data" required="true" />
					</td>
				</tr>
				<tr>
					<td class="nui-form-label commonServiceItem" colspan="1">
						<label>服务项目:</label>
					</td>
					<td colspan="1" class="commonServiceItem" >
						<input class="nui-buttonedit" id="itemId" name="itemId" textname="name" emptyText="请选择服务项目" onbuttonclick="selectCustomer" selectOnFocus="true"   required="true" />
					</td>
					<td class="nui-form-label taicanServiceItem" colspan="1" style="display:none;" >
						<label>套餐卡项目:</label>
					</td>
					<td colspan="1" class="taicanServiceItem" style="display:none;" >
						<input id="cardId" name="cardId" class="nui-combobox"  onvaluechanged="OnCardIdChanged" style="margin-right: 30px;" textField="name" value="" valueField="id" dataField="timesCard" />
					</td>
					<td class="nui-form-label" colspan="1" style="width: 22%;" >
						<label>微信项目名称:</label>
					</td>
					<td colspan="1" style="width: 32%;">
						<input class="nui-textbox tabwidth" name="serviceItemName" id="serviceItemName" required="true" />
					</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1" style="" >
						<label>项目价格:</label>
					</td>
					<td colspan="1">
						<input class="nui-textbox tabwidth" name="itemPrices" id="itemPrices"  />
					</td>
					<td class="nui-form-label" colspan="1" style="" >
						<label>库存量:</label>
					</td>
					<td colspan="1">
						<input class="nui-textbox tabwidth" name="itemNumber" id="itemNumber" emptyText="不限数量,请输入-1" onvalidation="OnItemNumberValidation" vtype="int" required="true" />
					</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1" style="" >
						<label>项目价格区间:</label>
					</td>
					<td colspan="3">
						<input class="nui-textbox tabwidth" name="serviceExtentBeginPrice" id="serviceExtentBeginPrice" onvaluechanged="OnBeginPricechanged" onvalidation="OnBeginPriceValidation" vtype="float" required="true" style="margin-right: 16px;" />-<input class="nui-textbox tabwidth" name="serviceExtentEndPrice" id="serviceExtentEndPrice" vtype="float" onvaluechanged="OnEndPricechanged" onvalidation="OnEndPriceValidation" required="true" style="margin-left: 16px;" />
					</td>
				</tr>
				<tr class="isCouponState" >
					<td class="nui-form-label" colspan="1" style="" >
						<label>是否优惠:</label>
					</td>
					<td colspan="1">
						<input  id="isCoupon" name="isCoupon" class="mini-checkbox" onvaluechanged="OnisCouponchanged"  trueValue="1" falseValue="0" />
					</td>
				</tr>
				<tr class="isCouponclass" style="display:none" >
					<td class="nui-form-label" colspan="1" style="" >
						<label>优惠类型:</label>
					</td>
					<td colspan="1">
						<div id="couponType" name="couponType" class="nui-radiobuttonlist" textField="text" onvaluechanged="OnCouponTypechanged" valueField="id" repeatLayout="none" value="1" data='[{"id":1,"text":"固定优惠"},{"id":2,"text":"折扣优惠"}]' />
					</td>
					<td class="nui-form-label couponPrice"colspan="1"  >
						<label>优惠价格:</label>
					</td>
					<td colspan="1" class="couponPrice">
						<input class="nui-textbox tabwidth" name="couponPrice" onvaluechanged="OnCouponPricechanged" onvalidation="OnCouponPriceValidation" id="couponPrice" vtype="float" />元
					</td>
					<td class="nui-form-label couponbai" colspan="1" style="display:none;" >
						<label>优惠比例:</label>
					</td>
					<td colspan="1" class="couponbai" style="display:none;" >
						<input class="nui-textbox tabwidth" name="couponPercentage" onvalidation="OnCouponPercentageChanged" id="couponPercentage" vtype="int" />%
					</td>
				</tr>
				
				<tr>
					<td class="nui-form-label" colspan="1">
						<label>上架日期:</label>
					</td>
					<td colspan="1">
						<input id="itemOnDate" name="itemOnDate" onvaluechanged="dateBeginchanged" class="nui-datepicker" required="true" />
					</td>
					<td class="nui-form-label" colspan="1">
						<label>下架日期:</label>
					</td>
					<td colspan="1">
						<input id="itemOffDate" name="itemOffDate" onvaluechanged="dateEndchanged" class="nui-datepicker" required="true" />
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
    	
    	var systemApiUrl = apiPathUrl+sysApi;
    	var repairApiUrl =apiPathUrl+repairApi;
    	var dmsUrl = webPathUrl+dms;
    	
    	//业务类型
    	var serviceTypeId=nui.get("serviceTypeId");
    	//服务项目
    	var itemId=nui.get("itemId");
    	//门店
    	var storeId=nui.get("storeId");
    	//套餐卡项目
    	var cardId=nui.get("cardId");
    	var serviceItemPicture="";
    	//服务项目简介图片判断
    	var contentBoolean=false;
    	
    	$(function(){
    		init();
		});
		
		function init(){
			nui.get("itemPrices").setEnabled(false);
			$("#imgshowOnly").attr("src", pathweb+"/autoServiceSys/images/add_img.png");
		    //设置业务类型的url
		    var serviceTypeUrl=systemApiUrl+"/com.hsapi.system.dict.dictMgr.queryServiceType.biz.ext?token="+token;
		    serviceTypeId.setUrl(serviceTypeUrl);
		    storeId.setUrl(pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryWechatStoreList.biz.ext?token="+token);
		}
		
		
		//页面间传输json数据
		function setFormData(data) {
			var infos = nui.clone(data);
			nui.get("pageType").setValue(infos.pageType);
			//console.log(infos);
			if(infos.pageType == "edit"){
				if(	infos.autoServiceProData.itemNumberStatus == 0 ) infos.autoServiceProData.itemNumber = -1;
				var form = new nui.Form("#basicInfoForm"); //将普通form转为nui的form
				form.setData(infos.autoServiceProData);
				nui.get("pageType").setValue(infos.pageType);
				nui.get("itemPrices").setValue(infos.autoServiceProData.couponTotalAmt);
				//项目图片
				$("#imgshowOnly").attr("src", infos.autoServiceProData.serviceItemPicture);
				serviceItemPicture=infos.autoServiceProData.serviceItemPicture;
				
				//项目简介图片
				var mapData={
					serviceItemId:infos.autoServiceProData.serviceItemId
				}
				var json=nui.encode({map:mapData});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatAutoServiceItem.queryServiceItemPicture.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						if(text.serviceItemPictureData.length != 0 ){
							var pictureData = text.serviceItemPictureData;
							for(var a=0;a<pictureData.length;a++){
								var html=editImageHtml(pictureData[a].pictureUrl,index,pictureData[a].pictureId);
				      			$(".add").before(html);
				      			editDelete(index);
				      			index++;
				      			$("#upload").append('<input id="fileImage'+index+'" name="fileImage'+index+'" class="images fileImage'+index+'" type="file" size="30" accept="image/png,image/jpeg" >');
				      			mouseImage();
				      			$(".imgListtwo").css("margin-left","42%");
							}
						}
					}
				});
				
				
				
				if ( infos.autoServiceProData.serviceItemType == 1 ) { //服务项目
					$(".isCouponState").show();
	               	$(".commonServiceItem").show();
	               	$(".taicanServiceItem").hide();
	               	serviceTypeId.setRequired(true);
	               	itemId.setRequired(true);
	               	cardId.setRequired(false);
	               	
	               	itemId.setValue(infos.autoServiceProData.itemId);
					itemId.setText(infos.autoServiceProData.itemName);
	            }else if( infos.autoServiceProData.serviceItemType == 2 ){ //套餐卡项目
	            	$(".isCouponState").hide();
	            	$(".commonServiceItem").hide();
	               	$(".taicanServiceItem").show();
	               	serviceTypeId.setRequired(false);
	               	itemId.setRequired(false);
	               	cardId.setRequired(true);
	               	
	               	initCardId();//套餐卡加载
	               	//业务类型
					serviceTypeId.setValue("");
					serviceTypeId.setText("");
	            }
				
				
				if( infos.autoServiceProData.isCoupon == 1 ){//优惠
					$(".isCouponclass").show();
					couponPrice.setRequired(true);
					
					if( infos.autoServiceProData.couponType == 1 ){//固定优惠
						$(".couponbai").hide();
						$(".couponPrice").show();
						couponPrice.setRequired(true);
						couponPercentage.setRequired(false);
					}else if( infos.autoServiceProData.couponType == 2 ){//比例优惠
						$(".couponPrice").hide();
						$(".couponbai").show();
						couponPrice.setRequired(false);
						couponPercentage.setRequired(true);
					}
					
				}else if( infos.autoServiceProData.isCoupon == 0 ){//不优惠
					$(".isCouponclass").hide();
					couponPercentage.setRequired(false);
					couponPrice.setRequired(false);
				}
			}else if(infos.pageType == "add"){
				nui.get("storeId").setText(infos.storeName);
				nui.get("storeId").setValue(infos.storeId);
			}
		}
		
		//优惠比例
		function OnCouponPercentageChanged(e){
			if( e.isValid && e.value > 100 ){
				e.errorText = "优惠比例不能超过100%";
                e.isValid = false;
			}
		}
		
		//套餐卡项目选择触发
		function OnCardIdChanged(){
			var cardItem=nui.get("cardId").getSelected();
			nui.get("itemPrices").setValue(cardItem.sellAmt);
			console.log(cardItem);
			nui.get("cardPeriodValidity").setValue(cardItem.periodValidity);
			nui.get("cardTotalAmt").setValue(cardItem.totalAmt);
			nui.get("cardName").setValue(cardItem.name);
		}
		
		//编辑项目图片简介
		function editImageHtml(imageUrl,indexss,pictureId){
			var html="";
			var imagerText="imagers"+indexss;
			var imagerShow="imageshow"+indexss;
			html+='<a href="#" class="imgListA '+imagerText+'">';
			html+='		<div class="" style="position: relative;" >';
			html+='		<div class="imgListOneDiv" style="display:none;" >';
			//html+='			<img id="" alt="" src="'+pathweb+'/autoServiceSys/images/imageEdit.png" class="imgListone imgEdit'+indexss+'" num="'+indexss+'" >';
			html+='			<img id="" alt="" src="'+pathweb+'/autoServiceSys/images/deleteImage.png" class="imgListtwo imgDelete" num="'+indexss+'" >';
			html+='		</div>';
			html+='			<img id="" alt="" src="'+imageUrl+'" class="imgStyle editPictureId '+imagerShow+'" pictureId="'+pictureId+'">';
			html+='		</div>';
			html+='</a>';
			return html;
		};
		
		var messAge = "";
		//保存
		function save(){
			var form = new nui.Form("#basicInfoForm");
			form.setChanged(false);
			
    		form.validate();
			if(form.isValid() == false) return;
			var data = form.getData(false, true);
			//项目图片的验证
			if( $("#fileImageOnly")[0].files.length == 0 && nui.get("pageType").getValue() != "edit"){
				showMsg("项目图片不能为空","W");
				return;
			}
			//项目简介图片的验证
			if( $(".imgListA").length == 0 ){
				showMsg("项目简介不能为空","W");
				return;
			}
			//优惠价格
			if( data.isCoupon == 1 && data.couponType == "1" ){
				if( Number(data.couponPrice) > data.itemPrices){
					showMsg("优惠价格不能超过项目价格","W");
					return;
				}
			}
			
			//优惠比例
			if( data.isCoupon == 1 && data.couponType == "2" ){
				if( Number(data.couponPercentage) > 100){
					showMsg("优惠比例不能大于百分之一百!","W");
					return;
				}
			}
			
			//门店租户外键赋值
			data.tenantId=nui.get("storeId").getSelected().tenantId;
			//车道系统的门店外键赋值
			data.orgid=nui.get("storeId").getSelected().orgid;
			//判断是否有优惠
			if( data.isCoupon == 0 ) data.couponType="";
			//业务类型名称
			if( data.serviceItemType == 1 ){
				data.serviceTypeName=nui.get("serviceTypeId").getText();
				data.itemName=nui.get("itemId").getText();
			}else{
				data.serviceTypeName="套餐";
				data.serviceTypeName="套餐";
				data.serviceTypeId=0;
				data.itemType=2;
			}
			data.isDelete=0;
			data.itemNumberStatus = 1;
			if(data.itemNumber == -1){
				data.itemNumberStatus = 0;
			}
			var fileImageOnly = $('#fileImageOnly').get(0).files[0];
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
					
					if(nui.get("pageType").getValue() == "edit"){//编辑
						var judgeParam={
							serviceItemId:data.serviceItemId,
							itemNumber:data.itemNumber
						};
						nui.ajax({
							url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatAutoServiceItem.judgeServiceItem.biz.ext?token="+token,
							type: 'POST',
							data: nui.encode(judgeParam),
							cache: false,
							async: false,
							contentType: 'text/json',
							success: function(text) {
								if( text.errCode == "S" ){
									//业务类型名称
									if( data.serviceItemType == 2 ) data.serviceTypeName = "套餐";
									if(fileImageOnly){//判断项目图片是否改变过
										uploadImageFiles(fileImageOnly,data,imageToken);
									}else{
										data.serviceItemPicture = serviceItemPicture;
										uploadOnlyItemInfoImage(data,imageToken);
									}
								}else{
									showMsg(text.errMsg,"W");
								}
							}
						});
					}else if(nui.get("pageType").getValue() == "add"){//保存
						uploadImageFiles(fileImageOnly,data,imageToken);
					}
					
				}
			});
			
		}
		
		//上传项目图片的文件
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
                	data.serviceItemPicture = uploadImageUrl + fileDatas.hash;
					uploadOnlyItemInfoImage(data,imageToken);
                },
                error: function () {
                    showMsg("图片上传失败,请重新选择","W");
                }
            });
	                
		}
		
		
		//项目详情图片上传
		function uploadOnlyItemInfoImage(data,imageToken){
			var length=$(".images").length-1;
			var uploadImageArray=[];
			var pictureArrayData=[];
			//门店详情上传
			$(".images").each(function(i,n){//过滤出有文件的数组
				if(Boolean($(n)[0].files[0]) ){//有文件的代码
					var fileImageOnly=$(n)[0].files[0];
					uploadImageArray.push(fileImageOnly);
				}
				if(i == length && uploadImageArray.length > 0 ){debugger;
					for(var a=0;a<uploadImageArray.length;a++){//循环上传图片
						var imageType=uploadImageArray[a].type;
						var uploadImageformData = new FormData();
		                uploadImageformData.append("file",uploadImageArray[a]);
		                uploadImageformData.append("token",imageToken);
		                uploadImageformData.append("x:index",a);
		                uploadImageformData.append("x:pictureName",uploadImageArray[a].name);
		                uploadImageformData.append("x:pictureType",imageType.split("/")[1]);
		                uploadImageformData.append("x:pictureSize",uploadImageArray[a].size);
		                $.ajax({
		                    url: "http://up-z2.qiniup.com",
		                    type: "POST",
		                    data: uploadImageformData,
		                    contentType: false,
		                    processData: false,
		                    success: function (fileDatas) {
		                    	var picture={
				                	pictureName:fileDatas["x:pictureName"],
				                	pictureType:fileDatas["x:pictureType"],
				                	pictureSize:fileDatas["x:pictureSize"],
				                	pictureUrl:uploadImageUrl + fileDatas.hash
				                };
								pictureArrayData.push(picture);
								if( fileDatas["x:index"] == uploadImageArray.length-1){
									saveData(data,pictureArrayData);
								}
		                    },
		                    error: function () {
		                        showMsg("门店详情图片上传失败,请重新选择或者保存","W");
		                    }
		                });
					}
				}else if(i == length){
					saveData(data,null);
				}
			});	
			
		}
		
		//保存数据到数据库执行逻辑流
		function saveData(data,imagerArrayData){
			if(nui.get("pageType").getValue() == "edit"){//编辑
				var json={};
				json.oldServiceItemPicture=serviceItemPicture;//旧的项目图片
				if(imagerArrayData){//判断项目简介是否改变
					json.pictureArrayData=imagerArrayData;
				}
				var oldPictureIdArray="";
				$(".editPictureId").each(function(i,n){
					oldPictureIdArray += ( $(n).attr("pictureId") + "," );
				});
				json.oldPictureIdArray=oldPictureIdArray;
				json.serviceItemData=data;
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatAutoServiceItem.editAutoServiceItem.biz.ext?token="+token,
					type: 'POST',
					data: nui.encode(json),
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						nui.hideMessageBox(messAge);//关闭提示
						if(text.returens){
							CloseWindow("editSuccess");
						}else{
							CloseWindow("editFail");
						}
					}
				}); 
			}else if(nui.get("pageType").getValue() == "add"){//保存
				var json=nui.encode({serviceItemData:data,pictureArrayData:imagerArrayData});
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatAutoServiceItem.addAutoServiceItem.biz.ext?token="+token,
					type: 'POST',
					data: json,
					cache: false,
					async: false,
					contentType: 'text/json',
					success: function(text) {
						nui.hideMessageBox(messAge);//关闭提示
						if(text.returens){
							CloseWindow("saveSuccess");
						}else{
							CloseWindow("saveFail");
						}
					}
				});
			}
		}
		
		
		
		
		//门店改变事件
		function OnStoreId(e){
			cardId.setValue("");
			initCardId();//套餐卡加载
		}
		
		//业务类型
		var serviceTypeId=nui.get("serviceTypeId");
		//服务项目
		var itemId=nui.get("itemId");
		//套餐卡项目
		var cardId=nui.get("cardId");
		
		//项目类型
		function OnServiceItemTypechanged(e){
			if ( e.value == 1 ) { //服务项目
				$(".isCouponState").show();
               	$(".commonServiceItem").show();
               	$(".taicanServiceItem").hide();
               	serviceTypeId.setRequired(true);
               	itemId.setRequired(true);
               	cardId.setRequired(false);
				cardId.setValue("");
            }else if( e.value == 2 ){ //套餐卡项目
            	nui.get("isCoupon").setValue(0);
            	$(".isCouponclass").hide();
            	couponPercentage.setRequired(false);
				couponPrice.setRequired(false);
				couponPercentage.setValue("");
				couponPrice.setValue("");
            	$(".isCouponState").hide();
            	$(".commonServiceItem").hide();
               	$(".taicanServiceItem").show();
               	serviceTypeId.setRequired(false);
               	itemId.setRequired(false);
               	cardId.setRequired(true);
				serviceTypeId.setValue("");
				itemId.setValue("");
            }
			initCardId();//套餐卡加载
		}
		
		//套餐卡加载
        function initCardId(){
        	if( nui.get("storeId").getValue() == "" ){
				return;
			};
        	var json=nui.encode({orgId:nui.get("storeId").getSelected().orgid,tenantId:nui.get("storeId").getSelected().tenantId});
			nui.ajax({
				url: repairApiUrl+"/com.hsapi.repair.baseData.crud.wechatQueryTimesCardNoPage.biz.ext?token="+token,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					cardId.setData(text.timesCard);
				}
			});
        }
		
		//优惠价格
		function OnCouponPricechanged(e){
			nui.get("couponPrice").setValue( e.value == "" || !Boolean(parseFloat(e.value)) ? "" : parseFloat(e.value).toFixed(2) );
		}
		
		//项目开始价格输入完之后
		function OnBeginPricechanged(e){
			nui.get("serviceExtentBeginPrice").setValue( e.value == "" || !Boolean(parseFloat(e.value)) ? "" : parseFloat(e.value).toFixed(2) );
		}
		
		//项目开始价格输入完之后
		function OnEndPricechanged(e){
			nui.get("serviceExtentEndPrice").setValue( e.value == "" || !Boolean(parseFloat(e.value)) ? "" : parseFloat(e.value).toFixed(2) );
		}
		
		 
		//优惠价格验证
		function OnCouponPriceValidation(e){
			if (e.isValid) {
                if ( e.value == 0) {
                    e.errorText = "不能为零";
                    e.isValid = false;
                }else if( Boolean(parseFloat(e.value)) && nui.get("couponType").getValue() == 1 && Number ( e.value ) > Number( nui.get("itemPrices").getValue() ) ){//固定优惠验证
                	e.errorText = "优惠价格不能大于实际价格";
                    e.isValid = false;
                }
                /* else if( Boolean(parseFloat(e.value)) && nui.get("couponType").getValue() == 2 && ( e.value * 0.01 * nui.get("itemPrices").getValue() ) < nui.get("itemPrices").getValue() ){//固定优惠验证
                	e.errorText = "比例优惠的价格不能大于实际价格";
                    e.isValid = false;
                } */
            }
		}
		
		//项目开始价格区间
		function OnBeginPriceValidation(e){
			if (e.isValid) {
                if ( e.value == 0) {
                    e.errorText = "不能为零";
                    e.isValid = false;
                }else if( e.value > Number( nui.get("serviceExtentEndPrice").getValue() ) && nui.get("serviceExtentEndPrice").getValue() != "" ){
                	e.errorText = "最小价格不能大于最大价格";
                    e.isValid = false;
                }
            }
		}
		
		//项目结束价格区间
		function OnEndPriceValidation(e){
			if (e.isValid) {
                if ( e.value == 0) {
                    e.errorText = "不能为零";
                    e.isValid = false;
                }else if( e.value < Number( nui.get("serviceExtentBeginPrice").getValue() ) ){
                	e.errorText = "最大价格不能小于最小价格";
                    e.isValid = false;
                }
            }
		}
		
		//库存量验证
		function OnItemNumberValidation(e){
			if (e.isValid) {
                if ( e.value == 0) {
                    e.errorText = "不能为零";
                    e.isValid = false;
                }
                 if ( e.value < 0 && e.value != -1) {
                    e.errorText = "请输入正确的库存量";
                    e.isValid = false;
                }
            }
		}
		
		//上架日期改变事件
		function dateBeginchanged(){
			nui.get("itemOffDate").setMinDate(nui.get("itemOnDate").getValue());
		}
		
		//下架日期改变事件
		function dateEndchanged(){
			nui.get("itemOnDate").setMaxDate(nui.get("itemOffDate").getValue());
		}
		
		//固定优惠
		var couponPrice=nui.get("couponPrice");
		//比例优惠
		var couponPercentage=nui.get("couponPercentage");
		
		//是否优惠
		function OnisCouponchanged(){
			var couponType=nui.get("isCoupon");
			if( couponType.getValue() == 1 ){//优惠
				$(".isCouponclass").show();
				couponPrice.setRequired(true);
			}else if( couponType.getValue() == 0 ){//不优惠
				$(".isCouponclass").hide();
				couponPercentage.setRequired(false);
				couponPrice.setRequired(false);
				couponPercentage.setValue("");
				couponPrice.setValue("");
			}
		}
		
		//优惠类型选择改变时的事件
		function OnCouponTypechanged(){
			var couponType=nui.get("couponType");
			if( couponType.getValue() == 1 ){//固定优惠
				$(".couponbai").hide();
				$(".couponPrice").show();
				couponPrice.setRequired(true);
				couponPercentage.setRequired(false);
				couponPercentage.setValue("");
			}else if( couponType.getValue() == 2 ){//比例优惠
				$(".couponPrice").hide();
				$(".couponbai").show();
				couponPrice.setRequired(false);
				couponPercentage.setRequired(true);
				couponPrice.setValue("");
			}
		}
		
		//下拉选择业务类型改变时
		function OnValueChanged(){
			itemId.setValue("");
			itemId.setText("");
		}
		
		//点击选择项目
		function selectCustomer(){
			if( serviceTypeId.getValue() == "" ){
				showMsg("请先选择业务类型!","W");
				return;
			};
			nui.open({
				url: dmsUrl+"/com.hsweb.repair.DataBase.itemChoose.flow?token="+token,
				title: "服务项目",
				width: 700,
				height: 640,
				onload: function() { //弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {
						serviceTypeId: serviceTypeId.getValue(),
						WechatShow:1,
						WechatOrgid:nui.get("storeId").getSelected().orgid
					}; //传入页面的json数据
					iframe.contentWindow.wechatSetData(data);
				},
				ondestroy: function(action) { //弹出页面关闭前
					var iframe = this.getIFrameEl();
					var data=iframe.contentWindow.getWechatData();
					if(data){
						console.log(data);
						if(data.base == 1){//本地
							nui.get("itemType").setValue(2);
							nui.get("itemPrices").setValue(data.amt);
							itemId.setValue(data.id);
							itemId.setText(data.name);
							nui.get("itemQty").setValue(data.itemTime);
							nui.get("itemPrice").setValue(data.unitPrice);
						}else if(data.base == 2){//标准
							nui.get("itemType").setValue(1);
							nui.get("itemPrices").setValue(0);
							itemId.setValue(data.id);
							itemId.setText(data.itemName);
							nui.get("itemQty").setValue(1);
							nui.get("itemPrice").setValue(0);
							//nui.get("carModelId").setValue(data.CarModelID);
						}
					}
					
				}
			});
		}
		
		/* nui.get("storeBusinessBeginTime").setIsValid(false);
		nui.get("storeBusinessBeginTime").setErrorText("不能为"); */
		
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
	      			index++;
	      			$("#upload").append('<input id="fileImage'+index+'" name="fileImage'+index+'" class="images fileImage'+index+'" type="file" size="30" accept="image/png,image/jpeg" >');
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
			html+='		<div class="imgListOneDiv" style="display:none;" >';
			html+='			<img id="" alt="" src="'+pathweb+'/autoServiceSys/images/imageEdit.png" class="imgListone imgEdit'+indexss+'" num="'+indexss+'" >';
			html+='			<img id="" alt="" src="'+pathweb+'/autoServiceSys/images/deleteImage.png" class="imgListtwo imgDelete" num="'+indexss+'" >';
			html+='		</div>';
			html+='			<img id="" alt="" src="'+imageUrl+'" class="imgStyle '+imagerShow+'" >';
			html+='		</div>';
			html+='</a>';
			return html;
		};
		
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
		      			$(".imageshow"+num).attr("src",e.target.result);
		      		}
		    	});
		    	$(".fileImage"+num).click();
	    	});
	    	
		}
		
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
	    		$(".fileImage"+num).remove();
	    		$(".imagers"+num).remove();
	    	});
		}
		
		//取消
		function onCancel() {
			CloseWindow("cancel");
		}
		
		//关闭窗口
		function CloseWindow( action ) {
			if(window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				window.close();
		}
		
    </script>
</body>
</html>
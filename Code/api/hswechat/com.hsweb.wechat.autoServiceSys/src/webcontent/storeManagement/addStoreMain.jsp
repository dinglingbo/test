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

	<div class="nui-fit">
	
		<!-- 车道系统门店选择 -->
		<div id="advancedOrgWin" class="nui-window windowsss"
		     title="公司选择" style="width:530px;height:430px;"
		     showModal="true"
		     showHeader="false"
		     allowResize="false"
		     style="padding:2px;border-bottom:0;"
		     allowDrag="true">
		     <div class="nui-toolbar" >
		        <table style="width:100%;">
		            <tr>
		                <td style="width:100%;">
		                    <input class="nui-textbox" id="orgidOrName" name="orgidOrName" onenter="searchOrg()" width="160px" emptyText="请输入店号或公司名">
		                    <a class="nui-button" iconCls="" plain="true" onclick="searchOrg()" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
		                    <a class="nui-button" iconCls="" plain="true" onclick="addOrg" id=""><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
		                    <a class="nui-button" iconCls="" plain="true" onclick="onOrgClose" id=""><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
		                </td>
		            </tr>
		        </table>
		    </div>
		    <div class="nui-fit">
		          <div id="moreOrgGrid" class="nui-datagrid" style="width:100%;height:88%;"
		               selectOnLoad="true"
		               showPager="false"
		               dataField="companyList"
		               onrowdblclick="addOrg"
		               allowCellSelect="true"
		               editNextOnEnterKey="true"
		               allowCellWrap = true
		               allowCellSelect="true" 
		               multiSelect="false"
		               url="">
		              <div property="columns">
		              	<div type="checkcolumn" width="15" class="mini-radiobutton" header="选择"></div>
		                <div field="orgid" name="orgid" width="15" align="center"  visible="true" headerAlign="center" header="企业号"></div>
		                <div field="shortName" name="shortName" width="" align="center"  headerAlign="center" header="公司简称"></div>
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
    	<div class="form" id="showInForm" name="showInForm" style="height:90%;left:0;right:0;margin: 0 auto;display: flex;padding-top: 10px;padding-left: 10px;">
    		
    		<div style="display:flew;" >
				<div style="text-align: center;" >
					<label>门店详情<span style='color:red;font-size: 10px;'>(建议尺寸/414*519像素,不能超过8张)</span></label>
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
			
			<table style="width:100%;margin-left: 30px;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
				<tr>
					<td class="nui-form-label" colspan="1" style="width: 45%;" >
						<label>门店图片:</label>
					</td>
					<td colspan="3">
						<a href="#" class="imgA">
							<div class="divImg" >
								<img id="imgshowOnly" alt="" src="#" class="imgStyle" >
							</div>
						</a>
						<div style='color:red;font-size: 12px;'>图片（414*180像素）</div>
						<form id="uploadOnly" action="" target="hidden_frameOnly" method="post" enctype="multipart/form-data" style="display:none;" >
							<input id="fileImageOnly" type="file" size="30" accept="image/png,image/jpeg" name="fileselect[]">
							<button type="button" id="fileSubmitOnly" onclick="uploadOnlyFile()" >确认上传文件</button>
						</form>
						<iframe name='hidden_frameOnly' id="hidden_frameOnly" style="display:none;" ></iframe>
						
						<input class="nui-textbox" name="pageType" id="pageType" visible="false"/>
						<input class="nui-textbox" name="storeId" id="storeId" visible="false"/>
					</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1" style="width: 15%;" >
						<label>门店选择:</label>
					</td>
					<td colspan="3">
						<input class="nui-buttonedit" id="orgname" name="orgname" textname="orgname" emptyText="请选择门店" onbuttonclick="selectCustomer" selectOnFocus="true" required="true"  />
                        <input class="nui-textbox" id="orgid" name="orgid" visible="false" />
                        <input class="nui-textbox" id="tenantId" name="tenantId" visible="false" />
                        <input class="nui-textbox" id="storeLatitude" name="storeLatitude" visible="false" />
                        <input class="nui-textbox" id="storeLongitude" name="storeLongitude" visible="false" />
                        <input class="nui-textbox" id="storeStreetaddress" name="storeStreetaddress" visible="false" />
                        
                        <input class="nui-textbox" id="storeProvinceId" name="storeProvinceId" visible="false" />
                        <input class="nui-textbox" id="storeCityId" name="storeCityId" visible="false" />
                        <input class="nui-textbox" id="storeRegionId" name="storeRegionId" visible="false" />
                        
					</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1" style="width: 15%;" >
						<label>微信门店名称:</label>
					</td>
					<td colspan="3">
						<input class="nui-textbox tabwidth" name="storeName" id="storeName" required="true"/>
					</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1">
						<label>门店营业开始时间:</label>
					</td>
					<td colspan="1">
						<input id="storeBusinessBeginTime" name="storeBusinessBeginTime"  class="nui-timespinner" format="HH:mm"  style="margin-right: 35px;" required="true" />
					</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1">
						<label>门店营业结束时间:</label>
					</td>
					<td colspan="1">
						<input id="storeBusinessEndTime" name="storeBusinessEndTime" class="nui-timespinner" format="HH:mm" required="true" />
					</td>
				</tr>
				<tr>
					<td class="nui-form-label" colspan="1" style="width: 15%;" >
						<label>门店电话:</label>
					</td>
					<td colspan="3">
						<input class="nui-textbox tabwidth" id="storePhone" name="storePhone" required="true"/>
					</td>
				</tr>
				<tr>
					<td>
						<form id="upload" action="" target="hidden_frame" method="post" enctype="multipart/form-data" style="display:none;" >
							<input id="fileImage0" class="fileImage0 images" type="file" size="30" accept="image/png,image/jpeg" name="fileImage0">
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
    	var systemApiUrl=apiPathUrl+sysApi;
    	var oldImage=[];
    	var newImage=[];
    	var deleteImage=[];
    	var oldImageHead="";
    	
    	$(function(){
    		init();
		});
		
		function init(){
			$("#imgshowOnly").attr("src", pathweb+"/autoServiceSys/images/add_img.png");
		}
		
		//页面间传输json数据
		function setFormData(data) {
			var infos = nui.clone(data);
			nui.get("pageType").setValue(infos.pageType);
			if(infos.pageType == "edit"){
				var form = new nui.Form("#showInForm"); //将普通form转为nui的form
				form.setData(infos.storeData);
				nui.get("pageType").setValue(infos.pageType);
				nui.get("storeId").setValue(infos.storeData.storeId);
				nui.get("orgname").setValue(infos.storeData.orgid);
				nui.get("orgname").setText(infos.storeData.name);
				$('#imgshowOnly').get(0).src = infos.storeData.storePicture;
				oldImageHead=infos.storeData.storePicture;
				var pictureDataList = infos.storeData.pictureDataList;
				for(var a=0; a<pictureDataList.length;a++){
					var html=imageHtml(pictureDataList[a].pictureUrl,a,pictureDataList[a].pictureId);
	      			$(".add").before(html);
	      			//editDelete(index);
	      			$(".imgListtwo").css("margin-left","0");
	      			index++;
	      			$("#upload").append('<input id="fileImage'+index+'" name="fileImage'+index+'" imageId="'+pictureDataList[a].pictureId+'" imageUrl="'+pictureDataList[a].pictureUrl+'" class="images fileImage'+index+'" type="file" size="30" accept="image/png,image/jpeg" >');
					if( a == pictureDataList.length-1 ){
						mouseImage();
					}
				}
				
				
			}
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
		      			if( nui.get("pageType").getValue() == "edit" && $(".fileImage"+num).attr("imageId") ){
		      				if(newImage.length == 0){
		      					//保存旧的的图片
			      				var oldImageId=$(".fileImage"+num).attr("imageId");
			      				var oldImageUrl=$(".fileImage"+num).attr("imageUrl");
			      				//记录新的图片
			      				var newImageName=file.name;
			      				newImage.push({pictureId:oldImageId,newPictureName:newImageName,pictureUrl:oldImageUrl,index:num});
		      				}else{
		      					for(var a=0;a<newImage.length;a++){
			      					if(newImage[a].index == num){
			      						newImage[a].pictureName = file.name;
			      					}
			      				}
		      				}
		      				
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
			
			//营业开始时间验证
			var beginDate=new Date(data.storeBusinessBeginTime);
			data.storeBusinessBeginTime=beginDate.getHours()+":"+beginDate.getMinutes()+":"+beginDate.getSeconds();
			//营业结束时间验证
			var endDate=new Date(data.storeBusinessEndTime);
			data.storeBusinessEndTime=endDate.getHours()+":"+endDate.getMinutes()+":"+endDate.getSeconds();
			if(data.storeBusinessBeginTime == "0:0:0" && data.storeBusinessEndTime == "0:0:0"){
				nui.get("storeBusinessBeginTime").setIsValid(false);
				nui.get("storeBusinessEndTime").setIsValid(false);
				showMsg("营业时间不能全部是00:00","W");
				return;
			}
			
			if( beginDate.getTime() > endDate.getTime() ){
				showMsg("开始时间不得大于结束时间！","W");
				return;
			} 
			
			if( endDate.getTime() < beginDate.getTime() ){
				showMsg("结束时间不得小于开始时间！","W");
				return;
			} 
			
			//门店图片的验证
			if( $("#fileImageOnly")[0].files.length == 0 && nui.get("pageType").getValue() == "add"){
				showMsg("门店图片不能为空","W");
				return;
			}
			//门店详情图片的验证
			if( $(".imgListA").length == 0 ){
				showMsg("门店详情不能为空","W");
				return;
			}
			if( $(".imgListA").length >= 9 ){
				showMsg("门店详情的图片不能超过8张","W");
				return;
			}
			
			var map={
				orgid:data.orgid,
				storeName:data.storeName
			}
			//检验门店是否重复
			var json=nui.encode({map:map,token:token});
			nui.ajax({
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryStoreGetOrgid.biz.ext?token="+token,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					if(!text.storeDataArray[0].storeId || (nui.get("pageType").getValue() == "edit" && text.storeDataArray[0].storeId == data.storeId) ){
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
									//上传门店图片
									uploadImageFiles(fileImageOnly,data,imageToken);
								}else{
									uploadOnlyStoreInfoImage(data,null,imageToken);
								}
							}
						});
						
					}else{
						showMsg("已有此门店，门店不能重复!","W");
					}
					
					
				}
			});
			
			
			
		}
		
		//上传门店图片的文件
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
                	data.storePicture = uploadImageUrl + fileDatas.hash;
					uploadOnlyStoreInfoImage(data,fileDatas.hash,imageToken);
                },
                error: function () {
                    showMsg("图片上传失败,请重新选择","W");
                }
            });
	                
		}
		
		
		//门店详情上传
		function uploadOnlyStoreInfoImage(data,pictureUrl,imageToken){
			var length=$(".images").length-1;
			var uploadImageArray=[];
			var pictureArrayData=[];
			//门店详情上传
			$(".images").each(function(i,n){//过滤出有文件的数组
				if(Boolean($(n)[0].files[0]) ){//有文件的代码
					var fileImageOnly=$(n)[0].files[0];
					uploadImageArray.push(fileImageOnly);
				}
				if(i == length && uploadImageArray.length > 0 ){
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
									saveData(data,pictureArrayData,pictureUrl);
								}
		                    },
		                    error: function () {
		                        showMsg("门店详情图片上传失败,请重新选择或者保存","W");
		                    }
		                });
					}
				}else if(i == length){
					saveData(data,pictureArrayData,pictureUrl);
				}
			});	
			
		}
		
		//保存数据到数据库执行逻辑流
		function saveData(data,pictureArrayData,pictureUrl){
			var urlStr="";
			if(nui.get("pageType").getValue() == "add"){
				urlStr = pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.addWechatStores.biz.ext?token="+token;
				var json=nui.encode({storeData:data,pictureArrayData:pictureArrayData});
				nui.ajax({
					url: urlStr,
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
			}else if(nui.get("pageType").getValue() == "edit"){
				var jsonData={};
				if(!fileImageOnly){
					data.storePicture=oldImageHead;
				}else if(pictureUrl != oldImageHead){
					jsonData.oldImageHead=oldImageHead;
				}
				jsonData.deleteImage=deleteImage;
				var oldPictureIdArray="";
				$(".editImager").each(function(i,n){
					oldPictureIdArray += ( $(n).attr("pictureId") + "," );
				});
				jsonData.oldPictureIdArray=oldPictureIdArray;
				jsonData.pictureArrayData=pictureArrayData;
				jsonData.storeData = data;
				var json=nui.encode(jsonData);
				nui.ajax({
					url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.editStoreInfo.biz.ext?token="+token,
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
	    		//选择所要显示图片的img，要赋值给img的src就是e中target下result里面的base64编码格式的地址
	        	$('#imgshowOnly').get(0).src = e.target.result;
      		}
    	});
    	
    	
		
		//选择车道系统门店
		function selectCustomer(){
			$("#advancedOrgWin").show();
	    	searchOrg();
	    }
	    
	    //车道系统门店查询
	    var moreOrgGrid = nui.get("moreOrgGrid");
        moreOrgGrid.setUrl(systemApiUrl+"/systemApi/com.hsapi.system.basic.organization.getCompanyAll.biz.ext?token="+token);
		function searchOrg(){
			nui.ajax({
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatStore.getStoreParam.biz.ext?token="+token,
				type: 'POST',
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
			    	/* var orgidOrName=nui.get('orgidOrName').value;
			    	params.name=orgidOrName; */
			    	//params.name = nui.get("orgidOrName").getValue();
			    	//params.orgid =text.orgid;
			    	//params.tenantId = text.tenantId;
			    	var params={
			    		params:{
			    			name:nui.get("orgidOrName").getValue(),
			    			tenantId:text.tenantId
			    		}
			    	};
			    	
			    	var json=nui.encode(params);
			    	nui.ajax({
						url: systemApiUrl+"/systemApi/com.hsapi.system.basic.organization.getCompanyAll.biz.ext?token="+token,
						type: 'POST',
						data: json,
						cache: false,
						async: false,
						contentType: 'text/json',
						success: function(text) {
							moreOrgGrid.setData(text.companyList);
						}
					});
			    	
				}
			});
	    }
	    
		
		//门店选择框取消事件
		function onOrgClose(){
			$("#advancedOrgWin").hide();
			nui.get('orgidOrName').setValue("");
		}
		
		//确定选择的门店
		function addOrg(){
			var storeData=moreOrgGrid.getSelected();
			var orgname=nui.get("orgname");
			orgname.setValue(storeData.name);
			orgname.setText(storeData.name);
			orgname.validate();//验证
			var orgname=nui.get("orgid");
			orgname.setValue(storeData.orgid);
			var orgname=nui.get("tenantId");
			orgname.setValue(storeData.tenantId);
			
			var storeLatitude=nui.get("storeLatitude");
			storeLatitude.setValue(storeData.latitude);
			
			var storeLongitude=nui.get("storeLongitude");
			storeLongitude.setValue(storeData.longitude);
			
			var storePhone=nui.get("storePhone");
			storePhone.setValue(storeData.tel);
			
			var storeStreetAddress=nui.get("storeStreetaddress");
			storeStreetAddress.setValue(storeData.address);
			
			var storeProvinceId=nui.get("storeProvinceId");
			storeProvinceId.setValue(storeData.provinceId);
			
			var storeCityId=nui.get("storeCityId");
			storeCityId.setValue(storeData.cityId);
			
			var storeRegionId=nui.get("storeRegionId");
			storeRegionId.setValue(storeData.countyId);
			
			
			
			$("#advancedOrgWin").hide();
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
	      			index++;
	      			$("#upload").append('<input id="fileImage'+index+'" name="fileImage'+index+'" class="images fileImage'+index+'" type="file" size="30" accept="image/png,image/jpeg" >');
	      			mouseImage();
	      		}
	    	});
	    	
		}
    	
    	
    	
		//添加门店详情图片
		function imageHtml(imageUrl,indexss,pictureId){
			var html="";
			var imagerText="imagers"+indexss;
			var imagerShow="imageshow"+indexss;
			html+='<a href="#" class="imgListA '+imagerText+'">';
			html+='		<div class="" style="position: relative;" >';
			if(nui.get("pageType").getValue() == "edit" && pictureId){
				html+='		<div class="imgListOneDiv" style="display:none;text-align: center;" >';
				html+='			<img id="" alt="" src="'+pathweb+'/autoServiceSys/images/deleteImage.png" class="imgListtwo imgDelete" num="'+indexss+'" >';
			}else{
				html+='		<div class="imgListOneDiv" style="display:none;" >';
				html+='			<img id="" alt="" src="'+pathweb+'/autoServiceSys/images/imageEdit.png" class="imgListone imgEdit'+indexss+'" num="'+indexss+'" >';
				html+='			<img id="" alt="" src="'+pathweb+'/autoServiceSys/images/deleteImage.png" class="imgListtwo imgDelete" num="'+indexss+'" >';
			}
			html+='		</div>';
			
			if( nui.get("pageType").getValue() == "edit" && pictureId){
				html+='			<img id="" alt="" src="'+imageUrl+'" class="imgStyle editImager '+imagerShow+'" pictureId="'+pictureId+'" >';
			}else{
				html+='			<img id="" alt="" src="'+imageUrl+'" class="imgStyle '+imagerShow+'" >';
			}
			
			
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
	    	$(".imgDelete").click(function(){debugger;
	    		var num=$(this).attr("num");
	    		if(nui.get("pageType").getValue() == "edit" && $( ".fileImage"+( Number(num) + 1 ) ).attr("imageId")){
	    			var oldImageId=$( ".fileImage" + ( Number(num) + 1 ) ).attr("imageId");
	    			var data={ pictureId : Number(oldImageId) };
	    			deleteImage.push(data);
	    			$(".fileImage"+num).remove();
	    			$(".imagers"+num).remove();
	    		}else{
	    			$(".fileImage"+num).remove();
	    			$(".imagers"+num).remove();
	    		}
	    		
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
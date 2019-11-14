<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): dlb
  - Date: 2019-08-26 11:32:24
  - Description:
-->
<head>
<title>系统信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
            <%@include file="/common/sysCommon.jsp"%>
    <style type="text/css">
    	.titel{
    		width: 20px;
    		height: 35px;
    	}
    	 .content{
    		width: 80%;
    		height: 35px;
    	}
    	span{margin-left:20px;}
    	.have {
    		cursor:pointer;
		   	margin: 5px;
		    height: 30px;
		    font-size: 16px;
		    text-align: center;
		    margin-left: 10px;
		    border-radius: 5px;
		    text-decoration: none;
		    line-height: 2;
		    background: #fff;
		    color: #1885f3;
		    /* border: 1px solid #c0e1fd; */
		    display: inline-block
		}
		.noHave {
			cursor:pointer;
		    /* width: 90px; */
		    margin: 5px;
		    height: 30px;
		    font-size: 16px;
		    text-align: center;
		    margin-left: 10px;
		    border-radius: 5px;
		    text-decoration: none;
		    line-height: 2;
		    background: #fff;
		    color: #1d1e1f;
		   /*  background: #252525ab;
		    color: #f2f5f7; */
		    /* border: 1px solid #c0e1fd; */
		    display: inline-block
		}
		.kaitong {
		    width: 90px;
		    height: 34px;
		    background: #21c064;
		    border-radius: 5px;
		    display: inline-table;
		    color: #fff;
		    font-size: 16px;
		    text-align: center;
		    text-decoration: none;
		    line-height: 34px;
		}	
		a.btn {
		    background: #28bef0;
		    text-decoration: none;
		    display: inline-block;
		    height: 38px;
		    line-height: 38px;
		    padding: 0 22px;
		    border-radius: 5px;
		    color: #fff;
		    font-size: 15px;
		}
		.xz {
		   border: 2px solid #e66e19;
		}
    </style>
</head>
<body>
<div class="nui-fit" style="width: 100%;height: 100%;">
	 <!-- <table border="1" cellspacing="0" cellpadding="0" style="border-color:aliceblue;width: 100%">
		<td class="content"><span id="upgrade"></span></td>	
		<tr>
            <td id="upgrade">
               	                        
            </td>
       </tr>									
	</table> -->
	<table style="width:100%;">
            <tr>
                <td id="upgrade" colspan="3">
                 
                </td>
           </tr>
           <tr>
              <td style="width:70px;" align="right">充值天数：</td>
              <td colspan="1" style="width:50%"><input class="nui-textbox" style="width:80%;"  align="left" name="periodValidity"  id="periodValidity" /></td>
              <!--  <td style="width:70px;" align="left"><a href="#" class="btn" itemid="0" onclick="sellCoin()">确认充值</a></td> -->
               <td align="left" ><a href="#" class="btn" itemid="0" onclick="sellCoin()">确认充值</a></td>
           <tr>
     </table>
</div>


	<script type="text/javascript">
    	nui.parse();
    	var updateUrl = apiPath + sysApi + "/" + "com.hsapi.system.tenant.product.addProductService.biz.ext";
    	var teantTemp = {};
    	var selectHash = {};
    	var allHash = {};
    	var ProductList = [];
    	$(document).ready(function(v) {
			
			 $("body").on("click","a[name='add']",function(e){
			    var id = e.currentTarget.id;
			    var elem = document.getElementById(id);
			    var str = elem.getAttribute("class");
		        if(str=="noHave" || str=="have"){
		           if(str=="noHave"){
		              elem.className="noHave "+'xz';
		           }else{
		              elem.className="have "+'xz';
		           }
		           selectHash[id] = allHash[id];
		        }else{
		           if(str=="noHave xz"){
		             elem.className="noHave";
		           }else{
		            elem.className="have";
		           }
		           delete selectHash[id];
		        }
			    
			}); 
		});
		function setData(e){
    	   teantTemp = e;
    	   querySysProduct();
    	}
    	//查询升级模块
		function querySysProduct(){
			var querySysProductUrl = apiPath + sysApi + "/com.hsapi.system.tenant.product.querySysProduct.biz.ext";
			nui.ajax({
				url : querySysProductUrl,
				type : "post",
				data : JSON.stringify({
					params : {
						isDisabled : 0
					},
					token: token
				}),
				success : function(data) {
					data = data || {};
					if (data.errCode == "S") {
						ProductList = data.list;
						var querySysProductUrl = apiPath + sysApi + "/com.hsapi.system.tenant.product.queryTenantProduct.biz.ext";				
						nui.ajax({
							url : querySysProductUrl,
							type : "post",
							data : JSON.stringify({
								params : {
									status: 0,
									tenantId : teantTemp.tenantId
								},
								token: token
							}),
							success : function(text) {
								text = text || {};
								if (text.errCode == "S") {
									var html="";
									for(var i=0;i<ProductList.length;i++){
									    var key = ProductList[i].id;
									    allHash[key] = ProductList[i];
									    if(ProductList[i].type==0){
									       var isPermissions = true;
									       for(var j=0;j<text.comTenantProduct.length;j++){									
											  if(ProductList[i].id==text.comTenantProduct[j].productId && text.comTenantProduct[j].status==0){
											      isPermissions = false;
												  var endDateStr = text.comTenantProduct[j].endDate;
												  endDateStr =new Date(endDateStr).getFullYear()+"年 "+(parseFloat(new Date(endDateStr).getMonth())+1)+"月 "+new Date(endDateStr).getDate()+"日";
												 	html+='	<a class="have" name="add" title="有效期至：'+endDateStr+'" id="'+ProductList[i].id+'"" >&nbsp;'+data.list[i].name+'&nbsp;</a> ';
									             }
										   }
										   if(isPermissions){
											    isPermissions = true;
										      html+='		<a class="noHave" name="add" title="未购买，点击跳转购买界面！" id="'+ProductList[i].id+'"">&nbsp;'+data.list[i].name+'&nbsp;</a> ';
										
										   }
									     }
									document.getElementById('upgrade').innerHTML=html;
									}
								} else{
									parent.showMsg(data.errMsg || "商户查询异常!","E");
								}
							},
							error : function(jqXHR, textStatus, errorThrown) {
								// nui.alert(jqXHR.responseText);
								console.log(jqXHR.responseText);
							}
						});
					} else {
						parent.showMsg(data.errMsg || "商户查询异常!","E");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					// nui.alert(jqXHR.responseText);
					console.log(jqXHR.responseText);
				}
			});
		}
    	function sellCoin(){
    	  var periodValidity = nui.get("periodValidity").value;
    	  if(periodValidity==0 || periodValidity==""){
    	     showMsg("请输入充值天数","W");
    	     return;
    	  }
    	  var list = [];
         for (var key in selectHash) {
            var temp = selectHash[key];
            list.push(temp);
         }
    	  var json =  nui.encode({
			      "tenantId":teantTemp.tenantId,
			      "orgid":currOrgId,
			      "periodValidity":periodValidity,
			      "productHash":list
			      });
    	  nui.ajax({
			    url: updateUrl,
			    type: 'post',
			    data: json,	    	
			    cache: false,
			    success: function (data) {
			        if (data.errCode == "S"){
			       	 closeWindow("ok");
			         }else {
			          showMsg(data.errMsg || "充值失败","E");
			        }
			    },
			    error: function (jqXHR, textStatus, errorThrown) {
			        nui.alert(jqXHR.responseText);
			    }
		   });
    	}
    	
    </script>
</body>
</html>
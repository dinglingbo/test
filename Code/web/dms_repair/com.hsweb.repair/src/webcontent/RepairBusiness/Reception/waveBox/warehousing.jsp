<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-02-25 18:27:12
  - Description:
-->
<head>
<title>成品入库</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="/default/common/js/partUtil.js?v=1.0.13" type="text/javascript"></script>
</head>
<style type="text/css">
    html,body
    {
        width:100%;
        height:100%;
        border:0;
        margin:0;
        padding:0;
        overflow:visible;
    }
    .tbtext{
    text-align:right;
    
    }
 </style>
<body>
       <div id="form1" >
        	<input name="id" id="id"class="nui-hidden" />
        	<input name="serviceId"  id="serviceId" class="nui-hidden" />
        	<input name="partCode"  id="partCode" class="nui-hidden" />
        	<input name="partId"  id="partId" class="nui-hidden" />
        	<input name="partName"  id="partName" class="nui-hidden" />
        	<input name="enterUnitId"  id="enterUnitId" class="nui-hidden" />
        	<input name="fullName"  id="fullName" class="nui-hidden" />
        	<input name="qty"  id="qty" class="nui-hidden" />
        	
        <table style="line-height:30px;">
            <tr>
                <td class="tbtext" >
                    <label >配件名称:</label>
                </td>
                <td >
                    <input id="partName"  name="partName" class="nui-textbox"    enabled="false" style="width:calc(100% - 92px)"/>
                    <a class="nui-button" plain="false" iconCls="" onclick="addPart()" align="right"><span class="fa fa-plus fa-lg"align="right"></span>&nbsp;选择配件</a>
                </td>
                <td style="width:110px" class="tbtext">
                    <label>仓库:</label>
                </td>
                <td>
                   <input id="storeId"
                       name="storeId"
                       class="nui-combobox width1"
                       textField="name"
                       valueField="id"
                       emptyText="请选择仓库"
                       url=""
                       dataField="storehouse"
                       valuefromselect="true"
                       allowInput="true"
                       selectOnFocus="true"
                       showNullItem="false"
                       nullItemText="请选择..."
                       />
                </td>
            </tr>
            <tr>
                <td style="width:110px" class="tbtext">
                    <label>维修金额(元):</label>
                </td>
                <td>
                    <input id="amt"  name="amt" class="nui-textbox"  enable="false"width="100%"/>
                </td>
                <td style="width:110px" class="tbtext">
                    <label >销售金额(元):</label>
                </td>
                 <td>
                    <input id="sellPrice"  name="sellPrice" class="nui-textbox"  enable="false"width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="tbtext">
                    <label >&nbsp;&nbsp;备注:</label>
                </td>
                <td colspan="3">
                    <input class="nui-textarea" style="width:100%;height:100px" name="remark" id="remark"/>
                </td>
            </tr>
        </table>
    </div>
    <div align="right" style="padding-top:20px">
    	<a class="nui-button" plain="false" iconCls="" onclick="save()" align="right">保存</a>
    	<a class="nui-button" plain="false" iconCls="" onclick="close()" align="right">取消</a>
    </div>   
	<script type="text/javascript">
    	nui.parse();
    	var form = new nui.Form("#form1");
    	var FGuestId = 0;
    	var enterDetail = {};
    	var partUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
    	var rightGridUrl = partUrl+ "com.hsapi.part.invoice.svr.queryPjPchsOrderDetailList.biz.ext";
    	var storehouse = null;
    	
    	getStorehouse(function(data){
	        var storehouse = data.storehouse||[];
	        nui.get("storeId").setData(storehouse);
    	});
    	function setData(){
    		getGuestId();
    	}
    	
    	var auditUrl = partUrl + "com.hsapi.part.invoice.crud.auditPjPchsOrder.biz.ext";
    	function save(){ 
    		var data = form.getData();
    		var orderMain = {
    			serviceId : data.serviceId,
    			storeId : data.storeId,
    			storeName : nui.get("storeId").text
    		};
    		var orderDetailAdd = null;
    		var orderDetailUpdate = null;
    		if(!data.id){
    			orderDetailAdd = data;
    		}
    		nui.ajax({
				url : partUrl + "com.hsapi.part.invoice.crud.auditPjProduct.biz.ext",
				type : "post",
				data : {
					orderMain : orderMain,
					orderDetailAdd : orderDetailAdd,
					operateFlag : 1,
					token : token
				},
				success : function(text) {
					console.log(text);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR.responseText);
				}
			});
    	}
    	
    	function searchDetailMsg(mainId){
    		var params = {};
    		params.mainId = mainId;
    		nui.ajax({
				url : rightGridUrl,
				type : "post",
				data : {
					params : params,
					token : token
				},
				success : function(data) {
					var pjPchsOrderDetailList = data.pjPchsOrderDetailList;
					if (pjPchsOrderDetailList.length > 0) {
						pjPchsOrderDetailList = data.pjPchsOrderDetailList[0];
						var mainId = pjPchsOrderDetailList.id;
						nui.get("mainId").setValue(mainId);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR.responseText);
				}
			});
    	}
    	
    	function addPart(){//添加配件
    		selectPart(function(data) {
				var part = data.part;
				addDetail(part);
			}, function(data) {
					
			});
    	}
    	
    	function addDetail(part) {
				nui.open({
			//				// targetWindow: window,,
							url : webPath+contextPath+"/com.hsweb.part.manage.detailQPAPopOperate.flow?token="+token,
							title : "入库数量金额",
							width : 430,
							height : 210,
							allowDrag : true,
							allowResize : false,
							onload : function() {
								var iframe = this.getIFrameEl();
								part.storeId = nui.get("storeId").value;//nui.get("storeId").getValue();
								iframe.contentWindow.setData({
									part : part,
									priceType : "pchsIn"
								});
							},
							ondestroy : function(action) {
								if (action == "ok") {
									var iframe = this.getIFrameEl();
									var data = iframe.contentWindow.getData();
									enterDetail = {};
									enterDetail.partId = data.id;
									enterDetail.partCode = data.code;
									enterDetail.partName = data.name;
									enterDetail.enterUnitId = data.unit;
									enterDetail.systemUnitId = data.systemUnitId;
									enterDetail.fullName = data.unit;
									enterDetail.qty = 1;
									enterDetail.amt = data.amt;
									enterDetail.price = data.price;
									enterDetail.storeId = data.storeId;
									enterDetail.remark = data.remark;
									enterDetail.serviceId = nui.get("serviceId").value;
									enterDetail.id = nui.get("id").value;
									form.setData(enterDetail);
								}
							}
						});
			}
    	
    	var guestUrl = partUrl + "com.hsapi.part.common.svr.getGuestByInternalId.biz.ext";
    	function getGuestId() {
		    nui.ajax({
		        url : guestUrl,
		        type : "post",
		        data : JSON.stringify({}),
		        success : function(data) {
		            data = data || {};
		            if (data.guest) {
		                var guest = data.guest;
		                FStoreId = guest.id;
		                var billTypeId = guest.billTypeId || "";
		                var settleTypeId = guest.settTypeId || "";
		                var dataAll = {guestId : FStoreId , billTypeId : billTypeId , settleTypeId : settleTypeId};
		                form.setData(dataAll);
		            } else {
		                console.log(data.errMsg);
		            }
		        },
		        error : function(jqXHR, textStatus, errorThrown) {
		            console.log(jqXHR.responseText);
		        }
		    });
		}
		
		function selectPart(callback, checkcallback) {
				nui.open({
			//		// targetWindow: window,,
					url : webPath+contextPath+"/com.hsweb.part.common.partSelectView.flow?token="+token,
					title : "配件选择",
					width : 930,
					height : 560,
					allowDrag : true,
					allowResize : true,
					onload : function() {
						var iframe = this.getIFrameEl();
						iframe.contentWindow.setData({}, callback, checkcallback);
					},
					ondestroy : function(action) {
					}
				});
		}
		
		function close(){
			window.CloseOwnerWindow('');
		}
    </script>
</body>
</html>
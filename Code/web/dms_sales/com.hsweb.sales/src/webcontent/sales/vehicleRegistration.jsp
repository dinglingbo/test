<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 17:21:29
  - Description:
-->

    <head>
        <title>车辆登记</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <%@include file="/common/commonRepair.jsp"%>
            <script src="<%= request.getContextPath() %>/sales/sales/js/vehicleRegistration.js?v=1.00" type="text/javascript">
            </script>
    </head>
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        
        .auto-style1 {
            height: 31px;
        }
        
        .td_title {
            width: 60px;
            text-align: right;
        }
        
        .style1 {
            width: 95px;
            text-align: right;
        }
        
        .style2 {
            width: 80px;
        }
        
        .style3 {
            width: 132px;
        }
        
        .style4 {
            width: 81px;
            text-align: right;
        }
        
        .style5 {
            width: 81px;
        }
        
        .textbox {
            height: 20px;
            margin: 0;
            padding: 0 2px;
            box-sizing: content-box;
        }
        
        .textbox .textbox-text {
            white-space: pre-wrap !important;
        }
    </style>

    <body id="form1">
        <div class="nui-toolbar" style="padding:0px;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
                        <a class="nui-button" iconCls="" plain="true" onclick="save()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
        <table style="width: 100%; line-height: 30px; padding-top: 10px; padding-left: 5px;">
             
              <!-- <input class="nui-combobox" id="insureCompName" name="insureCompName" emptyText="选择保险公司" 
              dataField="list" valueField="fullName" textField="fullName" showNullItem="true" nullItemText="请选择..." 
              popupWidth="200" onvaluechanged="insuranceChange" width="100%" visible="false"/> -->
        
            <tr>
                <td class="td_title">车牌号码
                </td>
               <td>
                    <input id="carNo" name="carNo" style="width: 100%" class="nui-textbox" />
                </td>
               <!--   <td align="right">出生日期
                    <td>
                        <input id="birthday" name="birthday" style="width: 100%" class="nui-textbox" />
                    </td> -->
            </tr>
            <!-- <tr>
                <td align="right">手机号码
                </td>
                <td>
                    <input id="mobile" name="mobile" style="width: 100%" class="nui-textbox" />
                </td>
                <td align="right">联系电话
                </td>
                <td>
                    <input id="tel" name="tel" style="width: 100%" class="nui-textbox" />
                </td>
            </tr> -->
            <tr>

                <td align="right" style="width:95px;">商业险保险公司
                </td>
                <td align="left">
                    <input id="annualInspectionCompCode" name="annualInspectionCompCode" class="nui-combobox" editable="false"  visible="false" />
                    <input class="nui-combobox" id="annualInspectionCompName" name="annualInspectionCompName" emptyText="选择保险公司" 
              dataField="compList" valueField="fullName" textField="fullName" showNullItem="true" nullItemText="请选择..." 
              popupWidth="200" onvaluechanged="insuranceChange" width="100%"/>
                </td>


                <td align="right" style="width:95px;">交强险保险公司
                </td>
                <td>
                    <input id="insureCompCode" name="insureCompCode" class="nui-combobox" editable="false" visible="false" />
                    <input class="nui-combobox" id="insureCompName" name="insureCompName" emptyText="选择保险公司" 
              dataField="list" valueField="fullName" textField="fullName" showNullItem="true" nullItemText="请选择..." 
              popupWidth="200" onvaluechanged="insuranceChange2" width="100%"/>
                </td>
            </tr>
            <tr>
                <td align="right">商业险到期
                </td>
                <td>
                    <input id="annualInspectionDate" name="annualInspectionDate" class="nui-datepicker" editable="false" style="width: 100%" />
                </td>
                <td align="right">交强险到期
                </td>
                <td>
                    <input id="insureDueDate" name="insureDueDate" class="nui-datepicker" editable="false" style="width: 100%" />
                </td>

            </tr>
            <tr>
                <td align="right" style="width:95px;">车辆年审日期
                </td>
                <td>
                    <input id="annualVerificationDueDate" name="annualVerificationDueDate" style="width: 100%" class="nui-datepicker" editable="false" />
                </td>

                <td align="right" style="width:95px;">驾证年审日期
                </td>
                <td>
                    <input id="licenseOverDate" name="licenseOverDate" style="width: 100%" class="nui-datepicker" editable="false" />
                </td>
            </tr>

            <tr>
                <td align="right" style="width:95px;">下次保养日期
                </td>
                <td>
                    <input id="careDueDate" name="careDueDate" style="width: 100%" class="nui-datepicker" editable="false" />
                </td>
                <td align="right" style="width:95px;">下次保养里程
                </td>
                <td>
                    <input id="careDueMileage" name="careDueMileage" min="0" class="nui-textbox usernumber" style="width: 120px;" />公里
                </td>
            </tr>
        </table>
        <script type="text/javascript">
            nui.parse();
            var saveUrl = apiPath + saleApi + '/com.hsapi.sales.svr.save.saveCarGuest.biz.ext';
            var insuranceInfoUrl =  apiPath + repairApi + "/" + "com.hsapi.repair.baseData.insurance.InsuranceQuery.biz.ext?params/orgid="+currOrgId+"&params/isDisabled=0";
            var form = new nui.Form("form1");
            var enterId = null;
            var guestId = null;
            var insuranceComp = null;
	       $(document).ready(function(v) {
	             insuranceComp = nui.get("insureCompName");
	             insuranceComp.setUrl(insuranceInfoUrl);
	       });
	
            function SetData(data) {
                 var compList = insuranceComp.getData();
                 nui.get("annualInspectionCompName").setData(compList);
               
                 enterId = data.enterId;
                 guestId = data.guestId;
                /* guestId = gId || "";
                guestFullName = gFullName || ""; */
                //查找该车的保险信息
                 if(enterId==0){
					 enterId = 0;
				 }else{
					 var params = {};
					 params.guestId = guestId;
					 params.enterId = enterId;
					 params.mobile = data.mobile;
				      nui.ajax({
				   	        url: apiPath + saleApi + "/com.hsapi.sales.svr.save.queryCarAndCarExtend.biz.ext",
				   	        data: {
				   	        	params:params,
				   	        	token:token
				   	        },
				   	        cache: false,
				   	        async: false,
				   	        success: function(text) {
				   	            if (text.errCode == "S"){
				   	               var result = text.result;
				   	               if(result){
				   	                  var car = result.car;
				   	                  var carExtend = result.carExtend;
				   	                  var data = result.data;
				   	                  var contactor = result.contactor;
				   	                  if(contactor){
				   	                     var licenseOverDate = contactor.licenseOverDate;
				   	                      nui.get("annualInspectionCompCode").setValue(licenseOverDate);
				   	                  }
				   	                  if(data){
					   	                  var insureCompName = data.insureCompName || "";
					   	                  nui.get("insureCompName").setValue(insureCompName);
					   	            	  nui.get("annualInspectionCompName").setValue(insureCompName);
					   	            	  
					   	            	   var insureCompId = data.insureCompId || "";
					   	            	  nui.get("annualInspectionCompCode").setValue(insureCompId);
					   	            	  nui.get("insureCompCode").setValue(insureCompId);
					   	            	  
					   	            	  var endDate = data.endDate || "";
					   	            	  nui.get("annualInspectionDate").setValue(endDate);
					   	            	  nui.get("insureDueDate").setValue(endDate);
				   	                  }
				   	                  if(carExtend){
				   	                      var careDueDate = carExtend.careDueDate || "";
					   	            	  nui.get("careDueDate").setValue(careDueDate);
					   	            	
					   	            	  var careDueMileage = data.careDueMileage || "";
					   	            	  nui.get("careDueMileage").setValue(careDueMileage);
				   	                  }
				   	                  if(car){
				   	                      var carNo = car.carNo || "";
					   	            	  nui.get("carNo").setValue(carNo);
				   	                  }
				   	            	  
				   	               }
				   	            } 
				   	        }
				   	    }); 
				  }
		   }

            function save() {
                var data = form.getData(true);
                var params = data;
                params.enterId = enterId;
                params.guestId = guestId;
                if(data.carNo){
		            var falge = isVehicleNumber(data.carNo);
		        	data.carNo = falge.vehicleNumber;//返回转化好的车牌
		        	if(!falge.result){
		        		showMsg("请输入正确的车牌号","W");
		        		return;
		        	}
		            nui.ajax({
		                url: saveUrl,
		                type: 'post',
		                data: {
		                    params: params
		                },
		                success: function(res) {
		                    if (res.errCode == 'S') {
		                        nui.get("carNo").setValue(data.carNo);
		                        showMsg('保存成功', 'S');
		                    } else {
		                        showMsg(res.errMsg, "E");
		                    }
		                }
		            })
		        }else{
		            showMsg("请输入车牌号","W");
		        	return;
		        }
            }

            function onCancel() {
                CloseWindow("cancel");
            }

            function CloseWindow(action) {
                if (window.CloseOwnerWindow)
                    return window.CloseOwnerWindow(action);
                else
                    window.close();
            }
            
            function insuranceChange(e){
			    var selected = e.selected;
			    nui.get("annualInspectionCompCode").setValue(selected.id);
			}
			function insuranceChange2(e){
			    var selected = e.selected;
			    nui.get("insureCompCode").setValue(selected.id);
			}
        </script>
    </body>

    </html>
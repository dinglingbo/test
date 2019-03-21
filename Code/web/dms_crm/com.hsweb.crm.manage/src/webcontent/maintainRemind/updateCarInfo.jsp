<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-22 15:07:42
  - Description: 
-->

<head>
    <title>修改 车信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
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
        table {
            font-size: 12px;
        }

        .form_label {
            width: 100px;
            text-align: right;
        }

        .required {
            color: red;
        }
         a.optbtn {
        width: 60px; 
        height: 20px; 
        border: 1px #d2d2d2 solid;
        background: #f2f6f9;
        text-align: center;
        display: inline-block;    
        /* line-height: 26px; */
        margin: 0 4px;
        color: #000000;
        text-decoration: none;
        border-radius: 5px; 
    }
    </style>
</head>

<body>

                    <div class="nui-toolbar" style="padding:0px;">
                            <table style="width:100%;">
                                <tr>
                                    <td style="width:100%;">
                                        <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a>
                                        <a class="nui-button" onclick="onClose(2)" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                  
                    <div class="form" id="carInfoFrom" style="height:100%;width:100%;padding-right:20px;">
                        <input class="nui-hidden" name="id" />
                        <input class="nui-hidden" name="guestId" />
                        <input class="nui-hidden" name="carBrandId" id="carBrandId" />
                        <input class="nui-hidden" name="carModelId" id="carModelId"/>
                        <input class="nui-hidden" name="carModelIdLy" id="carModelIdLy"/>
                        <input class="nui-hidden" name="insureCompName" id="insureCompName" />
                        <input class="nui-hidden" name="annualInspectionCompName" id="annualInspectionCompName" />
                        <table class="nui-form-table" style="width:100%;line-height: 30px;">
                            <tr>
                                <td class="form_label required">
                                    <label>车牌号：</label>
                                </td>
                                <td colspan="3">
                                    <input class="nui-textbox" name="carNo" id="carNo" onvaluechanged="onCarNoChanged"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>车架号(VIN)：</label>
                                </td>
                                <td colspan="2">
                                    <input class="nui-textbox" id="vin" name="vin" width="100%" />
                                </td>
                                <td>
                                    <a class="nui-button" onclick="onParseUnderpanNo()">解析车型</a>
                                    <a class="nui-button" onclick="getCarModel(setCarModel)">选择车型</a>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>车型信息：</label>
                                </td>
                                <td colspan="3">
                                    <textarea class="nui-textarea" id="carModel" name="carModelFullName" width="100%"></textarea>
                                </td>
                            </tr>
                            <!--
                            <tr>
                                <td class="form_label">
                                    <label>品牌车型：</label>
                                </td>
                                <td colspan="3">
                                    <input class="nui-buttonedit" name="carModelId" id="carModelId" onclick="selectCarModel('carModelId','carBrandId')" width="100%"/>
                                </td>
                            </tr>
                            -->
                            <tr>
                                <td class="form_label">
                                    <label>发动机号：</label>
                                </td>
                                <td>
                                    <input name="engineNo" class="nui-textbox" width="100%" />
                                </td>
                                <td class="form_label">
                                    <label>年审到期：</label>
                                </td>
                                <td>
                                    <input name="annualVerificationDueDate" format="yyyy-MM-dd" allowInput="false" class="nui-datepicker" width="100%" />
                                </td>
                            </tr>
            
                            <tr>
                                <td class="form_label">
                                    <label>商业险单号：</label>
                                </td>
                                <td>
                                    <input name="annualInspectionNo" class="nui-textbox" width="100%" />
                                </td>
                                <td class="form_label">
                                    <label>商业险到期：</label>
                                </td>
                                <td>
                                    <input name="annualInspectionDate" format="yyyy-MM-dd" allowInput="false" class="nui-datepicker" width="100%" />
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>商业险投保公司：</label>
                                </td>
                                <td colspan="3">
                                    <input class="nui-combobox" name="annualInspectionCompCode" id="annualInspectionCompCode" valueField="id" textField="fullName" width="100%" onvaluechanged="onannualInsureChange"
                                    />
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>交强险单号：</label>
                                </td>
                                <td>
                                    <input name="insureNo" class="nui-textbox" width="100%" />
                                </td>
                                <td class="form_label">
                                    <label>交强险到期：</label>
                                </td>
                                <td>
                                    <input name="insureDueDate" allowInput="false" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
                                </td>
                            </tr>
                             <tr>
                                <td class="form_label">
                                    <label>交强险投保公司：</label>
                                </td>
                                <td colspan="3">
                                    <input class="nui-combobox" name="insureCompCode" id="insureCompCode" valueField="id" textField="fullName" width="100%" onvaluechanged="onInsureChange"
                                    />
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>生产日期：</label>
                                </td>
                                <td>
                                    <input name="produceDate" allowInput="false" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
                                </td>
                                <td class="form_label"> 
                                    <label>上牌日期：</label>
                                </td>
                                <td>
                                    <input  id="firstRegDate" name="firstRegDate"  allowInput="false" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
                                </td>
                            </tr>
                            <tr>
            
                                <td class="form_label">
                                    <label>发证日期：</label>
                                </td>
                                <td>
                                    <input id="issuingDate" name="issuingDate" format="yyyy-MM-dd" allowInput="false" class="nui-datepicker" width="100%" />
                                </td>
                                <td class="form_label"> 
                                        <label>下次保养日期：</label>
                                    </td>
                                    <td>
                                        <input id="careDueDate" name="careDueDate" allowInput="false" format="yyyy-MM-dd" class="nui-datepicker" width="100%" />
                                    </td>
            
                                <!--   <td class="form_label" >
                                    <label>公司内部车：</label>
                                </td>
                                <td>
                                    <input name="isCompanyInside"
                                           data="[{id:1,text:'是'},{id:0,text:'否'}]"
                                           class="nui-combobox" width="100%"/>
                                </td> -->
            
                            </tr>
                        </table>
                    </div>
    <script type="text/javascript">
        nui.parse();
        var baseUrl = apiPath + repairApi + "/";
        var carUrl = baseUrl + "com.hsapi.repair.repairService.crud.getCarById.biz.ext";
        var carExUrl = baseUrl + "com.hsapi.repair.repairService.crud.GetCarExtendById.biz.ext";
        var saveUrl = baseUrl + "com.hsapi.repair.repairService.threeDC.saveCarData.biz.ext";

        var mainData = {};
        var carInfoFrom = new nui.Form("#carInfoFrom");

        initInsureComp("annualInspectionCompCode",function(){
    	var inlist = nui.get("annualInspectionCompCode").getData();
    	nui.get("insureCompCode").setData(inlist);
    });

        nui.get("carNo").focus();
        document.onkeyup = function (event) {
            var e = event || window.event;
            var keyCode = e.keyCode || e.which; //38向上 40向下
            if ((keyCode == 27)) { //ESC
                onCancel();
            }
        };

        function setData(rowData) {
            mainData = rowData;
            loadForm(mainData.carId);
        }


function loadForm(carId) {
    nui.ajax({
        url:carUrl,
        type:'post',
        data:{id:carId},
        success:function(res){
            if(res.car != '' &&res.car != null &&res.car != {} ){
                    carInfoFrom.setData(res.car );
            }else{
                showMsg('数据加载失败','E');
            }

        }
    });
    nui.ajax({
        url:carExUrl,
        type:'post',
        data:{id:carId},
        success:function(res){
            if(res.carExtend != '' &&res.carExtend != null &&res.carExtend != {} ){
                    nui.get("careDueDate").setValue(res.carExtend.careDueDate);
            }

        }
    });
    
}


function save(){

	var carForm = carInfoFrom.getData(true);
	if(carForm.carNo==""||carForm.carNo==""){
		showMsg("车牌号不能为空!","W");
		return;
    }
    else {
    var ex ={
        carId:carForm.id,
        careDueDate:carForm.careDueDate
    };
        
    // nui.mask({
	// 	el : document.body,
	// 	cls : 'mini-mask-loading',
	// 	html : '保存中...'
    // });
    // nui.unmask(document.body);

    nui.ajax({
        url:saveUrl,
        type:'post',
        data:{
            carData:carForm,
            carExData:ex
        },
        success:function(res){
            if(res.errCode == 'S'){
                showMsg('保存成功','S');
            }else{
                showMsg('保存失败','E');
            }
            CloseWindow("ok");
        }
    });
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
    </script>
</body>

</html>
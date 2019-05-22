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
    <title></title>
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

        .textboxWidth {
            width: 100%;
        }

        .tbText {
            text-align: right;
        }

        .td_title {
            padding-left: 15px;
        }
    </style>
</head>

<body>

    <div class="nui-fit" id="form1">
            <input id="id" name="id" class="nui-textbox" visible="false"/>
        <div class="nui-toolbar" style="padding:0px;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
                        <a class="nui-button" iconCls="" plain="true" onclick="save()"><span
                                class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span
                                class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
        <table style="font-size: 9pt; padding-left: 10px">
            <tr>
                <td class="td_title">车型编号：
                </td>
                <td>
                    <input id="code" name="code" class="nui-textbox" type="text" style="width: 150px" value="自动编号"
                        disabled="disabled" />
                </td>
                <td class="td_title">拼音码：
                </td>
                <td>
                    <input id="pyCode" name="pyCode" class="nui-textbox" type="text" style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">级别：
                </td>
                <td>
                    <input id="level" name="level"  class="nui-combobox"  dataField="data" valueField="id" textField="name"style="width: 150px" />
                </td>
                <td class="td_title">国别：
                </td>
                <td>
                    <input id="countryType" name="countryType" class="nui-combobox"  dataField="data" valueField="id" textField="name"style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">品牌：
                </td>
                <td>
                    <input name="carBrandId" id="carBrandId" class="nui-combobox width2" textField="nodeName"
                    valueField="nodeId" dataField="list"  emptyText="请选择..." url=""  onValuechanged="onBrandChanged"
                    showNullItem="false" nullItemText="请选择..." allowInput="true" valueFromSelect="true"
                    style="width: 150px" />
                    <!-- <input id="carBrandId" name="carBrandId" class="nui-combobox"  dataField="data" valueField="id" textField="name"style="width: 150px" /> -->
                </td>
                <td class="td_title">车系：
                </td>
                <td>
                    <input id="carSeriesId" name="carSeriesId"class="nui-combobox" dataField="list" allowUnselec="true"
                    textField="nodeName" valueField="nodeId"  allowInput="false"  
                     style="width:150px"/>
                    <!-- <input id="carSeriesId" name="carSeriesId" class="nui-combobox"  dataField="data" valueField="id" textField="name"style="width: 150px" /> -->
                </td>
            </tr>
            <tr>
                <td class="td_title">年款：
                </td>
                <td>
                    <input id="fyear" name="fyear" vtype="int" class="nui-textbox"style="width: 150px" />
                </td>
                <td class="td_title">车型名称：
                </td>
                <td>
                    <input id="name" name="name" class="nui-textbox" style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">结构：
                </td>
                <td>
                    <input id="carStructureType" name="carStructureType" class="nui-combobox"  dataField="data" valueField="id" textField="name"style="width: 150px" />
                </td>
                <td class="td_title">排量：
                </td>
                <td>
                    <input id="outputVolume" name="outputVolume" class="nui-combobox"  dataField="data" valueField="id" textField="name"style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">座位数：
                </td>
                <td>
                    <input id="seatQty" name="seatQty" class="nui-combobox"  dataField="data" valueField="id" textField="name"style="width: 150px" />
                </td>
                <td class="td_title">进气形式：
                </td>
                <td>
                    <input id="inletType" name="inletType" class="nui-combobox"  dataField="data" valueField="id" textField="name"style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">能源：
                </td>
                <td>
                    <input id="powerType" name="powerType" class="nui-combobox"  dataField="data" valueField="id" textField="name"style="width: 150px" />
                </td>
                <td class="td_title">驱动方式：
                </td>
                <td>
                    <input id="driveMode" name="driveMode" class="nui-combobox"  dataField="data" valueField="id" textField="name"style="width: 150px" onValuechanged="onDriveModeChanged"/>
                </td>
            </tr>
            <tr>
                <td class="td_title">续航里程：
                </td>
                <td>
                    <input id="enduranceMileage" name="enduranceMileage" class="nui-textbox" style="width: 150px" enabled="false"/>
                </td>
                <td class="td_title">电动机：
                </td>
                <td>
                    <input id="electricMotor" name="electricMotor" class="nui-textbox" style="width: 150px" enabled="false"/>
                </td>
            </tr>
            <tr>
                <td class="td_title">充电时间：
                </td>
                <td >
                    <input id="chargingTime" name="chargingTime" class="nui-textbox" style="width: 150px" enabled="false"/>
                </td>
                <td class="td_title">变速箱：
                </td>
                <td>
                    <input id="gearBox" name="gearBox" class="nui-combobox"  dataField="data" valueField="id" textField="name"style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">生产方式：
                </td>
                <td>
                    <input id="productionMode" name="productionMode" class="nui-combobox"  dataField="data" valueField="id" textField="name"style="width: 150px" />
                </td>
                <td class="td_title">上市日期：
                </td>
                <td>
                    <input id="launchDate" name="launchDate" class="nui-datepicker" style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">是否进口：
                </td>
                <td>
                    <input id="isImported" name="isImported" class="nui-combobox"  data="isNotArr" valueField="id" textField="name"style="width: 150px" />
                </td>
                <td class="td_title">是否共享：
                </td>
                <td>
                    <input id="isShare" name="isShare" class="nui-combobox"  data="isNotArr" valueField="id" textField="name"style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td align="right">指导进价：
                </td>
                <td>
                    <input id="guidingPrice" name="guidingPrice" class="nui-textbox" type="text" style="width: 135px" />元
                </td>

                <td align="right">指导销价：
                </td>
                <td>
                    <input id="sellPrice" name="sellPrice" class="nui-textbox" type="text" style="width: 135px" />元
                </td>
            </tr>
            <tr>
                <td align="right">销售底价：
                </td>
                <td>
                    <input id="sellPriceMin" name="sellPriceMin" class="nui-textbox" type="text" style="width: 135px" />元
                </td>
                <td align="right">购车订金：
                </td>
                <td>
                    <input id="sellOrderPrice" name="sellOrderPrice" class="nui-textbox" type="text" style="width: 135px" />元
                </td>
            </tr>
            <tr>
                <td align="right">备注说明：
                </td>
                <td colspan="3">
                    <input id="configure" name="configure" class="nui-textarea" multiline="true" style="width: 100%; height: 65px;" />
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
    var isNotArr = [{id:0,name:'是'},{id:1,name:'否'}];
    nui.parse();
    var addUrl = apiPath + saleApi + "/sales.base.addCsbCarModel.biz.ext";
    var updateUrl = apiPath + saleApi + "/sales.base.updateCsbCarModel.biz.ext";
    var modelUrl = apiPath + repairApi + '/com.hsapi.repair.common.svr.queryCarBrandSeriesTree.biz.ext';
    var form =  new nui.Form("form1");
    var carBrandId = nui.get('carBrandId');
    var carSeriesId = nui.get('carSeriesId');
    var driveMode = nui.get('driveMode');
    var type = null;
    carBrandId.setUrl(modelUrl);
    initDicts({
        level:'10383',//级别
        countryType:'10384',//国别
        carSeriesId:'',//车系
        carStructureType:'10385',//结构
        outputVolume:'DDT20130703000044',//排量
        seatQty:'10386',//座位数
        inletType:'10387',//进气形式
        powerType:'10388',//能源
        driveMode:'10389',//驱动方式
        gearBox:'DDT20130705000017',//变速箱
        productionMode:'10390',//生产方式


        //isCome: "DDT20150303000004",//来厂状态
        //visitStatus: "DDT20130703000081",//跟踪状态
        //color: "DDT20130726000003"//车辆颜色
    });

    function setData(row,e) {
        type = e;
        if(e == 2 || e == 3){
            form.setData(row);
            nui.get("carBrandId").doValueChanged();
            carSeriesId.setValue(row.carSeriesId);
            driveMode.doValueChanged();
        }
        
    }

    function save() {
        var data = form.getData(true);
        var carBrand = carBrandId.getText();
        var carSeries = carSeriesId.getText();
        var fyear = nui.get("fyear").value;
        var name = nui.get("name").value;
        data.fullName = carBrand +' '+carSeries+' '+fyear+'款 '+name;
        var turl = null;
        if(type == 1 || type == 3){
            turl = addUrl;
        }else if(type == 2){
            turl = updateUrl
        }
        nui.ajax({
            url:turl,
            type:'post',
            data:{
                data:data
            },
            success:function(res){
                if(res.errCode == 'S'){
                    showMsg('保存成功','S');
                }else{
                    showMsg('保存失败','E');
                }
                CloseWindow("ok");
            }
        })
        
    }

    function onDriveModeChanged(e) {
        if(e.value == "1558429420826"){
            nui.get('enduranceMileage').enable();
            nui.get('electricMotor').enable();
            nui.get('chargingTime').enable();
        }else{
            nui.get('enduranceMileage').disable();
            nui.get('electricMotor').disable();
            nui.get('chargingTime').disable();
            nui.get('enduranceMileage').setValue('');
            nui.get('electricMotor').setValue('');
            nui.get('chargingTime').setValue('');
        }

        
    }

    function onBrandChanged(e) {
        var id = carBrandId.getValue();
        var mUrl = null;
        
        if(id){
            mUrl = modelUrl + "?nodeId=" + id;
            carSeriesId.setUrl(mUrl);
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
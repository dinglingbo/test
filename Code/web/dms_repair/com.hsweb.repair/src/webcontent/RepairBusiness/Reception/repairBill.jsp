<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
<title>综合开单详情</title>
<script src="<%=webPath + repairDomain%>/repair/js/RepairBusiness/Reception/repairBill.js?v=1.0.0"></script>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
.title {
  width: 60px;
  text-align: right;
}

.form_label {
	width: 72px;
	text-align: right;
}

.required {
	color: red;
}

.rmenu {
    font-size: 14px;
    /* font-weight: bold; */
    text-align: left;
    margin: 0;
    padding-left: 25px;
    height: 18px;
    color: #fff;
    width: auto;
    margin-left: 20px;
    margin-top: 20px;
    background-size: 50%;
}

.mini-tools .mini-tools-collapse {
    float: left;
}

.mini-panel .mini-tools {
    position: absolute;
    top: 5px;
    left: 100px;
}

.btnType{
  font-family:Verdana;
  font-size: 14px;
  text-align: center;
  height: 40px;
  width: 80px;
  line-height:40px;
}

.mini-grid-rows-view {
    height: auto;
}

</style>

</head>
<body>

<div class="nui-fit">
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;height:60px">
        <table class="table" id="table1" border="0" style="width:100%">
            <tr>
                <td>
                    <label style="font-family:Verdana;">工单号：</label>
                    <label id="" style="font-family:Verdana;font-size:15px;font-weight:bold;">综合开单详情</label>
                    <label style="font-family:Verdana;">车牌号：</label>
                    <label id="" style="font-family:Verdana;font-size:15px;font-weight:bold;">粤AXXXXX</label>
                    <span class="separator"></span>
                    <label style="font-family:Verdana;">进厂日期：</label>
                    <label id="" style="font-family:Verdana;">2018-06-22</label>
                    <label style="font-family:Verdana;">交车日期：</label>
                    <label id="" style="font-family:Verdana;">2018-06-23</label>
                </td>
                <td rowspan="2" style="text-align:left;">
                    <a class="nui-button btnType" iconCls="" plain="false" onclick="add()" id="addBtn"><span class="btnType">次卡</span></a>
                    <a class="nui-button btnType" iconCls="" plain="false" onclick="add()" id="addBtn"><span class="btnType">充值</span></a>
                </td>
            </tr>
            <tr>
                <td>
                    <label style="font-family:Verdana;">客户名称：</label>
                    <label id="" style="font-family:Verdana;">配生</label>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;完工</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;结算</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="del()" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                    <a class="nui-menubutton" plain="true" menu="#popupMenuPrint" id="menuprint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>

                    <ul id="popupMenuPrint" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="onPrint(0)" id="type10"><span class="fa fa-print fa-lg"></span>&nbsp;打印订单</li>
                        <li iconCls="" onclick="onPrint(1)" id="type11"><span class="fa fa-print fa-lg"></span>&nbsp;打印进货单</li>
                    </ul>
                </td>
            </tr>
        </table>

    </div>

    <div class="" style="width:100%; height:auto;" >
      <%@include file="/repair/RepairBusiness/Reception/repairCarInfo.jsp" %>
    </div>
    <div class="" style="width:100%;height:auto;" >
      <%@include file="/repair/RepairBusiness/Reception/repairPackage.jsp" %>
      <%@include file="/repair/RepairBusiness/Reception/repairItem.jsp" %>
      <%@include file="/repair/RepairBusiness/Reception/repairPart.jsp" %>
    </div>



</div>



</body>
</html>
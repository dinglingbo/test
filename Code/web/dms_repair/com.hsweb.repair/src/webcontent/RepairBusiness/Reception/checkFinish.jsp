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
<title>完工</title>
<script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/checkFinish.js?v=1.1.1"></script>
<style type="text/css">

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

</style>

</head>
<body style="height:100%;width:100%">

<div class="nui-fit">
   <div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;text-align:center;">
    <div style="padding: 0px;" borderStyle="border:0;">
        <table width="100%">
            <tr>
                <td  >
                    <a class="nui-button"  onclick="finish()" id = "readyPay" plain="true"><span class="fa fa-check fa-lg" ></span>&nbsp;完工</a>
                    <!-- <a class="nui-button"  onclick="noPayOk()" id = "noPayOk" >保存</a>  -->
                    <a class="nui-button"  onclick="onCancel()" id = "payOk" plain="true"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a> 
                </td>
                <td align="left"><span id="checkDescribe" style="color:red;"></span></td>
            </tr>
        </table>
	</div>
  </div>
  <div>
    <div id="itemGrid"
        dataField="data"
        class="nui-datagrid"
        style="width: 50%; height: 230px;float:left"
        showPager="false"
        allowSortColumn="true">
        <div property="columns">
            <div headerAlign="center" type="indexcolumn" width="20">序号</div>
            <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="60">项目名称</div>
            <div field="workers" headerAlign="center" allowSort="true" visible="true" width="60" datatype="int" align="center">施工员</div>
            <div field="status" headerAlign="center" allowSort="true" visible="true" width="40" datatype="int" align="center">是否完工</div>
            <!-- <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">是否合格</div>
            <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">备注</div> -->
        </div>
    </div>
    <div id="partGrid"
        dataField="data"
        class="nui-datagrid"
        style="width: 50%; height: 230px;"
        showPager="false"
        allowSortColumn="true">
        <div property="columns">
            <div headerAlign="center" type="indexcolumn" width="15">序号</div>
            <div field="partName" headerAlign="center" allowSort="true" visible="true" width="60">配件名称</div>
            <div field="qty" headerAlign="center" allowSort="true" visible="true" width="15" datatype="float" align="center">数量</div>
            <div field="pickQty" headerAlign="center" allowSort="true" visible="true" width="20" datatype="float" align="center">已出库</div>
            <div field="notPickQty" headerAlign="center" allowSort="true" visible="true" width="20" datatype="float" align="center">未出库</div>
        </div>
    </div>
  </div> 
    <div class="nui-fit">
     <div class="form" id="basicInfoForm" >
        <input name="id" class="nui-hidden"/>
        <table class="nui-form-table" style="width:100%;height: 100%">
            <tr>
                <td  style="text-align:left">
                    <label >出车报告：</label>
                 <a class="nui-button"  onclick="SelectReport()" id = "SelectReport" plain="true"><span class="fa fa-check fa-lg"></span>&nbsp;选择出车报告</a>
                    <div class="nui-checkbox" id="completionWeChat" name="completionWeChat" ></div>微信通知客户
                </td>
            </tr>
            <tr>
                <td>
                    <textarea class="nui-textarea" name="content" style="width: 100%;height: 100%"></textarea>
                </td>
            </tr>
        </table>
     </div>
  </div>
   
</div>
</body>
</html>
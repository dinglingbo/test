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
<script src="<%=webPath + repairDomain%>/repair/js/RepairBusiness/Reception/repairBill.js?v=1.1.2"></script>
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
  width: 80px;
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

/*.mini-tools .mini-tools-collapse {
    float: left;
}*/

/*.mini-panel .mini-tools {
    position: absolute;
    top: 5px;
    left: 100px;
}*/

.btnType{
  font-family:Verdana;
  font-size: 14px;
  text-align: center;
  height: 40px;
  width: 120px;
  line-height:40px;
}

.mini-grid-rows-view {
    height: auto;
}

/*#wechatTag{
    color:#62b900;
}*/

 
html body .searchbox .mini-buttonedit-close
{
    background:url(common/nui/themes/icons/search.gif) no-repeat 50% 50%;
}
html body .searchbox .mini-buttonedit-close:before
{
    content:"";
} 
html body .searchbox .mini-buttonedit-icon
{
    background:url(common/nui/themes/icons/add.gif) no-repeat 50% 50%;
}
html body .searchbox .mini-buttonedit-icon:before
{
    content:"";
}

</style>

</head>
<body>

<div class="nui-fit">
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;height:60px">
            <table class="table" id="table1" border="0" style="width:100%">
                <tr>
                    <td>
                        <label style="font-family:Verdana;">工单号:</label>
                        <label id="servieIdEl" style="font-family:Verdana;font-size:15px;font-weight:bold;">综合开单详情</label>
                        <label style="font-family:Verdana;">车牌号:</label>
                        <label id="carNoEl" style="font-family:Verdana;font-size:15px;font-weight:bold;">粤AXXXXX</label>
                        <span class="separator"></span>
                        <span id="wechatTag" class="fa fa-wechat fa-lg"></span>&nbsp;
                        <label style="font-family:Verdana;">客户名称:</label>
                        <label id="guestNameEl" style="font-family:Verdana;font-weight:bold;">秦生</label>&nbsp;
                        <label style="font-family:Verdana;">联系方式:</label>
                        <label id="guestTelEl" style="font-family:Verdana;font-weight:bold;">1371032XXXX</label>
                        <label id="cardPackageEl" style="font-family:Verdana;color:blue;">次卡套餐(7)</label>
                        <label id="clubCardEl" style="font-family:Verdana;color:blue;">会员卡(2)</label>
                        <label id="creditEl" style="font-family:Verdana;color:blue;">挂账:265</label>
                    </td>
                    <td rowspan="2" style="text-align:left;">
                        <a class="nui-button btnType" iconCls="" plain="false" onclick="addcardTime()" id="addBtn"><span class="btnType"><span class="fa fa-gift fa-lg"></span>&nbsp;次卡套餐</span></a>
                        <a class="nui-button btnType" iconCls="" plain="false" onclick="addcard()" id="addBtn"><span class="btnType"><span class="fa fa-dollar fa-lg"></span>&nbsp;充值办卡</span></a>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left;">
                        <span id="carHealthEl" class="" style="font-family:Verdana;color:white;background:#62b900;padding:0px 8px;border-radius:90px;">车况:100</span>
                        <a class="nui-button" iconCls="" plain="false" onclick="" id="addBtn">查看详情</a>
                        <span class="separator"></span>
                        <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;完工</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="addBtn"><span class="fa fa-dollar fa-lg"></span>&nbsp;结算</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="del()" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                        <span class="separator"></span>

                        <a class="nui-menubutton" plain="true" menu="#popupMenuPrint" id="menuprint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>

                        <ul id="popupMenuPrint" class="nui-menu" style="display:none;">
                            <li iconCls="" onclick="onPrint(0)" id="type10">打印维修委托单</li>
                            <li iconCls="" onclick="onPrint(1)" id="type11">打印派工单</li>
                            <li iconCls="" onclick="onPrint(1)" id="type11">打印结算单</li>
                            <li iconCls="" onclick="onPrint(1)" id="type11">打印领料单</li>
                        </ul>


                        <a class="nui-menubutton" plain="true" menu="#popupMenuQT" id="menuQT"><span class="fa fa-print fa-lg"></span>&nbsp;其他</a>

                        <ul id="popupMenuQT" class="nui-menu" style="display:none;">
                            <li iconCls="" onclick="onPrint(0)" id="type10">储值卡销售</li>
                            <li iconCls="" onclick="onPrint(1)" id="type11">储值卡充值</li>
                            <li iconCls="" onclick="onPrint(1)" id="type11">车牌替换/修改</li>
                            <li iconCls="" onclick="onPrint(1)" id="type11">等级转介绍客户</li>
                        </ul>
                        <input name="receTypeId"
                                 id="receTypeId"
                                 class="nui-combobox"
                                 textField="name"
                                 visible="false"
                                 valueField="customid"/>
                    </td>
                </tr>
            </table>

        </div>

        <div class="" style="width:100%; height:100px" >
          <%@include file="/repair/RepairBusiness/Reception/repairCarInfo.jsp" %>
        </div>

        <div style="width:100%;height:5px;"></div>
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="nui-button" iconCls="" plain="true" onclick="entry()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;产品录入</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-id-card-o fa-lg"></span>&nbsp;会员卡</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-history fa-lg"></span>&nbsp;维修历史</a>
                    </td>
                </tr>
            </table>
        </div>


    <div class="nui-fit">
        <div class="" style="width:100%;height:auto;" >
          <div style="width:100%;height:5px;"></div>
          <%@include file="/repair/RepairBusiness/Reception/repairPackage.jsp" %>
          <div style="width:100%;height:5px;"></div>
          <%@include file="/repair/RepairBusiness/Reception/repairItem.jsp" %>
          <div style="width:100%;height:5px;"></div>
          <%@include file="/repair/RepairBusiness/Reception/repairPart.jsp" %>
        </div>

        <div id="bottomPanel" class="nui-panel" title="其他" iconCls="" style="width:100%;height:100px;" 
            showToolbar="false" showCollapseButton="true" showFooter="false" allowResize="false" collapseOnTitleClick="true"
        >
           <div id="billForm" class="form">
                  <table style="width: 100%;">
                      <tr>
                          <td class="title">
                              <label>套餐金额：</label>
                          </td>
                          <td >
                              <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                          </td>
                          <td class="title">
                              <label>套餐优惠：</label>
                          </td>
                          <td >
                              <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                          </td><td class="title">
                              <label>工时金额：</label>
                          </td>
                          <td >
                              <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                          </td>
                          <td class="title">
                              <label>工时优惠：</label>
                          </td>
                          <td >
                              <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                          </td>
                          <td class="title">
                              <label>零件金额：</label>
                          </td>
                          <td >
                              <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                          </td>
                          <td class="title">
                              <label>零件优惠：</label>
                          </td>
                          <td >
                              <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                          </td>
                      </tr>
                      <tr>
                          <td class="title">
                              <label>应收总计：</label>
                          </td>
                          <td >
                              <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                          </td>
                          <td class="title">
                              <label>未收总计：</label>
                          </td>
                          <td >
                              <input class="nui-textbox" enabled="false" width="100%" id="remark" name="remark"/>
                          </td>
                      </tr>
                  </table>
              </div>


        </div>
    </div>
</div>
  <script type="text/javascript">
      nui.parse();
      var grid_rpsPackageGrid = nui.get("rpsPackageGrid");
     
      grid_rpsPackageGrid.on("cellclick",function(e){
        var record = e.record;
        var column = e.column;
        if(column.field == "itemName"){
          try{
            nui.open({
              url : "repair/RepairBusiness/Reception/repairBillItemAdd.jsp",
              title : "添加工时",
              width : "600px",
              height : "400px",
              onload : function() {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setInitData();
              },
              ondestroy : function(action) {
              }
            });
          }finally{}
        }

      });  
      
 
      
    </script>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-26 15:41:25
  - Description:
-->

    <head>
        <title>选择库存车</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <%@include file="/common/commonRepair.jsp"%>
            <script src="<%=request.getContextPath()%>/sales/sales/js/selectCar.js?v=1.0.6"></script>
    </head>

    <body>
        <div class="nui-toolbar" style="padding:2px;height:35px;position: relative;">
            <a class="nui-button" iconCls="" plain="true" onclick="selectCar()" id="selectBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选车</a>
            <a class="nui-button" iconCls="" plain="true" onclick="close()" id="closeBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
        </div>
        <input id="frameColorId" name="frameColorId" style="width: 100%" class="nui-combobox" textField="name" valueField="customid" visible="false">
        <input id="interialColorId" name="interialColorId" style="width: 100%" class="nui-combobox" textField="name" valueField="customid" visible="false">
        <div id="grid" class="nui-datagrid" style="width:100%;height:100%;" showPager="true" dataField="cssCheckEnter" sortMode="client" url="" totalField="page.count" pageSize="10000" sizeList="[1000,5000,10000]" selectOnLoad="true" allowCellWrap=true showSummaryRow="true">
            <div property="columns">
                <div type="checkcolumn" width="40">选择</div>
                <div field="carModelName" name="carModelName" width="220" headerAlign="center" header="车型名称"></div>
                <div field="guestFullName" name="guestFullName" width="220" headerAlign="center" header="供应商"></div>
                <div field="enterDate" allowSort="true" width="130" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                <div field="frameColorId" allowSort="true" name="frameColorId" width="90" headerAlign="center" header="车身颜色"></div>
                <div allowSort="true" field="interialColorId" name="interialColorId" width="90" headerAlign="center" header="内饰颜色"></div>
                <div allowSort="true" field="unitPrice" name="unitPrice" width="90" headerAlign="center" header="进价"></div>
                <div allowSort="true" field="receiveCost" name="receiveCost" width="90" headerAlign="center" header="运费"></div>
                <div field="carFrameNo" allowSort="true" width="120" headerAlign="center" header="车架号（VIN）"></div>
                <div field="engineNo" allowSort="true" width="120" headerAlign="center" header="发动机号"></div>
                <div field="carLock" allowSort="true" width="60" headerAlign="center" header="是否锁库"></div>
                <div field="produceDate" allowSort="true" width="130" headerAlign="center" header="生产日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                <div field="remark" allowSort="true" width="220" headerAlign="center" header="车况备注"></div>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();
        </script>
    </body>

    </html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 14:49:39
  - Description:
-->

<head>
    <title>车型款式</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <script src="<%=webPath + contextPath%>/sales/base/js/sCarModelType.js?v=1.1.3"></script>
    <style>
        html,
        body {
            margin: 0px;
            padding: 0px;
            border: 0px;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        .mini-panel-border{
            border-radius: 0px;
        }
    </style>
</head>

<body>
    <input id="level" name="level"  class="nui-combobox" visible="false" dataField="data" valueField="customid" textField="name"/>
    <input id="countryType" name="countryType"  class="nui-combobox" visible="false" dataField="data" valueField="customid" textField="name"/>
    <input id="carSeriesId" name="carSeriesId"  class="nui-combobox" visible="false" dataField="data" valueField="customid" textField="name"/>
    <input id="carStructureType" name="carStructureType"  class="nui-combobox" visible="false" dataField="data" valueField="customid" textField="name"/>
    <input id="outputVolume" name="outputVolume"  class="nui-combobox" visible="false" dataField="data" valueField="customid" textField="name"/>
    <input id="seatQty" name="seatQty"  class="nui-combobox" visible="false" dataField="data" valueField="customid" textField="name"/>
             <input id="inletType" name="inletType"  class="nui-combobox" visible="false" dataField="data" valueField="customid" textField="name"/>
    <input id="powerType" name="powerType"  class="nui-combobox" visible="false" dataField="data" valueField="customid" textField="name"/>
    <input id="driveMode" name="driveMode"  class="nui-combobox" visible="false" dataField="data" valueField="customid" textField="name"/>
    <input id="gearBox" name="gearBox"  class="nui-combobox" visible="false" dataField="data" valueField="customid" textField="name"/>
    <input id="productionMode" name="productionMode"  class="nui-combobox" visible="false" dataField="data" valueField="customid" textField="name"/>
    <div class="nui-fit">
        <div class="nui-splitter" style="width:100%;height:100%;">
            <div  style="border:0;" size="15%" showCollapseButton="true">
                <div class="nui-fit">
                    <div class="mini-panel" title="品牌-车系" style="width:100%;height:100%;" bodyStyle="padding:0;">
                        <ul id="tree1" class="nui-tree"
                            style="width:100%;height:100%;"
                            dataField="list"
                            showTreeIcon="true" textField="nodeName" idField="nodeId" >
                        </ul>
                    </div>
                </div>
            </div>
            <div style="border:0;" showCollapseButton="true">
                <div class="nui-toolbar" style="border-bottom:0px;">
                    品牌：<input name="carBrandId" id="carBrandId" class="nui-combobox width2" textField="nodeName"
                    valueField="nodeId" dataField="list"  emptyText="请选择..." url=""  onValuechanged="onBrandChanged"
                    showNullItem="false" nullItemText="请选择..." allowInput="true" valueFromSelect="true"
                    style="width: 150px" />
                    车系：<input id="carSeriesId" name="carSeriesId"class="nui-combobox" dataField="list" allowUnselec="true"
                    textField="nodeName" valueField="nodeId"  allowInput="false"  
                     style="width:150px"/>
                    车型名称：<input id="fullName" name="fullName" class="nui-textbox" type="text" style="width: 110px" />
                    <input id="code" name="code" class="nui-textbox" visible="false" />
                    状态：<input id="isDisabled" name="isDisabled" class="nui-combobox" data="isDisArr" 
                    textField="text" valueField="id"  allowInput="false" style="width:90px"/>
                    <a class="nui-button" plain="true" onclick="search()" id="" enabled="true"><span
                            class="fa fa-search fa-lg"></span>&nbsp;查找</a>
                    <span class="separator"></span>
                    <a class="nui-button" plain="true" onclick="edit(1)" id="" plain="false"><span
                            class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" plain="true" onclick="edit(2)" id="" enabled="true"><span
                            class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                    <a class="nui-button" plain="true" onclick="isEnabled()" id="" enabled="true"><span
                            class="fa fa-refresh fa-lg"></span>&nbsp;启用/禁用</a>
                    <a class="nui-button" plain="true" onclick="edit(3)" id="" enabled="true"><span
                            class="fa fa-copy fa-lg"></span>&nbsp;复制</a>

                </div>
                <div class="nui-fit">
                    <div id="grid1" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                        multiSelect="false" pageSize="20" pageList='[10,20,50,100]' showPageInfo="true"
                        selectOnLoad="true" onDrawCell="" onselectionchanged="" allowSortColumn="false"
                        totalField="page.count">
                        <div property="columns">
                            <div type="indexcolumn" headerAlign="center" width="60px">序号</div>
                            <!-- <div type="checkcolumn" class="mini-radiobutton" width="60px">选择</div> -->
                            <div field="code" headerAlign="center" allowSort="true" width="100px">车型编号</div>
                            <div field="carBrandId" headerAlign="center" allowSort="true" width="100px">汽车品牌</div>
                            <div field="fullName" headerAlign="center" allowSort="true" width="400px">车型全称</div>
                            <div field="pyCode" headerAlign="center" allowSort="true" width="100px">拼音码</div>
                            <!-- <div field="" headerAlign="center" allowSort="true" width="100px">车辆类型</div> -->
                            <div field="fyear" headerAlign="center" allowSort="true" width="100px">年款</div>
                            <div field="launchDate" headerAlign="center" allowSort="true" width="100px">上市日期</div>
                            <div field="carStructureType" headerAlign="center" allowSort="true" width="100px">车体结构</div>
                            <div field="level" headerAlign="center" allowSort="true" width="100px">车辆级别</div>
                            <div field="gearBox" headerAlign="center" allowSort="true" width="100px">变速箱</div>
                            <div field="outputVolume" headerAlign="center" allowSort="true" width="100px">排量</div>
                            <div field="driveMode" headerAlign="center" allowSort="true" width="100px">驱动方式</div>
                            <div field="isImported" headerAlign="center" allowSort="true" width="100px">是否进口</div>
                            <div field="seatQty" headerAlign="center" allowSort="true" width="100px">座位数</div>
                            <div field="guidingPrice" headerAlign="center" allowSort="true" width="100px">指导进货价</div>
                            <div field="sellPrice" headerAlign="center" allowSort="true" width="100px">指导销售价</div>
                            <div field="sellPriceMin" headerAlign="center" allowSort="true" width="100px">公司限价</div>
                            <div field="sellOrderPrice" headerAlign="center" allowSort="true" width="100px">购车订金</div>
                            <div field="configure" headerAlign="center" allowSort="true" width="100px">备注说明</div>
                            <div field="isDisabled" headerAlign="center" allowSort="true" width="100px">启用/禁用</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>

    <script type="text/javascript">
        nui.parse();
    </script>
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-02-18 23:25:58
  - Description:
-->
<head>
<title>车架号查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    
    <script src="<%=sysDomain%>/llq/common/llqCommon.js?v=1.1" type="text/javascript"></script>
    <script src="<%=sysDomain%>/llq/vin/js/vinQuery.js?v=1s" type="text/javascript"></script>    
</head>
<body>
    <div class="nui-splitter" style="width:100%;height:60px;" style="border:0;" handlerSize=0>
        <div size="40%" showCollapseButton="false" style="border:0;">
            <br/>
            <center id="groupButton">
                <a class="nui-button groupButton" onclick="setBgColor(this);showRightGrid(gridCfg)">主&nbsp;&nbsp;组</a>
                <a class="nui-button groupButton" onclick="setBgColor(this);showRightGrid(gridSubGroup)" onclick="">分&nbsp;&nbsp;组</a>
                <a class="nui-button groupButton" onclick="setBgColor(this);showRightGrid(gridParts)">零&nbsp;&nbsp;件</a>
            </center>
        </div>
        <div showCollapseButton="false" style="border:0;">
            <br/>
            全部品牌 >
            <div id="vin" 
                class="nui-autocomplete" 
                style="width:350px;"
                popupWidth="400" 
                textField="vin" 
                valueField="vin" 
                url="<%=sysDomain%>/com.hsweb.system.llq.vin.vin.searchHistory.biz.ext" 
                onvaluechanged="" 
                dataField="data"
                searchField="vin"
                enterQuery="true">     
                <div property="columns">
                    <div header="vin" field="vin" width="50"></div>
                    <div header="品牌" field="brandname"></div>
                </div>
            </div>
            <a class="nui-button" onclick="queryVin();">查&nbsp;&nbsp;询</a>
            <br/><br/>
        </div>
    </div> 
    
    <div class="nui-fit">
        <div class="nui-splitter" style="width:100%; height:100%;" id="panel">
            <div size="40%" showCollapseButton="false">
                <div class="nui-fit">
                    <!--主组-->
                    <div id="gridMainGroup" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;"
                        showColumns="true"
                        showPager="false"
                        allowcellwrap="true"
                        showSummaryRow="true">
                        <div property="columns">                                           
                        </div>
                    </div>
                </div>
            </div>
            <div size="60%" showCollapseButton="false">
                <div class="nui-fit">            
                    <!--车辆配置-->
                    <div id="gridCfg" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;"
                        showColumns="true"
                        showPager="false"
                        allowcellwrap="true"
                        showSummaryRow="true">
                        <div property="columns">  
                            <div type="indexcolumn" width="20">序号</div>
                            <div field="field1" width="80" headerAlign="center" allowSort=false>分类</div>
                            <div field="field2" width="150" headerAlign="center" allowSort=false>详情</div>
                        </div>
                    </div>
                    <!--分组-->
                    <div id="gridSubGroup" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;display:none;"
                        showColumns="true"
                        showPager="false"
                        allowcellwrap="true"
                        showSummaryRow="true">
                        <div property="columns"> 
                            <div field="auth" width="80" visible="false" allowSort="false"></div>
                            <div type="indexcolumn" width="20">序号</div>
                            <div field="num" width="30" headerAlign="center" allowSort=false>主组</div>
                            <div field="subgroup" width="30" headerAlign="center" allowSort=false>分组</div>
                            <div field="mid" width="60" headerAlign="center" allowSort=false>图号</div>
                            <div field="subgroupname" width="150" headerAlign="center" allowSort=false>名称</div>
                            <div field="description" width="150" headerAlign="center" allowSort=false>备注</div>
                            <div field="model" width="100" headerAlign="center" allowSort=false>型号</div>                      
                        </div>
                    </div>
                    <!--零件-->
                    <div id="gridParts" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;display:none;"
                        showColumns="true"
                        showPager="false"
                        allowcellwrap="true"
                        showSummaryRow="true">
                        <div property="columns"> 
                            <div type="indexcolumn" width="20">序号</div>
                            <div field="num" width="30" headerAlign="center" allowSort=false>位置</div>
                            <div field="subgroup" width="30" headerAlign="center" allowSort=false>零件OE号</div>
                            <div field="mid" width="60" headerAlign="center" allowSort=false>名称</div>
                            <div field="subgroupname" width="150" headerAlign="center" allowSort=false>件数</div>
                            <div field="description" width="150" headerAlign="center" allowSort=false>型号</div>
                            <div field="model" width="100" headerAlign="center" allowSort=false>备注</div>
                            <div field="description" width="150" headerAlign="center" allowSort=false>参考价格</div>
                            <div field="model" width="100" headerAlign="center" allowSort=false>说明</div>                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
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
    <%@include file="/common/sysCommon2.jsp" %>
    <link href="<%=sysDomain%>/llq/brand/css/cloud.css?v=1.3" rel="stylesheet" type="text/css" />
    
    <script src="<%=sysDomain%>/llq/common/llqCommon.js?v=1.2" type="text/javascript"></script>
    <script src="<%=sysDomain%>/llq/vin/js/vinQuery.js?v=1.3" type="text/javascript"></script>    
</head>
<body>
    <div class="nui-splitter" style="width:100%;height:60px;" style="border:0;" handlerSize=0>
        <div size="40%" showCollapseButton="false" style="border:0;">
            <br/>
            <center id="groupButton">
                <a class="nui-button groupButton" style="display:none;" onclick="showRightGrid(gridCfg)">主&nbsp;&nbsp;组</a>
                <a class="nui-button groupButton" style="display:none;" onclick="showRightGrid(subGroups)" onclick="">分&nbsp;&nbsp;组</a>
                <a class="nui-button groupButton" style="display:none;" onclick="showRightGrid(gridParts)">零&nbsp;&nbsp;件</a>
            </center>
        </div>
        <div showCollapseButton="false" style="border:0;">
            <br/>
            <div class="" id="partForm" style="width:100%;height:40px;">
                  <table class="" >
                      <tr class="">
                            <td >
                                输入VIN(全部品牌)<input class="nui-textbox" width="350px" id="vin" name="vin" enabled="true" emptyText="输入VIN"/>
                                <a class="nui-button" onclick="queryVin" style="width:100px">目录查询</a>
                            </td>
                      </tr>
                </table>    
            </div>
            <!-- <div id="vin" 
                class="nui-autocomplete" 
                style="width:350px;"
                popupWidth="400" 
                textField="vin" 
                valueField="vin" 
                url="<%=sysDomain%>/com.hsweb.system.llq.vin.vin.searchHistory.biz.ext" 
                onvaluechanged="" 
                emptyText="输入17位VIN车架号"
                placeholder="data"
                searchField="vin"
                enterQuery="true">     
                <div property="columns">
                    <div header="vin" field="vin" width="50"></div>
                    <div header="品牌" field="brandname"></div>
                </div>
            </div> -->
            <!-- <a class="nui-button" onclick="queryVin();">查&nbsp;&nbsp;询</a> -->
            <br/><br/>
        </div>
    </div> 
    
    <div class="nui-fit">
        <div class="nui-splitter" style="width:100%; height:100%;" id="panel">
            <div size="40%" showCollapseButton="false">
                <div class="nui-fit">
                    <!--主组-->
                    <%@include file="/llq/vin/vinQuery_MainGroup.jsp" %>                    
                </div>
            </div>
            <div size="60%" showCollapseButton="false">
                <div class="nui-fit">            
                    <!--车辆配置-->
                    <%@include file="/llq/vin/vinQuery_Cfg.jsp" %>
                    <!--分组-->
                    <%@include file="/llq/vin/vinQuery_SubGroup.jsp" %>
                    <!--零件-->
                    <%@include file="/llq/vin/vinQuery_Parts.jsp" %>
                </div>
            </div>
        </div>
    </div>
    
    
	<div id="brandWin" class="nui-window"
	     title="品牌查询" style="width:416px;"
	     showModal="true"
	     allowResize="false"
	     allowDrag="false"><!--height:150px;-->
	    <div id="brandForm" class="form">
	        <div class="brandsContainer">
                <!--
                <div class="brandsItem">
                    <img src="https://cdns.007vin.com/img/greatwall.png">
                    <span>长城</span>
                </div>
                <div class="brandsItem">
                    <img src="https://cdns.007vin.com/img/wey.png">
                    <span>魏派</span>
                </div>
                -->
            </div>
            <!--
	        <div style="text-align:center;padding:10px;">
	            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
	            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
	        </div>
            -->
	    </div>
	</div>
</body>
</html>
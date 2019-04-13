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
    <%@include file="/common/commonCloudPart.jsp"%>
    <link href="<%=contextPath%>/epc/brand/css/cloud.css?v=1.0" rel="stylesheet" type="text/css" />
    
    <script src="<%=contextPath%>/epc/common/llqCommon.js?v=1.1" type="text/javascript"></script>
    <script src="<%=contextPath%>/epc/vin/js/vinQuery.js?v=1.66" type="text/javascript"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <style>
        .search-result-list-item-content-img{
            width: 180px;
            height: 108px;
            border: 1px solid #d8d8d8;
            margin-right: 10px;
        }
        .search-result-list-item-title-color{
            color: #f35a12;
        }

        body .mini-grid-row-selected{
            background:#89c3d6 !important; 
        }
        .part-span{
		   font-size:13px;
		   color:#2779aa;
		}
        #vin{
        	border-color :#aed0ea;
        	background-color : #f2f5f7;
        	color : #362b36;
        	border-radius :4px;
        	border: 1px solid #aed0ea
        }
    </style>
</head>
<body>
    <div class="nui-splitter" style="width:100%;height:60px;" style="border:0;" handlerSize="0">
        <div size="40%" showCollapseButton="false" style="border:0;">
            <br/>
            <center id="groupButton">
                <a class="nui-button groupButton" style="display:none;" onclick="showRightGrid(gridCfg)">主&nbsp;&nbsp;组</a>
                <a class="nui-button groupButton" style="display:none;" onclick="showRightGrid(subGroups)" onclick="">分&nbsp;&nbsp;组</a>
                <a class="nui-button groupButton" style="display:none;" onclick="showRightGrid(gridParts)">零&nbsp;&nbsp;件</a>
                <a class="nui-button groupButton" style="display:none;" onclick="showRightGrid(gridCfgT)">配&nbsp;&nbsp;置</a>
            </center>
        </div>
        <div showCollapseButton="false" style="border:0;">
            <div class="" id="partForm" style="width:100%;height:40px;">
                  <br/>
                  <table class="" >
                      <!-- 目前不支持短vin查询  20180724修改为可按品牌查询
                      <tr class="">
                            <td >
                                <div id="rbl_brand" class="nui-radiobuttonlist"  repeatLayout="table" 
                                    repeatDirection="vertical" onValuechanged="setVinLenght(e.value)"
                                    textField="text" valueField="text" value="全部品牌" data="final_data_brand">
                                </div>
                            </td>
                      </tr>
                      -->
                      <tr class="">
                            <td >
                                输入VIN(全部品牌)<input class="" width="350px"  id="vin" name="vin"  list="vin" enabled="true" emptyText="请输入17VIN"/>
                                <a class="nui-button" onclick="queryVin" style="width:100px" >目录查询</a>
                            </td>
                            <td width="460px" style="padding-left:15%">
     
	                            <a class="nui-button groupButton" style="display:none;" onclick="lastGroup">上一主组</a>
					            <a class="nui-button groupButton" style="display:none;" onclick="nextGroup">下一主组</a>
					            <a class="nui-button groupButton" style="display:none;" onclick="lastSubGroup">上一分组</a>
					            <a class="nui-button groupButton" style="display:none;" onclick="nextSubGroup">下一分组</a>
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
                url="<%=contextPath%>/com.hsweb.system.llq.vin.vin.searchHistory.biz.ext" 
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
        <div class="nui-splitter" style="width:100%; height:100%;" id="panel" allowResize="false">
            <div size="40%" showCollapseButton="false">
                <div class="nui-fit">
                    <!--主组-->
                    <%@include file="/epc/vin/vinQuery_MainGroup.jsp" %>                    
                </div>
            </div>
            <div size="60%" showCollapseButton="false">
                <div class="nui-fit">            
                    <!--车辆配置-->
                    <%@include file="/epc/vin/vinQuery_Cfg.jsp" %>
                    <!--分组-->
                    <%@include file="/epc/vin/vinQuery_SubGroup.jsp" %>
                    <!--零件-->
                    <%@include file="/epc/vin/vinQuery_Parts2.jsp" %>
     
                </div>
            </div>
        </div>
    </div>
    
    
	<div id="brandWin" class="nui-window"
	     title="选择品牌" style="width:416px;"
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
	    </div>
	</div>
    
    <div id="configWin" class="nui-window"
	     title="选择配置" style="width:416px;height:150px;"
	     showModal="true"
	     allowResize="false"
	     allowDrag="false"><!--height:150px;-->
	    <div id="configForm" class="form">
	        <div class="nui-fit">
            </div>
                <div id="gridConfig" 
                    class="nui-datagrid" 
                    style="width:100%;height:100%;"
                    showColumns="true"
                    showPager="false"
                    allowcellwrap="true"
                    allowHeaderWrap="true"
                    showSummaryRow="true">
                    <div property="columns">  
                        <!--
                        <div type="indexcolumn" width="20" summaryType="count">序号</div>
                        <div field="field1" width="80" headerAlign="center" allowSort=false>地区</div>
                        <div field="field1" width="80" headerAlign="center" allowSort=false>变速箱&nbsp;/&nbsp;等级</div>
                        <div field="field2" width="150" headerAlign="center" allowSort=false>设备</div>
                        -->
                    </div>
                </div>
	    </div>
	</div>
    
    <div id="vinWin" class="nui-window"
	     title="选择VIN" style="width:405px;height:300px;"
	     showModal="true"
	     allowResize="false"
	     allowDrag="false"><!--height:150px;-->
	    <div id="vinForm" class="form">
            <div class="brandsContainer2">
                <!--
                <div class="search-result-list-item">
                    <div class="search-result-list-item-title">
                        <span class="search-result-list-item-title-color">1A023575</span>
                    </div>
                    <div class="search-result-list-item-content">
                        <img class="search-result-list-item-content-img" src="">
                        <div class="search-result-list-item-content-detail">
                            <span></span>
                            <span></span>
                        </div>
                    </div>
                </div>
                -->
            </div>
	    </div>
	</div>

    <div id="winCarCfg" class="nui-window" title="车辆配置" style="width:500px;height:450px;" 
        showMaxButton="true" showCollapseButton="true" showShadow="true"
        showToolbar="true" showFooter="true" showModal="false" allowResize="true" allowDrag="true"
        >
        <div id="gridCfgT" 
            class="nui-datagrid" 
            style="width:100%;height:100%;"
            showColumns="true"
            showPager="false"
            allowcellwrap="true"
            showSummaryRow="true">
            <div property="columns">  
                <div field="field1" width="80" headerAlign="center" allowSort=false summaryType="count">分类</div>
                <div field="field2" width="150" headerAlign="center" allowSort=false>详情</div>
            </div>
        </div>
    </div>

</body>
</html>
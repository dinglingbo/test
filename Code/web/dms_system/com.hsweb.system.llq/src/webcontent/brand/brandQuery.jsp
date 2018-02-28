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
<title>车型查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    
    <script src="<%=sysDomain%>/llq/common/llqCommon.js?v=1.1" type="text/javascript"></script>
    <script src="<%=sysDomain%>/llq/brand/js/brandQuery.js?v=ss2" type="text/javascript"></script>    
</head>
<body>
    <div class="nui-splitter" style="width:100%;height:60px;" style="border:0;" handlerSize=0>
        <div size="15%" showCollapseButton="false" style="border:0;">
            <br/>
            <center id="groupButton">
                <a class="nui-button groupButton" onclick="showRightGrid(gridCfg)">上一步</a>
                <a class="nui-button groupButton" onclick="showRightGrid(gridParts)">下一步</a>
            </center>
        </div>
        <div showCollapseButton="false" style="border:0;">
            <br/>
            <!--<a class="nui-button" onclick="queryVin();"></a>-->
            <br/><br/>
        </div>
    </div> 
    <div class="nui-fit">
        <div class="nui-splitter" style="width:100%; height:100%;" id="panel">
            <div size="15%" showCollapseButton="false">
                <div class="nui-fit">
                    <!--导航-->
                    <div id="dgNavigation" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;"
                        showColumns="false"
                        showPager="false"
                        allowcellwrap="true"
                        showSummaryRow="true">
                        <div property="columns">
                            <div field="title" width="150" align="center" visible="true" allowSort=false></div>
                            <div field="index" headerAlign="center" visible="false" allowSort=false></div>
                        </div>
                    </div>
                </div>
            </div>
            <div size="60%" showCollapseButton="false">
                <div class="nui-fit">            
                    <!--层1-->
                    <div id="dg1" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;"
                        showColumns="true"
                        showPager="false"
                        allowcellwrap="true"
                        showSummaryRow="true">
                        <div property="columns">  
                            <div type="indexcolumn" width="20" headerAlign="center" summaryType="count">序号</div>
                            <div field="brand" width="80" headerAlign="center" allowSort=false>品牌代号</div>
                            <div field="brandEn" width="120" headerAlign="center" allowSort=false>品牌英文名</div>
                            <div field="brandCn" width="150" headerAlign="center" allowSort=false>品牌中文名</div>
                            <div field="brandImg" headerAlign="center" visible="false" allowSort=false>品牌log图片url</div>
                        </div>
                    </div>
                    <!--层2-->
                    <div id="dg2" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;display:none;"
                        showColumns="false"
                        showPager="false"
                        allowcellwrap="true"
                        showSummaryRow="true">
                        <div property="columns">  
                            <div type="indexcolumn" width="20" headerAlign="center" summaryType="count">序号</div>
                            <div field="has_next" width="80" visible="false" headerAlign="center" allowSort=false>是否拥有下一层条件</div>
                            <div field="last" width="150" visible="false" headerAlign="center" allowSort=false>是否是最后一层</div>
                            <div field="code" width="120" visible="false" headerAlign="center" allowSort=false>品牌代号</div>
                            <div field="auth" headerAlign="center" visible="false" allowSort=false>Auth串</div>
                            <div field="name" headerAlign="center" visible="true" allowSort=false>条件名称</div>
                        </div>
                    </div>
                    <!--层3-->
                    <div id="dg3" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;display:none;"
                        showColumns="false"
                        showPager="false"
                        allowcellwrap="true"
                        showSummaryRow="true">
                        <div property="columns">  
                            <div type="indexcolumn" width="20" headerAlign="center" summaryType="count">序号</div>
                            <div field="has_next" width="80" visible="false" headerAlign="center" allowSort=false>是否拥有下一层条件</div>
                            <div field="last" width="150" visible="false" headerAlign="center" allowSort=false>是否是最后一层</div>
                            <div field="code" width="120" visible="false" headerAlign="center" allowSort=false>品牌代号</div>
                            <div field="auth" headerAlign="center" visible="false" allowSort=false>Auth串</div>
                            <div field="name" headerAlign="center" visible="true" allowSort=false>条件名称</div>
                        </div>
                    </div>
                    <!--层4-->
                    <div id="dg4" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;display:none;"
                        showColumns="false"
                        showPager="false"
                        allowcellwrap="true"
                        showSummaryRow="true">
                        <div property="columns">  
                            <div type="indexcolumn" width="20" headerAlign="center" summaryType="count">序号</div>
                            <div field="has_next" width="80" visible="false" headerAlign="center" allowSort=false>是否拥有下一层条件</div>
                            <div field="last" width="150" visible="false" headerAlign="center" allowSort=false>是否是最后一层</div>
                            <div field="code" width="120" visible="false" headerAlign="center" allowSort=false>品牌代号</div>
                            <div field="auth" headerAlign="center" visible="false" allowSort=false>Auth串</div>
                            <div field="name" headerAlign="center" visible="true" allowSort=false>条件名称</div>
                        </div>
                    </div>
                    <!--层5-->
                    <div id="dg5" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;display:none;"
                        showColumns="false"
                        showPager="false"
                        allowcellwrap="true"
                        showSummaryRow="true">
                        <div property="columns">  
                            <div type="indexcolumn" width="20" headerAlign="center" summaryType="count">序号</div>
                            <div field="has_next" width="80" visible="false" headerAlign="center" allowSort=false>是否拥有下一层条件</div>
                            <div field="last" width="150" visible="false" headerAlign="center" allowSort=false>是否是最后一层</div>
                            <div field="code" width="120" visible="false" headerAlign="center" allowSort=false>品牌代号</div>
                            <div field="auth" headerAlign="center" visible="false" allowSort=false>Auth串</div>
                            <div field="name" headerAlign="center" visible="true" allowSort=false>条件名称</div>
                        </div>
                    </div>
                    <!--层6-->
                    <div id="dg6" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;display:none;"
                        showColumns="false"
                        showPager="false"
                        allowcellwrap="true"
                        showSummaryRow="true">
                        <div property="columns">  
                            <div type="indexcolumn" width="20" headerAlign="center" summaryType="count">序号</div>
                            <div field="has_next" width="80" visible="false" headerAlign="center" allowSort=false>是否拥有下一层条件</div>
                            <div field="last" width="150" visible="false" headerAlign="center" allowSort=false>是否是最后一层</div>
                            <div field="code" width="120" visible="false" headerAlign="center" allowSort=false>品牌代号</div>
                            <div field="auth" headerAlign="center" visible="false" allowSort=false>Auth串</div>
                            <div field="name" headerAlign="center" visible="true" allowSort=false>条件名称</div>
                        </div>
                    </div>
                    <!--层7-->
                    <div id="dg7" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;display:none;"
                        showColumns="false"
                        showPager="false"
                        allowcellwrap="true"
                        showSummaryRow="true">
                        <div property="columns">  
                            <div type="indexcolumn" width="20" headerAlign="center" summaryType="count">序号</div>
                            <div field="has_next" width="80" visible="false" headerAlign="center" allowSort=false>是否拥有下一层条件</div>
                            <div field="last" width="150" visible="false" headerAlign="center" allowSort=false>是否是最后一层</div>
                            <div field="code" width="120" visible="false" headerAlign="center" allowSort=false>品牌代号</div>
                            <div field="auth" headerAlign="center" visible="false" allowSort=false>Auth串</div>
                            <div field="name" headerAlign="center" visible="true" allowSort=false>条件名称</div>
                        </div>
                    </div>
                    <!--层8-->
                    <div id="dg8" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;display:none;"
                        showColumns="false"
                        showPager="false"
                        allowcellwrap="true"
                        showSummaryRow="true">
                        <div property="columns">  
                            <div type="indexcolumn" width="20" headerAlign="center" summaryType="count">序号</div>
                            <div field="has_next" width="80" visible="false" headerAlign="center" allowSort=false>是否拥有下一层条件</div>
                            <div field="last" width="150" visible="false" headerAlign="center" allowSort=false>是否是最后一层</div>
                            <div field="code" width="120" visible="false" headerAlign="center" allowSort=false>品牌代号</div>
                            <div field="auth" headerAlign="center" visible="false" allowSort=false>Auth串</div>
                            <div field="name" headerAlign="center" visible="true" allowSort=false>条件名称</div>
                        </div>
                    </div>
                    <!--层9-->
                    <div id="dg9" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;display:none;"
                        showColumns="false"
                        showPager="false"
                        allowcellwrap="true"
                        showSummaryRow="true">
                        <div property="columns">  
                            <div type="indexcolumn" width="20" headerAlign="center" summaryType="count">序号</div>
                            <div field="has_next" width="80" visible="false" headerAlign="center" allowSort=false>是否拥有下一层条件</div>
                            <div field="last" width="150" visible="false" headerAlign="center" allowSort=false>是否是最后一层</div>
                            <div field="code" width="120" visible="false" headerAlign="center" allowSort=false>品牌代号</div>
                            <div field="auth" headerAlign="center" visible="false" allowSort=false>Auth串</div>
                            <div field="name" headerAlign="center" visible="true" allowSort=false>条件名称</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
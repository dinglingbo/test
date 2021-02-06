<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<div class="nui-splitter" style="width:100%;height:60px;" style="border:0;" handlerSize=0>
    <div size="15%" showCollapseButton="false" style="border:0;">
        <br/>
        <center id="groupButton">
            <a class="nui-button groupButton" onclick="showUp()">上一步</a>&nbsp;
            <a class="nui-button groupButton" onclick="showDown()">下一步</a>
        </center>
    </div>
    <div showCollapseButton="false" style="border:0;">
        <br/>
        <div id="topNav">
            <a style="cursor:pointer" onclick="showRightGrid(eval('dg1'))"><B>选择品牌</B></a>
        </div>
        <br/><br/>
    </div>
</div> 
<div class="nui-fit">
    <div class="nui-splitter" style="width:100%; height:100%;display:;" id="panel1">
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
                        <div field="name" width="150" headerAlign="center" allowSort=false>品牌名称</div>
                        <div field="brandCode" width="80" headerAlign="center" allowSort=false>品牌代号</div>
                        <div field="img" headerAlign="center" visible="false" allowSort=false>品牌log图片url</div>
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
                <!--层10-->
                <div id="dg10" 
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
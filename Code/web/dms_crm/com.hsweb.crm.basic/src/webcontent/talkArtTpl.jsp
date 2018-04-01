<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-03-26 10:16:08
  - Description:
-->
<head>
<title>话术模板</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="<%=crmDomain%>/basic/js/talkArtTpl.js?v=1.1" type="text/javascript"></script> 
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                <label style="font-family:Verdana;">话术来源：</label>
                <input class="nui-textbox" name="source" id="source" enabled="true"/>
                <label style="font-family:Verdana;">主题：</label>
                <input class="nui-textbox" name="topic" id="topic" enabled="true"/>
                <label style="font-family:Verdana;">创建人：</label>
                <input class="nui-textbox" name="recorder" id="recorder" enabled="true"/>
                <a class="nui-button" iconCls="icon-find" plain="true" onclick="query()" id="query" enabled="true">查询</a>
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="add()" id="add" enabled="true">新增话术</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="edit()" id="edit" enabled="true">修改话术</a>
            </td>
        </tr>
    </table>
</div>

<div class="nui-fit">
    <!-- splitter 1 -->
    <div class="nui-splitter" vertical="false" style="width:100%;height:100%;" style="border:0;" handlerSize=0>
        <div size="20%" showCollapseButton="false" style="border:0;">
            <div class="nui-fit">
                <div title="话术类型" class="nui-panel"
                     showHeader="true"
                     showFooter="false"
                     style="width:100%;height:100%;border: 0;">
                    <ul id="tree1" class="nui-tree" 
                        url="<%=apiPath + sysApi%>/com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130725000001&page/length=200&token=<%=token%>" 
                        style="width:95%;height:95%;padding:5px;" 
                        showTreeIcon="true" 
                        dataField="data" 
                        textField="NAME" 
                        idField="CUSTOMID" 
                        resultAsTree="false" 
                        parentField="DICTID" 
                        showTreeLines="true" 
                        onNodedblclick="onNodeDbClick"
                        allowDrag="true">
                    </ul>
                </div>
            </div>
        </div>
        <div showCollapseButton="false" style="border:0;">
            <div class="nui-fit">
                <div title="" class="nui-panel"
                     showHeader="false"
                     showFooter="false"
                     style="width:100%;height:100%;border: 0;">
                    <div id="dgGrid" class="nui-datagrid" style="width:100%;height:100%;"
                         showPager="true"
                         totalField="page.count"
                         pageSize="50" sizeList=[20,50,100] 
                         selectOnLoad="true"
                         ondrawcell=""
                         onrowdblclick=""
                         dataField="rs"
                         sortMode="client"
                         allowcellwrap="true"
                         idField="id"
                         url="<%=apiPath + crmApi%>/com.hsapi.crm.basic.crmBasic.getTalkArtList.biz.ext"
                         showSummaryRow="true">
                        <div property="columns">
                            <div type="indexcolumn" width="20">序号</div>
                            <div headerAlign="center"><strong>基本信息</strong>
                                <div property="columns">
                                    <div field="id" visible=false>ID</div>
                                    <div field="topic" width="50" headerAlign="center" summaryType="count" allowSort=false>主题</div>
                                    <div field="content" width="80" headerAlign="center" summaryType="" allowSort=false>话术内容
                                        <input property="editor" class="nui-textarea" style="width: 100%;">
                                    </div>
                                </div>
                            </div>
                            <div headerAlign="center"><strong>其他信息</strong>
                                <div property="columns">
                                    <div field="source" width="30" headerAlign="center" summaryType="" allowSort=false>话术来源</div>
                                    <div field="recorder" width="30" headerAlign="center" summaryType="" allowSort=false>创建人</div>
                                    <div field="recordDate" width="30" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss" allowSort=false>创建日期</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--footer-->
                    <div property="footer">
                        <input class='nui-textbox' value='' id="leftGridCount" readonly="true" style='vertical-align:middle;'/>
                    </div>
                </div>
            </div>
        </div>
    </div><!--splitter-->
</div>
</body>
</html>
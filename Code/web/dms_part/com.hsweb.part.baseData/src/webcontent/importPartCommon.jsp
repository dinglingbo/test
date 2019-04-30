<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2017-08-23 18:21:14
  - Description:
-->
<head>
<title>配件资料导入</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=webPath + contextPath%>/common/nui/xlsx.core.min.js?v=2.0.0"></script>
<script src="<%=webPath + contextPath%>/baseDataPart/js/importJs/importPartCommon.js?v=1.0.2"></script>
<style type="text/css">
/*.a-upload {
    padding: 4px 10px;
    height: 20px;
    line-height: 20px;
    position: relative;
    cursor: pointer;
    color: #888;
    background: #fafafa;
    border: 1px solid #ddd;
    border-radius: 4px;
    overflow: hidden;
    display: inline-block;
    *display: inline;
    *zoom: 1
}

.a-upload  input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
    filter: alpha(opacity=0);
    cursor: pointer
}

.a-upload:hover {
    color: #444;
    background: #eee;
    border-color: #ccc;
    text-decoration: none
}*/


.file {
    position: relative;
    /*display: inline-block;*/
    background: #D0EEFF;
    border: 1px solid #99D3F5;
    border-radius: 4px;
    padding: 4px 12px;
    margin-bottom: 0px;
    text-align: center;
    overflow: hidden;
    color: #1E88C7;
    text-decoration: none;
    text-indent: 0;
    line-height: 30px;
}
.file input {
    position: absolute;
    font-size: 10px;
    right: 0;
    top: 0px;
    opacity: 0;
}
.file:hover {
    background: #AADFFD;
    border-color: #78C3F3;
    color: #004974;
    text-decoration: none;
}
</style>
</head>

<body>
	<!-- <a href="javascript:;" class="a-upload">
	    <input type="file" name="" id="" onchange="importf(this)">点击这里上传文件
	</a> -->
	<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
	    <table style="width:100%;">
	        <tr>
	            <td style="width:100%;">
	            	<input id="applyCarBrandId"
                           name="applyCarBrandId"
                           class="nui-combobox width1"
                           textField="nameCn"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           style="display:none"
                           allowInput="false"
                           showNullItem="true"
                           nullItemText="请选择..."/>
					<a href="javascript:;" class="file">点击这里选择文件
					    <input type="file" name="" id="" onchange="importf(this)">
					</a>
	                <a class="nui-button" iconCls="" plain="true" onclick="sure()" id="openBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a>
					<a style="text-decoration: none;color: #2779aa;" plain="true" href="<%=request.getContextPath() %>/repair/RepairBusiness/template/importPart.xlsx" download="配件导入模板"><span class="fa fa-arrow-down fa-lg"></span>下载模板</a>
				</td>
	        </tr>
	    </table>
	</div>
	<div class="nui-fit">
		<div id="mainGrid" class="nui-datagrid" dataField="data" url="" showPager="false"
			showSummaryRow="true" showModified="false" allowCellSelect="true" allowCellEdit="true"
			style="width:100%;height:100%;">
			<div property="columns">
				<div type="indexcolumn">序号</div>
				<div field="品牌" width="50px" summaryType="count" headerAlign="center" allowSort="true">
					*品牌<input property="editor" class="nui-textbox"/></div>
				<div field="编码" width="100px" summaryType="count" headerAlign="center" allowSort="true">
					*编码<input property="editor" class="nui-textbox"/></div>
				<div field="名称" width="100px" headerAlign="center" allowSort="true">
					*名称<input property="editor" class="nui-textbox"/></div>
				<div field="单位" width="50px" headerAlign="center" allowSort="true">
					*单位<input property="editor" class="nui-textbox"/></div>
				<div field="规格" width="80px" headerAlign="center" allowSort="true">
                    规格<input property="editor" class="nui-textbox"/></div>
                <div field="厂牌" width="80px" headerAlign="center" allowSort="true">
                    厂牌<input property="editor" class="nui-textbox"/></div>
				<div field="型号" width="80px" headerAlign="center" allowSort="true">
					型号<input property="editor" class="nui-textbox"/></div>
				<div field="实物码" width="100px" headerAlign="center" allowSort="true">
					实物码<input property="editor" class="nui-textbox"/></div>
				<div field="OEM码" width="100px" headerAlign="center" allowSort="true">
					OEM码<input property="editor" class="nui-textbox"/></div>
				<div field="适用车型" width="120px" headerAlign="center" allowSort="true">
					适用车型<input property="editor" class="nui-textbox"/></div>
                <div field="通用编码" width="120px" headerAlign="center" allowSort="true">
                    通用编码<input property="editor" class="nui-textbox"/></div>
                <div field="生产厂家" width="120px" headerAlign="center" allowSort="true">
                    生产厂家<input property="editor" class="nui-textbox"/></div>
                <div field="备注" width="120px" headerAlign="center" allowSort="true">
                    备注<input property="editor" class="nui-textbox"/></div>
			</div>
		</div>
	</div>

    <div id="advancedTipWin" class="nui-window"
        title="未成功导入配件" style="width:400px;height:200px;"
        showModal="true"
        allowResize="false"
        allowDrag="true">
        <div id="advancedTipForm" class="form">
            <table style="width:100%;height: 100%;">
            
                <tr>
                    <td colspan="3">
                        <textarea class="nui-textarea" emptyText="" width="100%" style="height: 100%;" id="fastCodeList" name="fastCodeList"></textarea>
                    </td>
                </tr>
                
            </table>
        </div>
    </div>

</body>
</html>
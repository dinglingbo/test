<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2017-08-23 18:21:14
  - Description:
-->
<head>
<title>价格导入</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=webPath + contextPath%>/common/nui/xlsx.core.min.js?v=2.0.0"></script>
<script src="<%=webPath + contextPath%>/basic/js/importPartCommon.js?v=1.0.5"></script>
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
					<a href="javascript:;" class="file">点击这里选择文件
					    <input type="file" name="" id="" onchange="importf(this)">
					</a>
	                <a class="nui-button" iconCls="" plain="true" onclick="sure()" id="openBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a>
	                <a class="nui-button" iconCls="" plain="true" onclick="clear()" id="saveBtn"><span class="fa fa-trash fa-lg"></span>&nbsp;清空</a>
	                <a class="nui-button" iconCls="" plain="true" onclick="close()" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
	                <a class="nui-button" plain="true" href="<%=request.getContextPath() %>/common/template/importPartCommon.xlsx"><span class="fa fa-arrow-down fa-lg"></span>下载模板</a>
					<label style="color:red">(注：通用标识列相同的表示相互通用，通用标识列可以为字母或是数字)</label>
				<input class="nui-combobox" visible="false" name="orgCarBrandId" id="orgCarBrandId"/>
				</td>
	        </tr>
	    </table>
	</div>
	<div class="nui-fit">
		<div id="mainGrid" class="nui-datagrid" dataField="data" url="" showPager="false"
			showSummaryRow="true" allowCellEdit="true" allowCellSelect="true"
			style="width:100%;height:100%;">
			<div property="columns">
				<div type="indexcolumn">序号</div>
				<div field="品质" width="50px" headerAlign="center" allowSort="true">
					品质</div>
				<div field="品牌" width="100px" headerAlign="center" allowSort="true">
					品牌</div>
				<div field="厂牌" width="50px" headerAlign="center" allowSort="true">
					厂牌</div>
				<div field="配件编码" width="150px" summaryType="count" headerAlign="center" allowSort="true">
					配件编码</div>
				<div field="通用标识" width="50px" headerAlign="center" allowSort="true">
					通用标识</div>
                </div>
			</div>
		</div>
	</div>


</body>
</html>
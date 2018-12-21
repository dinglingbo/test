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
<title>工单导入</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=webPath + contextPath%>/common/nui/xlsx.core.min.js?v=2.0.0"></script>
<script src="<%=webPath + contextPath%>/repair/RepairBusiness/Reception/js/importMaintain.js?v=1.0.5"></script>
<style type="text/css">



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
	                <a class="nui-button" iconCls="" plain="true" onclick="close()" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
				</td>
	        </tr>
	    </table>
	</div>
	<div class="nui-fit">
		<div id="mainGrid" class="nui-datagrid" dataField="data" url="" showPager="false"
			showSummaryRow="true" showModified="false" allowCellSelect="true" allowCellEdit="true" allowSortColumn="false"
			style="width:100%;height:100%;">
			<div property="columns">
				<div type="indexcolumn" width="40px" header="序号"></div>
									<div field="serviceCode" headerAlign="center" allowSort="true" width="180px">工单号</div>

									<div field="billTypeId" headerAlign="center" allowSort="true" width="60px">
										工单类型</div>
									<div field="guestName" headerAlign="center" allowSort="true" width="60px">
										客户姓名</div>
									<div field="mobile" headerAlign="center" allowSort="true" width="100px">
										客户电话</div>
									<div field="carNo" headerAlign="center" allowSort="true" width="80px">
										车牌号</div>
									<div field="carVin" headerAlign="center" allowSort="true" width="120px">
										车架号（VIN）</div>
									<div field="itemAmt" headerAlign="center" allowSort="true" width="60px">
										项目金额</div>
									<div field="partAmt" headerAlign="center" allowSort="true" width="60px">
										配件金额</div>
									<div field="packageAmt" headerAlign="center" allowSort="true" width="60px">
										套餐金额</div>
									<div field="planFinishDate" name="planFinishDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm">
										进店日期</div>
									<div field="outDate" name="planFinishDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm">
										结算日期</div>
									<div field="mtAdvisor" headerAlign="center" allowSort="true" width="60px">
										维修顾问</div>
									<div field="remark" renderer="onstatus" headerAlign="center" allowSort="true" width="120px">备注</div>

			</div>
		</div>
	</div>

    <div id="advancedTipWin" class="nui-window"
        title="未成功导入客户" style="width:400px;height:200px;"
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
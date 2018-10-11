<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>业绩审核</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="manage/js/investAudit.js" type="text/javascript"></script>
</head>
<body>
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table class="table">
            <tr>
                <td>
                	<span>年份:</span>
                    <input class="nui-spinner"/>
                    <span>月份:</span>
                    <input class="nui-spinner" minValue="1" maxValue="12"/>
                    <span>车牌号:</span>
                    <input class="nui-textbox" emptyText="输入查询条件" width="120"/>
                    <span>状态:</span>
                    <input class="nui-combobox"  width="80" allowInput="false"/>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="">查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="">审核通过</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="">审核退回</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="">导出</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
          <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="true"
               showPager="true"
               pageSize="50"
               totalField="page.count"
               sizeList=[20,50,100,200]
               dataField="list"
               onrowdblclick=""
               allowCellSelect="true"
               url="">
              <div property="columns">
              	  <div type="indexcolumn">序号</div> 
              	  <div type="checkcolumn"></div>
                  <div header="业务信息" headerAlign="center">
                  	<div property="columns">
                  		<div field="" name="" width="80" headerAlign="center" header="是否大客户"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="业务单号"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="分店"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="维修顾问"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="进厂日期"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="销售员"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="销售员备注"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="来厂类型"></div>
                  	</div>
                  </div>
                  <div header="客户信息" headerAlign="center">
                  	<div property="columns">
                  		<div field="" name="" width="80" headerAlign="center" header="车牌号"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="厂牌"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="车型"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="客户名称"></div>
                  	</div>
                  </div>
                  <div header="工时配件" headerAlign="center">
                  	<div property="columns">
                  		<div field="" name="" width="80" headerAlign="center" header="工时"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="配件"></div>
                  	</div>
                  </div>
                  <div header="审核信息" headerAlign="center">
                  	<div property="columns">
                  		<div field="" name="" width="80" headerAlign="center" header="审核人"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="审核标志"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="审核日期"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="审核意见"></div>
                  	</div>
                  </div>
                  <div header="其他信息" headerAlign="center">
                  	<div property="columns">
                  		<div field="" name="" width="80" headerAlign="center" header="备注"></div>
                  	</div>
                  </div>
              </div>
          </div>
    </div>
</body>
</html>
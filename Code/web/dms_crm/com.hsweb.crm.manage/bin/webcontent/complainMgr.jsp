<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>投诉管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
     <script src="<%=webPath + contextPath%>/manage/js/complainMgr.js?v=1.0.3"></script>
</head>
<body> 
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table class="table">
            <tr>
                <td>
                	<span>分店:</span>
                    <input class="nui-combobox"  width="120" allowInput="false"/>
                    <span>投诉时间:</span>
                    <input class="nui-datepicker" id="sEnterDate" name="sEnterDate" format="yyyy-MM-dd" width="120" allowInput="false"/>
                    <span>至</span>
                    <input class="nui-datepicker" id="eEnterDate" name="eEnterDate" format="yyyy-MM-dd" width="120" allowInput="false"/>
                    <span>车牌号:</span>
                    <input class="nui-textbox" emptyText="输入查询条件" width="120"/>
                    <span>状态:</span>
                    <input class="nui-combobox"  width="80" allowInput="false"/>
                    <a class="nui-button"  plain="true" onclick="search()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" plain="true" onclick="addComplain()"><span class="fa fa-plus fa-lg"></span>&nbsp;投诉登记</a>
                    <a class="nui-button" plain="true" onclick="eidComplain()"><span class="fa fa-edit fa-lg"></span>&nbsp;投诉修改</a>
                    <a class="nui-button"  plain="true" onclick="">维修档案</a>
                    <a class="nui-button"  plain="true" onclick=""><span class="fa fa-print fa-lg"></span>打印</a>
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
               allowCellSelect="true">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div header="投诉分店" headerAlign="center">
                  	<div property="columns">
                  		<div field="id" class="nui-hidden" name="" width="40" headerAlign="center" ></div>
                  		<div field="" name="" width="40" headerAlign="center" header="区号"></div>
                  		<div field="" name="" width="60" headerAlign="center" header="店号"></div>
                  		<div field="complaintOrgid" name="" width="60" headerAlign="center" header="分店"></div>
                  	</div>
                  </div>
                  <div header="客户信息" headerAlign="center">
                  	<div property="columns">
                  		<div field="guestName" name="" width="80" headerAlign="center" header="客户名称"></div>
                  		<div field="mobile" name="" width="120" headerAlign="center" header="手机号"></div>
                  		<div field="carNo" name="" width="80" headerAlign="center" header="车牌号"></div>
                  	</div>
                  </div>
                  <div header="投诉信息" headerAlign="center">
                  	<div property="columns">
                  		<div field="complaintType" name="" width="80" headerAlign="center" header="投诉类型"></div>
                  		<div field="complaintLevel" name="" width="80" headerAlign="center" header="投诉级别"></div>
                  		<div field="complaintReason" name="" width="80" headerAlign="center" header="投诉原因"></div>
                  		<div field="complaintReamrk" name="" width="80" headerAlign="center" header="投诉备注"></div>
                  		<div field="complaintDate" name="" width="80" headerAlign="center" header="投诉日期" dateFormat="yyyy-MM-dd"></div>
                  		<div field="status" name="" width="80" headerAlign="center" header="状态"></div>
                  		<div field="dutyDept" name="" width="80" headerAlign="center" header="责任部门"></div>
                  		<div field="dutyMan" name="" width="80" headerAlign="center" header="责任人"></div>
                  		<div field="processReamrk" name="" width="80" headerAlign="center" header="处理意见"></div>
                  		<div field="solution" name="" width="80" headerAlign="center" header="解决措施"></div>
                  		<div field="preventReamrk" name="" width="80" headerAlign="center" header="预防措施"></div>
                  		<div field="punishType" name="" width="80" headerAlign="center" header="处罚方式"></div>
                  		<div field="punishAmt" name="" width="80" headerAlign="center" header="处罚金额"></div>
                  		<div field="recordDate" name="" width="80" headerAlign="center" header="建档日期" dateFormat="yyyy-MM-dd"></div>
                  		<div field="recorder" name="" width="80" headerAlign="center" header="建档人"></div>
                  	</div>
                  </div>
              </div>
          </div>
    </div>
</body>
</html>
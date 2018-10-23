<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>投诉管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
     <script src="<%=webPath + contextPath%>/manage/js/complainMgr.js?v=1.0.1"></script>
</head>
<body>
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table class="table">
            <tr>
                <td>
                	<span>分店:</span>
                    <input class="nui-combobox"  width="120" allowInput="false"/>
                    <span>投诉时间:</span>
                    <input class="nui-datepicker" format="yyyy-MM-dd" width="120" allowInput="false"/>
                    <span>至</span>
                    <input class="nui-datepicker" format="yyyy-MM-dd" width="120" allowInput="false"/>
                    <span>车牌号:</span>
                    <input class="nui-textbox" emptyText="输入查询条件" width="120"/>
                    <span>状态:</span>
                    <input class="nui-combobox"  width="80" allowInput="false"/>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="">查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="icon-add" plain="true" onclick="addComplain()">投诉登记</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="">维修档案</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="">打印</a>
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
                  <!-- <div type="indexcolumn">序号</div> -->
                  <div header="投诉分店" headerAlign="center">
                  	<div property="columns">
                  		<div field="" name="" width="40" headerAlign="center" header="区号"></div>
                  		<div field="" name="" width="60" headerAlign="center" header="店号"></div>
                  		<div field="" name="" width="60" headerAlign="center" header="分店"></div>
                  	</div>
                  </div>
                  <div header="客户信息" headerAlign="center">
                  	<div property="columns">
                  		<div field="" name="" width="80" headerAlign="center" header="客户名称"></div>
                  		<div field="" name="" width="120" headerAlign="center" header="手机号"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="车牌号"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="厂牌"></div>
                  	</div>
                  </div>
                  <div header="投诉信息" headerAlign="center">
                  	<div property="columns">
                  		<div field="" name="" width="80" headerAlign="center" header="投诉形式"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="投诉级别"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="投诉内容"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="投诉调查"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="投诉解决方案"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="投诉日期"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="业务单号"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="业务类型"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="维修顾问"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="当前状态"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="登记人"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="处理人"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="处理日期"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="受理状态"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="关闭投诉时间"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="投诉单号"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="归档日期"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="满意度分数"></div>
                  		<div field="" name="" width="80" headerAlign="center" header="归档人"></div>
                  	</div>
                  </div>
              </div>
          </div>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>业绩录入</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="manage/js/investInput.js" type="text/javascript"></script>
</head>
<body>
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table class="table">
            <tr>
                <td>
                    <span>车牌号:</span>
                    <input id="carNo" class="nui-textbox" emptyText="输入查询条件" width="120"/>
                    <span>工单号:</span>
                    <input id="serviceCode" class="nui-textbox" emptyText="输入查询条件" width="120"/>
                    <span>审核状态:</span>
                    <input id="auditSign" class="nui-combobox" data="gAuditSign" emptyText="输入查询条件" width="120"/>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="search()">查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="onAddClick()">新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onEditClick()">修改</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onDeleteClick()">删除</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="">查看跟踪明细</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
          <div id="investGrid" class="nui-datagrid" style="width:100%;height:100%;"
               pageSize="50"
               multiSelect="false"
               totalField="page.count"
               sizeList=[20,50,100,200]
               dataField="list"
               onrowdblclick=""
               allowCellSelect="true"
               ondrawcell="onDrawcell"
               url="com.hsapi.crm.svr.svr.queryInvestList.biz.ext">
              <div property="columns">
              	  <div type="indexcolumn">序号</div> 
                  <div header="业绩信息" headerAlign="center">
                  	<div property="columns">
                  		<div field="carNo" name="carNo" width="80" headerAlign="center" header="车牌号"></div>
                  		<div field="serviceCode" name="serviceCode" width="80" headerAlign="center" header="工单号"></div>
                  		<div field="visitMan" name="visitMan" width="80" headerAlign="center" header="营销员"></div>
                  		<div field="carType" name="carType" width="80" headerAlign="center" header="来厂类型"></div>
                  		<div field="auditSign" name="auditSign" width="80" headerAlign="center" header="审核状态"></div>
                  		<div field="auditDate" name="auditDate" width="80" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd"></div>
                  		<div field="auditOpinion" name="auditOpinion" width="80" headerAlign="center" header="审核备注"></div>
                  		<div field="remark" name="remark" width="80" headerAlign="center" header="业绩备注"></div>
                  		<div field="recorder" name="recorder" width="80" headerAlign="center" header="登记人"></div>
                  		<div field="recordDate" name="recordDate" width="80" headerAlign="center" header="登记日期" dateFormat="yyyy-MM-dd"></div>
                  		<div field="modifier" name="modifier" width="80" headerAlign="center" header="最后修改人"></div>
                  		<div field="modifyDate" name="modifyDate" width="80" headerAlign="center" header="最后修改日期" dateFormat="yyyy-MM-dd"></div>
                  	</div>
                  </div>
                  <div header="维修信息" headerAlign="center">
                  	<div property="columns">
                  		<div field="serviceTypeId" name="serviceTypeId" width="80" headerAlign="center" header="业务类型 "></div>
                  		<div field="mtAdvisor" name="mtAdvisor" width="80" headerAlign="center" header="维修顾问 "></div>
                  		<div field="partTotalAmt" name="partTotalAmt" width="80" headerAlign="center" header="材料金额 "></div>
                  		<div field="itemTotalAmt" name="itemTotalAmt" width="80" headerAlign="center" header="项目金额 "></div>  
                  	</div>
                  </div>
                  <div header="车辆信息" headerAlign="center">
                  	<div property="columns">
                  		<div field="compComeTimes" name="compComeTimes" width="80" headerAlign="center" header="分店来厂次数"></div>
                  		<div field="chainComeTimes" name="chainComeTimes" width="80" headerAlign="center" header="连锁来厂次数"></div>
                  		<div field="carBrandId" name="carBrandId" width="80" headerAlign="center" header="品牌"></div>
                  		<div field="carModel" name="carModel" width="80" headerAlign="center" header="车型"></div>
                  		<div field="engineNo" name="engineNo" width="80" headerAlign="center" header="发动机号"></div>
                  		<div field="vin" name="vin" width="80" headerAlign="center" header="底盘"></div>
                  	</div>
                  </div>
              </div>
          </div>
    </div>
</body>
</html>
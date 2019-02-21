<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-02-18 09:38:27
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<style type="text/css">
 body {
                margin: 0;
                padding: 0;
                border: 0;
                width: 100%;
                height: 100%;
                overflow: hidden;
 }
.title {
  width: 80px;
  text-align: right;
}

.form_label {
	width: 72px;
	text-align: right;
}

.required {
	color: red;
}

.rmenu {
    font-size: 14px;
    /* font-weight: bold; */
    text-align: left;
    margin: 0;
    padding-left: 25px;
    height: 18px;
    color: #fff;
    width: auto;
    margin-left: 20px;
    margin-top: 20px;
    background-size: 50%;
}

 #wechatTag1{
            color:#ccc;
        }
 #wechatTag{
            color:#62b900;
        }
</style>

</head>
<body>

<div class="nui-fit">
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table class="table" id="table1">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                     <a class="nui-menubutton " menu="#popupMenuStatus" id="menunamestatus">业务类型</a>
                    <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="quickSearch(0)" id="type0">厂外维修</li>
                        <li iconCls="" onclick="quickSearch(1)" id="type0">厂内翻新</li>
                        <li iconCls="" onclick="quickSearch(2)" id="type1">厂外返修</li>
                    </ul>
                    <span class="separator"></span>
                    <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="onenterSearch(this.value)"/>
                    <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="服务顾问" url=""  allowInput="true" showNullItem="false" width="80" valueFromSelect="true" onenter="onenterMtAdvisor(this.value)"/>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
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
               showModified="false"
               onrowdblclick=""
               allowCellSelect="true"
               editNextOnEnterKey="true"
               onshowrowdetail="onShowRowDetail"
               allowCellWrap = "true"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div field="status" name="status" width="70px" headerAlign="center" header="进程"></div>
                  <div field="serviceCode" name="serviceCode" width="150px" headerAlign="center" header="工单号"></div>
                  <div field="carNo" name="carNo" width="80px" headerAlign="center" header="车牌号"></div>
                  <div field="enterDate" name="enterDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm" header="进厂时间"></div>
                  <div field="serviceTypeName" name="serviceTypeName" width="140px" headerAlign="center" header="业务类型"></div>
                  <div field="carModel" name="carModel" width="100px" headerAlign="center"  header="波箱厂牌"></div>
                  <div field="carVin" name="carVin" width="130px" headerAlign="center" header="变速箱型号"></div>
                  <div field="mtAdvisor" name="mtAdvisor" width="90px" headerAlign="center" header="服务顾问"></div>
                  <div field="balaAuditSign" name="balaAuditSign" width="90px" headerAlign="center" header="结算状态"></div>
                  <div field="contactName" name="contactName" width="80px" headerAlign="center" header="联系人姓名"></div>
                  <div field="contactMobile" name="contactMobile" width="100px" headerAlign="center" header="联系人手机"></div>

              </div>
          </div>
    </div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>
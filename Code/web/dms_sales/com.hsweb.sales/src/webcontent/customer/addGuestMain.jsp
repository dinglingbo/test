<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
<title>客户资料</title>
<script src="<%=webPath + contextPath%>/sales/customer/js/addGuestMain.js?v=1.0.0"></script>
<link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
<style type="text/css">

.title {
  width: 80px;
  text-align: right;
}shu

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
                    <!-- <label style="font-family:Verdana;">客户名称：</label> -->
                    <input class="nui-textbox" id="name-search" emptyText="客户名称" width="120"  onenter="doSearch()"/>
                    <!-- <label style="font-family:Verdana;">手机号：</label> -->
                    <input class="nui-textbox" id="mobile-search" emptyText="手机号" width="120"  onenter="doSearch()"/>
                   <!--  <label style="font-family:Verdana;">销售顾问：</label> -->                 
                    <input name="saleAdvisorId" id="saleAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="销售顾问" url=""  allowInput="true" showNullItem="false" width="100" valueFromSelect="true"  onenter="doSearch()"/>
                    <label style="font-family:Verdana;">跟踪状态：</label>
                    <input class="nui-combobox" id="scoutStatus" emptyText="" name="scoutStatus" data="[{scoutStatus:0,text:'继续跟进'},{scoutStatus:1,text:'终止跟进'},{scoutStatus:2,text:'重点跟进'},
                         {scoutStatus:1,text:'已来厂/已成交'},{scoutStatus:1,text:'未跟进'}]" width="120"  onvaluechanged="onSearch" textField="text" valueField="scoutStatus" value="1"/>
               
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                   <!--  <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-check fa-lg"></span>&nbsp;全选/反选</abbr></a> -->
                     <span class="separator"></span>
                    <label style="font-family:Verdana;">将客户资料分配给：</label>
                    <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="服务顾问" url=""  allowInput="true" showNullItem="false" width="80" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
                    <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-check fa-lg"></span>&nbsp;确定</abbr></a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
           <input name="identity"
             id="identity"
             class="nui-combobox"
             textField="name"
             valueField="id"
             allowInput="true"
             width="100%"
             visible="false"
           />
            <input name="trade"
             id="trade"
             class="nui-combobox"
             textField="name"
             valueField="id"
             allowInput="true"
             width="100%"
             visible="false"
           />
            <input name="source"
             id="source"
             class="nui-combobox"
             textField="name"
             valueField="id"
             allowInput="true"
             width="100%"
             visible="false"
           />
           <input name="nature"
             id="nature"
             class="nui-combobox"
             textField="name"
             valueField="id"
             allowInput="true"
             width="100%"
             visible="false"
           />
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
               multiSelect="true"
               url="">
              <div property="columns">
                <div type="indexcolumn" width="50">序号</div>
                  <div header="选择" headerAlign="center">
                       <div property="columns" >
                        <!-- <div field="guestOptBtn" name="guestOptBtn" width="50" headerAlign="center" allowsort="false" header="选择">
                         <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0" width="30%"/>
                        </div> -->
                        <div type="checkcolumn" field="check" width="30"></div> 
                       </div>
                  </div>
                  <div header="基本信息" headerAlign="center">
                  	  <div property="columns" >
	                  <div type="checkcolumn" name="checkcolumn" visible="false"></div>
	                  <div field="guestId" name="guestId" visible="false"></div>
	                  <div field="saleAdvisor" name="saleAdvisor" width="80" headerAlign="center" allowsort="true" header="销售顾问"></div>
	                  <div field="name" name="name" width="80" headerAlign="center" allowsort="true" header="姓名"></div>
  	                  <div field="sex" name="sex" width="80" headerAlign="center" allowsort="true" header="性别"></div>
  	                  <div field="birthdayType" name="birthdayType" width="80" headerAlign="center" allowsort="true" header="生日类型"></div>
	                  <div field="birthday" name="birthday" width="120" headerAlign="center" allowsort="true" dateFormat="yyyy-MM-dd HH:mm" header="生日"></div>
	                  <div field="identity" name="identity" width="60" headerAlign="center" allowsort="true" header="身份"></div>
	                 </div>
                  </div>
                  <div header="其他信息" headerAlign="center">
                  	  <div property="columns" >
	                  <div type="checkcolumn" name="checkcolumn" visible="false"></div>
	                  <div field="nature" name="nature" width="80" headerAlign="center" allowsort="true" header="特征"></div>
	                  <div field="trade" name="trade" width="80" headerAlign="center" allowsort="true" header="行业"></div>
  	                 <!--  <div field="mtAdvisor" name="mtAdvisor" width="80" headerAlign="center" allowsort="true" header="群体"></div> -->
  	                  <div field="specialCare" name="specialCare" width="80" headerAlign="center" allowsort="true" header="特别关注"></div>
	                  <div field="maritalStatus" name="maritalStatus" width="60" headerAlign="center" allowsort="true" header="婚姻状况"></div>
	                  <div field="source" name="source" width="60" headerAlign="center" allowsort="true" header="客户来源"></div>
	                 </div>
                  </div>
                  <div header="详细信息" headerAlign="center">
                  	  <div property="columns" >
	                  <div type="checkcolumn" name="checkcolumn" visible="false"></div>
	                  <div field="idNo" name="idNo" width="80" headerAlign="center" allowsort="true" header="身份证"></div>
	                  <div field="idAddress" name="idAddress" width="80" headerAlign="center" allowsort="true" header="发证地"></div>
  	                  <!-- <div field="mtAdvisor" name="mtAdvisor" width="80" headerAlign="center" allowsort="true" header="学历"></div> -->
  	                  <div field="email" name="emali" width="80" headerAlign="center" allowsort="true" header="邮箱"></div>
	                  <div field="workPlace" name="workPlace" width="60" headerAlign="center" allowsort="true" header="工作单位"></div>
	                 </div>
                  </div>
                  <div header="操作信息" headerAlign="center">
                  <div property="columns" >
                      <div field="modifier" name="modifier" width="80" headerAlign="center" allowsort="false" header="修改人"></div>
	                  <div field="modifyDate" name="modifyDate" width="120" headerAlign="center" allowsort="true" dateFormat="yyyy-MM-dd HH:mm" header="修改时间"></div>
                  </div>
                  </div>
                  </div>
              </div>
          </div>
    </div>


<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:420px;height:220px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            
            <input name="carBrandId"
                id="carBrandId" visible="false"
                class="nui-combobox"
                textField="name"
                valueField="id"/>
                
           <input name="serviceTypeId"
                id="serviceTypeId" visible="false"
                class="nui-combobox"
                textField="name"
                valueField="id"/>
            <tr>
                <td class="title" width="800px">开单日期:</td>
                <td>
                    <input id="sRecordDate"
                           name="sRecordDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="eRecordDate"
                           name="eRecordDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">预计完工日期:</td>
                <td>
                    <input id="sPlanFinishDate"
                           name="sPlanFinishDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="ePlanFinishDate"
                           name="ePlanFinishDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">业务类型:</td>
                <td colspan="3">
                    <div id="serviceTypeIds" name="serviceTypeIds" class="nui-checkboxlist" repeatItems="5" 
                    repeatLayout="flow"  value="" 
                    textField="name" valueField="id" ></div>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
        </div>
    </div>
</div>
</body>
</html>
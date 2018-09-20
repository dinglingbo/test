<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>

<html> 
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-02 20:50:20 
  - Description:  
-->         
 
<head> 
    <title>查车单</title> 
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/checkDetail.js?v=1.0.956"></script>
    <style type="text/css">
    body { 
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
    .tbtext {
        float: right;
    }

    .vpanel {
        border: 1px solid #d9dee9;
        margin: 10px 0px 10px 0px;
        /* width: 39%;
        height: 248px; */

    }

    .vpanel_heading {
        border-bottom: 1px solid #d9dee9;
        width: 100%;
        height: 28px;
        line-height: 28px;
    }

    .vpanel_heading span {
        margin: 0 0 0 20px;
        font-size: 16px;
        font-weight: normal;
    }

    .vpanel_bodyww {
        padding: 10 10 10 10px !important
    }


    .function-item {
        margin-left: 5px;
        margin-right: 5px;
    } 
</style>
</head>

<body>

    <div class="nui-toolbar" id="toolbar1" style="padding:2px;height:30px">
        <input class="nui-hidden" id="mid" name="mid" value='<b:write property="mid"/>'/>
        <input class="nui-hidden" id="tid" name="tid" value='<b:write property="tid"/>'/>
        <input class="nui-hidden" id="actionType" name="actionType" value='<b:write property="actionType"/>'/>
        <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
            <tr>            
                <td style="width: 500px;">
                    <div class="nui-autocomplete" style="width:200px;"  popupWidth="600" textField="text" valueField="id" 
                    id="search_key" url="" value="carNo" placeholder="车牌号/客户名称/手机号/VIN码"  searchField="key" 
                    dataField="list" loadingText="数据加载中...">     
                    <div property="columns">
                        <div header="客户名称" field="guestFullName" width="30" headerAlign="center"></div>
                        <div header="客户手机" field="guestMobile" width="60" headerAlign="center"></div>
                        <div header="车牌号" field="carNo" width="40" headerAlign="center"></div>
                        <div header="送修人名称" field="contactName" width="30" headerAlign="center"></div>
                        <div header="送修人手机" field="mobile" width="60" headerAlign="center"></div>
                        <div header="VIN" field="vin" width="70" headerAlign="center"></div>
                    </div>
                </div>
                <input id="search_name"
                name="search_name"
                class="nui-textbox"
                emptyText="车牌号/客户名称/手机号/VIN码"
                onbuttonclick="onSearchClick()"
                width="200px"
                visible="false"
                enabled="false"
                showClose="false"
                allowInput="true"/>
                <a class="nui-button" iconCls="" plain="false" onclick="addGuest()" id="addBtn">新增客户</a>
                <label style="font-family:Verdana;">工单号:</label>
                <label id="servieIdEl" style="font-family:Verdana;"></label>
            </td>     
            <td style="text-align:right;">
                <a class="nui-button" iconCls="" plain="true" onclick="newCheckMainMore()">
                    <span class="fa fa-search fa-lg"></span>&nbsp;查看历史记录</a>
                  <a class="nui-button" onclick="saveb()" plain="true"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                  <a class="nui-button" onclick="print()" plain="true"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
              </td>     
          </tr>
      </table>
  </div>


  <div class="nui-fit">
    <div id="billForm" class="form">
        <input class="nui-hidden" name="id" id="id"/>
        <input class="nui-hidden" name="guestId"/>
        <input class="nui-hidden" name="mtAdvisor" id="mtAdvisor"/>
        <input class="nui-hidden" name="contactorId"/>
        <input class="nui-hidden" name="carId"/>
        <input class="nui-hidden" name="status"/>
        <input class="nui-hidden" name="drawOutReport"/>
        <input class="nui-hidden" name="contactorName"/>
        <input class="nui-hidden" name="identity"/>
        <input class="nui-hidden" name="billTypeId"/>
        <input class="nui-hidden" name="status"/>
        <input class="nui-hidden" name="isSettle"/>
        <input class="nui-hidden" name="serviceTypeId"/>
        <table  style=" left:0;right:0;margin: 0 auto;"> 

            <tr>
                <td class="tbtext">车主:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" name="guestFullName" id="guestFullName" />
                </td>
                <td class="tbtext">车主电话:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" name="guestMobile" id="guestMobile" />
                </td>

                <td class="tbtext">车牌:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" name="carNo" id="carNo"/>
                </td>

                <td class="tbtext">检查模板:</td>
                <td class="tbCtrl">
                    <input class="nui-combobox tabwidth"  id="checkMainId" name="checkMainId" 
                    dataField="list" valueField="id" textField="name" onvaluechanged="ValueChanged"/>
                    <input class="nui-combobox tabwidth"  id="checkMainName" name="checkMainName" visible="false"/>
                </td>

            </tr> 
            <tr>
                <td class="tbtext">上次检查时间:</td>
                <td class="tbCtrl">
                    <input class="nui-datepicker tabwidth" name="" id="" format="yyyy-MM-dd"/>
                </td>
               <td class="tbtext">上次检查里程:</td>
               <td class="tbCtrl">
                <input class="nui-textbox tabwidth" name="lastKilometers" id="lastKilometers"/>
            </td>

                <td class="tbtext">上次检查项目:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" name="" id=""/>
                </td>
                <td class="tbtext">上次检查得分:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth"  name="lastPoint" id="lastPoint"/>
                </td>
       
            </tr>
            <tr>
                <td class="tbtext">检查人:</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" id="checkMan" name="checkMan"/>
                </td>

                        <td class="tbtext">本次里程:</td>
            <td class="tbCtrl">
                <input class="nui-textbox tabwidth" name="enterKilometers" id="enterKilometers"/>
            </td>
            <td class="tbtext">服务顾问:</td>
            <td class="tbCtrl">

                <input name="mtAdvisorId"
                id="mtAdvisorId"
                class="nui-combobox width1"
                textField="empName"
                valueField="empId"
                emptyText="请选择..."
                url=""
                allowInput="true"
                showNullItem="false"
                valueFromSelect="true"
                nullItemText="请选择..."/>
                
            </td>

            <td class="tbtext">本次检查得分:</td>
            <td class="tbCtrl">
                <input class="nui-textbox tabwidth" name="checkPoint" id="checkPoint"/>
            </td>

        </tr>

    </table>
</div>

<div id="mainGrid" class="nui-datagrid" style="width:100%;height:auto;" showPager="false" 
dataField="list"  allowCellSelect="true" 
url=""  showModified="false"
allowCellEdit="true" ShowHGridLines="false" ShowVGridLines="false" >
<div property="columns">
    <div type="indexcolumn" align="center" headerAlign="center" width="10px"><strong>序号</strong></div>
    <div field="id" name="id" visible="false">id</div>
    <div field="checkName" name="checkName" width="30" headerAlign="center" align="center"><strong>检查项目</strong></div>
    <div field="checkCode" name="checkCode" width="30" headerAlign="center" align="center" visible="false"><strong>检查项目</strong></div>
    <div field="checkId" name="checkId" width="30" headerAlign="center" align="center" visible="false"><strong>配件名称id</strong></div>
    <div type="checkboxcolumn" field="status" name="status" trueValue="1" falseValue="0"  width="30" headerAlign="center" align="center" value="1"><strong>正常状态</strong></div>
    <div type="checkboxcolumn" field="nostatus" name="nostatus" trueValue="1" falseValue="0"  width="30" headerAlign="center" align="center"><strong>异常状态</strong></div>
    <div field="remark" name="remark" width="90" headerAlign="center" align="center"><strong>备注</strong>
        <input property="editor" class="nui-combobox" style="width:100%;" 
        textfield="content" valuefield="content"  dataField="list" allowInput="true"/>  

    </div>
</div>
</div>


<div class="vpanel" style="width:calc(100% - 2px);height:120px;">
    <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;">
        <span>客户描述</span>
    </div>
    <div class="nui-fit">
        <input class="nui-textarea " style="width:100%;height:100%;border:0px;" />
    </div>
</div>
<div style="clear: both;">
    <div class="vpanel" style="width:calc(100% - 2px);height:100px;margin-left: auto;margin-right: auto;margin-top: 20px;">
        <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;">
            <span>检测照片</span>
        </div>
        <div class="vpanel_body"> 
 

        </div> 
    </div> 
<!-- 
    <div style="width:100%;margin-top: 10px;">
        <a class="nui-button" onclick="saveb()" plain="false">保存</a>
        <a class="nui-button" onclick="" plain="false">退出</a>
    </div> -->
</div>

<script type="text/javascript">
    nui.parse();
</script>
</body>

</html>
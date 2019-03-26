<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
    <%@include file="/common/common.jsp"%>
        <%@include file="/common/commonRepair.jsp"%>
            <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
            <html>
            <!-- 
  - Author(s): Administrator
  - Date: 2018-01-31 16:54:43
  - Description:
-->
<head>
    <title>新增客户档案</title>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/Split.js?v=1.0.0"></script>
    <style type="text/css">
        table {
            font-size: 12px;
        }

        .form_label {
            width: 100px;
            text-align: right;
        }

        .required {
            color: red;
        }
         a.optbtn {
        width: 60px; 
        height: 20px; 
        border: 1px #d2d2d2 solid;
        background: #f2f6f9;
        text-align: center;
        display: inline-block;    
        /* line-height: 26px; */
        margin: 0 4px;
        color: #000000;
        text-decoration: none;
        border-radius: 5px; 
    }
    </style>
</head>

<body>
      <div class="nui-splitter" id="addEditCustomerPage" style="width:100%;height:100%;" vertical="true" borderStyle="border:0;"
        handlerSize="0" allowResize="false">
        <div size="240" showCollapseButton="false" style="border:0;">
            <div class="nui-panel" showToolbar="false" title="客户信息" showFooter="false" borderStyle="border:0;" style="width:100%;height:100%;">

                <div class="form" id="basicInfoForm">
                    <input class="nui-hidden" name="id" />
                    <table class="nui-form-table" style="width:99%">
                        <tr>
                            <td class="form_label required">
                                <label>客户名称：</label>
                            </td>
                            <td>
                                <input class="nui-hidden" name="id" id="guestId" />
                                <input class="nui-textbox" id="fullName" name="fullName" width="200px" onvaluechanged="onChangedMobile(this.id)"/>
                            </td>
                            <td class="form_label required">
                                <label>手机号码：</label>
                            </td>
                            <td>
                                <input class="nui-textbox" id="mobile" name="mobile" width="100%" onvaluechanged="onChangedMobile(this.id)"
                                  emptyText="请输入手机号查询" onenter="onChangedMobile(this.id)"
                                 />
                            </td>
                        </tr>
                        <tr>
                            <td class="form_label">
                                <label>性别：</label>
                            </td>
                            <td>
                                <input class="nui-combobox" data="[{value:'0',text:'男',},{value:'1',text:'女'},]" textField="text" valueField="value" name="sex"
                                    value="0"  width="200px"/>
                            </td>
                            <td class="form_label ">
                                <label>客户简称：</label>
                            </td>
                            <td>
                                <input class="nui-textbox" id="shortName" name="shortName" onValuechanged=""  width="100%" />
                            </td>
                        </tr>
                        <tr>
                        
                           <td class="form_label">
                                <label>客户级别：</label>
                            </td>
                            <td colspan="3">
                                <input name="guestTypeId"
                                   id="guestTypeId"
                                   class="nui-combobox "
                                   textField="name"
                                   valueField="id"
                                   emptyText="请选择..."
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   width="42%" 
                                   valueFromSelect="true"
                                   nullItemText="请选择..."/>
                        	</td>
                           <!--  <td class="form_label">
                                <label>生日类型：</label>
                            </td>
                            <td>
                                <input class="nui-combobox" data="[{value:'0',text:'农历',},{value:'1',text:'阳历'},]" textField="text" valueField="value" name="birthdayType"
                                    value="0"  width="200px"/>
                            </td>
                            <td class="form_label ">
                                <label>生日日期：</label>
                            </td>
                            <td>
                                <input name="birthday" allowInput="false" class="nui-datepicker" width="100%" />
                            </td> -->
                        </tr>
                        <tr>
                            <td class="form_label">
                                <label>地址：</label>
                            </td>
                            <td colspan="3">
                                <input name="provinceId" id="provice" valueField="code" textField="name" emptyText="省" url="" onValuechanged="initCityByParent('cityId', e.value || -1)"
                                    class="nui-combobox" width="32%" />

                                <input name="cityId" id="cityId" valueField="code" textField="name" emptyText="市/县" onValuechanged="initCityByParent('areaId', e.value || -1)"
                                    class="nui-combobox" width="33%" />

                                <input name="areaId" id="areaId" valueField="code" textField="name" emptyText="乡/镇" class="nui-combobox" width="33%" />

                                <input class="nui-textbox" name="addr" width="100%" />
                            </td>
                        </tr>
                        <tr>
                            <td class="form_label">
                                <label>备注：</label>
                            </td>
                            <td colspan="3">
                                <input class="nui-textbox" name="remark" width="100%" />
                            </td>
                        </tr>
                        <tr>

                            <td colspan="6" align="left">
                                <a class="nui-button" onclick="onOk" style="width:120px;margin-right:20px;">
                                    <span class="fa fa-save fa-lg"></span>&nbsp;拆分资料</a>
                                <!-- <a class="nui-button" onclick="onCancel" style="width:60px;"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a> -->
                            </td>
                        </tr>

                    </table>
                </div>
            </div>
        </div>  
</body>

</html>
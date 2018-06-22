<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    

<div id="mainTabs" class="nui-tabs" activeIndex="0" style="width: 100%; height:auto;" plain="false">
    <div title="车主信息">

        <div id="advancedAddForm" class="form">
          <table style="width: 100%;">
              <tr>
                  <td class="title required">
                      <label>车牌号：</label>
                  </td>
                  <td >
                      <input class="nui-textbox" enable="false" width="100%" id="remark" name="remark"/>
                  </td>
                  <td class="title required">
                      <label>业务类型：</label>
                  </td>
                  <td>
                      <input name="billTypeId"
                             id="billTypeId"
                             class="nui-combobox width1"
                             textField="name"
                             valueField="customid"
                             emptyText="请选择..."
                             url=""
                             allowInput="true"
                             showNullItem="false"
                             width="100%"
                             valueFromSelect="true"
                             onvaluechanged=""
                             nullItemText="请选择..."
                             onvalidation="onComboValidation"/>
                  </td>
                  <td class="title required">
                      <label>维修顾问：</label>
                  </td>
                  <td>
                      <input name="billTypeId"
                             id="billTypeId"
                             class="nui-combobox width1"
                             textField="name"
                             valueField="customid"
                             emptyText="请选择..."
                             url=""
                             allowInput="true"
                             showNullItem="false"
                             width="100%"
                             valueFromSelect="true"
                             onvaluechanged=""
                             nullItemText="请选择..."
                             onvalidation="onComboValidation"/>
                  </td>
                  <td class="title required">
                      <label>进厂油量：</label>
                  </td>
                  <td>
                      <input name="billTypeId"
                             id="billTypeId"
                             class="nui-combobox width1"
                             textField="name"
                             valueField="customid"
                             emptyText="请选择..."
                             url=""
                             allowInput="true"
                             showNullItem="false"
                             width="100%"
                             valueFromSelect="true"
                             onvaluechanged=""
                             nullItemText="请选择..."
                             onvalidation="onComboValidation"/>
                  </td>
              </tr>
              <tr>
                  <td class="title">
                      <label>进厂里程：</label>
                  </td>
                  <td >
                      <input class="nui-textbox" width="100%" id="remark" name="remark"/>
                  </td>
                  <td class="title">
                      <label>进厂日期：</label>
                  </td>
                  <td width="120">
                      <input name="createDate"
                             id="createDate"
                             width="100%"
                             showTime="true"
                             class="nui-datepicker" format="yyyy-MM-dd H:mm:ss"/>
                  </td>
                  <td class="title">
                      <label>预计交车：</label>
                  </td>
                  <td width="120">
                      <input name="createDate"
                             id="createDate"
                             width="100%"
                             showTime="true"
                             class="nui-datepicker" format="yyyy-MM-dd H:mm:ss"/>
                  </td>
                  <td class="title">
                      <label>备注：</label>
                  </td>
                  <td >
                      <input class="nui-textbox" width="100%" id="remark" name="remark"/>
                  </td>
              </tr>
          </table>
      </div>

    </div>
    <div title="送修人信息">
    </div>
    <div title="保险信息">
    </div>
    <div title="描述信息">
        <table class="nui-form-table" style="margin:0;width: 100%">
            <tr>
                <td>
                    <label>客户描述：</label>
                </td>
                <td>
                    <label>故障现象：</label>
                </td>
                <td>
                    <label>解决措施：</label>
                </td>
            </tr>
            <tr>
                <td>
                    <textarea class="nui-textarea" name="guestDesc"
                              style="width:100%;height: 80px;"></textarea>
                </td>
                <td>
                    <textarea class="nui-textarea" name="faultPhen"
                              style="width:100%;height: 80px;"></textarea>
                </td>
                <td>
                    <textarea class="nui-textarea" name="solveMethod"
                              style="width:100%;height: 80px;"></textarea>
                </td>
            </tr>
        </table>
    </div>
</div>
    



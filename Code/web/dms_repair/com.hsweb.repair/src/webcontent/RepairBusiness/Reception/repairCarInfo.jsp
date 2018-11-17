<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    

<div id="mainTabs" class="nui-tabs" activeIndex="0" style="width: 100%; height:auto;" plain="false">
    <div title="工单信息" name="mainTab">

        <div id="billForm" class="form">
          <table style="width: 100%;border-spacing: 0px 5px;">
                <input name="id" class="nui-hidden"/>
                <input name="guestId" class="nui-hidden"/>
                <input id="mtAdvisor" name="mtAdvisor" class="nui-hidden"/>
                <input class="nui-hidden" name="contactorId"/>
                <input class="nui-hidden" name="carId"/>
                <input class="nui-hidden" name="status"/>
                <input class="nui-hidden" name="carVin"/>
                <input class="nui-hidden" name="drawOutReport"/>
                <input class="nui-hidden" name="contactorName"/>
                <input class="nui-hidden" name="carModel"/>
                <input class="nui-hidden" name="identity"/>
                <input class="nui-hidden" name="billTypeId"/>
                <input class="nui-hidden" name="status"/>
                <input class="nui-hidden" name="isSettle"/>
                <input class="nui-hidden" name="isOutBill"/>
              <tr>
                  <td class="title required">
                      <label>车牌号：</label>
                  </td>
                  <td class="" width="24%"><input  class="nui-textbox" name="carNo" id="carNo" enabled="false" width="100%"/></td>
                  <td class="title required">
                      <label>业务类型：</label>
                  </td>
                  <td>
                      <input name="serviceTypeId"
                             id="serviceTypeId"
                             class="nui-combobox width1"
                             textField="name"
                             valueField="id"
                             emptyText="请选择..."
                             url=""
                             allowInput="true"
                             showNullItem="false"
                             width="100%"
                             valueFromSelect="true"
                             nullItemText="请选择..."/>
                  </td>
                  <td class="title required">
                      <label>服务顾问：</label>
                  </td>
                  <td>
                      <input name="mtAdvisorId"
                             id="mtAdvisorId"
                             class="nui-combobox width1"
                             textField="empName"
                             valueField="empId"
                             emptyText="请选择..."
                             url=""
                             allowInput="true"
                             showNullItem="false"
                             width="100%"
                             valueFromSelect="true"
                             nullItemText="请选择..."/>
                  </td>
                   <td class="title required" >
                      <label>品牌/车型：</label>
                  </td>
                      <td class=""><input  class="nui-textbox" name="carModel" id="carModel" enabled="false" width="100%"/></td>
              </tr>
              <tr>
                 <td class="title required">
                      <label>进厂油量：</label>
                  </td>
                  <td>
                      <input name="enterOilMass"
                             id="enterOilMass"
                             class="nui-combobox width1"
                             textField="name"
                             valueField="customid"
                             emptyText="请选择..."
                             url=""
                             width="28%"
                             allowInput="true"
                             showNullItem="false"
                             valueFromSelect="true"
                             nullItemText="请选择..."/>
                       <label class="title required">进厂里程：</label>
                       <input class="nui-Spinner" minValue="0" maxValue="100000000" width="30%" id="enterKilometers" name="enterKilometers" allowNull="false" showButton="false" />
                       <label class="title" id="lastComeKilometers">(上次里程：0)</label>
                  </td>
                  <td class="title required">
                      <label>进厂日期：</label>
                  </td>
                  <td>
                      <input id="enterDate" name="enterDate" class="nui-datepicker" value="" nullValue="null" format="yyyy-MM-dd hh:MM" showTime="true"  showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" width="100%"/>
                      <input id="recordDate" name="recordDate" class="nui-datepicker" visible="false" value="" nullValue="null" format="yyyy-MM-dd hh:MM" showTime="true"  showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" width="100%"/>
                  </td>
                  <td class="title required">
                      <label>预计交车：</label>
                  </td>
                  <td>
                      <input id="planFinishDate" name="planFinishDate" class="nui-datepicker" value="" format="yyyy-MM-dd hh:MM" nullValue="null" timeFormat="HH:mm:ss" showTime="true" showOkButton="false" showClearButton="true" width="100%"/>
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
    <div title="联系人信息" name="contactorTab">
          <div id="sendGuestForm" class="form">
              <table style="width: 100%;    border-spacing: 0px 5px;">
                  <input class="nui-hidden" name="id"/>
                  <input class="nui-hidden" name="guestId"/>
                  <tr>
                      <td class="title required">
                          <label>姓名：</label>
                      </td>
                      <td class=""><input  class="nui-textbox" name="contactorName" id="contactorName" enabled="false"/></td>
                      <td class="title">
                          <label>性别：</label>
                      </td>
                      <td>
                          <input name="sex"
                                 id="sex"
                                 enabled="false"
                                 class="nui-combobox width1"
                                 textField="text"
                                 valueField="id"
                                 emptyText="请选择..."
                                 data="[{id:0,text:'男'},{id:1,text:'女'},{id:2,text:'未知'}]"
                                 allowInput="true"
                                 showNullItem="false"
                                 width="100%"
                                 valueFromSelect="true"
                                 nullItemText="请选择..."/>
                      </td>
                      <td class="title">
                          <label>联系方式：</label>
                      </td>
                      <td >
                          <input class="nui-textbox" enabled="false" width="100%" id="mobile" name="mobile"/>
                      </td>
                      <td class="title">
                          <label>证件号：</label>
                      </td>
                      <td >
                          <input class="nui-textbox" enabled="false" width="100%" id="idNo" name="idNo"/>
                      </td>
                  </tr>
                  <tr>
                      <td class="title">
                          <label>备注：</label>
                      </td>
                      <td colspan="3">
                          <input class="nui-textbox" enabled="false" width="100%" id="contactRemark" name="remark"/>
                      </td>
                  </tr>
              </table>
          </div>
    </div>
    <div title="保险信息" name="insuranceTab">
          <div id="insuranceForm" class="form">
              <table style="width: 100%;height: 60px;">
                  <input class="nui-hidden" name="id"/>
                  <tr>
                      <td class="title ">
                          <label>保险公司：</label>
                      </td>
                      <td >
                          <input class="nui-textbox" enabled="false" width="100%" id="insuranceName" name="insuranceName"/>
                      </td>
                      <td class="title">
                          <label>交强险单号：</label>
                      </td>
                      <td >
                          <input class="nui-textbox" enabled="false" width="100%" id="insureNo" name="insureNo"/>
                      </td>
                      <td class="title">
                          <label>交强险到期：</label>
                      </td>
                      <td width="">
                          <input name="insureDueDate"
                                 id="insureDueDate"
                                 width="100%"
                                 showTime="false"
                                 enabled="false"
                                 class="nui-datepicker" format="yyyy-MM-dd"/>
                      </td>
                  </tr>
              </table>
          </div>
    </div>
    <div title="描述信息" name="describeTab">
        <div id="describeForm" class="form">
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
                                style="width:100%;height: 40px;"></textarea>
                  </td>
                  <td>
                      <textarea class="nui-textarea" name="faultPhen"
                                style="width:100%;height: 40px;"></textarea>
                  </td>
                  <td>
                      <textarea class="nui-textarea" name="solveMethod"
                                style="width:100%;height: 40px;"></textarea>
                  </td>
              </tr>
          </table>
        </div>
    </div>
</div>
    



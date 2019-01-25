<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
  <%@include file="/common/commonRepair.jsp"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2018-09-30 17:18:32
  - Description:
-->

    <head>
      <title>可退配件</title>
      <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
      <script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/returnPart.js?v=1.0.18"></script>
    </head>

    <body>

      <div class="nui-fit">
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
          <table class="table" id="table1">
            <tr>
               <td>
                  <label style="font-family:Verdana;">快速查询：</label>
                  <input class="nui-textbox" emptyText="工单号" width="170" id="search-serviceCode" name="serviceCode" onenter="onSearch"/>
                  <input class="nui-textbox" emptyText="配件编码" width="130" id="search-code" name="partCode" onenter="onSearch"/>
                  <input class="nui-textbox" emptyText="配件名称" width="130" id="search-name" name="partName" onenter="onSearch"/>
                  <span class="separator"></span>
                  <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
               </td>
              <td>
                <a class="nui-button" iconCls="" plain="true" onclick="onOk" id="onOk">
                 <span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
              </td>
            </tr>
          </table>
        </div>
        <!-- oncellcommitedit="onCellCommitEdit"
     ondrawsummarycell="onDrawSummaryCell" -->
        <div class="nui-fit">
          <div id="rpsPartGrid" dataField="list" class="nui-datagrid" 
               style="float:left;height:100%;" 
               showPager="false" 
               showModified="false"
               editNextOnEnterKey="true" 
               allowSortColumn="true" 
               allowCellSelect="true" 
               allowCellEdit="true" 
               allowCellWrap = "true">
            <div property="columns">
              <div headerAlign="center" type="indexcolumn" width="30">序号</div>
              <div header="配件信息" headerAlign="center">
                <div property="columns">
                  <div field="serviceCode" headerAlign="serviceCode" allowSort="false" visible="true" width="130" header="所属工单号"></div>
                  <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称"></div>
                  <div field="partCode" headerAlign="center" allowSort="false" width="80px" header="配件编码"></div>
                  <div field="qty" name="qty" summaryType="sum" numberFormat="0" width="40" headerAlign="center" header="数量"> </div>
                  <div field="pickQty" name="pickQty" summaryType="sum" numberFormat="0" width="50" headerAlign="center" header="已领数量"> </div>
                  <div field="unitPrice" width="50" headerAlign="center" header="单价"></div>
                  <div field="subtotal" summaryType="sum" width="40" headerAlign="center" header="金额"></div>
                  <div field="saleMan" headerAlign="center" allowSort="false" visible="true" width="50" header="销售员" align="center">
                    <input property="editor" enabled="true" dataField="memList" class="nui-combobox" valueField="empName" textField="empName"
                      data="memList" url="" onvaluechanged="onpartsalemanChanged" emptyText="" vtype="required" />
                  </div>
                  <div field="saleManId" headerAlign="center" allowSort="false" visible="false" width="70" header="销售员" align="center">
                  </div>
                  <div field="recordDate" width="100" headerAlign="center" header="购买日期" dateFormat="yyyy-MM-dd HH:mm"> </div>
                </div>
              </div>
            </div>
          </div>
          <div id="splitDiv2" style="float:left;width:1%;height:100%;display:none"></div>
          <div id="tempGrid2" class="nui-datagrid" style="float:left;width:20%;height:100%;display:none" showPager="false" pageSize="1000"
            selectOnLoad="true" showModified="false" onrowdblclick="" multiSelect="true" dataField="parts" url="">
            <div property="columns">
              <div type="indexcolumn" width="20px" headerAlign="center">序号</div>
              <div header="已添加配件" headerAlign="left">
                <div property="columns">
                  <div type="checkboxcolumn" field="check" trueValue="1" falseValue="0" width="20" headerAlign="center" header="">操作
                  </div>
                  <div field="partName" headerAlign="center" allowSort="true" width="80px">配件名称</div>
                  <div field="id" headerAlign="center" allowSort="true" width="20px" visible="false">id</div>
                </div>
              </div>
            </div>
          </div>

        </div>

      </div>
      <script type="text/javascript">
        nui.parse();
      </script>
    </body>

    </html>
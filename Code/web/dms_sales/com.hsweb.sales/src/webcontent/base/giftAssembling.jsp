<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-10 08:49:01
  - Description:
-->

    <head>
        <title>精品加装</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <%@include file="/common/commonRepair.jsp"%>
        <script src="<%=webPath + contextPath%>/sales/base/js/giftAssembling.js?v=1.3.6"></script>
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
        
        .td_title {
            width: 90px;
            text-align: right;
        }
        
        .textbox {
            height: 20px;
            margin: 0;
            padding: 0 2px;
            box-sizing: content-box;
        }
        
        .textbox .textbox-text {
            white-space: pre-wrap!important;
        }
    </style>

    <body>
        <input name="serviceTypeId" id="serviceTypeId" class="nui-combobox " textField="name" valueField="id" visible="false"/>
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
            <table style="width:100%;">
                <tr>
                    <td style="white-space:nowrap;">
                        <label style="font-family:Verdana;">快速查询：</label>
                        <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>

                        <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                            <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
                            <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
                            <li class="separator"></li>
                            <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                            <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
                            <li class="separator"></li>
                            <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
                            <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
                            <li class="separator"></li>
                            <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
                            <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
                        </ul>
                        单据日期：<input id="startDate" name="startDate"style="width: 100px" editable="false" class="nui-datepicker" />
                        至<input id="endDate" name="endDate"style="width: 100px" editable="false" class="nui-datepicker" />
                        <a class="nui-button" iconCls="" plain="true" onclick="search()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="newAdd()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="updateMainStatus(1)" id="deletBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="updateMainStatus(0)" id="deletBtn"><span class="fa fa-close fa-lg"></span>&nbsp;反审</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>

                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div class="mini-splitter" style="width:100%;height:100%;">
                <div size="38%" showCollapseButton="true">
                    <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="false" showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
                        allowCellWrap="true" url="">
                        <div property="columns">
                            <div type="indexcolumn">序号</div>
                            <div field="status" name="" width="100px" headerAlign="center" header="状态"></div>
                            <div field="guestName" name="" width="100px" headerAlign="center" header="客户名称"></div>
                            <div field="vin" name="" width="100px" headerAlign="center" header="车架号(VIN)"></div>
                            <div field="sellType" name="" width="100px" headerAlign="center" header="销售类型"></div>
                            <div field="recordDate" name="" width="100px" headerAlign="center" header="单据日期" dateFormat="yyyy-MM-dd"></div>
                        </div>
                    </div>
                </div>
                <div showCollapseButton="true" id="form1">
                    <fieldset id="fd9" style="width:99%;">
                        <legend><span>基本信息：</span></legend>
                        <input id="id" name="id" class="nui-textbox" allowInput="false" visible="false"/>
                        <input id="status" name="status" class="nui-textbox" allowInput="false" visible="false"/>
                        <input id="carNo" name="carNo" class="nui-textbox" allowInput="false" visible="false"/>
                        <input id="giftServiceCode" name="giftServiceCode" class="nui-textbox" allowInput="false" visible="false"/>
                        <table style="line-height: 23px; padding-top: 10px;width: 100%">
                            <tr>
                                <td class="td_title">
                                    销售类型：
                                </td>
                                <td>
                                    <input id="sellType" name="sellType"  style="width: 100%" class="nui-combobox" required="true"
                                    data="sellTypeArr" valueField="id" textField="text" allowInput="false" value="2" onvaluechanged="sellTypeChanged">
                                </td>
                                <td class="td_title" >
                                    销售单编码：
                                </td>
                                <td>
                                    <input id="saleCode" name="saleCode" class="nui-buttonedit" 
                                    allowInput="false" required="true" style="width: 100%" onbuttonclick="onSaleEdit" />
                                    <input id="saleId" name="saleId" class="nui-textbox" allowInput="false" visible="false" style="width: 100%"/>
                                </td>
                                <td class="td_title" style="width:;">
                                    库存车ID：
                                </td>
                                <td>
                                    <input id="enterId" name="enterId" class="nui-buttonedit" 
                                    allowInput="false" required="true" style="width: 100%;" onbuttonclick="onEnterIdEdit" />
                                </td>
                            </tr>
                            <tr>
                                <td class="td_title">
                                    车架号(VIN)：
                                </td>
                                <td>
                                    <input id="vin"name="vin" style="width: 100%" class="nui-textbox" enabled="false"/>
                                </td>
                         
                                <td class="td_title">
                                    车型全称：
                                </td>
                                <td colspan="1" style="width:250px;">
                                    <input id="carModelName" name="carModelName"  style="width: 100%" class="nui-textbox" enabled="false"/>
                                </td>
                                <td class="td_title">
                                    客户名称：
                                </td>
                                <td>
                                    <input id="guestId" name="guestId" style="width: 100%" class="nui-textbox" enabled="false" visible="false"/>
                                    <input id="guestName" name="guestName" style="width: 100%" class="nui-textbox" enabled="false"/>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">备注：
                                </td>
                                <td colspan="5">
                                    <input id="remark"name="remark" style="width: 100%;height:80px" class="nui-textarea" multiline="true" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <div class="nui-fit">
                        <div class="mini-tabs" activeIndex="0" style="width:100%;height:100%;">
                            <div title="工时信息">
                                <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                                    <table style="width:100%;">
                                        <tr>
                                            <td style="white-space:nowrap;">
                                                <a class="nui-button" iconCls="" plain="true" onclick="addItem()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                                                <a class="nui-button" iconCls="" plain="true" onclick="removeItem()" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                                                <a class="nui-button" iconCls="" plain="true" onclick="saveItem()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="nui-fit">

                                        <!-- <div id="dgGrid" class="nui-datagrid" style="width:100%;height:100%;" dataField="list" sortMode="client"
                                        allowCellSelect="true" allowCellEdit="true" showModified="false"
                                        style="width: 100%; height: 100%;" pageSize="20" pageList='[10,20,50,100]' showPageInfo="true"
                                        totalField="page.count" > -->
                                        <input id="worker" name="worker"  class="nui-combobox " textField="empName" valueField="empId"
                                        emptyText=""   allowInput="true" visible="false"/>
                                    <div id="itemGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="false" 
                                    showPager="true" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] 
                                    dataField="list" showModified="false" onrowdblclick="" allowCellSelect="true" 
                                    editNextOnEnterKey="true"  allowCellWrap="true" url="" allowCellEdit="true" >
                                        <div property="columns">
                                            <div type="indexcolumn">序号</div>
                                            <div field="itemId" name=""  header="工时ID" visible="false"></div>
                                            <div field="itemCode" name="" header="工时编码"  visible="false"></div>
                                            <div field="itemName" name="" width="100px" headerAlign="center" header="工时名称"></div>
                                            <div field="amt" name="" width="100px" headerAlign="center" header="金额小计"></div>
                                            <div field="itemTime" name="" width="100px" headerAlign="center" header="工时"></div>
                                            <div field="deductAmt" name="" width="100px" headerAlign="center" header="提成金额">
                                                    <input property="editor" class="nui-textbox" />
                                            </div>
                                            <div field="receType" name="" width="100px" headerAlign="center" header="收费类型">
                                                    <input property="editor" class="nui-textbox" />
                                            </div>
                                            <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="100px" align="center">业务类型
                                                <input  property="editor" enabled="true" dataField="servieTypeList" 
                                                         class="nui-combobox" valueField="id" textField="name" data="servieTypeList"
                                                         url="" onvaluechanged="" emptyText=""  vtype="required" width="60%"/> 
                                            </div>
                                            <div field="workerId" name="workerId"  headerAlign="center" visible="false" header="承修人Id"></div>
                                            <!-- <div field="" name="" width="100px" headerAlign="center" header="班组"></div> -->
                                            <div field="worker" name="" width="100px" headerAlign="center" header="承修人">
                                                <input property="editor"   class="nui-combobox " textField="empName" valueField="empName"
                                                emptyText=""   allowInput="true" showNullItem="false" valueFromSelect="true" onValueChanged="workChanged"/>
                                            </div>
                                            <div field="remark" name="" width="100px" headerAlign="center" header="备注">
                                                <input property="editor" class="nui-textarea" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div title="精品信息">
                                <div class="nui-fit">
                                        <div id="jpDetailGrid" class="nui-datagrid" style="width:100%;height:100%;" oncellcommitedit="onCellCommitEdit" showSummaryRow="true" selectOnLoad="false" allowcelledit="true" showPager="false" pageSize="50" totalField="page.count" sizeList=[20,50,100,200]
                                        dataField="data" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true" allowCellWrap="true" url="">
                                        <div property="columns">
                                            <div type="indexcolumn">序号</div>
                                            <div field="giftName" name="giftName" width="100px" headerAlign="center" header="精品名称"></div>
                                            <div field="receType" name="receType" width="100px" headerAlign="center" header="收费类型">
                                            </div>
                                            <div field="qty" name="qty" width="100px" headerAlign="center" header="数量">
                                            </div>
                                            <div field="price" name="price" width="100px" headerAlign="center" header="单价">
                                            </div>
                                            <div field="amt" name="amt" width="100px" headerAlign="center" header="金额" summaryType="sum">
                                            </div>
                                            <div field="costAmt" name="costAmt" width="100px" headerAlign="center" header="成本金额">
                                            </div>
                                            <div field="remark" name="remark" width="100px" headerAlign="center" header="备注内容">
                                            </div>
                                        </div>
                                    </div>


                                </div>
                            </div>
                            <div title="已出库精品">
                                     <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                                    <table style="width:100%;">
                                        <tr>
                                            <td style="white-space:nowrap;">
                                                <a class="nui-button" iconCls="" plain="true" onclick="selectGift()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;领料</a>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                    <div class="nui-fit">

                                            <div id="repairOutGrid" class="nui-datagrid" style="width:100%;height:100%; " showPager="false" 
                                            dataField="data"  allowCellSelect="true" multiSelect="false" allowCellWrap = true
                                            url=""  showModified="false" showSummaryRow="true"
                                            allowCellEdit="true"  >
                                            <div property="columns">
                                               <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                               <div type="checkcolumn" width="30" ></div>
                                                    <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称"></div>
                                                    <div field="partCode" headerAlign="center" allowSort="false" visible="true" width="80px" header="配件编码" ></div>           
                                                    <div field="outQty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="int" align="center" header="数量" summaryType="sum"></div>
                                                    <div field="unit" headerAlign="center" allowSort="false" visible="false" width="80px" header="单位"></div>           
                                                    <div field="sellUnitPrice" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="销售单价"></div>
                                                    <div field="sellAmt" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="销售金额" summaryType="sum"></div>
                                                    <div field="trueUnitPrice" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="成本单价"></div>
                                                    <div field="trueCost" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="成本金额" summaryType="sum"></div>
                                                    
                                                    <div field="storeId" headerAlign="center" allowSort="false" visible="true" width="70" align="center" header="仓库"></div>
                                                    <div field="returnSign" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="是否归库" renderer="onGenderRenderer"></div>
                                                    <div field="pickMan" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="领料人"></div>
                                                    <div field="pickDate" headerAlign="center" allowSort="false" visible="true" width="100" align="center" header="领料日期" dateFormat="yyyy-MM-dd"></div>
                                                    <div field="remark" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="领料备注"></div>
                                                    <div field="recorder" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="操作人"></div>
                                             
                                                    <div field="returnMan" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="归库人"></div>
                                                    <div field="returnDate" headerAlign="center" allowSort="false" visible="true" width="100" align="center" header="归库日期" dateFormat="yyyy-MM-dd"></div>
                                                    <div field="returnRemark" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="归库备注"></div>
                                                    <div field="action" name="action" width="40" headerAlign="center" header="操作" align="center" align="center"></div>
                                            </div>
                                            </div>
                                        </div>
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
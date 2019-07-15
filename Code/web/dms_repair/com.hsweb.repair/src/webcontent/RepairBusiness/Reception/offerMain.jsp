<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
    <%@include file="/common/commonRepair.jsp"%>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>
        <!-- 
  - Author(s): Administrator
  - Date: 2019-07-12 16:27:47
  - Description:
-->

        <head>
            <title>配件报价</title>
            <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
                    	<script src="<%=request.getContextPath()%>/coframe/imjs/message.js"></script>
	<script src="<%=request.getContextPath()%>/coframe/imjs/messagebody.js"></script>
            <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/offerMain.js?v=1.2.6"></script>
            <style type="text/css">
                body {
                    margin: 0;
                    padding: 0;
                    border: 0;
                    width: 100%;
                    height: 100%;
                    overflow: hidden;
                }

                .btnType {
                    font-family: Verdana;
                    font-size: 14px;
                    text-align: center;
                    height: 40px;
                    width: 120px;
                    line-height: 40px;
                }

                .title {
                    width: 80px;
                    text-align: right;
                }

                .required {
                    color: red;
                }

                #guestInfo a:link {
                    font-size: 12px;
                    color: #578ccd;
                    text-decoration: none;
                }

                #guestTab a:link {
                    font-size: 12px;
                    color: #578ccd;
                    text-decoration: none;
                }

                #guestInfo a:visited {
                    font-size: 12px;
                    color: #578ccd;
                    text-decoration: none;
                }

                #guestInfo a:hover {
                    font-size: 12px;
                    color: #578ccd;
                    text-decoration: underline;
                }

                #wechatTag {
                    color: #62b900;
                }

                #wechatTag1 {
                    color: #ccc;
                }

                #eTag {
                    color: #62b900;
                }

                #eTag1 {
                    color: #ccc;
                }

                /* font-family:Verdana;color:white;background:#62b900;padding:0px 8px;border-radius:90px; display:block;  padding:4px 15px;*/

                a.healthview {
                    background: #78c800;
                    font-size: 13px;
                    color: #fff;
                    text-decoration: none;
                    padding: 0px 8px;
                    border-radius: 20px;
                }

                a.healthview:hover {
                    background: #f00000;
                    color: #fff;
                    text-decoration: none;
                }

                a.chooseClass {
                    background: #578ccd;
                    font-size: 13px;
                    color: #fff;
                    text-decoration: none;
                    padding: 0px 8px;
                    border-radius: 20px;
                }

                a.chooseClass:hover {
                    background: #f00000;
                    color: #fff;
                    text-decoration: none;
                }

                a.optbtn {
                    width: 52px;
                    /* height: 26px; */
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

                .statusview {
                    background: #78c800;
                    color: #fff;
                    padding: 3px 20px;
                    border-radius: 20px;
                }

                .nvstatusview {
                    color: #5a78a0;
                    padding: 3px 20px;
                    border-radius: 20px;
                    border: 1px solid;
                }

                .bottomfont {
                    font-size: 20px;
                }

                .showhealthcss {
                    color: #5a78a0;
                    padding: 3px 20px;
                    border: 1px solid;
                }

                #comment_bubble {

                    width: 140px;
                    height: 100px;
                    background: #78c800c2;
                    position: relative;
                    -moz-border-radius: 12px;
                    -webkit-border-radius: 12px;
                    border-radius: 12px;
                }

                /*  #search:before {
    content: "";
    width: 0;
    height: 0;
    right: 100%;
    top: 12px;
    position: absolute;
    border-top: 8px solid transparent;
    border-right: 18px solid #cac52afc;
    border-bottom: 8px solid transparent;
}   */

                .tishi {
                    margin-top: 5px;
                }

                .btn .mini-buttonedit {
                    height: 36px;
                }

                .btn .aa {
                    height: 36px;
                    width: 300px;
                }

                .btn .mini-buttonedit .mini-corner-all {
                    height: 33px;
                    background: #368bf447;
                }

                .btn .aa .mini-corner-all {
                    height: 33px;
                }

                .mini-corner-all .nui-textbox {
                    height: 30px;
                }

                .btn .mini-corner-all .mini-buttonedit-input {
                    font-size: 16px;
                    margin-top: 8px;

                }

                .btn .mini-corner-all .mini-textbox-input {
                    font-size: 14px;
                    margin-top: 8px;

                }
            </style>
        </head>

        <body>

            <div class="nui-fit">
                <div class="mini-splitter" style="width:100%;height:100%;">
                    <div size="24%" showCollapseButton="true">
                        <div class="nui-fit">
                       		<div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
							    <table style="width:100%;">
						            <tr>
						                 <td>
						                 	<input class="nui-textbox" id="carNo" emptyText="车牌号" width="70px"  onenter="onSearch"/>
						                 	<input class="nui-textbox" id="serviceCode" emptyText="工单号" width="120px"  onenter="onSearch"/>
						                 	<a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
						 				</td>
							        </tr>
							    </table>
							</div>
                            <div id="mainGrid1" class="nui-datagrid" style="width:100%;height:90%;float:left;" showPager="false" 
                                 ondrawcell="" dataField="list" virtualColumns="true" onrowdblclick="" idField="id"
                                sortMode="client" allowSortColumn="true" showSummaryRow="true">
                                <div property="columns">
                                    <div type="indexcolumn" width="40" summaryType="count">序号</div>
                                    <div field="serviceCode" width="160" headerAlign="center" allowSort="true" dataType="string">工单号</div>
                                    <div field="carNo" width="70" headerAlign="center" allowSort="true" dataType="string">车牌号</div>
                                    <div field="noMtFileSign" width="60" headerAlign="center" allowSort="true" dataType="string">报价状态</div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div>
                        <div class="mini-splitter" vertical="true" style="width:100%;height:100%;">
                            <div size="60%" showCollapseButton="true">
                                <div class="nui-fit">
                                    <div class="nui-toolbar" style="width:76%;padding:2px;border-bottom:0;" id="queryForm">
                                        <table style="width:76%;">
                                            <tr>
                                                <td>
                                                    <a class="nui-button" plain="true" onclick="save()" id="" enabled="true">
                                                        <span class="fa fa-save fa-lg"></span>&nbsp;保存报价</a>
                                                    <a class="nui-button" plain="true" onclick="releaseOfferRemind()" id="" enabled="true">
                                                        <span class="fa fa-bell fa-lg"></span>&nbsp;发布报价</a>  
                                                      <div id="sendWechat" name="" class="nui-checkbox" readOnly="false" text="推送微信"  trueValue="1" falseValue="0"></div>
		  											 <div id="sendApp" name="" class="nui-checkbox" readOnly="false" text="推送APP"    trueValue="1" falseValue="0"></div>      
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="rpsItemGrid" borderStyle="border-bottom:1;" class="nui-datagrid" dataField="list" style="float:left;width:76%; height:90%;"
                                        showPager="false" showModified="false" allowSortColumn="true" ondrawsummarycell="onDrawSummaryCellItem" onrowdblclick=""
                                        editNextOnEnterKey="false">
                                        <div property="columns">
                                            <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
                                            <div field="prdtName" name="prdtName" headerAlign="center" allowSort="false" visible="true" width="100">项目名称</div>
                                             <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="50" align="center">业务类型
                                                <input property="editor" enabled="true" dataField="servieTypeList" class="nui-combobox" valueField="id" textField="name"
                                                    data="servieTypeList" url="" onvaluechanged="onValueChangedItemTypeId" emptyText=""
                                                    vtype="required" width="60%" />
                                            </div>
                                            <div field="qty" headerAlign="center" allowSort="false" visible="true" width="30" datatype="float" align="center" name="itemItemTime">工时/数量
                                                <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedComQty" selectOnFocus="true" width="60%"
                                                />
                                            </div>
                                            <div field="planFinishDate" headerAlign="center" allowSort="false" visible="false" width="40" datatype="float" align="center"
                                                name="planFinishDate">
                                                工时预计完工时间
                                            </div>
                                            <div field="unitPrice" name="itemUnitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float"
                                                align="center">单价
                                                <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedItemUnitPrice" selectOnFocus="true"
                                                    width="60%" />
                                            </div>
                                            <div field="rate" name="itemRate" headerAlign="center" allowSort="false" visible="true" width="50" datatype="float" align="center">
                                                优惠率%
                                                <a href="javascript:setItemPartRate()" title="批量设置优化率" style="text-decoration:none;">&nbsp;&nbsp;
                                                    <span class="fa fa-edit fa-lg"></span>
                                                </a>
                                                <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedItemRate" selectOnFocus="true" width="60%"
                                                />
                                            </div>
                                            <div field="subtotal" name="itemSubtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float"
                                                align="center">金额
                                                <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedItemSubtotal" selectOnFocus="true"
                                                    width="60%" />
                                            </div>
                                            <div field="amt" name="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">项目总金额
                                            </div>
                                            <div field="remark" headerAlign="center" name="remark" allowSort="false" visible="true" width="80" header="备注" align="center">
                                                <input class="nui-textbox" property="editor" id="remark" name="remark" onvaluechanged="remarkChang" width="80%" />
                                            </div>
                                            <div field="itemOptBtn" name="itemOptBtn" width="80" headerAlign="center" header="操作" align="center"></div>
                                        </div>
                                    </div>
                                    <div id="billForm" class="form" style="float:left;width:24%; height:90%;">
                                        <table style="width: 100%;border-spacing: 0px 5px;">
                                            <input name="id" class="nui-hidden" id="mainId" />
                                            <input name="guestId" class="nui-hidden" />
                                            <input id="mtAdvisor" name="mtAdvisor" class="nui-hidden" />
                                            <input class="nui-hidden" name="contactorId" />
                                            <input class="nui-hidden" name="carId" />
                                            <input class="nui-hidden" name="status" />
                                            <input class="nui-hidden" name="drawOutReport" />
                                            <input class="nui-hidden" name="contactorName" />
                                            <input class="nui-hidden" name="carModel" />
                                            <input class="nui-hidden" name="identity" />
                                            <input class="nui-hidden" name="billTypeId" />
                                            <input class="nui-hidden" name="status" />
                                            <input class="nui-hidden" name="isSettle" />
                                            <!-- <input class="nui-hidden" name="isOutBill"/> -->
                                            <input class="nui-hidden" name="carModelIdLy" />
                                            <input class="nui-hidden" name="balaAuditor" />
                                            <input class="nui-hidden" name="balaAuditSign" />
                                            <div allowSort="true" field="storeId" width="100" headerAlign="center" header="仓库" style="display:none;"></div>
                                            <tr>
                                                <td class="title" width="40%">
                                                    <label>车&nbsp;牌&nbsp;&nbsp;号：</label>
                                                </td>
                                                <td class="">
                                                    <input class="nui-textbox" name="carNo"  enabled="false" width="100%" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="title">
                                                    <label>进厂时间：</label>
                                                </td>
                                                <td style="width:60%">
                                                    <input id="enterDate" name="enterDate" enabled="false" class="nui-datepicker" value="" nullValue="null" format="yyyy-MM-dd HH:mm"
                                                        showTime="true" showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss"
                                                        width="100%" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="title">
                                                    <label>品牌车型：</label>
                                                </td>
                                                <td class="" colspan="1">
                                                    <input class="nui-textbox" name="carModel" id="carModel" enabled="false" width="100%" />
                                                    <!--                             <input  class="nui-textbox" name="carBrandModel" id="carBrandModel" enabled="false" width="100%"/>
 -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="title">
                                                    <label>车架号(VIN)：</label>
                                                </td>
                                                <td class="" colspan="1">
                                                    <input class="nui-textbox" name="carVin" id="carVin" enabled="false" width="100%" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="title">
                                                    <label>业务类型：</label>
                                                </td>
                                                <td>
                                                    <input name="serviceTypeId" id="serviceTypeId" class="nui-combobox width1" textField="name" valueField="id" emptyText="请选择..."
                                                        url="" allowInput="true" showNullItem="false" enabled="false" width="100%" valueFromSelect="true"
                                                        nullItemText="请选择..." />
                                                </td>
                                            </tr>
<!--                                             <tr>
                                                <td class="title">
                                                    <label>进厂油量：</label>
                                                </td>
                                                <td> -->
                                                    <input class="nui-combobox" id="enterOilMass" emptyText="请选择..." name="enterOilMass" data="[{enterOilMass:'F',text:'F'},{enterOilMass:'3/4',text:'3/4'},{enterOilMass:'1/2',text:'1/2'},{enterOilMass:'1/4',text:'1/4'},{enterOilMass:'N',text:'N'}]"
                                                        width="100%" textField="text" enabled="false" valueField="enterOilMass" value="" style="display:none;"/>
<!-- 
                                                </td>
                                            </tr> -->
 <!--                                            <tr>
                                                <td class="title">
                                                    <label>进厂里程：</label>
                                                </td>
                                                <td> -->
                                                    <input class="nui-Spinner " decimalPlaces="0" minValue="0" maxValue="1000000000" width="30%" id="enterKilometers" name="enterKilometers"
                                                        allowNull="false" showButton="false" enabled="false" style="display:none;" />
                                                    <label class="title"><!-- (上次里程：
                                                        <span id="lastComeKilometers">0</span>)</label>
                                                </td>
                                            </tr> -->
                                            <tr>
                                                <td class="title">
                                                    <label>预计交车：</label>
                                                </td>
                                                <td>
                                                    <input id="planFinishDate" name="planFinishDate" class="nui-datepicker" value="" format="yyyy-MM-dd HH:mm" nullValue="null"
                                                        timeFormat="HH:mm:ss" showTime="true" enabled="false" showOkButton="false" showClearButton="true"
                                                        width="100%" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="title">
                                                    <label>服&nbsp;务&nbsp;&nbsp;顾&nbsp;问：</label>
                                                </td>
                                                <td>
                                                    <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId" emptyText="请选择..."
                                                        url="" allowInput="true" showNullItem="false" enabled="false" width="100%" valueFromSelect="true"
                                                        nullItemText="请选择..." />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="title">
                                                    <label>备注：</label>
                                                </td>
                                                <td>
                                                    <input class="nui-textbox" width="100%" enabled="false" id="remark" name="remark" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                            </div>
                            <div>
                                <div id="mainTabs" class="nui-tabs" name="mainTabs" activeIndex="0" style="width:100%; height:100%;" plain="false" onactivechanged="activechangedmain()" >
                                    <div title="出库记录" id="queryRepairOutList" name="queryRepairOutList">
											<div id="queryRepairOutListGrid" class="nui-datagrid" style="width:100%;height:100%;"
											    showPager="true"
											    dataField="list"
											    idField="partId"
											    sortMode="client"
											    pageSize="100"
											    showSummaryRow="true"
											    totalField="page.count" 
											    sizeList=[50,100,500,1000] 
											     onrowdblclick="" 
											     allowCellWrap = true
											    frozenStartColumn="0"
											    frozenEndColumn="0"
											    sortMode="client"
											    >
											    <div property="columns">
											        <div type="indexcolumn">序号</div>
										            	<div allowSort="true" field="serviceCode" name="serviceCode" width="180" headerAlign="center" header="业务单号" ></div>
										            	<div allowSort="true" field="carNo" name="carNo" width="100" headerAlign="center" header="车牌号" ></div>
										            	<div allowSort="true" field="serviceTypeId" name="serviceTypeId" width="100" headerAlign="center" header="业务类型" ></div>
										            	<div allowSort="true" field="storeId" width="100" headerAlign="center" header="仓库" ></div>
										                <div allowSort="true" field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码" ></div>
										                <div allowSort="true" field="partName" name="partName" width="150" headerAlign="center" header="配件名称" ></div>
										                <div allowSort="true" field="oemCode" width="100" headerAlign="center" header="OEM码" ></div>
										                <div allowSort="true" field="outQty" summaryType="sum" name="outQty" width="100" headerAlign="center"  dataType="float" header="数量" ></div>	
										                <div summaryType="sum" allowSort="true" field="trueUnitPrice" width="60" headerAlign="center" header="成本单价" datatype="float" align="left"></div>
                										<div summaryType="sum" allowSort="true" field="trueCost" headerAlign="center" header="成本金额" dataType="float" align="left"></div>
										                <div allowSort="true" summaryType="sum" allowSort="true" field="sellUnitPrice" width="60" headerAlign="center" header="销售单价" dataType="float" align="left"></div>
                										<div allowSort="true" summaryType="sum" allowSort="true" field="sellAmt" headerAlign="center" header="销售金额" dataType="float" align="left"></div>	
                                						<div allowSort="true" summaryType="sum" allowSort="true" field="gross" width="80" headerAlign="center" header="毛利" dataType="float" align="left"></div>									        
 								                		<div allowSort="true"  field="pickMan" width="60" name="pickMan" headerAlign="center" header="出库人" dataType="float" align="left"></div>
                										<div allowSort="true" width="130"  dateFormat="yyyy-MM-dd HH:mm" field="pickDate" headerAlign="center" header="出库日期" dataType="float" align="left"></div>
											        
											    </div>
											</div>
                                    </div>
                                    <div title="入库记录" id="queryPjPchsOrderEnterDetailChkList" name="queryPjPchsOrderEnterDetailChkList">
										<div id="queryPjPchsOrderEnterDetailChkListGrid" class="nui-datagrid" style="width:100%;height:100%;"
										    showPager="true"
										    dataField="detailList"
										    idField="partId"
										    sortMode="client"
										    pageSize="100"
										    showSummaryRow="true"
										    totalField="page.count" 
										    sizeList=[50,100,500,1000] 
										     onrowdblclick="" 
										     allowCellWrap = true
										    frozenStartColumn="0"
										    frozenEndColumn="0"
										    sortMode="client"
										    >
										    <div property="columns">
										        <div type="indexcolumn">序号</div>
										        <div allowSort="true" field="manualCode" width="180" summaryType="count" headerAlign="center" header="入库单号"></div>
							                    <div allowSort="true" field="comPartCode" headerAlign="center" header="配件编码"></div>
							                    <div allowSort="true"width="100" field="comPartName" headerAlign="center" header="配件名称"></div>
							                    <div field="guestFullName" name="guestFullName" width="180" headerAlign="center" header="供应商" allowSort="true"></div>
							                    <div field="orderMan" name="orderMan" width="60" headerAlign="center" header="采购员"></div>
							                    <div allowSort="true" field="enterDate"width="140" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
							                    <div allowSort="true" field="storeId" width="90" headerAlign="center" header="仓库"></div>	
							                    <div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
							                    <div allowSort="true" field="partBrandId" width="80" headerAlign="center" header="品牌"></div>	
							                    <div allowSort="true" datatype="float" summaryType="sum" field="enterQty" width="60" headerAlign="center" header="入库数量"></div>
							                    <div allowSort="true" datatype="float" field="enterPrice" width="60" headerAlign="center" header="入库单价"></div>
							                    <div allowSort="true" datatype="float" summaryType="sum" field="enterAmt" width="60" headerAlign="center" header="入库金额"></div>
							                    <div allowSort="true" datatype="float" summaryType="sum" field="outableQty" width="60" headerAlign="center" header="剩余库存"></div>
							                    <div allowSort="true" field="detailRemark" width="120" headerAlign="center" header="备注"></div>	
							                    <div allowSort="true" datatype="float" field="suggSellPrice" width="60" headerAlign="center" header="建议售价"></div>							   										      										        
										    </div>
										</div>
                                    </div>
                                    <div title="本店库存" id="queryPartStoreStock" name="queryPartStoreStock">
										  <div id="queryPartStoreStockGrid" class="nui-datagrid" style="width:100%;height:100%;"
									         showPager="true"
									         dataField="detailList"
									         idField="detailId"
									         ondrawcell="onDrawCell"
									         sortMode="client"
									         url=""
									         allowCellWrap = true
									         pageSize="1000"
									         sizeList="[1000,2000,5000]"
									         contextMenu="#gridMenu"
									         showSummaryRow="true">
									        <div property="columns">
									            <div type="indexcolumn"  width="40">序号</div>
							                    <div allowSort="true" field="comPartCode" width="120" headerAlign="center" header="配件编码"></div>
							                    <div allowSort="true" field="comPartFullName" width="150" headerAlign="center" header="配件全称"></div>
							                    <div allowSort="true" field="comOemCode" width="150"headerAlign="center" header="OEM码"></div>
							                    <div allowSort="true" field="partBrandId" width="90" headerAlign="center" header="品牌"></div>
							                    <div allowSort="true" field="applyCarModel" width="200" headerAlign="center" header="品牌车型"></div>
							                    <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
							                    <div allowSort="true" field="storeId" width="100" headerAlign="center" header="仓库"></div>
							                    <div allowSort="true" field="shelf" width="60" headerAlign="center" header="仓位"></div>
					                    		<div allowSort="true" datatype="float" field="stockQty" summaryType="sum" width="70" headerAlign="center" header="数量"></div>
							                    <div allowSort="true" datatype="float" field="costPrice" width="70" headerAlign="center" header="单价"></div>
							                    <div allowSort="true" datatype="float" field="stockAmt" summaryType="sum" width="70" headerAlign="center" header="金额"></div>
							                    <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可售数量"></div>
							                    <div allowSort="true" datatype="float" field="sellPrice" width="70" headerAlign="center" header="建议售价"></div>
							                    <div allowSort="true" datatype="float" field="orderQty" visible="false" summaryType="sum" width="70" headerAlign="center" header="开单数量"></div>
							                    <div allowSort="true" datatype="float" field="onRoadQty" visible="false" summaryType="sum" width="60" headerAlign="center" header="在途数量"></div>
							                    <div allowSort="true" field="lastEnterDate" headerAlign="center" header="最近入库日期"  width="120" dateFormat="yyyy-MM-dd HH:mm"></div>
							                    <div allowSort="true" field="lastOutDate" headerAlign="center" header="最近出库日期" width="120" dateFormat="yyyy-MM-dd HH:mm"></div>
									        </div>
									    </div>
                                    </div>
                                    <div title="4s店参考价" id="returnMain" name="returnMain">

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
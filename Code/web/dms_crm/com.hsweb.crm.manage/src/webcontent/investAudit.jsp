<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	 <%@include file="/common/sysCommon.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>业绩审核</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
   <script src="<%=webPath + contextPath%>/manage/js/investAudit.js?v=1.0.1"></script>
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
                    <a class="nui-button"  plain="true" onclick="search()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onAuditClick(1)"><span class="fa fa-check fa-lg"></span>&nbsp;审核通过</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onAuditClick(2)"><span class="fa fa-remove fa-lg"></span>&nbsp;审核不通过</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onDeleteClick()"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
        <div class="nui-splitter" allowResize="false" style="width:100%;height:100%;">
            <div size="70%" showCollapseButton="false">
                <div id="investGrid" class="nui-datagrid" style="width:100%;height:100%;"
                    pageSize="50"
                    multiSelect="false"
                    totalField="page.count"
                    sizeList=[20,50,100,200]
                    dataField="list"
                    onrowdblclick=""
                    allowCellSelect="true"
                    ondrawcell="onDrawcell"
                    onrowclick="onRowclick"
                   >
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
            <div size="450px" showCollapseButton="false">
            	<div id="infoTab" class="nui-tabs" style="height:100%">
            		<div title="基本信息">
            			<table id="basicInfo" style="margin:0 5px;">
            				<tr>
                				<td style="width:80px;text-align:right;"><span>客户名称:</span></td>
								<td><input name="guestName" style="width:130px;" class="nui-textbox"/></td>
								<td style="width:80px;text-align:right;"><span>客户电话:</span></td>
								<td><input name="guestMobile" style="width:130px;" class="nui-textbox"/></td>
            				</tr>
            				<tr>
                				<td style="width:80px;text-align:right;"><span>联系人:</span></td>
								<td><input name="contactName" style="width:130px;" class="nui-textbox"/></td>
								<td style="width:80px;text-align:right;"><span>联系电话:</span></td>
								<td><input name="contactMobile" style="width:130px;" class="nui-textbox"/></td>
            				</tr>
            				<tr>
                				<td style="width:80px;text-align:right;"><span>身份证:</span></td>
								<td><input name="contactIdNo" style="width:130px;" class="nui-textbox"/></td>
								<td style="width:80px;text-align:right;"><span>来厂次数:</span></td>
								<td><input name="compComeTimes" style="width:130px;" class="nui-textbox"/></td>
            				</tr>
            				<tr>
                				<td style="width:80px;text-align:right;"><span>车牌号:</span></td>
								<td><input name="carNo" style="width:130px;" class="nui-textbox"/></td>
								<td style="width:60px;text-align:right;"><span>品牌:</span></td>
								<td><input id="carBrandIdEl" name="carBrandId" style="width:130px;" textField="name" valueField="id" class="nui-combobox" /></td>
            				</tr>
            				<tr>
                				<td style="width:80px;text-align:right;"><span>车型:</span></td>
								<td><input name="carModel" style="width:130px;" class="nui-textbox"/></td>
								<td style="width:80px;text-align:right;"><span>发动机:</span></td>
								<td><input name="engineNo" style="width:130px;" class="nui-textbox"/></td>
            				</tr>
            				<tr>
                				<td style="width:80px;text-align:right;"><span>底盘号:</span></td>
								<td><input name="vin" style="width:130px;" class="nui-textbox"/></td>
								<td style="width:80px;text-align:right;"><span>是否出单:</span></td>
								<td><input name="isOutBill" style="width:130px;" data="gIsOutBill" class="nui-combobox"/></td>
            				</tr>
            				<tr>
                				<td colspan="4"><hr/></td>
            				</tr>
            				<tr>
                				<td style="width:80px;text-align:right;"><span>业务类型:</span></td>
								<td><input id="serviceTypeIdEl" name="serviceTypeId" style="width:130px;" textField="name" valueField="id" class="nui-combobox" /></td>
								<td style="width:80px;text-align:right;"><span>维修类型:</span></td>
								<td><input name="billTypeId" style="width:130px;" class="nui-textbox"/></td>
            				</tr>
            				<tr>
                				<td style="width:80px;text-align:right;"><span>维修顾问:</span></td>
								<td><input name="mtAdvisor" style="width:130px;" class="nui-textbox"/></td>
								<td style="width:80px;text-align:right;"><span>里程数:</span></td>
								<td><input name="enterKilometers" style="width:130px;" class="nui-textbox"/></td>
            				</tr>
            				<tr>
                				<td style="width:80px;text-align:right;"><span>进厂日期:</span></td>
								<td><input name="enterDate" style="width:130px;" class="nui-datepicker" dateformat="yyyy-MM-dd"/></td>
								<td style="width:80px;text-align:right;"><span>离场日期:</span></td>
								<td><input name="outDate" style="width:130px;" class="nui-datepicker" dateformat="yyyy-MM-dd"/></td>
            				</tr>
            			</table>
            		</div>
            		<div title="套餐信息">
            			           <div id="rpsPackageGrid" class="nui-datagrid" style="width:100%;height:auto;" dataField="list" showPager="false" showModified="false" allowSortColumn="false" ondrawsummarycell="">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center" name="index" visible="false">序号</div>
                    <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
                    <div header="套餐信息" headerAlign="center">
                        <div property="columns">
                            <div field="prdtName" headerAlign="center" allowSort="false" visible="true" width="100" header="套餐名称"></div>
                            <div field="type" headerAlign="center" allowSort="false" visible="true" width="60" header="项目类型" align="center"></div>
                            <div field="serviceTypeId" headerAlign="center" name="pkgServiceTypeId" allowSort="false" visible="true" width="50" header="业务类型" align="center">
                                <input property="editor" enabled="true" dataField="servieTypeList" class="nui-combobox" valueField="id" textField="name" data="servieTypeList" url="" onvaluechanged="onPkgTypeIdValuechanged" emptyText="" vtype="required" />
                            </div>
                            <div field="subtotal" headerAlign="center" name="pkgSubtotal" allowSort="false" visible="true" width="60" header="套餐金额" align="center">
                                <input property="editor" vtype="float" class="nui-textbox" selectOnFocus="true" onvaluechanged="onPkgSubtotalValuechanged" />
                            </div>
                            <div field="rate" headerAlign="center" name="pkgRate" allowSort="false" visible="true" width="60" header="" align="center">优惠率<a href="javascript:setPkgRate()" title="批量设置优化率" style="text-decoration:none;">  <span class="fa fa-edit fa-lg"></span></a>

                                <input property="editor" width="60%" vtype="float" class="nui-textbox" onvaluechanged="onPkgRateValuechanged" selectOnFocus="true"/>
                            </div>
                            <div field="amt" headerAlign="center" name="pkgAmt" allowSort="false" visible="true" width="60" header="原价" align="center"></div>
                            <div field="workers" headerAlign="center" allowSort="false" visible="true" width="60" header="施工员" align="center" name="workers">
                                <div id="combobox2" property="editor" class="mini-combobox" style="width:250px;" popupWidth="100" textField="empName" valueField="empName" url="" data="memList" value="" multiSelect="true" showClose="true" oncloseclick="onCloseClick" onvaluechanged=""></div>
                            </div>
                            <div field="workerIds" headerAlign="center" allowSort="false" visible="false" width="80" header="施工员" align="center"></div>
                            <div field="saleMan" headerAlign="center" allowSort="false" visible="true" width="50" header="销售员" align="center" name="saleMan">
                                <input property="editor" enabled="true" dataField="memList" class="nui-combobox" valueField="empName" textField="empName" data="memList" url="" onvaluechanged="onsalemanChanged" emptyText="" vtype="required" />
                            </div>
                            <div field="saleManId" headerAlign="center" allowSort="false" visible="false" width="80" header="销售员" align="center"></div>
                            <div field="packageOptBtn" name="packageOptBtn" width="100" headerAlign="center" header="操作" align="center" visible="false"></div>
                        </div>
                    </div>
                </div>
            </div>
            		</div>
            		<div title="维修项目信息" >
            			 <div id="rpsItemGrid" borderStyle="border-bottom:1;" class="nui-datagrid" dataField="list" style="width: 100%; height:auto;" showPager="false" showModified="false" allowSortColumn="true" ondrawsummarycell="">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center" name="index" visible="false">序号</div>
                    <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
                    <div header="项目信息" headerAlign="center">
                        <div property="columns">
                            <div field="prdtName" name="prdtName" headerAlign="center" allowSort="false" visible="true" width="100">项目名称</div>
                            <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" align="center">业务类型
                                <input property="editor" enabled="true" dataField="servieTypeList" class="nui-combobox" valueField="id" textField="name" data="servieTypeList" url="" onvaluechanged="onValueChangedItemTypeId" emptyText="" vtype="required" />
                            </div>
                            <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" name="itemItemTime">工时/数量
                                <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedComQty" selectOnFocus="true" />
                            </div>
                            <div field="unitPrice" name="itemUnitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">单价
                                <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedItemUnitPrice" selectOnFocus="true" />
                            </div>
                            <div field="rate" name="itemRate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">优惠率<a href="javascript:setItemPartRate()" title="批量设置优化率" style="text-decoration:none;">  <span class="fa fa-edit fa-lg"></span></a>

                                <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedItemRate" selectOnFocus="true"/>
                            </div>
                            <div field="subtotal" name="itemSubtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center">金额
                                <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedItemSubtotal" selectOnFocus="true" />
                            </div>
                            <div field="amt" name="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">工时总金额</div>
                            <div field="workers" headerAlign="center" allowSort="false" visible="true" width="80" header="施工员" name="workers" align="center">
                                <div id="combobox2" property="editor" class="mini-combobox" style="width:250px;" popupWidth="100" textField="empName" valueField="empName" url="" data="memList" value="" multiSelect="true" showClose="true" oncloseclick="onCloseClick" onvaluechanged="onitemworkerChanged"></div>
                            </div>
                            <div field="workerIds" headerAlign="center" allowSort="false" visible="false" width="80" header="施工员" align="center"></div>
                            <div field="saleMan" headerAlign="center" allowSort="false" visible="true" width="50" header="销售员" align="center" name="saleMan">
                                <input property="editor" enabled="true" dataField="memList" class="nui-combobox" valueField="empName" textField="empName" data="memList" url="" onvaluechanged="onitemsalemanChanged" emptyText="" vtype="required" />
                            </div>
                            <div field="saleManId" headerAlign="center" allowSort="false" visible="false" width="80" header="销售员" align="center"></div>
                            <div field="itemOptBtn" name="itemOptBtn" width="100" headerAlign="center" header="操作" align="center" visible="false"></div>
                        </div>
                    </div>
                </div>
            </div>
            		</div>
            	</div>
            </div>
        </div>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-22 15:07:42
  - Description: 
--> 
<head>  
    <title>保养提醒</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <script src="<%= request.getContextPath() %>/manage/js/maintainRemMain/maintainRemMain.js?v=1.0.60" type="text/javascript"></script>
    <style type="text/css">
    body {
        margin: 0; 
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%; 
        overflow: hidden;
        font-family: "微软雅黑";
    }
</style> 
</head>
<body>
    <div class="nui-toolbar">
        <label style="font-family:Verdana;">快速查询：</label>
        <label style="font-family:Verdana;">车牌号：</label>
        <input class="nui-textbox" name="tcarNo" id="tcarNo">
        <label style="font-family:Verdana;">手机号：</label>
        <input class="nui-textbox" name="tmobile" id="tmobile">
        <a class="nui-button" plain="true" onclick="onSearch()" iconcls="" plain="false"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
        <span class="separator"></span>
        <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-send fa-lg"></span>&nbsp;发送短信</a>
		<a class="nui-button" plain="true" iconCls="" plain="false" onclick="addBooking()"><span class="fa fa-clock-o fa-lg"></span>&nbsp;预约</a>
		<a class="nui-button" plain="true" iconCls="" plain="false" onclick="remindDetail()"><span class="fa fa-list fa-lg"></span>&nbsp;跟踪明细</a>
		<a class="nui-button" plain="true" iconCls="" plain="false" onclick="checkMtRecord()"><span class="fa fa-search fa-lg"></span>&nbsp;查看保养提醒</a>
    </div>
    <div class="nui-fit">
        <div class="nui-splitter" style="width: 100%; height: 100%;"> 
            <div size="30%" showCollapseButton="true">
                <div class="nui-fit">
                    <div id="gridCar" class="nui-datagrid gridborder"
                    style="width: 100%; height: 100%;"
                    url=""
                    dataField="data" idField="id" sizeList="[20,30,50,100]"
                    pageSize="20" totalField="page.count" showPager="true">

                    <div property="columns">
                        <div type="indexcolumn" width="30">序号</div>
                        <div field="carNo" width="70" headerAlign="center"align="center">车牌号</div>
                        <div field="carModel" width="170" headerAlign="center"align="center">车型</div>
                        <div field="guestName" width="70" headerAlign="center"align="center">客户名称</div>
                        <div field="leaveDays" width="70" headerAlign="center"align="center">离厂天数</div>
                        <div field="finalRemindDay" dateFormat="yyyy-MM-dd HH:mm" width="170" headerAlign="center"align="center">最后提醒时间</div>
                        <div field="chainComeTimes" width="70" headerAlign="center"align="center">连锁次数</div>
                        <div field="lastComeDate" dateFormat="yyyy-MM-dd HH:mm" width="170" headerAlign="center"align="center">最后进厂时间</div>
                        <div field="firstComeDate" dateFormat="yyyy-MM-dd HH:mm" width="170" headerAlign="center"align="center">首次来厂时间</div>
                        <div field="lastLeaveDate" dateFormat="yyyy-MM-dd HH:mm" width="170" headerAlign="center"align="center">最后离厂时间</div>
                        <div field="careDueDate" dateFormat="yyyy-MM-dd HH:mm" width="170" headerAlign="center" align="center">保养到期时间</div>
                        <div field="preAdvisorName" width="70" headerAlign="center" align="center">营销员</div>
                        <div field="mobile" visible="false" width="70" headerAlign="center" align="center">手机号</div>
                        <div field="carBrandId" visible="false" width="70" headerAlign="center" align="center">品牌</div>
                        <div field="carBrandId" visible="false" width="70" headerAlign="center" align="center">车型</div>
                    </div>
                </div> 
            </div> 
        </div>

        <div showCollapseButton="true">
            <div class="nui-fit">
                <div id="tabs" name="tabs" class="nui-tabs" activeIndex="0"
                style="width: 100%; height: 100%;"
                bodyStyle="padding:0;border:0;">
                <div title="基本信息" name="tab1">
                    <input class="nui-hidden" name="carId" id="carId"/>
                    <input class="nui-hidden" name="mainId" id="mainId"/>
                    <input class="nui-hidden" name="serviceId" id="serviceId"/>
                    <input class="nui-hidden" name="mtAdvisorId" id="mtAdvisorId"/>
                    <input class="nui-hidden" name="guestId" id="guestId"/>
                    <table class="tmargin" style="margin-left:5px;" id="tableDis">
                        <tr class="htr">
                            <td style="width: 70px;">客户名称：</td>
                            <td style="width: 140px;">
                                <input id="guest" name="guest" class="nui-textbox textboxWidth" enabled="false">
                            </td>
                            <td style="width: 70px;">客户电话：</td>
                            <td style="width: 140px;">
                                <input id="mobile" name="mobile" class="nui-textbox textboxWidth" enabled="false">
                            </td>
                            <td style="width: 70px;">来厂次数：</td>
                            <td style="width: 140px;">
                                <input id="compComeTimes" name="compComeTimes" class="nui-textbox textboxWidth" enabled="false">
                            </td>
                        </tr> 
                        <tr class="htr">
                            <td >联系人：</td>
                            <td >
                                <input id="contactor" name="contactor" class="nui-textbox textboxWidth" enabled="false">
                            </td>
                            <td >联系电话：</td>
                            <td >
                                <input id="contactorTel" name="contactorTel" class="nui-textbox textboxWidth" enabled="false">
                            </td>
                            <td >身份：</td>
                            <td >
                                <input id="identity" name="identity" class="nui-combobox textboxWidth"valueField="customid" textField="name" enabled="false">
                            </td>
                        </tr>
                        <tr class="htr">
                            <td >车牌号：</td>
                            <td >
                                <input id="carNo" name="carNo" class="nui-textbox textboxWidth" enabled="false">
                            </td>
                            <td >品牌：</td>
                            <td >
                                <input id="carBrandId" name="carBrandId" class="nui-combobox textboxWidth"textField="name"valueField="id" enabled="false">
                            </td>
                            <td >车型：</td>
                            <td >
                                <input id="carModel" name="carModel" class="nui-textbox textboxWidth" enabled="false">
                            </td>
                        </tr>  
                        <tr class="htr">
                            <td >发动机号：</td> 
                            <td >
                                <input id="engineNo" name="engineNo" class="nui-textbox textboxWidth" enabled="false">
                            </td>
                            <td >车架号：</td>
                            <td >
                                <input id="carVin" name="carVin" class="nui-textbox textboxWidth" enabled="false">
                            </td>
                            <td ></td>
                            <td >

                            </td>
                        </tr>
                        <tr class="htr">
                            <td >业务类型：</td>
                            <td >
                                    <input name="serviceTypeId"
                                    id="serviceTypeId"
                                    class="nui-combobox textboxWidth"
                                    textField="name"
                                    valueField="id"
                                    emptyText="业务类型"
                                    url=""
                                    allowInput="true"
                                    showNullItem="true"
                                    valueFromSelect="true"
                                    onvaluechanged=""
                                    nullItemText="请选择..." enabled="false"/>
                            </td>

                            <td >服务顾问：</td>
                            <td >
                                <input id="mtAdvisor" name="mtAdvisor" class="nui-combobox textboxWidth" allowInput="true" textField="empName"valueField="empId"emptyText="请选择..."nullItemText="请选择..." onvaluechanged="mtAdvisorChanged" enabled="false">
                            </td>
                            <td ></td>
                            <td >

                            </td>
                        </tr>
                        <tr class="htr">
                            <td >里程数：</td>
                            <td >
                                <input id="enterKilometers" name="enterKilometers" class="nui-textbox textboxWidth" enabled="false">
                            </td>
                            <td >进场日期：</td>
                            <td >
                                <input id="enterDate" name="enterDate" class="nui-datepicker textboxWidth" enabled="false">
                            </td>
                            <td >离厂日期：</td>
                            <td >
                                <input id="outDate" name="outDate" class="nui-datepicker textboxWidth" enabled="false">
                            </td>
                        </tr>
                    </table>
                    <div style="height: 10px;width: 100%;"></div>
                    <div class="nui-fit">
                        <div id="p1" class="nui-panel" title="沟通结果" iconCls="" style="width:100%;height:100%;"buttons="">
						    <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
					            <table style="width:80%;">
					                <tr>
					                    <td style="width:80%;">
					                        <a class="nui-button" iconCls="" plain="true" onclick="save"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
					                 
					                    </td>
					                </tr>
					            </table>
					        </div>
                            <input class="nui-hidden" name="visitId" id="visitId"/>
                            <input class="nui-hidden" name="id" id="id"/>
                            <table class="tmargin" style="table-layout: fixed;width:100%">
                                <tr class="htr">
                                    <td  style="width: 70px;">提醒方式：</td>
                                    <td style="width: 135px;">
                                        <input id="visitMode" name="visitMode" class="nui-combobox textboxWidth" dataField="data" valueField="customid" textField="name">
                                    </td>

                                    <td style="width: "></td>
                                </tr> 
                                <tr class="htr">
                                    <td >提醒内容：</td>
                                    <td  colspan="6">
                                        <input id="visitContent" name="visitContent" class="nui-textarea textboxWidth" style="width: 100%;height:200px;">
                                    </td>
                                </tr> 
 
                            </table>
                        </div>
                    </div>
                </div>

                <div title="套餐信息" name="tab2">
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
                                    <div field="rate" headerAlign="center" name="pkgRate" allowSort="false" visible="true" width="60" header="" align="center">优惠率

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
                <div title="维修项目信息" name="tab3">
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
                                    <div field="rate" name="itemRate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">优惠率

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

                <div title="描述信息" name="tab5"style="padding:5px;" id="tab5">
                 <table class="tmargin" style="width: 100%;" id="table1">
                    <tr >
                        <td style="width: 60px;">客户描述：</td>
                        <td style="width:calc(100% - 60px)">
                            <input id="guestDesc" name="guestDesc" class="nui-textarea textboxWidth" style="height:100px;width:100%">
                        </td>
                    </tr> 
                    <tr >
                        <td style="width: 60px;">故障现象：</td>
                        <td >
                            <input id="faultPhen" name="faultPhen" class="nui-textarea textboxWidth"style="height:100px;width:100%">
                        </td>
                    </tr>
                    <tr >
                        <td style="width: 60px;">解决措施：</td>
                        <td >
                            <input id="solveMethod" name="solveMethod" class="nui-textarea textboxWidth"style="height:100px;width:100%">
                        </td>
                    </tr>
                </table>
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
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
    <title>配件出库详情</title> 
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<script src="<%=request.getContextPath()%>/coframe/imjs/message.js"></script>
	<script src="<%=request.getContextPath()%>/coframe/imjs/messagebody.js"></script>
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/repairOutDetail.js?v=1.3.9"></script>
    <style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
        .required {
            color: red;
        }
    .tbtext {
        text-align: center;
        width:80px;
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
    a { 
	    text-decoration: none;
	}
	
	a.healthview{ background:#78c800; font-size:13px; color:#fff; text-decoration:none;  padding:0px 8px; border-radius:20px;}
    a.healthview:hover{ background:#f00000;color:#fff;text-decoration:none;}

    a.chooseClass{ background:#578ccd; font-size:13px; color:#fff; text-decoration:none;  padding:0px 8px; border-radius:20px;}
    a.chooseClass:hover{ background:#f00000;color:#fff;text-decoration:none;}
        
    a.optbtn {
        width: 44px;
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
        
</style>
</head>

<body>

    <div class="nui-toolbar" id="toolbar1" style="padding:2px;height:30px">
        <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
            <tr>            
                <td>
                    <div class="nui-autocomplete" style="width:300px;"  popupWidth="600" textField="text" valueField="id" 
                    id="search_key" url="" value="carNo" placeholder="车牌号/客户名称/手机号/VIN码"  searchField="key" 
                    dataField="list" loadingText="数据加载中...">     
                    <div property="columns">
                        <div header="客户名称" field="guestFullName" width="30" headerAlign="center"></div>
                        <div header="客户手机" field="guestMobile" width="60" headerAlign="center"></div>
                        <div header="车牌号" field="carNo" width="40" headerAlign="center"></div>
                        <div header="联系人名称" field="contactName" width="30" headerAlign="center"></div>
                        <div header="联系人手机" field="mobile" width="60" headerAlign="center"></div>
                        <div header="车架号(VIN)" field="vin" width="70" headerAlign="center"></div>
                    </div>
                </div>
                <input id="search_name"
                name="search_name"
                class="nui-textbox"
                emptyText="车牌号/客户名称/手机号/VIN码"
                onbuttonclick="onSearchClick()"
                width="300px"
                visible="false"
                enabled="false"
                showClose="false"
                allowInput="true"/>
                <a class="nui-button" iconCls="" plain="false" onclick="addGuest()" id="addBtn" name="addBtn" style="display: none;">新增客户</a>
                <label style="font-family:Verdana;">工单号:</label>
                <label id="servieIdEl" style="font-family:Verdana;"></label>
                 <li class="separator"></li>
                <a class="nui-button" iconCls="" onclick="onPrint(5)" plain="true" style="align:right"><span class="fa fa-print fa-lg"></span>&nbsp;打印领料单</a>
                <a class="nui-button" onclick="" style="display :none" plain="true" style="align:right"><span class="fa fa-check fa-lg"></span>&nbsp;一键领料</a>
                 <a class="nui-button" onclick="updateBillExpense" plain="true" style="align:right"><span class="fa fa-file-o fa-lg"></span>&nbsp;费用登记</a>
                 <a class="nui-button"  id="" onclick="auditPart" plain="true" style="align:right"><span class="fa fa-check fa-lg"></span><span id="audit">&nbsp;配件审核</span></a>
                <label style="font-family:Verdana;">显示归库：</label>
                <input class="nui-checkbox" id="showOut" trueValue="1" falseValue="0" onvaluechanged="onValueChangShowOut"/>
            </td>     
            <td style="text-align:left;">
            <!-- 
            进场日期:<input class="nui-datepicker tabwidth" name="enterDate" id="enterDate" />
            预计交车日期:<input class="nui-datepicker tabwidth" name="planFinishDate" id="planFinishDate"/> -->
        </td>     
    </tr>
</table>

</div>


<div class="nui-fit">
    <div id="billForm" class="form" >
        <input class="nui-hidden" name="id" id="id" />
        <input class="nui-hidden" name="guestId"/>
        <input class="nui-hidden" name="mtAdvisorId" id="mtAdvisorId"/>
        <input class="nui-hidden" name="contactorId"/>
        <input class="nui-hidden" name="carId"/>
        <input class="nui-hidden" name="status"/>
        <input class="nui-hidden" name="serviceCode"/>
        <input class="nui-hidden" name="drawOutReport"/>
        <input class="nui-hidden" name="contactorName"/>
        <input class="nui-hidden" name="identity"/>
        <input class="nui-hidden" name="billTypeId"/>
        <input class="nui-hidden" name="status"/>
        <input class="nui-hidden" name="isSettle"/>
        <input name="serviceTypeId"
        id="serviceTypeId"
        style="display: none" 
        class="nui-combobox width1"
        textField="name"
        valueField="id"
        emptyText="请选择业务类型"
        url=""
        allowInput="true"
        showNullItem="false"
        width="120"
        valueFromSelect="true"
        onvaluechanged=""
        nullItemText="请选择..."/>
        <table  style=" left:0;right:0;margin: 0 auto; width:100%;"> 

<!--             <tr> -->
<!--                 <td class="tbtext">客户名称:</td> -->
<!--                 <td class="tbCtrl"> -->
<!--                     <input class="nui-textbox tabwidth" name="guestFullName" id="guestFullName" style="width:100%" allowInput="false"/> -->
<!--                 </td> -->
<!--                 <td class="tbtext">客户手机:</td> -->
<!--                 <td class="tbCtrl"> -->
<!--                     <input class="nui-textbox tabwidth" name="guestMobile" id="guestMobile" style="width:100%" allowInput="false"/> -->
<!--                 </td> -->
<!-- 	            <td class="tbtext">联系人:</td> -->
<!-- 	            <td class="tbCtrl"> -->
<!-- 	                <input class="nui-textbox tabwidth" name="contactorName" id="contactorName"style="width:100%" allowInput="false"/> -->
<!-- 	            </td> -->
<!-- 	            <td class="tbtext">联系方式:</td> -->
<!-- 	            <td class="tbCtrl"> -->
<!-- 	                <input class="nui-textbox tabwidth" " name="mobile" id="mobile" style="width:100%" allowInput="false"/> -->
<!-- 	            </td> -->
<!--                 
<!--                 <td class="tbtext">级别:</td> -->
<!--                 <td class="tbCtrl"> -->
<!--                     <input class="nui-textbox tabwidth" /> -->
<!--                 </td> -->
<!--                 <td class="tbtext">会员卡:</td> -->
<!--                 <td class="tbCtrl"> -->
<!--                     <input class="nui-textbox tabwidth"  name="cardType" id ="cardType"/> -->
<!--                 </td> -->
<!--             --> 
<!--         </tr>  -->
        <tr>
            <td class="tbtext">车牌号:</td>
            <td class="tbCtrl">
                <input class="nui-textbox tabwidth" name="carNo" id="carNo" style="width:100%" allowInput="false"/>
            </td>
            <td class="tbtext">预计交车:</td>
            <td class="tbCtrl">
                <input class="nui-datepicker tabwidth" name="planFinishDate" dateFormat="yyyy-MM-dd HH:mm" format="yyyy-MM-dd HH:mm" id="planFinishDate" style="width:100%" allowInput="false"/>
            </td>
            <td class="tbtext">距离交车时间:</td>
            <td class="tbCtrl">
                <input class="nui-textbox tabwidth" name="timeDaff"  id="timeDaff" style="width:100%" allowInput="false"/>
            </td>
            <td class="tbtext">服务顾问:</td>
            <td class="tbCtrl">
                <input class="nui-textbox tabwidth" name="mtAdvisor" id="mtAdvisor"style="width:100%" allowInput="false"/>
            </td>
            <td class="tbtext required">配件审核状态:</td>
            <td class="tbCtrl">
                <input class="nui-textbox tabwidth" name="partAuditSign" id="partAuditSign" style="width:100%" allowInput="false"/>
            </td>
            <td class="tbtext">品牌车型:</td>
            <td class="tbCtrl">
                <input class="nui-textbox tabwidth" name="carModel" id="carModel" style="width:100%" allowInput="false"/>
            </td>
            <td class="tbtext">车架号(VIN):</td>
            <td class="tbCtrl">
                <input class="nui-textbox tabwidth" id="carVin" name="carVin"style="width:100%" allowInput="false"/>
            </td>
        </tr>

    </table>
</div>

<div style="height:10px;width:100%"></div>

<div id="rpsPackageGrid" class="nui-datagrid"
     style="width:100%;height:auto;"
     dataField="list"
     showPager="false"
     showModified="false"
     allowSortColumn="false"
     visible="false"
     showSummaryRow="true"
     ondrawsummarycell="onDrawSummaryCell"
     >
    <div property="columns">
    	<div type="indexcolumn" headerAlign="center" name="index" visible="false">序号</div>
        <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
        <div header="套餐信息">
            <div property="columns">
                <div field="prdtName" headerAlign="center" allowSort="false"
                     visible="true" width="100" header="套餐名称">
                </div>
                 <div field="type" headerAlign="center" allowSort="false"
                     visible="true" width="60" header="项目类型" align="center">
                </div>
                <div field="serviceTypeId" headerAlign="center" name="pkgServiceTypeId"
                     allowSort="false" visible="true" width="50" header="业务类型" align="center">
                     <input  property="editor" enabled="true" dataField="servieTypeList" 
                             class="nui-combobox" valueField="id" textField="name" data="servieTypeList"
                             url="" onvaluechanged="onPkgTypeIdValuechanged" emptyText=""  vtype="required" /> 
                </div>
                <div field="qty" headerAlign="center" allowSort="false" visible="true" width="40" datatype="float" align="center" name="itemItemTime"summaryType="sum" >工时/数量
                </div>
                <div field="pickQty" headerAlign="center" allowSort="false" visible="true" width="60px" align="center" header="已领数量"></div> 
                <div field="restQty" headerAlign="center" allowSort="false" visible="true" width="60px" align="center" header="未领数量"></div>   
                <div field="amt" headerAlign="center" name="pkgAmt"
                     allowSort="false" visible="true" width="60" header="原价" align="center">
                </div>

                <div field="rate" headerAlign="center" name="pkgRate"
                     allowSort="false" visible="true" width="60" header="" align="center">
                           优惠率%
                     <input property="editor"  width="60%" vtype="float"  class="nui-textbox"  onvaluechanged="onPkgRateValuechanged" selectOnFocus="true"/>
                </div>
                 <div field="subtotal" headerAlign="center" name="pkgSubtotal"
                     allowSort="false" visible="true" width="60" header="套餐金额" align="center" summaryType="sum">
                     <input  property="editor" vtype="float" class="nui-textbox" selectOnFocus="true" onvaluechanged="onPkgSubtotalValuechanged"/>
                </div>
                <div field="packageOptBtn" name="packageOptBtn" width="100" headerAlign="center" header="操作" align="center"></div>
            </div>
        </div>
    </div>
</div>

<div id="rpsItemGrid"
     borderStyle="border-bottom:1;"
     class="nui-datagrid"
     dataField="list"
     style="width: 100%; height:auto;"
     showPager="false"
     showModified="false"
     allowSortColumn="true"
     visible="false"
     showSummaryRow="true"
     ondrawsummarycell="onDrawSummaryCell2"
     >
    <div property="columns">
        <div type="indexcolumn" headerAlign="center" name="index" visible="false">序号</div>
        <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
        <div header="项目信息">
            <div property="columns">
                <div field="prdtName" name="prdtName" headerAlign="center" allowSort="false" visible="true" width="100">项目名称
                	<input property="editor" class="nui-textbox" selectOnFocus="true"/>
                </div>
                <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" align="center">业务类型
                    <input  property="editor" enabled="true" dataField="servieTypeList" 
                             class="nui-combobox" valueField="id" textField="name" data="servieTypeList"
                             url="" onvaluechanged="onValueChangedItemTypeId" emptyText=""  vtype="required"/> 
                </div>
                <div field="qty" headerAlign="center" allowSort="false" visible="true" width="40" datatype="float" align="center" name="itemItemTime" summaryType="sum">工时/数量
                    <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedComQty" selectOnFocus="true"/>
                </div>
                <div field="pickQty" headerAlign="center" allowSort="false" visible="true" width="60px" align="center" header="已领数量"></div> 
                <div field="restQty" headerAlign="center" allowSort="false" visible="true" width="60px" align="center" header="未领数量"></div>    
                <div field="unitPrice" name="itemUnitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">单价
                    <input property="editor" vtype="float" class="nui-textbox"  onvaluechanged="onValueChangedItemUnitPrice" selectOnFocus="true"/>
                </div>
                <div field="rate" name="itemRate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" >
                    优惠率%
                    <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedItemRate" selectOnFocus="true"/>
                </div>
                <div field="subtotal"  name="itemSubtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center" summaryType="sum">金额
                    <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedItemSubtotal" selectOnFocus="true"/>
                </div>
                <div field="amt"  name="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">项目总金额
                </div>
                <div field="itemOptBtn" name="itemOptBtn" width="100" headerAlign="center" header="操作" align="center" ></div>
            </div>
        </div>
    </div>
</div>

<div id="mainGrid" class="nui-datagrid" style="width:100%;height:auto;" showPager="false" 
dataField="data"   multiSelect="false" allowCellWrap = true
url=""  showModified="false" visible="false" showSummaryRow="true"
allowCellEdit="true" >
<div property="columns">
   <div headerAlign="center" type="indexcolumn" width="20">序号</div>
   <div type="checkcolumn"></div> 
   <div field="id" name="id" visible="false"  header="recordId"></div>
   <div header="待领料-配件信息">  
    <div property="columns">
        <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称"></div>
        <div field="partCode" headerAlign="center" allowSort="false" visible="true" width="80px" header="配件编码"></div> 
        <div field="serviceTypeId" name="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" header="业务类型" align="center"></div>
        <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="int" align="center" header="数量" summaryType="sum"></div>
        <div field="pickQty" headerAlign="center" allowSort="false" visible="true" width="60px" align="center" header="已领数量"></div>                        
        <div field="unitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="单价"></div>
        <div field="rate" headerAlign="center" allowSort="false" visible="true" width="60" align="center"  header="优惠率"></div>
        <div field="subtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center" header="金额" summaryType="sum"></div>
        <div field="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">金额</div>
        <div field="saleMan" headerAlign="center" allowSort="false" visible="true" width="50" header="销售员" align="center"></div>
        <div field="saleManId" headerAlign="center" allowSort="false" visible="false" width="80" header="销售员" align="center"></div>
        <div field="action" name="action" width="40" headerAlign="center" header="操作" align="center" align="center"></div>   

    </div>
</div> 
</div>
</div>  

<div style="height:10px;width:100%"></div>

<div id="repairOutGrid" class="nui-datagrid" style="width:100%;height:auto; " showPager="false" 
dataField="data"  allowCellSelect="true" multiSelect="false" allowCellWrap = true
url=""  showModified="false" showSummaryRow="true"
allowCellEdit="true"  >
<div property="columns">
   <div headerAlign="center" type="indexcolumn" width="30">序号</div>
   <div type="checkcolumn" width="30" ></div>
   <div header="已领料-配件信息">
    <div property="columns">
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
        <div field="pickDate" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="领料日期" dateFormat="yyyy-MM-dd"></div>
        <div field="remark" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="领料备注"></div>
        <div field="recorder" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="操作人"></div>

        <div field="returnMan" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="归库人"></div>
        <div field="returnDate" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="归库日期" dateFormat="yyyy-MM-dd"></div>
        <div field="returnRemark" headerAlign="center" allowSort="false" visible="true" width="60" align="center" header="归库备注"></div>
		<div field="action" name="action" width="40" headerAlign="center" header="操作" align="center" align="center"></div>

    </div>
</div>
</div>
</div>

<div id="advancedMorePartWin" class="nui-window"
     title="" style="height:70px;width:100px;"
     showModal="false"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
    <table style="text-align:left;width: 100%; height: 100%;padding-left:6px;">
        <tr>
            <td>
            <a class="nui-button" iconCls="" plain="true" onclick="chooseBasic()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;选择配件</a>
            </td>
        </tr>
        <tr>
            <td>
            <a class="nui-button" iconCls="" plain="true" onclick="chooseStock()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;直接出库</a>
            </td>
        </tr>
    </table>
</div>    

<!-- <div style="width:100%;margin-top: 10px;"> -->
<!--     <a class="nui-button" onclick="LLSave()" plain="false">领料</a> -->
<!--     <a class="nui-button" onclick="THSave()" plain="false">退货</a> -->
<!--     <a class="nui-button" onclick="onPrint(5)" plain="false">打印领料单</a> -->
<!-- </div> -->
</div>

<script type="text/javascript">
    nui.parse();
</script>
</body>

</html>
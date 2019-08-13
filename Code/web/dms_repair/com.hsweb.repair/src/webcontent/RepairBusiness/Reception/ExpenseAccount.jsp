<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-02 19:02:07 
  - Description:  
-->   
<head>
    <title>报销单</title>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/ExpenseAccount.js?v=1.4.40"></script>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"></script>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <style type="text/css">
        body { 
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        .btnType{
            font-family:Verdana;
            font-size: 14px;
            text-align: center;
            height: 40px;
            width: 120px;
            line-height:40px;
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

        #wechatTag{
            color:#62b900;
        }


        /* font-family:Verdana;color:white;background:#62b900;padding:0px 8px;border-radius:90px; display:block;  padding:4px 15px;*/
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



<div class="nui-toolbar" style="padding:2px;height:30px">
	<input class="nui-hidden" id="sourceServiceId"   name="sourceServiceId"/>
	<input class="nui-combobox" visible="false" name="serviceTypeId" id="serviceTypeId"
										   valueField="id" allowInput="true" valueFromSelect="true"
										   textField="name"/>
    <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
        <tr>            
            <td style="text-align:right;">
                <!-- <span id="carHealthEl" class="" style="font-family:Verdana;color:white;background:#62b900;padding:0px 8px;border-radius:90px;">车况:100</span>
                <a class="nui-button" iconCls="" plain="false" onclick="" id="addBtn">查看详情</a>
                <span class="separator"></span> -->
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <span class="separator"></span>
                 <a class="nui-menubutton" plain="true" menu="#popupMenuPrint" id="menuprint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
                <ul id="popupMenuPrint" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="onPrint(1)" id="type11">打印报价单</li>
                    <!-- <li iconCls="" onclick="onPrint(3)" id="type11">打印报价单(项目配件分开)</li> -->
                    <li iconCls="" onclick="onPrint(2)" id="type11">打印结账单</li>
                    <li iconCls="" onclick="onPrint(3)" id="type11">66</li>
                    <!-- <li iconCls="" onclick="onPrint(4)" id="type11">打印结账单(项目配件分开)</li> -->
                    <!-- <li iconCls="" onclick="onPrint(5)" id="type11">模板3</li>
                    <li iconCls="" onclick="onPrint(6)" id="type11">模板4</li>
                    <li iconCls="" onclick="onPrint(7)" id="type11">模板5</li> -->
                </ul>
            </td>
        </tr>
    </table>

</div>
<div class="nui-fit">
    <div id="billForm" class="form">
        <input name="id" class="nui-hidden"id="rid"/>
        <input name="guestId" class="nui-hidden"/>
        <input id="mtAdvisor" name="mtAdvisor" class="nui-hidden"/>
        <input class="nui-hidden" name="contactorId"/>
        <input class="nui-hidden" name="guestId"/>
        <input class="nui-hidden" name="carId"/>
        <input class="nui-hidden" name="status"/>
        <input class="nui-hidden" name="carVin"/>
        <input class="nui-hidden" name="drawOutReport"/>
        <input class="nui-hidden" name="carModel"/>
        <input class="nui-hidden" name="identity"/>
        <input class="nui-hidden" name="billTypeId"/>
        <input class="nui-hidden" name="status"/>
        <input class="nui-hidden" name="isSettle"/>
        <input class="nui-hidden" name="serviceCode"/>
        <input class="nui-hidden" name="sourceServiceId"/>
        <input class="nui-hidden" name="isSettle"/>
        <input class="nui-hidden" name="guestDesc"/>
        <input class="nui-hidden" name="faultPhen"/>
        <input class="nui-hidden" name="solveMethod"/>
        <input class="nui-hidden" name="enterOilMass"/>
         <input class="nui-hidden" name="recordDate" id="recordDate"/>
        <input id="enterDate" name="enterDate" class="nui-datepicker"visible="false"nullValue="null" format="yyyy-MM-dd HH:mm" showTime="true"  showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" width="100%"/>
        <table  style=" left:0;right:0;margin: 0 auto;width:100%"> 
            <tr>   
                <td class="title">车牌号:</td> 
                <td class=""><input  class="nui-textbox" name="carNo" id="carNo" style="width:100%;"/></td>
                <td class="title">
                    <label>业务类型:</label>
                </td>
                <td class="">
                    <input name="serviceTypeId"
                        id="serviceTypeId"
                        class="nui-combobox width1"
                        textField="name"
                        valueField="id"
                        emptyText="请选择..."
                        url=""
                        allowInput="true"
                        showNullItem="false"
                        valueFromSelect="true"
                        nullItemText="请选择..." style="width:100%;"/>
                </td>
                <td class="title">
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
                            valueFromSelect="true"
                            nullItemText="请选择..." style="width:100%;"/>
                </td>
                <td class="title">进厂里程:</td> 
                <td class=""><input  class="nui-textbox" name="enterKilometers" style="width:100%;"/></td>
                <td class="title">备注:</td> 
                <td class="" colspan=""><input  class="nui-textbox" name="remark" style="width:100%;"/></td>
            </tr>
            <tr>  
               
                <td class="title">客户名称:</td> 
                <td class=""><input  class="nui-textbox" name="guestName" id="guestName" style="width:100%;"/></td>
                <td class="title">客户手机:</td> 
                <td class=""><input  class="nui-textbox" name="guestTel" id="guestTel"  style="width:100%;"/></td>
                <td class="title">联系人名称:</td> 
                <td class=""><input  class="nui-textbox" name="contactorName" id="contactorName" style="width:100%;"/></td>
                <td class="title">联系人手机:</td> 
                <td class=""><input  class="nui-textbox" name="contactorTel" id="contactorTel" style="width:100%;"/></td>
                <td class="title">开单时间:</td> 
                <td class="">
                    <input id="recordDate"
                    name="recordDate"
                    allowInput="false" format="yyyy-MM-dd"
                    class="nui-datepicker" style="width:100%;"/>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
<div class="nui-fit">
    <div class="" style="width:100%;height:auto;" >
        <div style="width:100%;height:5px;"></div>
        <div id="rpsPackageGrid" class="nui-datagrid"
		     style="width:100%;height:auto;"
		     dataField="pkgBill"
		     showPager="false"
		     showModified="false"
		     allowSortColumn="false" allowCellEdit="true" allowCellSelect="true"
		     oncellcommitedit="onCellCommitEditPkg"
		     ondrawsummarycell="onDrawSummaryCellPack"
		     >
    <div property="columns">
    	 <div type="indexcolumn" headerAlign="center" align="center"visible="false">序号</div>
         <div field="orderIndex"  headerAlign="center" allowSort="false" visible="true" width="20" name="num"  align="right">序号</div>
        <div header="套餐信息">
            <div property="columns">
             
               <div field="billPackageId" width="120" headerAlign="center" allowSort="true" visible="false">员工帐号</div>  
                <div field="packageName" headerAlign="center" allowSort="false"
                     visible="true" width="100" header="套餐名称">
                     <input property="editor"  class="nui-textbox"/>
                </div>
                <div field="subtotal" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="套餐金额" align="center">
                     <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="rate" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="优惠率%" align="center">
                     <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="amt" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="原价" align="center">
                </div>
                <div field="discountAmt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">折扣金额
                </div>
                <div field="action" name="action" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="操作" align="center"></div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:choosePackage()" id="addPkg" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择套餐</a>
    </span>
</div>
      <div style="width:100%;height:5px;"></div>
      <div id="rpsItemGrid" class="nui-datagrid"
		     style="width:100%;height:auto;"
		     dataField="itemBill"
		     showPager="false"
		     showModified="false"
		     allowSortColumn="false" allowCellEdit="true" allowCellSelect="true"
		     oncellcommitedit="onCellCommitEditItem"
		     ondrawsummarycell="onDrawSummaryCellItem"
		     >
    <div property="columns">
    	<div type="indexcolumn" headerAlign="center" align="center"visible="false">序号</div>
        <div field="orderIndex" name="orderIndex" headerAlign="center" allowSort="false" visible="true" width="20" align="right">序号</div>
        <div header="项目信息">
            <div property="columns">
                
                <div field="itemName" name="itemName" headerAlign="center" allowSort="false" visible="true" width="100">项目名称
                	<input property="editor"  class="nui-textbox"/>
                </div>
                <div field="itemTime" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">工时/数量
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="unitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">单价
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="rate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" >优惠率%
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="subtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center">金额
                </div>
                 <div field="discountAmt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">折扣金额
                </div>
                 <div field="action" name="action" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="操作" align="center"></div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:chooseItem()" class="chooseClass" id="addItem"><span class="fa fa-plus"></span>&nbsp;选择项目</a>
    </span>
    <!--<span>&nbsp;</span>
     <span id="carHealthEl" >
        <a href="javascript:showBasicData('item')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择标准项目</a>
    </span> -->
</div>
<!-- <div id="advancedMorePartWin" class="nui-window"
     title="" style="height:70px;width:100px;"
     showModal="false"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
    <table style="text-align:left;width: 100%; height: 100%;padding-left:6px;">
        <tr>
            <td>
            <a class="nui-button" iconCls="" plain="true" onclick="choosePart()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;选择配件</a>
            </td>
        </tr>
        <tr>
            <td>
            <a class="nui-button" iconCls="" plain="true" onclick="showBasicDataPart()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;选择标准配件</a>
            </td>
        </tr>
    </table>
</div>  -->
          </div>
                
                        
      </div>
    </div>
    <div style="height: 10%;"></div>
</div>

<div style="background-color: #cfddee;position:absolute; top:90%;width:100%;height: 10%; z-index:900;">
 <div id="sellForm" class="form"  style="float:right;height: 100%;padding-right: 20px;">
    	<table style='height: 100%'>
    		<tbody>
    			<tr>
    				<td  style='height: 100%'>
			        <label>套餐金额：</label>
			            <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="pkgTotalAmt" name="pkgSubtotal"/>
                    <label>项目金额：</label>
 			          <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="itemTotalAmt" name="itemSubtotal"/>
  			       <label>配件金额：</label>
	 			        <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="partTotalAmt" name="partSubtotal"/>
	  			   <label>总金额：</label>
	 			        <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="totalAmt" name="totalAmt"/> 
                      <!-- <div style='display: none'>
			          <input class="nui-hidden" enabled="false" id="packageSubtotal" name="packageSubtotal"/>
			          <input class="nui-hidden" enabled="false" id="packagePrefAmt" name="packagePrefAmt"/>
			          <input class="nui-hidden" enabled="false" id="itemSubtotal" name="itemSubtotal"/>
			          <input class="nui-hidden" enabled="false" id="itemPrefAmt" name="itemPrefAmt"/>
			          <input class="nui-hidden" enabled="false" id="partSubtotal" name="partSubtotal"/>
			          <input class="nui-hidden" enabled="false" id="partPrefAmt" name="partPrefAmt"/>
			          <input class="nui-hidden" enabled="false" id="ycAmt" name="ycAmt"/>
			        </div> -->
    				</td>
    			 </tr>
    		</tbody>
    	</table>
    </div>
</div>
<script type="text/javascript">
 nui.parse();
</script>
</body>
</html>
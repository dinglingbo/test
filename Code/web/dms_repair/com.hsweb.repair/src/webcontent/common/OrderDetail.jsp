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
    <title>工单详情</title>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/orderDetail.js?v=1.3.63"></script>
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
    .zffs td {
			font-size: 16px;
		}
	.zffs {
			padding: 15px 0;
		}
		.pay_tcbk {
			border: 1px #dcdcdc solid;
		}
		.pay_tcbk_list ul li a {
			width: 180px;
			height: 33px;
			display: block;
			background: #75b7ea;
			border-radius: 3px;
			color: #fff;
			text-decoration: none;
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
        <input class="nui-hidden" id="sourceServiceId" value='<b:write property="sourceServiceId"/>'  name="sourceServiceId"/> 
        <input class="nui-combobox" visible="false" name="serviceTypeId" id="serviceTypeId"
        valueField="id" allowInput="true" valueFromSelect="true"
        textField="name"/>
        <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
            <tr>            
			<td  style="text-align:left;">
				<label style="font-family:Verdana;">工单号:</label>
                <label id="servieIdEl" style="font-family:Verdana;"></label>
			</td>
			<td align="right">
			     <a class="nui-menubutton" plain="true" menu="#popupMenuPrint" id="menuprint" ><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
                  <ul id="popupMenuPrint" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="onPrint(1)" id="type11">打印报价单</li>
                    <li iconCls="" onclick="onPrint(8)" id="type11">打印报价单(项目配件分开)</li>
                    <li iconCls="" onclick="onPrint(2)" id="type11">打印派工单</li>
                    <li iconCls="" onclick="onPrint(3)" id="type11">打印结账单</li>
                    <li iconCls="" onclick="onPrint(9)" id="type11">打印结账单(项目配件分开)</li>
                    <li iconCls="" onclick="onPrint(4)" id="type11">打印结账单(小票)</li>
                     <li iconCls="" onclick="onPrint(10)" id="type11">打印结账单(小票,项目配件分开)</li>
                    <li iconCls="" onclick="onPrint(5)" id="type11">打印领料单</li>
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
        <input id="enterDate" name="enterDate" class="nui-datepicker"visible="false"nullValue="null" format="yyyy-MM-dd HH:mm" showTime="true"  showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" width="100%"/>
        <table  style="width:100%; left:0;right:0;margin: 0 auto;"> 
            <tr>   
                <td class="title">车牌号:</td> 
                <td class=""><input  class="nui-textbox" name="carNo" id="carNo" enabled="false" width="100%"/></td>
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
                    enabled="false" width="100%"
                    allowInput="true"
                    showNullItem="false"
                    valueFromSelect="true"
                    nullItemText="请选择..."/>
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
                    enabled="false" width="100%"
                    allowInput="true"
                    showNullItem="false"
                    valueFromSelect="true"
                    nullItemText="请选择..."/>
                </td>
                <td class="title">进厂里程:</td> 
                <td class=""><input  class="nui-textbox" name="enterKilometers"enabled="false" width="100%"/></td>
                <td class="title">备注:</td> 
                <td class="" colspan=""><input  class="nui-textbox" name="remark"enabled="false" width="100%"/></td>
            </tr>
            <tr>   
                <td class="title">客户名称:</td> 
                <td class=""><input  class="nui-textbox" name="guestFullName" id="guestFullName" enabled="false" width="100%"/></td>
                <td class="title">性别:</td> 
                <td class="">  <input name="sex"
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
                <td class="title">客户手机:</td> 
                <td class=""><input  class="nui-textbox" name="guestMobile" id="guestMobile" enabled="false" width="100%"/></td>
                <td class="title">证件号:</td> 
                <td class=""><input  class="nui-textbox" name="idNo" id="idNo"enabled="false" width="100%" /></td>
                <td class="title">联系人备注:</td> 
                <td class=""><input  class="nui-textbox" name="contactRemark" id="contactRemark" enabled="false" width="100%"/></td>
 
            </tr>
            <tr>   
                <td class="title">进厂油量:</td> 
                <td class=""><input  class="nui-textbox" name="enterOilMass" id="enterOilMass" enabled="false" width="100%"/></td>
                <td class="title">进厂日期:</td> 
                <td class=""><input  class="nui-textbox" name="enterDate" id="enterDate" format="yyyy-MM-dd" class="nui-datepicker"enabled="false" width="100%" /></td>
                <td class="title">预计交车时间:</td> 
                <td class=""><input  class="nui-textbox" name="planFinishDate" id="planFinishDate" format="yyyy-MM-dd" class="nui-datepicker" enabled="false" width="100%"/></td>
                <td class="title">品牌车型:</td> 
                <td class=""><input  class="nui-textbox" name="carModel" id="carModel" enabled="false" width="100%"/></td>
                <td class="title">开单时间:</td> 
                <td class="">
                    <input id="recordDate"
                    name="recordDate"
                    width="100%" enabled="false"
                    allowInput="false" format="yyyy-MM-dd"
                    class="nui-datepicker" />
                </td>
            </tr>
            <tr>   
                <td class="title">保险公司:</td> 
                <td class=""><input  class="nui-textbox" name="insuranceName" id="insuranceName"  enabled="false" width="100%"/></td>
                <td class="title ">交强险单号:</td> 
                <td class=""><input  class="nui-textbox" name="insureNo" id="insureNo" enabled="false" width="100%"/></td>
                <td class="title">交强险到期:</td> 
                <td class=""><input  class="nui-textbox" name="insureDueDate" id="insureDueDate" enabled="false" width="100%"/></td>
                <td  class="title">客户描述:</td> 
                <td colspan="3" class=""><input  class="nui-textbox" name="guestDesc" id="guestDesc" width="100%" enabled="false"/></td>
                
            </tr>
                <tr>   
                <td class="title">故障现象:</td> 
                <td colspan="5" class="">
                    <input  class="nui-textbox" name="faultPhen" id="faultPhen" enabled="false"width="100%"/>
                </td>
                
                <td class="title">解决措施:</td> 
                <td colspan="3"  class="">
                    <input  class="nui-textbox" name="solveMethod" id="solveMethod" width="100%" enabled="false" />
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
			<div class="" style="width:100%;height:auto;" >
                <div style="width:100%;height:15px;"></div>
                <div id="rpsPackageGrid" class="nui-datagrid"
                style="width:100%;height:auto;"
                dataField="aa" ondrawsummarycell="onDrawSummaryCellPack"
                showPager="false"
                showModified="false"
                allowSortColumn="false" allowCellEdit="false" allowCellSelect="true">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center" visible="false" align="center">序号</div>
                    <div field="orderIndex" name="orderIndex" headerAlign="center" allowSort="false" visible="true" width="20" name="num">序号</div>
                    <div header="套餐信息">
	                <div property="columns">
	                    <div field="billPackageId" width="120" headerAlign="center" allowSort="true" visible="false">员工帐号</div>  
	                    <div field="prdtName" headerAlign="center" allowSort="false"
	                    visible="true" width="100" header="套餐名称">
	                    <input property="editor" vtype="float" class="nui-textbox"/>
	                </div>
	                <div field="type" headerAlign="center" allowSort="false"
                     visible="true" width="60" header="项目类型" align="center">
                </div>
	                <div field="serviceTypeId" headerAlign="center"
            		allowSort="false" visible="true" width="60" header="业务类型" align="center"></div>
	                <div field="subtotal" headerAlign="center"
	                allowSort="false" visible="true" width="60" header="套餐金额" align="center">
	                <input property="editor" vtype="float" class="nui-textbox"/>
	            </div>
                    <div field="rate" headerAlign="center"
                    allowSort="false" visible="true" width="60" header="优惠率" align="center">
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="amt" headerAlign="center"
                allowSort="false" visible="true" width="60" header="原价" align="center">
            </div>
            
        </div>
    </div>
</div>
</div>

<div style="width:100%;height:15px;"></div>
<div id="rpsItemGrid" class="nui-datagrid"
style="width:100%;height:auto;"
borderStyle="border-bottom:1;"
dataField="bb"
showPager="false"
showModified="false"
allowSortColumn="true" ondrawsummarycell="onDrawSummaryCellItem" allowCellEdit="false" allowCellSelect="true">
<div property="columns">
    <div type="indexcolumn" headerAlign="center" align="center"visible="false">序号</div>
    <div field="orderIndex" name="orderIndex" headerAlign="center" allowSort="false" visible="true" width="20" name="num">序号</div>
    <div header="项目信息">
        <div property="columns">
            <div field="prdtName" name="prdtName" headerAlign="center" allowSort="false" visible="true" width="100">项目名称
                <input property="editor" vtype="float" class="nui-textbox"/>
            </div>
            <div field="serviceTypeId" headerAlign="center"
            allowSort="false" visible="true" width="60" header="业务类型" align="center"></div>
            <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">工时/数量
                <input property="editor" vtype="float" class="nui-textbox"/>
            </div>
            <div field="unitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">单价
                <input property="editor" vtype="float" class="nui-textbox"/>
            </div>
            <div field="rate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" >优惠率
                <input property="editor" vtype="float" class="nui-textbox"/>
            </div>
            <div field="subtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center">金额
            </div>

        </div>
    </div>
</div>
</div>
</div>

<div class="pay_list">
						<h2><span style="font-size: 16;font-weight: bold;    margin-bottom: 10px;">其它费用收入</span></h2>
						<div class="pay_tcbk zffs" style="padding: 0 0 18px 0;">
							<div id="dataform">
								<div class="skbox2" id="div0" name="div0">
									<table name="account0" id="account0" width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
										<tbody>
											<tr>
												<td width="50%" height="&quot;44&quot;">
											
												</td>
												<td>
												</td>
											
											</tr>
										</tbody>
									</table>
									<table name="paytype0" id="paytype0" width="96%" border="0" cellpadding="0" cellspacing="0">
										<tbody>

										</tbody>
									</table>
								</div>
							</div>
					
						</div>
					</div>

					
					<div class="pay_list">
						<h2><span style="font-size: 10;    margin-bottom: 10px;">其它费用支出</span></h2>
						<div class="pay_tcbk zffs" style="padding: 0 0 14px 0;">
							<div id="dataform">
								<div class="skbox2" id="div0" name="div0">
									<table name="account0" id="account0" width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
										<tbody>
											<tr>
												<td width="50%" height="&quot;44&quot;">
									
												</td>
												<td>
												</td>
									
											</tr>
										</tbody>
									</table>
									<table name="paytype1" id="paytype1" width="96%" border="0" cellpadding="0" cellspacing="0">
										<tbody>

										</tbody>
									</table>
								</div>
							</div>

						</div>
					</div>

</div>
<div style="height: 11%;"></div>
</div>
<div style="background-color: #cfddee;position:absolute; top:90%;width:100%;height: 10%; z-index:900;">
 <div id="sellForm" class="form"  style="float:right;height: 100%;padding-right: 20px;">
    	<table style='height: 100%'>
    		<tbody>
    			<tr>
    				<td  style='height: 100%'>
			        <label>总金额：&nbsp;&nbsp;&nbsp;&nbsp;</label>
			            <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="totalAmt" name="totalAmt"/>
			        <label>优惠金额：</label>
 			          <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="totalPrefAmt" name="totalPrefAmt"/>        
 			        <label>小计金额：</label>
 			        <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="totalSubtotal" name="totalSubtotal"/>

                      <div style='display: none'>
			          <input class="nui-hidden" enabled="false" id="packageSubtotal" name="packageSubtotal"/>
			          <input class="nui-hidden" enabled="false" id="packagePrefAmt" name="packagePrefAmt"/>
			          <input class="nui-hidden" enabled="false" id="itemSubtotal" name="itemSubtotal"/>
			          <input class="nui-hidden" enabled="false" id="itemPrefAmt" name="itemPrefAmt"/>
			          <input class="nui-hidden" enabled="false" id="partSubtotal" name="partSubtotal"/>
			          <input class="nui-hidden" enabled="false" id="partPrefAmt" name="partPrefAmt"/>
			          <input class="nui-hidden" enabled="false" id="ycAmt" name="ycAmt"/>
			        </div>
    				</td>
    			</tr>
    			<tr>
    				<td>
	    				<label>其他优惠：</label>
	 			        <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="otherPreferential" name="otherPreferential"/>
	  			        <label>次卡抵扣：</label>
	 			        <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="ycAmt" name="ycAmt"/>
	  			        <label>结算金额：</label>
	 			        <input class="nui-textbox" inputStyle="color:red;font-weight:bold;font-size:14px;" enabled="false"  id="settlementAmt" name="settlementAmt"/>
	 
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
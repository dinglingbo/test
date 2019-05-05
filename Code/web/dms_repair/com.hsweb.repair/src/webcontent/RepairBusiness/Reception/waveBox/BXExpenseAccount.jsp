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
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/waveBox/js/BXExpenseAccount.js?v=1.4.40"></script>
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
                    <li iconCls="" onclick="onPrint(5)" id="type11">打印报价单</li>
                    <li iconCls="" onclick="onPrint(6)" id="type11">打印结账单</li>
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
        <input class="nui-hidden" name="guestDesc"/>
        <input class="nui-hidden" name="faultPhen"/>
        <input class="nui-hidden" name="solveMethod"/>
        <input id="enterDate" name="enterDate" class="nui-datepicker"visible="false"nullValue="null" format="yyyy-MM-dd HH:mm" showTime="true"  showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" width="100%"/>
        <table style="width: 100%;border-spacing: 0px 5px;">
                        <tr>
                            <td  align="right"style="width:100px">变速箱型号：</td>
                            <td class="">
                                <input class="nui-textbox" name="engineModel" id="engineModel" width="100%" />
                            </td>
                            <td  align="right"style="width:100px">
                                <label>波箱厂牌：</label>
                            </td>
                            <td class="" colspan="1">
                                <input class="nui-combobox" name="carBrandId" id="carBrandId" valueField="id" textField="name"
                                    width="100%" />
                            </td>
                            <td align="right" style="width:100px">变速箱号：</td>
                            <td class="">
                                <input class="nui-textbox" name="engineNo" id="engineNo" width="100%" />
                            </td>
                            <td align="right" style="width:100px">
                                <label>驱动形式：</label>
                            </td>
                            <td class="" colspan="1">
                                <input name="driveType" id="driveType" class="nui-combobox width1" property="editor" data="QD" emptytext="请选择驱动形式" allowInput="true"
                                    showNullItem="false" valueFromSelect="true" nullItemText="请选择..." width="100%" />
                            </td>
                            <td class="title"  style="width:100px">
                                <label>车架号(VIN)：</label>
                            </td>
                            <td class="" colspan="1">
                                <input class="nui-textbox" name="carVin" id="carVin" width="100%" />
                            </td>
                        </tr>

                        <tr>
                        	<td class="title" style="width:100px">
                                <label>车牌号：</label>
                            </td>
                            <td class="" colspan="1">
                                <input class="nui-textbox" name="carNo" id="carNo" width="100%" />
                            </td>
                            <td class="title required" style="width:100px">
                                <label>业务类型：</label>
                            </td>
                            <td class="">
                                <input name="boxServiceTypeId" id="boxServiceTypeId" class="nui-combobox width1" property="editor" data="boxServiceTypeId"
                                    emptytext="请选择业务类型" allowInput="true" showNullItem="false" valueFromSelect="true" 
                                    nullItemText="请选择..." width="100%" />
                            </td>
                            <td class="title required">
                                <label>服务顾问：</label>
                            </td>
                            <td>
                                <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" emptyText="请选择..." url="" allowInput="true" showNullItem="false"
                                    valueFromSelect="true" textField="empName" valueField="empId" nullItemText="请选择..." width="100%"
                                />

                            </td>
                            <td class="title required">客户名称：</td>
                            <td class="">

                                <input class="nui-textbox" name="guestName" id="guestName"  width="100%" />

                            </td>

                            <td class="title required">客户手机：</td>
                            <td class="">
                                <input class="nui-textbox" name="guestTel" id="guestTel"  width="100%" />

                            </td>
                        </tr>
                        <tr>
                        	<td class="title">联系人名称：</td> 
                			<td class=""><input  class="nui-textbox" name="contactorName" id="contactorName" style="width:100%;"/></td>
                            <td class="title required">联系人手机：</td>
                            <td class="">
                                <input class="nui-textbox" name="contactorTel" id="contactorTel"  width="100%" />
                                <input class="nui-Spinner" decimalPlaces="0" minValue="0" maxValue="100000000" width="45%" id="enterKilometers" name="enterKilometers"
                                    allowNull="false" showButton="false" visible="false" />
                            </td>
                            <td class="title">进厂时间：</td>
                            <td class="">
                                <input id="enterDate" name="enterDate" allowInput="false" format="yyyy-MM-dd HH:mm" class="nui-datepicker" 
                                    width="100%" />
                            </td>
                            <td class="title" style="width:100px">
                                <label>故障描述：</label>
                            </td>
                            <td class="" colspan="1">
                                <input class="nui-textbox" name="faultPhen" id="faultPhen"  width="100%" />
                            </td>
                            <td class="title">备注：</td>
                            <td class="" colspan="1">
                                <input class="nui-textbox" name="remark" width="100%" />
                            </td>
                        </tr>
                    </table>
    </div>

    <div class="nui-fit">
<div class="nui-fit">
    <div class="" style="width:100%;height:auto;" >
        <div style="width:100%;height:5px;"></div>
      <div id="rpsItemGrid" class="nui-datagrid"
		     style="width:100%;height:auto;"
		     dataField="itemBill"
		     showPager="false"
		     showModified="false"
		     allowSortColumn="false" allowCellEdit="true" allowCellSelect="true"
		     oncellcommitedit="onCellCommitEditItem"
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
                 <div field="action" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="操作" align="center"></div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:chooseItem()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择项目</a>
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


    

</div>
<script type="text/javascript">
var boxServiceTypeId = [{ id: 1, text: "厂外维修" }, { id: 2, text: "厂内翻新" }, { id: 3, text: "厂外返修" }];
                var QD = [{ id: 1, text: "FWD" }, { id: 2, text: "RWD" }, { id: 3, text: "4WD" }];
 nui.parse();
</script>
</body>
</html>
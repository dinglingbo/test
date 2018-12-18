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
    <title>工单模板设置详情</title>
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/addQuickBill.js?v=1.0.13"></script>
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
    <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
        <tr>            
            <td style="text-align:left;">
                <!-- <span id="carHealthEl" class="" style="font-family:Verdana;color:white;background:#62b900;padding:0px 8px;border-radius:90px;">车况:100</span>
                <a class="nui-button" iconCls="" plain="false" onclick="" id="addBtn">查看详情</a>
                <span class="separator"></span> -->
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="billForm" class="form">
        <input name="id" class="nui-hidden" id="rid"/>
        <input id="enterDate" name="enterDate" class="nui-datepicker"visible="false"nullValue="null" format="yyyy-MM-dd HH:mm" showTime="true"  showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" width="100%"/>
        <table  style=" left:0;right:0;margin: 0 auto;width:100%"> 
            <tr>   
                <td class="title required">模板名称:</td> 
                <td class="" style="width:"><input  class="nui-textbox" name="modelName" id="modelName" style="width:100%;"/></td>
                 <td class="title required">
                    <label>开单类型:</label>
                </td>
                <td class="" style="width:">
                    <input class="nui-combobox" id="billTypeId" name="billTypeId" data="[{id:1,text:'综合'},{id:2,text:'洗美'},{id:3,text:'理赔'}]" width="100%" value="1"/>
                </td>
                <td class="title required">
                    <label>业务类型:</label>
                </td>
                <td class="" style="width:">
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
                
                 <td class="title">创建日期:</td> 
                <td class="" style="width:">
                    <input id="recordDate"
                    name="recordDate"
                    allowInput="false" format="yyyy-MM-dd"
                    class="nui-datepicker" style="width:100%;"
                    enabled="false"
                    />
                </td>

	            </tr>
	            <tr>
	            <td class="title" >
                  <label>品牌：</label>
	            </td>
	            <td style="width:">
	                 <input class="nui-combobox"  id="carBrandId" name="carBrandId" allowInput="true" valueField="id" textField="name" onvaluechanged="onCarBrandChange"   width="100%"/>
	            </td>
	            <td class="title">
	                  <label>车系：</label>
	             </td>
	             <td style="width:">
	                 <input class="nui-combobox"  id="carSeriesId" name="carSeriesId" allowInput="true" textField="name" valueField="id" width="100%"/>
	             </td>

                <td class="title">备注:</td> 
                <td class="" colspan="3"><input  class="nui-textbox" name="remark" style="width:100%;"/></td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
    <div class="" style="width:100%;height:auto;" >
        <div style="width:100%;height:5px;"></div>
        <div id="rpsPackageGrid" class="nui-datagrid"
		     style="width:100%;height:auto;"
		     dataField="pkgBill"
		     showPager="false"
             showModified="false"
             allowSortColumn="false"
		    >
    <div property="columns">
    	 <div type="indexcolumn" headerAlign="center" align="center"visible="false">序号</div>
         <div field="orderIndex"  headerAlign="center" allowSort="false" visible="true" width="20" name="num">序号</div>
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
                             url=""  emptyText=""  vtype="required" /> 
                </div>
                <div field="amt" headerAlign="center" name="pkgAmt"
                     allowSort="false" visible="true" width="60" header="原价" align="center">
                </div>
                <div field="rate" headerAlign="center" name="pkgRate"
                     allowSort="false" visible="true" width="60" header="优惠率" align="center">
                     <input property="editor"  width="60%" vtype="float"  class="nui-textbox"  onvaluechanged="onPkgRateValuechanged" selectOnFocus="true"/>
                </div>
                 <div field="subtotal" headerAlign="center" name="pkgSubtotal"
                     allowSort="false" visible="true" width="60" header="套餐金额" align="center" >
                     <input  vtype="float" class="nui-textbox" selectOnFocus="true" onvaluechanged="onPkgSubtotalValuechanged" property="editor"/>
                </div>
                <div field="packageOptBtn" name="packageOptBtn" width="100" headerAlign="center" header="操作" align="center"></div>
               </div>
            </div>
        </div>
    </div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:choosePackage()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择套餐</a>
    </span>
</div>
<div id="rpsItemGrid"
     borderStyle="border-bottom:1;"
     class="nui-datagrid"
     dataField="list"
     style="width: 100%; height:auto;"
     showPager="false"
     showModified="false"
     allowSortColumn="true"
     >
    <div property="columns">
        <div type="indexcolumn" headerAlign="center" name="index" visible="false">序号</div>
        <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
        <div header="项目信息">
            <div property="columns">
                <div field="prdtName" name="prdtName" headerAlign="center" allowSort="false" visible="true" width="100">项目名称</div>
                <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" align="center">业务类型
                    <input  property="editor" enabled="true" dataField="servieTypeList" 
                             class="nui-combobox" valueField="id" textField="name" data="servieTypeList"
                             url=""  emptyText=""  vtype="required"/> 
                </div>
                <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" name="itemItemTime">工时/数量
                    <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedComQty" selectOnFocus="true"/>
                </div>
                <div field="unitPrice" name="itemUnitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">单价
                    <input property="editor" vtype="float" class="nui-textbox"  onvaluechanged="onValueChangedItemUnitPrice" selectOnFocus="true"/>
                </div>
                <div field="rate" name="itemRate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" >
                                                          优惠率
                    <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedItemRate" selectOnFocus="true"/>
                </div>
                <div field="subtotal"  name="itemSubtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center">金额
                    <input property="editor" vtype="float" class="nui-textbox" onvaluechanged="onValueChangedItemSubtotal" selectOnFocus="true"/>
                </div>
                <div field="amt"  name="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">项目总金额
                </div>
                <div field="itemOptBtn" name="itemOptBtn" width="100" headerAlign="center" header="操作" align="center" ></div>
            </div>
        </div>
    </div>
</div>
   <div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:chooseItem()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择项目</a>
    </span>
    <span>&nbsp;</span>
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
            <a class="nui-button" iconCls="" plain="true" onclick="choosePart()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;选择配件</a>
            </td>
        </tr>
    </table>
  </div>  
 </div>                  
 </div>
</div>
<script type="text/javascript">
 nui.parse();
</script>
</body>
</html>
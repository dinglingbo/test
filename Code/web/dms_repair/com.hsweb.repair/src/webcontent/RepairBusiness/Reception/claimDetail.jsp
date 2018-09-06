<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-02 19:02:07
  - Description: 
-->

<head>
    <title>理赔工单</title>
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


        table {

            left: 0;
            right: 0;
            margin: 0 auto;
        }


        #table_A tr {
            height: 40px;
        }

        table tr td span {

            display: inline-block;
        }


        #table_A tr {
            height: 40px;
        }

        table tr td span {

            display: inline-block;
        }

        .tabwidth {
            width: 100%;
        }

        .tbtext {
            float: right;
            line-height: 40px;
        }

        .tbCtrl {
            width: 150px;
        }

        .mini-textbox {
            height: 28px;
        }

        .mini-textbox-border {
            height: 25px;
        }

        .mini-textbox-input {
            /* 输入框的里面的高度 */
            height: 24px;
        }

        .checkboxwidth {
            width: 65px;
            margin-left: 20px;
        }

        .mini-tabs-header {
            height: 30px;
        }

        .mini-button-text {
            line-height: 26px;
        }




        /* ////////////////下拉框样式/////////////////////////////// */

        .mini-buttonedit {
            height: 28px;
        }

        .mini-buttonedit-border {
            height: 25px;
        }

        .mini-buttonedit-input {
            height: 24px;
        }

        .mini-buttonedit-buttons {
            top: 3px;
            right: 10px;
        }

        .mini-buttonedit-button {
            border-left: 0px;
            background: #fff;
        }

        .mini-buttonedit-button-pressed,
        .mini-buttonedit-popup .mini-buttonedit-button {
            background: #fff;
            color: #333333;
            border-width: 0px;
            border-left: 0px;
        }

        .mini-buttonedit-popup .mini-buttonedit-button {
            background: #fff;
            border-width: 0px;
            border-left: 0px;
        }

        .mini-buttonedit-button-hover,
        .mini-buttonedit-hover .mini-buttonedit-button {
            color: #333;
            background: #fff;
            border-width: 0px;
            border-left: 0px;
        }

        /* /////////////////////////////////////////////// */

        .red {
            color: red;
        }

        .right {
            text-align: right;
        }

        .fwidtha {
            width: 120px;
        }

        .fwidthb {
            width: 120px;
        }

        .bt_trWidth {
            width: 170px;
        }

        .textboxWidth {
            width: 100%;
        }

        .htr {
            height: 30px;
        }

        .tmargin {
            margin-top: 10px;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>
    <div class="nui-fit">
        <table>
            <tr>
                <td class="tbtext">进场日期</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">预计交车日期</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
            </tr>
            <tr>
                <td class="tbtext">车主</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">车主电话</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">级别</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">来电途径</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>

            </tr>
            <tr>
                <td class="tbtext">车牌</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">车型</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">VIN码</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">车身颜色</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>

            </tr>
            <tr>
                <td class="tbtext">当前里程</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">下次保养</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">下次保养日期</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">油量</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>

            </tr>
            <tr>
                <td class="tbtext">车辆分类</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">业务分类</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">建档人</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>

            </tr>

        </table>
        <div class="nui-panel" title="送修人信息" width="100%" showCollapseButton="true">
            <table>
                <tr>
                    <td class="tbtext">姓名</td>
                    <td class="tbCtrl">
                        <input class="nui-textbox tabwidth" />
                    </td>
                    <td class="tbtext">联系方式</td>
                    <td class="tbCtrl">
                        <input class="nui-textbox tabwidth" />
                    </td>
                    <td class="tbtext">证件类型</td>
                    <td class="tbCtrl">
                        <input class="nui-textbox tabwidth" />
                    </td>
                    <td class="tbtext">证件号</td>
                    <td class="tbCtrl">
                        <input class="nui-textbox tabwidth" />
                    </td>

                </tr>
                <tr>
                    <td class="tbtext">性别</td>
                    <td class="tbCtrl">
                        <input class="nui-textbox tabwidth" />
                    </td>
                    <td class="tbtext">详细地址</td>
                    <td class="tbCtrl">
                        <input class="nui-textbox tabwidth" />
                    </td>


                </tr>


            </table>
        </div>

        <div class="nui-panel" title="保险/理赔信息" width="100%" showCollapseButton="true">
            <table>
                <tr>
                    <td class="tbtext">理赔公司</td>
                    <td class="tbCtrl">
                        <input class="nui-textbox tabwidth" />
                    </td>
                    <td class="tbtext">理赔保单号</td>
                    <td class="tbCtrl">
                        <input class="nui-textbox tabwidth" />
                    </td>
                    <td class="tbtext">同本车保险</td>
                    <td class="tbCtrl">
                        <input class="nui-textbox tabwidth" />
                    </td>
                    <td class="tbtext"></td>
                    <td class="tbCtrl">
                        <a class="nui-button" onclick="" plain="false">新增保险公司</a>
                    </td>

                </tr>



            </table>
        </div>
        <div style="width:100%;margin-top: 10px;">
            <a class="nui-button" onclick="" plain="false">套餐选择</a>
            <a class="nui-button" onclick="" plain="false">会员卡</a>
            <a class="nui-button" onclick="" plain="false">维修历史</a>
            <a class="nui-button" onclick="" plain="false">相关单据</a>
        </div>
        <div>
            <div id="rpsPackageGrid" class="nui-datagrid"
     style="width:100%;height:auto;"
     dataField="list"
     showPager="false"
     showModified="false"
     allowCellSelect="true"
     allowCellEdit="true"
     allowSortColumn="true">
    <div property="columns">
        <div headerAlign="center" type="indexcolumn" width="20">序号</div>
        <div header="套餐信息">
            <div property="columns">
                <div field="packageName" headerAlign="center" allowSort="false"
                     visible="true" width="100" header="套餐名称">
                </div>
                <div field="serviceTypeId" headerAlign="center"
                     allowSort="false" visible="true" width="50" header="业务类型">
                     <input  property="editor" enabled="true" dataField="servieTypeList" 
                             class="nui-combobox" valueField="id" textField="name" data="servieTypeList"
                             url="" onvaluechanged="" emptyText=""  vtype="required"/> 
                </div>
                <div field="pkgamt" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="套餐金额">
                </div>
                <div field="rate" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="优惠率">
                     <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="discountAmt" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="优惠金额">
                </div>
                <div field="subtotal" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="小计金额">
                </div>
                <div field="workers" headerAlign="center"
                     allowSort="false" visible="true" width="60" header="施工员">
                    <div id="combobox2" property="editor" class="mini-combobox" style="width:250px;"  popupWidth="100" textField="empName" valueField="empName" 
                    url="" data="memList" value="" multiSelect="true"  showClose="true" oncloseclick="onCloseClick" onvaluechanged="onworkerChanged" >     
                    <!-- <div property="columns">
                        <div header="ID" field="id"></div>
                        <div header="名称" field="empName"></div>
                    </div> -->
                </div>
                </div>
                <div field="workerIds" headerAlign="center"
                     allowSort="false" visible="false" width="80" header="施工员">
                </div>
                <div field="remark" headerAlign="center"
                     allowSort="false" visible="true" width="40" header="销售员">
                </div>
                <div field="packageOptBtn" name="packageOptBtn" width="100" headerAlign="center" header="操作" align="center"></div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:showHealth()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择套餐</a>
    </span>
</div>
<div id="packageDetailGridForm" style="display:none;">
    <div id="packageDetailGrid" class="nui-datagrid"
         style="width: 100%; "
         dataField="list"
         showPager="false"
         selectOnLoad="true"
         allowSortColumn="true">
        <div property="columns">
            <div field="typeName" headerAlign="center" allowSort="false"
                 visible="true" width="60">类型
            </div>
            <div field="name" headerAlign="center"
                 allowSort="false" visible="true" width="">名称
            </div>
            <div field="qty" headerAlign="center"
                 allowSort="false" visible="true" width="80">工时/数量
            </div>
            <div field="remark" headerAlign="center"
                 allowSort="false" visible="true" width="80">备注
            </div>
        </div>
    </div>
</div>
    



                            <div style="width:100%;height:5px;"></div>
                            
    
<div id="rpsItemGrid"
     borderStyle="border-bottom:1;"
     class="nui-datagrid"
     dataField="list"
     style="width: 100%; height:auto;"
     showPager="false"
     showModified="false"
     allowCellSelect="true"
     allowCellEdit="true"
     allowSortColumn="true">
    <div property="columns">
        <div headerAlign="center" type="indexcolumn" width="20">序号</div>
        <div header="工时信息">
            <div property="columns">
                <div field="itemName" headerAlign="center" allowSort="false" visible="true" width="100">工时名称</div>
                <div field="itemName" headerAlign="center" allowSort="false" visible="true" width="60">业务类型</div>
                <div field="itemTime" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="right">工时</div>
                <div field="amt" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="right">工时单价</div>
                <div field="amt" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="right">工时金额</div>
                <div field="rate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="right" numberFormat="p">优惠率</div>
                <div field="discountAmt" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="right">优惠金额</div>
                <div field="subtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="right">小计金额</div>
                <div field="worker" headerAlign="center" allowSort="false" visible="true" width="80">施工员</div>
                <div field="worker" headerAlign="center" allowSort="false" visible="true" width="60">销售员</div>
                <div field="itemOptBtn" name="itemOptBtn" width="100" headerAlign="center" header="操作" align="center" ></div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:showHealth()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择工时</a>
    </span>
</div>
    



                            <div style="width:100%;height:5px;"></div>
                            
    
<div id="rpsPartGrid"
     dataField="list"
     class="nui-datagrid"
     style="width: 100%; height:auto;"
     showPager="false"
     allowCellSelect="true"
     allowCellEdit="true"
     showModified="false"
     editNextOnEnterKey="true"
     allowSortColumn="true">
    <div property="columns" >
        <div headerAlign="center" type="indexcolumn" width="20">序号</div>
        <div header="配件信息">
            <div property="columns">
                <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称">
                    <!-- <input property="editor" class="nui-textbox" emptyText="配件编码、名称、拼音" /> -->
                </div>
                <div field="receTypeId" headerAlign="center" allowSort="false" visible="true" width="60" header="业务类型">
                    <input  property="editor" enabled="true" name="storehouse" dataField="storehouse" class="nui-combobox" valueField="customid" textField="name" data="receTypeIdList"
                     url="" onvaluechanged="" emptyText=""  vtype="required"/>
                </div>
                <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="int" align="right" header="数量">
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="unitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="right" header="单价">
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="amt" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="right" header="金额"></div>
                <div field="rate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="right" numberFormat="p" header="优惠率">
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="discountAmt" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="right" header="优惠金额">
                    <input property="editor" vtype="float" class="nui-textbox"/>
                </div>
                <div field="subtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="right">小计金额</div>
                <div field="partCode" headerAlign="center" allowSort="false" visible="true" width="80px" header="配件编码">
                  <input property="editor" vtype="float" class="nui-textbox"/> 
                </div>
                <div field="partCode" headerAlign="center" allowSort="false" visible="true" width="60px" header="销售员">
                  <input property="editor" vtype="float" class="nui-textbox"/> 
                </div>
                <div field="partOptBtn" name="partOptBtn" width="80" headerAlign="center" header="操作" align="center"></div>
            </div>
        </div>
    </div>
</div>
<div style="text-align:center;">
    <span id="carHealthEl" >
        <a href="javascript:showHealth()" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;选择配件</a>
    </span>
</div>
<div id="advancedMorePartWin" class="nui-window"
     title="" style="width:450px;height:200px;"
     showModal="false"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
     <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="addSelectPart" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;关闭</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="morePartGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="false"
               dataField=""
               frozenStartColumn="0"
               frozenEndColumn="1"
               onrowdblclick="addSelectPart"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div field="code" name="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
                  <div field="oemCode" name="comPartCode" width="100" headerAlign="center" header="OEM码"></div>
                  <div field="fullName" name="comPartCode" width="200" headerAlign="center" header="配件全称"></div>
              </div>
          </div>
    </div>
</div> 
        </div>
        <div id="datagrid3" class="nui-datagrid" showPager="false">
            <div property="columns">

                <div field="" width="100" headerAlign="center" align="center">材料名称</div>
                <div field="" width="100" headerAlign="center" align="center">数量</div>
                <div field="" width="100" headerAlign="center" align="center">删除</div>

            </div>
        </div>
 		<div style="width:100%;margin-top: 10px;text-align: center;">
            <a href="##" onclick="">添加自带材料</a>
        </div>

        <table>
            <tr>
                <td class="tbtext">代办费</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">诊断费</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">检测费</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">加工费</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>
                <td class="tbtext">管理费</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" />
                </td>

            </tr>
            <tr>
                <td class="tbtext">备注</td>
                <td colspan="9" class="tbCtrl">
                    <input class="nui-textarea tabwidth" style="height: 100px;" />
                </td>


            </tr>

            <tr>
                <td class="tbtext">应收总计</td>
                <td colspan="5" class="tbCtrl">￥0.00 = 工时费小计：￥0.00 + 材料费小计：￥0.00 +附加费小计：￥0.00</td>

            </tr>

        </table>
        <div style="width:100%;margin-top: 10px;text-align: center;">
            <a class="nui-button" onclick="" plain="false">保存</a>

            <a class="nui-button" onclick="" plain="false">价参</a>
        </div>

    </div>
    <script type="text/javascript">
        nui.parse();
    </script>
</body>

</html>
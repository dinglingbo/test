<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): huang
- Date: 2014-08-13 12:27:01
- Description:
  --%>
  <head>
    <title>
      计次卡添加
    </title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript">
    </script>
  </head>
  <body>
    <fieldset style="border:solid 1px #aaa;position:relative;margin:5px 2px 0px 2px;">
      <legend>
        计次卡
      </legend>
      <div id="dataform1" style="padding-top:5px;">
        <!-- hidden域 -->
        <input class="nui-hidden" name="ooperator.oContacts" id="ooperator.oContacts"/>
        <input class="nui-hidden" name="ooperator.operatorId" id="ooperator.operatorId"/>
        <table style="width:100%;height:95%;table-layout:fixed;" class="nui-form-table">
          <tr>
            <td class="form_label" style="width:15%;">
              卡名称:
            </td>
            <td colspan="1" style="width:35%;">
              <input class="nui-textbox" name="ooperator.userId"/>
            </td>
            <td class="form_label" style="width:13%;">
             有效期（月）:
            </td>
            <td colspan="2" style="width:37%;">
              <input class="nui-textbox" name="ooperator.postcode"/>
            </td>
          </tr>
          <tr>
            <td class="form_label">
             销售价格:
            </td>
            <td colspan="1">
              <input class="nui-textbox" name="ooperator.birthday"/>
            </td>
            <td class="form_label">
              总价值:
            </td>
            <td colspan="2">
              <input class="nui-textbox"  name="ooperator.gender"/>
            </td>
          </tr>
          <tr>
           <td class="form_label">
              销售提成方式:
            </td>
            <td colspan="1">
            <input class="nui-combobox" data ="[{value:'0',text:'按原价比例',},{value:'1',text:'按折后价比例'},{value:'2',text:'按产值比例',},{value:'3',text:'固定金额'}]" 
            textField="text" valueField="value" name="salesDeductType"  value="0" onvalidation="updateError()" id="x"/>

            </td>
            <td class="form_label">
             销售提成值:
            </td>
            <td colspan="1" >
              <input class="nui-textbox" name="salesDeductValue" requiredErrorText="元" vtype="float"/>
              
            </td>
			 <td colspan="1" ><div style="display:none;" id="y" >&nbsp元</div><div style="display:block;" id="b" >&nbsp%</div></td> 
          </tr>
          <tr>
			 <td class="form_label">
              状态:
            </td>
            <td colspan="2">
		    
		    <div class="mini-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical" name="status"
    textField="text" valueField="value"  data ="[{value:'0',text:'启用',},{value:'1',text:'禁用'}]" value="0">
</div>
		    
		</tr>
           <tr>
            <td class="form_label">
             使用条款:
            </td>
            <td colspan="2">
            <input class="nui-TextArea" name="useRemark"     style="width:330px;height:50px;"/>

            </td>
            </tr>
            <tr>
            <td class="form_label">
           卡说明:
            </td>
            <td colspan="1">
            <input class="nui-TextArea" name="remark"  style="width:330px;height:50px;"/>
            </td>
          </tr>
          <tr>
        </table>
      </div>
    </fieldset>
    <!-- 从表的修改 -->
    <div style="margin:0px 2px 0px 2px;" >
      <div class="nui-tabs" id="tab" activeIndex="0" style="width:100%;height:100%;">
        <div title="卡项目">
          <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
              <tr>
                <td style="width:15%;">
					 <a  class="nui-button" onclick="selectPackage()" iconCls="icon-add">
					    添加套餐
					</a>

                </td >
                <td style="width:15%;">
					 <a  class="nui-button" onclick="addItem()" iconCls="icon-add">
					    添加工时
					</a>
                </td >
                <td style="width:15%;">
					 <a  class="nui-button" onclick="addDetail()" iconCls="icon-add">
					    添加配件
					</a>
                </td>
                <td style="width:55%;">
					 <a  class="nui-button" onclick="" iconCls="icon-remove">
					    删除
					</a>
                </td>
              </tr>
            </table>
          </div>
          <div id="grid_0" class="nui-datagrid" style="width:100%;height:150px;" showPager="false" sortMode="client" allowCellEdit="true" allowCellSelect="true" multiSelect="true" editNextOnEnterKey="true" >
            <div property="columns">
              <div type="checkcolumn">
              </div>
              <div field="contactName" allowSort="true" align="left" headerAlign="center" width="">
               项目名称
                <input class="nui-textbox" name="contactName" property="editor"/>
              </div>
               <div field="relation" allowSort="true" align="left" headerAlign="center" width="">
               次数
                <input class="nui-textbox" name="relation" property="editor"/>
              </div>
              <div field="relation" allowSort="true" align="left" headerAlign="center" width="">
               项目类型
                <input class="nui-textbox" name="relation" property="editor"/>
              </div>
              <div field="phone" allowSort="true" align="left" headerAlign="center" width="">
                工时/数量
                <input class="nui-textbox" name="phone" property="editor"/>
              </div>
              <div field="postcode" allowSort="true" align="left" headerAlign="center" width="">
                原价
                <input class="nui-textbox" name="postcode" property="editor"/>
              </div>
              <div field="address" allowSort="true" align="left" headerAlign="center" width="">
                销价
                <input class="nui-textbox" name="address" property="editor"/>
              </div>
              <div field="email" allowSort="true" align="left" headerAlign="center" width="">
                原销售金额
                <input class="nui-textbox" name="email" property="editor"/>
              </div>
              <div field="email" allowSort="true" align="left" headerAlign="center" width="">
                现销售金额
                <input class="nui-textbox" name="email" property="editor"/>
              </div>

            </div>
          </div>
        </div>
      </div>
      <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
        <table width="100%">
          <tr>
            <td style="text-align:center;" colspan="4">
              <a class="nui-button" iconCls="icon-save" onclick="onOk()">
                保存
              </a>
              <span style="display:inline-block;width:25px;">
              </span>
              <a class="nui-button" iconCls="icon-cancel" onclick="onCancel()">
                取消
              </a>
            </td>
          </tr>
        </table>
      </div>
    </div>
    <script type="text/javascript">
      nui.parse();
      var tab = nui.get("tab");
      var form = new nui.Form("#dataform1");
      form.setChanged(false);

      function onOk(){
        saveData();
      }

      function gridAddRow(datagrid){
        var grid = nui.get(datagrid);
        grid.addRow({});
      }

      function gridRemoveRow(datagrid) {
        var grid = nui.get(datagrid);
        var rows = grid.getSelecteds();
        if (rows.length > 0) {
          grid.removeRows(rows, true);
        }
      }

      function setGridData(datagrid,dataid){
        var grid = nui.get(datagrid);
        var grid_data = grid.getChanges();
        nui.get(dataid).setValue(grid_data);
      }

      function saveData(){
        form.validate();
        if(form.isValid()==false) return;
        setGridData("grid_0","ooperator.oContacts");
        var data = form.getData(false,true);
        var json = nui.encode(data);

        $.ajax({
          url:"com.primeton.nuisample.ooperatorbiz.addOOperator.biz.ext",
          type:'POST',
          data:json,
          cache:false,
          contentType:'text/json',
          success:function(text){
            var returnJson = nui.decode(text);
            if(returnJson.exception == null){
              CloseWindow("saveSuccess");
            }else{
              nui.alert("保存失败", "系统提示", function(action){
                if(action == "ok" || action == "close"){
                  //CloseWindow("saveFailed");
                }
                });
              }
            }
            });
          }

          function onReset(){
            form.reset();
            form.setChanged(false);
          }

          function onCancel(){
            CloseWindow("cancel");
          }

          function CloseWindow(action){
            if(action=="close"){

              }else if(window.CloseOwnerWindow)
              return window.CloseOwnerWindow(action);
              else
              return window.close();
            }
            
            		  function updateError(e) {
            
		  
            if (nui.get('x').getValue()=="3") {
                document.getElementById('y').style.display='block';
                document.getElementById('b').style.display='none';
            }else{
            	document.getElementById('b').style.display='block';
            	document.getElementById('y').style.display='none';
            }
        }
        
        
        
        function addDetail(){
        	alert("11");
             var list = rightGrid.getData();
   			 nui.open({
			 	targetWindow: window,
				url: "com.hsweb.part.common.partSelectView.flow?token=" + token,
				title: "配件选择",
				width: 900, height: 500,
				allowDrag:true,
				allowResize:false,
				onload: function (){
					var iframe = this.getIFrameEl();
					var params = {
						list:list
					};
					iframe.contentWindow.setData(params);
				},
				ondestroy: function (action){
					if(action == "ok"){
						var iframe = this.getIFrameEl();
						var data = iframe.contentWindow.getData();
						data = data||{};
						var part = data.part;
						console.log(part);
						getCycStoreByPartId(part.id,function(data){
						data = data||{};
							if(data.cyc){
								var cycStore = data.cyc;
								var detail = {};
								detail.applyCarModel = part.applyCarModel;
								detail.partBrandName = part.partBrandName;
								detail.partId = part.id;
								detail.partName = part.name;
								detail.partFullName = part.fullName;
								detail.partNameId = part.partNameId;
								detail.partCode = part.code;
								detail.unit = part.unit;
								detail.balaUnitPrice = 0;
								detail.paperQty = cycStore.stockQty||0;
								detail.trueQty = detail.paperQty;
								detail.invtLossQty = 0;
								detail.storeLocation = cycStore.stockLocation;
								detail.stockLocationId = cycStore.stockLocationId;
								rightGrid.addRow(detail);
							}
						});
					}
				}
		});
}


//本店套餐录入
function selectPackage() {
var maintain = basicInfoForm.getData();
if (!maintain.id) {
return;
}
nui.open({
targetWindow: window,
url: "com.hsweb.repair.common.rpbPackageSelect.flow",
title: "本店套餐",
width: 1000,
height: 600,
allowResize: false,
onload: function () {
var iframe = this.getIFrameEl();
var params = {};
iframe.contentWindow.setData(params, function (data, callback) {
console.log(data);
var _package = {};
var tmpPkg = data.package;
_package.serviceId = maintain.id;
_package.packageId = tmpPkg.id;
_package.packageName = tmpPkg.name;
_package.packageTypeId = tmpPkg.type;
_package.receTypeId = "04150101";
_package.pkgamt = tmpPkg.amount;
_package.amt = tmpPkg.amount;
_package.detailAmt = tmpPkg.amount;
_package.subtotal = tmpPkg.amount;
_package.amt4s = tmpPkg.total;
_package.differAmt = 0;
_package.costAmt = 0;
_package.discountAmt = 0;
_package.rate = 0;
_package.status = 0;
_package.isDisabled = 0;
var tmpItemList = data.itemList;
var itemList = tmpItemList.map(function (v) {
return {
itemId: v.itemId,
itemCode: v.itemCode,
itemName: v.itemName,
itemIsNeed: 1,
receTypeId: _package.receTypeId,
serviceId: _package.serviceId,
itemKind: v.itemKind,
itemTime: v.itemTime,
unitPrice: v.unitPrice,
pkgitemamt: v.amt,
amt: v.amt,
rate: 0,
discountAmt: 0,
subtotal: v.amt,
status: 0
}
});
var tmpPartList = data.partList;
var partList = tmpPartList.map(function (v) {
return {
receTypeId: _package.receTypeId,
serviceId: _package.serviceId,
partId: v.partId,
partCode: v.partCode,
partName: v.partName,
partIsNeed: 1,
qty: v.qty,
unit: v.unit,
unitPrice: v.unitPrice,
amt: v.amt,
rate: 0,
discountAmt: 0,
subtotal: v.amt,
status: 0
};
});
var par = {
pkg: _package,
itemList: itemList,
partList: partList
};
savePackage(par, function (data) {
data = data || {};
if (data.errCode == "S") {
callback && callback({
info: "本店套餐录入成功",
close: true
});
loadPackageGridData();
}
else {
callback && callback({
info: data.errMsg || "本店套餐录入失败",
close: false
});
}
});
});
},
ondestroy: function (action) {
}
});
}



function selectItem(callback)
{
	nui.open({
		targetWindow: window,
		url: "com.hsweb.repair.DataBase.RepairItemMain.flow",
		title: "维修项目", width: 930, height: 560,
		allowDrag:true,
		allowResize:true,
		onload: function ()
		{
			var iframe = this.getIFrameEl();
			var params = {};
			params.list = rightItemGrid.getData();
			iframe.contentWindow.setData(params);
		},
		ondestroy: function (action)
		{
			if(action == "ok")
			{
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				callback && callback(data);
			}
		}
	});
}
function addItem()
{

	selectItem(function(data)
	{
		var item = data.item;
		var packageItem = {
			itemId:item.id,
			itemCode:item.code,
			itemName:item.name,
			itemTime:item.itemTime,
			itemKind:item.itemKind,
			itemKindName:item.itemKindName,
			unitPrice:item.unitPrice,
			amt:item.amt
		};
		rightItemGrid.addRow(packageItem);
	});
}
        
          </script>
        </body>
      </html>

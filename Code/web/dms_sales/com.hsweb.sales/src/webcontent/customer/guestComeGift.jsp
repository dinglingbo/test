<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00 
  - Description:
-->
<head> 
    <title>精品加装</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  	<%-- <script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
 	<script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
 	<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>  --%> 
    <style type="text/css">
</style>
</head>
<body>
<div class="nui-fit"> 
	 <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
	    <table style="width:100%;">
	        <tr>
	            <td style="width:100%;">
	                <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
	                <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
	            </td>
	        </tr>
	    </table>
	</div>
	<div class="nui-fit">
	<div title="精品加装">
        <div class="mini-splitter" style="width:100%;height:100%;">
            <div size="30%" showCollapseButton="true">
                <div class="nui-fit">
                    <div id="jpGrid" class="nui-datagrid" style="width:100%;height:100%;" multiSelect="true" selectOnLoad="false" showPager="false" pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="data" showModified="false" onrowdblclick="" allowCellSelect="true"
                            editNextOnEnterKey="true" allowCellWrap="true" url="">
                            <div property="columns">
                                <div type="checkcolumn" width="20px">选择</div>
                                <div field="name" name="name" width="90px" headerAlign="center" header="精品名称"></div>
                            </div>
                        </div>
                     </div>
                 </div>
<!-- oncellcommitedit="onCellCommitEdit"
 -->                        
                    <div showCollapseButton="true">
                    <div id="jpDetailGrid" class="nui-datagrid" style="width:100%;height:100%;"  showSummaryRow="true" selectOnLoad="false" allowcelledit="true" showPager="false" pageSize="50" totalField="page.count" sizeList=[20,50,100,200]
                    dataField="data" showModified="false" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true" allowCellWrap="true" url="">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div field="giftName" name="giftName" width="100px" headerAlign="center" header="精品名称"></div>
                        <div field="receType" name="receType" width="100px" headerAlign="center" header="收费类型">
                        <input class="nui-combobox"  name="name"  valueField="id" id="name"
                             textField="name"  property="editor" data="statusList" emptyText="" />
          
                        </div>
                        <div field="qty" name="qty" width="100px" headerAlign="center" header="数量">
                            <input class="nui-textbox" property="editor" vtype="float">
                        </div>
                        <div field="price" name="price" width="100px" headerAlign="center" header="单价">
                            <input class="nui-textbox" property="editor" vtype="float">
                        </div>
                        <div field="amt" name="amt" width="100px" headerAlign="center" header="金额" summaryType="sum">
                        </div>
                        <div field="costPrice" name="costPrice" width="100px" headerAlign="center" header="成本单价">
                            <input class="nui-textbox" property="editor" vtype="float">
                        </div>
                        <div field="costAmt" name="costAmt" width="100px" headerAlign="center" header="成本金额">
                            <input class="nui-textbox" property="editor" vtype="float">
                        </div>
                        <div field="remark" name="remark" width="100px" headerAlign="center" header="备注内容">
                            <input class="nui-textarea" property="editor">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</div>
<script type="text/javascript">
  nui.parse();
var jpGrid = null;
var baseUrl = apiPath + saleApi + "/";
var jpUrl = baseUrl + "sales.search.searchCsbGiftMsg.biz.ext";
var jpDetailGrid = null;
var jpDetailGridUrl = baseUrl + "sales.search.searchSaleGiftApply.biz.ext";
var serviceIdF = null;
var statusList = [{id:"0",name:"免费"},{id:"1",name:"收费"}];
$(document).ready(function (){
   jpGrid = nui.get("jpGrid");
   jpGrid.setUrl(jpUrl);
   jpDetailGrid = nui.get("jpDetailGrid");
   jpDetailGrid.setUrl(jpDetailGridUrl);
   jpGrid.load();
   jpGrid.on("rowclick", function(e) {
        /* var billFormData = billForm.getData(true); //主表信息
        if (billFormData.status != 0) {
            return;
        } */
        var jpdata = jpGrid.getSelecteds();
        var jpDetailData = jpDetailGrid.getData();
        for (var i = 0, l = jpdata.length; i < l; i++) {
            var msg = jpDetailData.find(jpDetailData => jpDetailData.giftId == jpdata[i].id);
            if (!msg) {
                var newRow = {
                    giftId: jpdata[i].id,
                    giftName: jpdata[i].name,
                    billType:1
                };
                jpDetailGrid.addRow(newRow, jpDetailData.length);
            };
        }
        jpDetailData = jpDetailGrid.getData();
        for (var i = 0, l = jpDetailData.length; i < l; i++) {
            var row = jpDetailGrid.getRow(i);
            var msg = jpdata.find(jpdata => jpdata.id == jpDetailData[i].giftId);
            if (!msg) {
                jpDetailGrid.commitEdit();
                jpDetailGrid.removeRow(row, false);
            };
        };
    });
     jpGrid.on("load", function(e) {
        var data = jpDetailGrid.getData();
        var data1 = jpGrid.getData();
        for (var i = 0, l = data.length; i < l; i++) {
            for (var j = 0, k = data1.length; j < k; j++) {
                if (data[i].giftId == data1[j].id) {
                    var row = jpGrid.getRow(j);
                    jpGrid.select(row, false);
                };
            };
        };
    });
    jpDetailGrid.on("load", function(e) {
        var data = jpDetailGrid.getData();
        var data1 = jpGrid.getData();
        for (var i = 0, l = data.length; i < l; i++) {
            for (var j = 0, k = data1.length; j < k; j++) {
                if (data[i].giftId == data1[j].id) {
                    var row = jpGrid.getRow(j);
                    jpGrid.select(row, false);
                };
            };
        };
    });
    jpDetailGrid.on("cellendedit", function(e) {
        var row = e.row,
            field = e.field;
        if (field == "price" || field == "qty"  || field == "costPrice") {
            var price = row.price || 0;
            var qty = row.qty || 0;
            var costPrice = row.costPrice || 0;
            var value = (price * qty).toFixed(2);
            var value2 = (costPrice * qty).toFixed(2);
            var newRow = { amt: value ,
                           costAmt:value2
                  };
            jpDetailGrid.updateRow(row, newRow);
            //编辑完成后调用购车计算表将精品加装金额赋值上去,需要在购车预算里面计算这个的值
            /* var data = jpDetailGrid.getBottomColumns();
            var decrAmt = data.find(data => data.field == "amt").summaryValue;
            document.getElementById("caCalculation").contentWindow.setDecrAmt(decrAmt); */
        };
    });
    jpDetailGrid.on('drawcell', function (e) {
      var value = e.value;
      var field = e.field;
      if (field == 'receType') {
           e.cellHtml = (value == 0 ? '免费' : '收费');
       } 
    });
   document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }
     }  
});

/* var requiredField = {
	name : "客户名称",
	source:"客户来源",
	nature:"特征",
	buyCarStatus:"购车次数",
	mobile : "手机号",
	saleAdvisorId : "销售顾问",
	identity:"身份"
};*/
var saveUrl = apiPath + saleApi + "/sales.save.saveGiftApply.biz.ext";
function save(){
    if (serviceIdF && serviceIdF < 0) {
        showMsg("请先保存来访登记", "W");
        return;
    }else if(statusF==1){
    	showMsg("来访登记已归档不能修改!","W");
    	return;
    }else if(statusF==2){
    	showMsg("来访登记已转销售不能修改!","W");
    	return;
    }else {
       var jpDetailGridAdd = jpDetailGrid.getChanges("added"); //精品加装
	   var jpDetailGridEdit = jpDetailGrid.getChanges("modified");
	   var jpDetailGridDel = jpDetailGrid.getChanges("removed");
	   nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '保存中...'
	    });
	     var json = nui.encode({
	        serviceId:serviceIdF,
	   		jpDetailGridAdd:jpDetailGridAdd,
	   		jpDetailGridEdit:jpDetailGridEdit,
	   		jpDetailGridDel:jpDetailGridDel,
	   		token:token
	   	  });
		nui.ajax({
			url : saveUrl,
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				if(text.errCode=="S"){
			    	showMsg("保存成功","S");
			    }else{
			    	showMsg("保存失败","E");
			    }
				nui.unmask(document.body);
			}
	    }); 
    }
}
var statusF = null;
function setData(params){
    serviceIdF = params.id;
    statusF = params.status;
    jpDetailGrid.load({
        token:token,
        serviceId:serviceIdF,
        billType:1
    });
}


function CloseWindow(action)
{
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else window.close();
}

function onCancel() {
	CloseWindow("cancel");
}
  
</script>
</body>
</html>
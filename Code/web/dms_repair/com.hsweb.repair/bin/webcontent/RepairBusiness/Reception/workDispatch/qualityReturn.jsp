<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
<head>
    <title>查看调度</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/commonRepair.jsp"%>
    <title>质检打回</title>
    <style type="text/css">
        table {
            font-size: 12px;
        }

        .form_label {
            width: 100px;
            text-align: right;
        }

        .required {
            color: red;
        }
        
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
<div class="nui-fit">
     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" onclick="save()" plain="true" style="width: 60px;" id="save" visible="true"><span class="fa fa-save fa-lg"></span>&nbsp;确定</ a>
                    <a class="nui-button" onclick="CloseWindow('cancle')" plain="true" id="cancle" style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
    <div  id="mainGrid" class="nui-datagrid"
	    style="width:100%;height:100%;"
	    dataField="data"
	    showPager="false"
	    showModified="false"
	    allowSortColumn="false"
	    allowCellWrap=true
	     >
      <div property="columns">
           <div field="id" headerAlign="center" allowSort="false" visible="false" width="100" header="id" align="center"></div>
    	   <div field="itemName" headerAlign="center" allowSort="false" visible="true" width="100" header="项目名称" align="center"></div>
           <div field="workers" headerAlign="center" name="identity" allowSort="false" visible="true" width="50" header="施工员" align="center"> </div>
           <div field="remark" name="remark" headerAlign="center" allowSort="false" visible="true" width="120" header="打回原因" align="center">
            <input property="editor"  class="nui-textarea" id="remark"  selectOnFocus="true" width="80%"/>
           </div>
     </div>
    </div>
   </div>
</div>
    <script type="text/javascript">
	var mainGrid = null;
	var rowItem = {};
	$(document).ready(function (){
	mainGrid = nui.get("mainGrid");
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }
     }
	});		
	function setData(data){
	    rowItem = data;
	    var itemList =[];
	    itemList.push(data);
	    mainGrid.setData(itemList);
	    var row = mainGrid.findRow(function(row){
 		   mainGrid.beginEditRow(row);		 
 	    });
	}
	function save(){
	  var row = mainGrid.getSelected() || "";
	  var remark = null;
	  if(row != ""){
	     var remarkget = mainGrid.getCellEditor("remark", row);
	     remark = remarkget.getValue();
	  }else{
	     showMsg("请填写质检打回原因!","W");
	  }
      
	  if(remark == null){
	     showMsg("请填写质检打回原因!","W");
	  }else{
	   if($.trim(remark).length == 0) {
           showMsg("请填写质检打回原因!","W");
         } 
	  }
       if(rowItem){
    	nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '保存中...'
        });
    	nui.ajax({
            url:apiPath + repairApi + "/" +"com.hsapi.repair.repairService.sureMt.updateItemDispatch.biz.ext",
            type:"post",
            async:false,
            data:JSON.stringify({
            	rpsItem:rowItem,
            	status:4,
            	remark:remark,
            	token: token
            }),
            success:function(data)
            {
            	if(data.errCode == "S"){
            		showMsg("质检打回成功","S");
            		CloseWindow("ok")
            	}else{
            		showMsg("质检打回失败","E")
            	}
            	nui.unmask(document.body);
            },
            error:function(jqXHR, textStatus, errorThrown){
            	nui.unmask(document.body);
                console.log(jqXHR.responseText);
            }
        });
      }
	}
	
	function CloseWindow(action) {
       if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
       else window.close();
    }
    </script>
         
</body>
</html>
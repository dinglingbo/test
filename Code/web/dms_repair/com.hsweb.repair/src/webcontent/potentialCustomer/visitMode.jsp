<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
    <%@include file="/common/common.jsp"%>
        <%@include file="/common/commonRepair.jsp"%>
            <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
            <html>
            <!-- 
  - Author(s): Administrator
  - Date: 2018-01-31 16:54:43
  - Description:
-->
<head>
    <title>来访方式</title>
     <%-- <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/selectCustomer.js?v=1.0.0"></script>  --%>
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
                    
                   <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                   <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                   <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                   <a class="nui-button" onclick="CloseWindow('cancle')" plain="true" id="cancle" style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;退出</a>
                </td>
            </tr>
        </table>
    </div>
    	
    <div class="nui-fit">
    <div  id="guestGrid" class="nui-datagrid"
	    style="width:100%;height:100%;"
	    dataField="list"
	    showPager="false"
	    showModified="false"
	    allowSortColumn="false"
	    allowCellWrap=true
	    allowCellEdit="true"
	    pageSize="20"
        totalField="page.count"
	     >
      <div property="columns">
           <div width="30" type="indexcolumn">序号</div>
           <div field="id" headerAlign="center" allowSort="false" visible="false" width="100" header="id" align="center"></div>
    	   <div field="fullName" headerAlign="center" allowSort="false" visible="true" width="100" header="名称" align="center"></div>
     </div>
    </div>
   </div>
</div>

<div id="advancedAddWin" class="nui-window"
     title="购车用途" style="width:300px;height:160px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
       <div class="nui-toolbar" style="">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="onAdvancedAddOk()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a>
                            <a class="nui-button" onclick="onAdvancedAddCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                        </td>
                    </tr>
                </table>
            </div>
    <div id="advancedAddForm" class="form">
        <input id="id" name="id" width="100%" class="nui-hidden" >
    	<input id="orgid" name="orgid" width="100%" class="nui-hidden" >
        <table class="tmargin" style="width:100%;margin-top:10px;">
            <tr class="htr">
                <td ><input id="name" name="name" width="100%" class="nui-textbox" ></td>
            </tr>
        </table>
    </div>
</div>
 
</body>

</html>
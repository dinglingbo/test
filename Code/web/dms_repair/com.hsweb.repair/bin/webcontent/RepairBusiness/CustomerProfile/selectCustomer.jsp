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
    <title>选择客户</title>
     <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/selectCustomer.js?v=1.0.0"></script> 
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
                    
                    <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;确定</ a>
                    <a class="nui-button" onclick="CloseWindow('cancle')" plain="true" id="cancle" style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                </td>
            </tr>
        </table>
    </div>
    	<div class="nui-toolbar" style="border-bottom: 0;">
		<div class="nui-form" id="queryForm">
			<table class="table">
				<tr>
					<td>
					   <label style="font-family: Verdana;">快速查询：</label>
						<input class="nui-textbox" name="guestFullName" emptyText="客户名称" onenter="onSearch()" style="width:150px" />					
						<input class="nui-textbox" name="mobile" id="mobile"  onenter="onSearch()" emptyText="手机号码" style="width:150px" />
						<a class="nui-button" iconCls="" plain="true" onclick="onSearch()">
							<span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
     <div style="padding-bottom: 5px;padding-top: 5px">
         <span>合并原因:</span>  <input class="nui-textbox" name="remark" width="45%"  id="remark" />
     </div>
    <div class="nui-fit">
    <div  id="guestGrid" class="nui-datagrid"
	    style="width:100%;height:100%;"
	    dataField="list"
	    showPager="true"
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
    	   <div field="fullName" headerAlign="center" allowSort="false" visible="true" width="100" header="客户姓名" align="center"></div>
    	    <div field="mobile" headerAlign="center" allowSort="false" visible="true" width="120" header="客户手机" align="center"></div>
           <div field="sex" headerAlign="center" name="sex" allowSort="false" visible="true" width="50" header="性别" align="center" ></div>
           <div name="addr" field="addr"  headerAlign="center"  visible="true" width="200px" header="地址"></div>
     </div>
    </div>
   </div>
</div>         
</body>

</html>
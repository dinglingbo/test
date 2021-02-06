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
    <title>选择联系人</title>
     <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/selectContactor.js?v=1.0.0"></script> 
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
    </style>
</head>
<body>
<div class="nui-fit">
     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" onclick="save()" plain="true" style="width: 60px;" id="save"><span class="fa fa-save fa-lg"></span>&nbsp;确定</ a>
                    <a class="nui-button" onclick="CloseWindow('cancle')" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
    <div  id="contactorGrid" class="nui-datagrid"
	    style="width:100%;height:100%;"
	    dataField="contactList"
	    showPager="false"
	    showModified="false"
	    allowSortColumn="false"
	    allowCellWrap=true
	     >
      <div property="columns">
           <div field="id" headerAlign="center" allowSort="false" visible="false" width="100" header="id" align="center"></div>
    	   <div field="name" headerAlign="center" allowSort="false" visible="true" width="100" header="联系人姓名" align="center"></div>
           <div field="identity" headerAlign="center" name="identity" allowSort="false" visible="true" width="50" header="身份" align="center"> </div>
           <div field="sex" headerAlign="center" name="sex" allowSort="false" visible="true" width="50" header="性别" align="center" ></div>
           <div field="mobile" headerAlign="center" allowSort="false" visible="true" width="120" header="联系人手机" align="center"></div>
           <div field="idNo" headerAlign="center" allowSort="false" visible="true" width="160" header="证件号" align="center"></div> 
           <div field="remark" headerAlign="center" name="remark" allowSort="false" visible="true" width="200" header="备注" align="center"></div>
     </div>
    </div>
   </div>
</div>         
</body>

</html>
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
     <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/bindWechatContactor.js?v=1.0.14"></script> 
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
                    <a class="nui-button" onclick="save()" plain="true" style="width: 60px;" id="save" visible="false"><span class="fa fa-save fa-lg"></span>&nbsp;确定</ a>
                    <a class="nui-button" onclick="CloseWindow('cancle')" plain="true" id="cancle" style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
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
           <div field="wechatServiceId" name="wechatServiceId" headerAlign="center" allowSort="false" visible="true" width="120" header="服务号" align="center">
            <input property="editor"  class="nui-textbox" id="wechatId" onvaluechanged="wechatServiceIdChange" selectOnFocus="true" width="80%"/>
           </div>
           <div field="wechatOptBtn" name="itemOptBtn" width="100" headerAlign="center" header="操作" align="center" ></div>
     </div>
    </div>
   </div>
</div>         
</body>

</html>
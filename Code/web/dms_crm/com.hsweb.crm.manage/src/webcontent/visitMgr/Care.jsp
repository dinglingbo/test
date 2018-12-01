<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-18 12:13:16
  - Description:
-->
<head>
<title>特别关怀</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    	<script src="<%=request.getContextPath()%>/manage/js/Care.js?v=1.0.6">
	</script>
    
</head>
<body>
						<div class="nui-fit">
					     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
				                <table style="width:100%;">
				                    <tr>
				                        <td style="width:100%;">
				                            <a class="nui-button" onclick="save()" plain="true" style="width: 80px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
				                            <a class="nui-button" onclick="onClose()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
				                        </td>
				                    </tr>
				                </table>
				            </div>
                            <input class="nui-hidden" name="visitId" id="visitId"/>
                            <input class="nui-hidden" name="id" id="id"/>
                            <table class="tmargin" style="table-layout: fixed;width:100%">
                                <tr class="htr">
                                    <td  style="width: 70px;">关怀方式：</td>
                                    <td style="width: 100px;">
                                        <input id="visitMode" name="visitMode" class="nui-combobox textboxWidth" dataField="data" valueField="customid" textField="name">
                                    </td>

                                    <td style="width: "></td>
                                </tr> 
                                <tr class="htr">
                                    <td >关怀内容：</td>
                                    <td  colspan="6">
                                        <input id="visitContent" name="visitContent" class="nui-textarea textboxWidth" style="width: 100%;height:280px;">
                                    </td>
                                </tr> 
 
                            </table>
                        </div>
                    </div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>
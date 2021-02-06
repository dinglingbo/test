<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-25 09:17:32
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@ include file="/common/sysCommon.jsp" %>
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
<script
	src="<%= request.getContextPath() %>/manage/js/report/purchase/purchase.js?v=1.1"
	type="text/javascript"></script>
<!--下：采购订单-->
  </head>
<body>   
     <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                <a class="nui-button" iconCls="" plain="true" onclick="quSearch(0)" id="type0">本日</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quSearch(1)" id="type1">昨日</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="qukSearch(2)" id="type2">本周</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quSearch(3)" id="type3">上周</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quSearch(4)" id="type4">本月</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quSearch(5)" id="type5">上月</a>
                <span class="separator"></span>
               
                <span class="separator"></span>
                <label style="font-family:Verdana;">公司名称：</label>
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择公司"
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <span class="separator"></span>
                <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
            </td>
        </tr>
    </table>
</div>
     
    <div showCollapseButton="false">
            <div id="mainTabs" class="nui-tabs" activeIndex="0" style="width:100%; height:900px;" plain="false" onactivechanged="">
                  
                    <div title="按供应商排行" >
                      <div class="nui-fit">
                      <%@ include file="supplier.jsp" %>
                      </div>
                    </div>
                    
                    <div title="按商品排行" >
                      <div class="nui-fit">
                      <%@ include file="brand.jsp" %>
                      </div>
                    </div> 
                    
                        <div title="按配件类型排行" >
                      <div class="nui-fit">
                      <%@ include file="parts.jsp" %>
                      </div>
                    </div> 
                    
                    <div title="按品牌排行" >
                      <div class="nui-fit">
                      <%@ include file="commodity.jsp" %>
                      </div>
                    </div>  
			</div>
    </div>
    
    
    <div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:600px;height:350px;"
     showModal="true"
     allowResize="false"
     allowDrag="true"
     >
		<div id="advancedSearchForm" class="form">
			<table style="width:500px;">
				<tr>
					<td class="title">入库日期:</td>
					<td>
						<input name="sOrderDate"
							   width="120px"
							   class="nui-datepicker"/>
					</td>
					<td class="">至:</td>
					<td>
						<input name="eOrderDate"
							   class="nui-datepicker"
							   format="yyyy-MM-dd"
							   timeFormat="H:mm:ss"
							
							
							   width="120px"
							   />
					</td>
				</tr>
				
				
					<td class="title">
						<span style="letter-spacing: 6px;">供应商编码:</span>
					</td>
					<td colspan="3">
						<input id="btnEdit2"
							   name="guestId"
							   class="nui-buttonedit"
							   emptyText="请选择供应商..."
							   onbuttonclick="selectSupplier('btnEdit2')"
							   width="120px"
							   selectOnFocus="true" />
					</td>
				</tr>
				<tr>
					<td class="title">供应商拼音码:</td>
					<td colspan="3">
						<textarea class="nui-textarea" emptyText="" width="100px" style="height: 20px;" id="serviceIdList" name="serviceIdList"></textarea>
					</td>
					
					<td class="title">供应商名称:</td>
					<td colspan="3">
						<textarea class="nui-textarea" emptyText="" width="100px" style="height: 20px;" id="partCodeList" name="partCodeList"></textarea>
					</td>
				</tr>
				<tr>
					
				</tr>
				<tr>
					<td class="title">商品编码:</td>
					<td colspan="3">
						<input id="partName"
							   name="partName"
							   class="nui-textbox" 
							   width="120px"/>
					</td>
					<td class="title">商品拼音码:</td>
					<td colspan="3">
						<input id="partName"
							   name="partName"
							   class="nui-textbox" 
							   width="120px"/>
					</td>
				</tr>
				<tr>
					<td class="title">配件名称:</td>
					<td colspan="3">
						<input id="partId"
							   name="partId"
							   class="nui-textbox" 
							   width="120px"/>
					</td>
				</tr>
				<tr>
					<td class="title">配件类型:</td>
					<td colspan="3">
						<input id="partId"
							   name="partId"
							   class="nui-textbox" 
							   width="120px"/>
					</td>
				</tr>
				
				<tr>
					<td class="title">适用车型:</td>
					<td colspan="3">
						<input id="partName"
							   name="partName"
							   class="nui-textbox" 
							   width="120px"/>
					</td>
					<td class="title">品牌:</td>
					<td colspan="3">
						<input id="partName"
							   name="partName"
							   class="nui-textbox" 
							   width="120px"/>
					</td>
				</tr>
			</table>
			<div style="text-align:center;padding:10px;">
				<a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
				<a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
			</div>
			
		</div>
</div>
</body>
</html>
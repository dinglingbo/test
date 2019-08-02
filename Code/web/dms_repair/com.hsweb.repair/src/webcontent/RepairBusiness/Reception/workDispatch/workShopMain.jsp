<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 15:39:18
  - Description:
-->

<head>
    <title>编辑整车销售</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/commonRepair.jsp"%>
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/workDispatch/js/workShopMain.js?v=1.0.1" type="text/javascript"></script>  

</head>
<style type="text/css">
 
    </style>
    <body>
        <div class="nui-fit" style="padding-top:10px">
            <div class="mini-tabs" activeIndex="0" style="width:100%;height:100%;"  id="mainTabs" name="mainTabs">
               <div title="购车计算" id="editForm" name="editForm">
               <div class="nui-fit" style="padding-top:0px">
                <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
			    <table class="table" id="table1">
			     <tr>
		            <td>
		                <label>车牌号：</label>
		                <input class="nui-textbox" id="carNo-search" emptyText="" width="120"  onenter="doSearch()"/>
		                <label>服务顾问：</label>
	                    <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
	                        emptyText="服务顾问" url=""  allowInput="true" showNullItem="false" width="120" valueFromSelect="true"  onenter="doSearch()"/>
	                     <label>班组：</label>
	                     <input class="nui-combobox"  allowInput="true" required="false" id="memberGroupId" name="memberGroupId" textField="name" valueField="id" emptyText="选择工作组" onenter="doSearch()" />
	                     <a class="nui-button" iconCls="" plain="true" onclick="doSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
		            </td>
		        </tr>
			    </table>
				</div>
				 <div class="nui-splitter" style="width: 100%; height: 100%;">
		         <div size="430" showcollapsebutton="true">
		           <div class="nui-fit" >
		            <div id="mainGrid" class="nui-datagrid" dataField="list" style="width: 100%; height: 100%;" 
		             idField="id" allowResize="true"
		                sizeList="[20,50,100]" 
		                pageSize="20" 
		                totalField="page.count" 
		                showPager="true" 
		                onselectionchanged="selectionChanged"
		                showPagerButtonIcon="true" >
		                <div property="columns">
		                    <div type="indexcolumn" name="index" width="30px" headeralign="center" >  <strong>序号</strong></div>
		                    <div field="carNo" width="70" headeralign="left" visible="true"><strong>车牌号</strong></div>
		                    <div field="billTypeId" width="60" headeralign="left" visible="true"><strong>开单类型</strong></div>
		                    <div field="enterDate" name="enterDate"   width="120" headerAlign="left" dateFormat="  yyyy-MM-dd HH:mm"><strong>进厂日期</strong></div>
		                    <!-- <div field="enterDate" width="70" headeralign="left" visible="true"><strong>进厂时间</strong></div> -->
		                    <div field="mtAdvisor" width="70" headeralign="left" visible="true"><strong>服务顾问</strong></div>
		                </div>
		           </div> 
		         </div>
		         </div>
		         <div showcollapsebutton="true">
		           <div class="nui-fit" >
		            <div id="rightGrid" class="nui-datagrid" dataField="itemList" style="width: 100%; height: 100%;" 
		             idField="id" allowResize="true"
		                sizeList="[20,50,100]" 
		                pageSize="20" 
		                totalField="page.count" 
		                showPager="false" 
		                showPagerButtonIcon="true" >
		                <div property="columns">
		                    <div type="indexcolumn" name="index" width="30px" headeralign="center" >  <strong>序号</strong></div>
		                    <div field="id" width="70" headeralign="left" visible="false"><strong>项目ID</strong></div>
		                    <div field="itemName" width="70" headeralign="left" visible="true"><strong>项目</strong></div>
		                   <!--  <div field="beginDate" width="70" headeralign="left" visible="true"><strong>派工时间</strong></div> -->
		                    <div field="workers" width="70" headeralign="left" visible="true"><strong>施工员</strong></div>
		                    <div field="planFinishDate" width="70" headeralign="left" visible="true" dateFormat="  yyyy-MM-dd HH:mm"><strong>预计完工时间</strong></div>
		                    <div field="beginDate" width="70" headeralign="left" visible="true" dateFormat="  yyyy-MM-dd HH:mm"><strong>开始施工</strong></div>
		                    <div field="workTime" width="70" headeralign="left" visible="true"><strong>施工耗时</strong></div>
		                    <div field="stopTime" width="70" headeralign="left" visible="true"><strong>中断耗时</strong></div>
		                    <div field="finishDate" width="70" headeralign="left" visible="true" dateFormat="  yyyy-MM-dd HH:mm"><strong>实际完工时间</strong></div>
		                    <div field="status" width="70" headeralign="left" visible="true"><strong>状态</strong></div>
		                    <div field="itemOptBtn" width="70" headeralign="left" visible="true"><strong>操作</strong></div>
		                </div>
		           </div> 
		           </div>
		         </div>
		         </div>
		     </div>
            </div> 
               <div title="购车计算" id="editForm" name="editForm">
                  <iframe id="caCalculation" src="" style="width: 100%;height: 100%; border:0px" ></iframe>
              </div>
        </div>
     </div>
<script type="text/javascript">
   
</script>
 </body>
</html>
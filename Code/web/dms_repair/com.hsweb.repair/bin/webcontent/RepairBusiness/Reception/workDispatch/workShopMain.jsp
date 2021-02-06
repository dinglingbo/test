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
    <title>车间调度</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/commonRepair.jsp"%>
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/workDispatch/js/workShopMain.js?v=1.0.5" type="text/javascript"></script>  

</head>
<style type="text/css">
     a.optbtn {
            width: 52px;
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
.zhongduan{ left:-170px; top:-14px; width:170px; padding:5px; border:1px #d2d2d2 solid; border-radius:5px; background:#fff; box-shadow:0px 2px 5px #dcdcdc; z-index:888;}
.zhongduan ul li a{ display:block; height:32px; line-height:32px; text-align:left; padding-left:33px; background:url(repair/imag/zhongduan.png) left center no-repeat; text-decoration:none; color:#578ccd;border-radius:3px;}
.zhongduan ul li a:hover{ background-color:#ebf2f5;}
</style>
    <body>
        <div class="nui-fit"  >
        
            <div class="mini-tabs" activeIndex="0" style="width:100%;height:99%;"  id="mainTabs" name="mainTabs" onactivechanged="activechangedmain()">
               
               <div title="维修派工" id="repairWork" name="repairWork">
               <div class="nui-fit" >
                <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
			    <table class="table" id="table1">
			     <tr>
		            <td>
		                <label>车牌号：</label>
		                <input class="nui-textbox" id="carNo" emptyText="" width="120"  onenter="doSearch()"/>
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
				<div class="nui-fit" >
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
		                showPagerButtonIcon="true" 
		                selectOnLoad="true"
		                >
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
                 <!-- <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
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
				 </div> -->
				 
		         <div class="nui-splitter" style="width: 100%; height: 100%;" vertical="true">
		         <div size="50%" showcollapsebutton="true">
		         <div class="nui-fit" >
		            <div id="rightGrid" class="nui-datagrid" dataField="itemList" style="width: 100%; height: 100%;" 
		             idField="id" 
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
		                    <div field="workers" width="70" headeralign="left" visible="true"><strong>施工员
		                     <a href="javascript:setItemWorkers()" title="批量设置施工员" style="text-decoration:none;">&nbsp;&nbsp;<span class="fa fa-edit fa-lg"></span></a>
		                    </strong></div>
		                    <div field="planFinishDate" width="70" headeralign="left" visible="true" dateFormat="  yyyy-MM-dd HH"><strong>预计完工时间</strong></div>
		                    <div field="beginDate" width="70" headeralign="left" visible="true" dateFormat="  yyyy-MM-dd HH"><strong>开始施工</strong></div>
		                    <div field="workTime" width="70" headeralign="left" visible="true"><strong>施工耗时</strong></div>
		                    <div field="stopTime" width="70" headeralign="left" visible="true"><strong>中断耗时</strong></div>
		                    <div field="finishDate" width="70" headeralign="left" visible="true" dateFormat="  yyyy-MM-dd HH:mm"><strong>实际完工时间</strong></div>
		                    <div field="status" width="70" headeralign="left" visible="true"><strong>状态</strong></div>
		                    <div field="itemOptBtn" width="100" headeralign="left" visible="true"><strong>操作</strong></div>
		                </div>
		           </div> 
		           </div>
		          </div>
		           <div showcollapsebutton="true">
		               <div class="nui-fit" >
		            <div id="rightGrid2" class="nui-datagrid" dataField="itemList" style="width: 100%; height: 100%;" 
		             idField="id" 
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
		                    <div field="isBack" width="70" headeralign="left" visible="true"><strong>状态</strong></div>
		                     <div field="checkers" width="70" headeralign="left" visible="true"><strong>质检员
		                     <a href="javascript:checkerSelect()" title="批量设置质检员" style="text-decoration:none;">&nbsp;&nbsp;<span class="fa fa-edit fa-lg"></span></a>
		                     </strong></div>
		                     <div field="checkerIds" width="70" headeralign="left" visible="false">质检员</div>
		                     <div field="itemOptBtn" width="100" headeralign="left" visible="true"><strong>操作</strong></div>
		                </div>
		            </div> 
		            </div>
		            </div>
		          </div>	           
		         </div>
		         </div>
		     </div>
		     </div>
            </div> 
               <div title="车检派工" id="checkWork" name="checkWork">
                  <div class="nui-fit">
                  <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
			    <table class="table" id="table1">
			     <tr>
		            <td>
		                <label>车牌号：</label>
		                <input class="nui-textbox" id="carNo-search" emptyText="" width="120"  onenter="doSearch2()"/>
		                <!-- <label>服务顾问：</label>
	                    <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
	                        emptyText="服务顾问" url=""  allowInput="true" showNullItem="false" width="120" valueFromSelect="true"  onenter="doSearch()"/>
	                     <label>班组：</label>
	                     <input class="nui-combobox"  allowInput="true" required="false" id="memberGroupId" name="memberGroupId" textField="name" valueField="id" emptyText="选择工作组" onenter="doSearch()" /> -->
	                     <a class="nui-button" iconCls="" plain="true" onclick="doSearch2"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
		            </td>
		        </tr>
			    </table>
				</div>
				<div class="nui-fit" >
				  <div id="mainGrid2" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
				  totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
				  onshowrowdetail="onShowRowDetail" url="" allowCellWrap=true>
				  <div property="columns">
					<div width="10" type="indexcolumn">序号</div>
				    <div field="id" name="id" visible="false">id</div>
				    <div field="carNo" name="carNo" width="40" headerAlign="center" align="center">车牌</div>
				    <div field="carModel" name="carModel" width="80" headerAlign="center" align="center">接待人</div>
				    <div field="recordDate" name="recordDate" width="60" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm">派工时间</div>
				    <div field="checkMainName" name="checkMainName" width="80" headerAlign="center" align="center">检查名称</div>
				    <div field="checkMan" name="checkMan" width="80" headerAlign="center" align="center">检查人</div>
				    <div field="checkManId" name="checkManId" width="60" headerAlign="center" align="center" visible="false">查车技师Id</div>
				    <div field="checkPoint" name="checkPoint" width="60" headerAlign="center" align="center" visible="false">本次检查得分</div>
				    <div field="finishDate" name="finishDate" width="60" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm">检查完成时间</div>
				    <div field="checkStatus" name="checkStatus" width="40" headerAlign="center" align="center">状态</div>
				    <div field="checkOptBtn" name="checkOptBtn" width="60" headerAlign="center" align="center">操作</div>
				 </div>
				 </div>
				 </div>
              </div>
              </div>
        </div>
     </div>
      <div id="advancedStopWin" class="nui-window" bodyStyle="padding:0"
      title="" style="height:198px;width:184px;"
      showModal="false"
      showHeader="false"
      allowResize="false"
      allowDrag="true">
       <div class="zhongduan" style="display: block;">
        <ul style="padding:0px;list-style: none;">
            <li ><a href="javascript:stopWork(1);" name="projectpause" serviceprojectid="309810" statusid="8">等待客户答复</a></li>
            <li ><a href="javascript:stopWork(2);" name="projectpause" serviceprojectid="309810" statusid="9">等待保险公司定损</a></li>
            <li ><a href="javascript:stopWork(3);" name="projectpause" serviceprojectid="309810" statusid="10">等待配件</a></li>
            <li ><a href="javascript:stopWork(4);" name="projectpause" serviceprojectid="309810" statusid="1">等待施工</a></li>
            <li ><a href="javascript:stopWork(5);" name="projectpause" serviceprojectid="309810" statusid="11">等待洗车</a></li>
        </ul>
      </div>
    
      </div>                               
<script type="text/javascript">
   
</script>
 </body>
</html>
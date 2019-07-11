<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUillLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>

<html>  
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-02 20:50:20  
  - Description:  
-->         

<head> 
    <title>检查开单详情</title> 
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/checkDetail.js?v=1.2.9"></script>
    <style type="text/css">
    
    body { 
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
    .tbtext {
         width: 80px;
         text-align: right;
    }

    .vpanel {
        border: 1px solid #d9dee9;
        margin: 10px 0px 10px 0px;
        /* width: 39%;
        height: 248px; */

    }

    .vpanel_heading {
        border-bottom: 1px solid #d9dee9;
        width: 100%;
        height: 28px;
        line-height: 28px;
    }

    .vpanel_heading span {
        margin: 0 0 0 20px;
        font-size: 16px;
        font-weight: normal;
    }

    .vpanel_bodyww {
        padding: 10 10 10 10px !important
    }


    .function-item {
        margin-left: 5px;
        margin-right: 5px;
    } 
    
    /* 	#search{
		 display: none; 
		font-size:18px;
		text-align:center;
		left:240px;
		top:0px;
		text-align:center;
		z-index:999;
		color: #671e1ebf;
		width: 120px;
	    height: 40px;
	    background: #cac52afc;
	    position: absolute;
	    -moz-border-radius: 12px;
	    -webkit-border-radius: 12px;
	    border-radius: 12px;
	} */
 	#comment_bubble {

    width: 140px;
    height: 100px;
    background: #78c800c2;
    position: relative;
    -moz-border-radius: 12px;
    -webkit-border-radius: 12px;
    border-radius: 12px;
} 
  
/*  #search:before {
    content: "";
    width: 0;
    height: 0;
    right: 100%;
    top: 12px;
    position: absolute;
    border-top: 8px solid transparent;
    border-right: 18px solid #cac52afc;
    border-bottom: 8px solid transparent;
}   */
.tishi{
	margin-top: 5px;
}

.btn .mini-buttonedit{
	height:36px;
}
.btn .aa{
	height:36px;
	width: 350px;
}
.btn .mini-buttonedit .mini-corner-all{
	height:33px;
	background: #368bf447;
}
.btn .aa .mini-corner-all{
	height:33px;
}
.mini-corner-all .nui-textbox{
	height:30px;
}
.btn .mini-corner-all .mini-buttonedit-input{
	font-size: 16px;
	margin-top: 8px;
	
}
.btn .mini-corner-all .mini-textbox-input{
	font-size: 14px;
	margin-top: 8px;
	
}
</style>
</head>

<body>

    <div class="nui-toolbar" id="toolbar1" style="padding:2px;height:48px;position: relative;">
        <input class="nui-hidden" id="mid" name="mid" value='<b:write property="mid"/>'/>
        <input class="nui-hidden" id="tid" name="tid" value='<b:write property="tid"/>'/>
        <input class="nui-hidden" id="actionType" name="actionType" value='<b:write property="actionType"/>'/>
        <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
        <tr>            
            <td class="btn">
                <div class="mini-autocomplete" emptyText="未匹配到数据...(输入的内容长度要求大于或是等于3)"
                    style="width:350px;height: 50px !important;"  popupWidth="600" textField="text" valueField="id" 
                    id="search_key" url="" value="carNo"   searchField="key" 
                    dataField="list" placeholder="请输入...">     
                    <div property="columns">
                        <div header="客户名称" field="guestFullName" width="30" headerAlign="center"></div>
                        <div header="客户手机" field="guestMobile" width="60" headerAlign="center"></div>
                        <div header="车牌号" field="carNo" width="40" headerAlign="center"></div>
                        <div header="联系人名称" field="contactName" width="30" headerAlign="center"></div>
                        <div header="联系人手机" field="mobile" width="60" headerAlign="center"></div>
                        <div header="车架号(VIN)" field="vin" width="70" headerAlign="center"></div>
                    </div>
                </div>
                <input id="search_name"
                name="search_name"
                class="nui-textbox aa"
                emptyText="车牌号/客户名称/手机号/车架号(VIN)"
                onbuttonclick="onSearchClick()"
                visible="false"
                enabled="false"
                showClose="false"
                allowInput="true"/>
                <a class="nui-button" iconCls="" plain="false" onclick="addGuest()" id="addBtn">新增客户</a>
                <label style="font-family:Verdana;">工单号：</label>
                <label id="servieIdEl" style="font-family:Verdana;"></label>
            </td>    
            <td style="text-align:right;">
               <a class="nui-button" iconCls="" plain="true" onclick="addNew()" id="addNew"> <span class="fa fa-plus fa-lg"></span>&nbsp;新增</a> 
                <a class="nui-button" onclick="newCheckMainMore()" plain="true" id="history" name="history"><span class="fa fa-list fa-lg"></span>&nbsp;查看历史记录</a>
                <a class="nui-button" onclick="saveb()" plain="true" id="saveData" name="saveData"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" onclick="finish()" plain="true" id="saveData" name="saveData"><span class="fa fa-check fa-lg"></span>&nbsp;完成</a>
                <a class="nui-button" onclick="tprint()" plain="true" id="onPrint" name="onPrint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
            </td>     
        </tr>
    </table>
</div>


<div class="nui-fit">
    <div id="billForm" class="form">
        <input class="nui-hidden" name="id" id="id"/>
        <input class="nui-hidden" name="guestId"/>
        <input class="nui-hidden" name="checkMan" id="checkMan"/>
        <input class="nui-hidden" name="mtdvisorId" id="mtdvisorId"/>
        <input class="nui-hidden" name="mtdvisor" id="mtdvisor"/>
        <input class="nui-hidden" name="contactorId"/>
        <input class="nui-hidden" name="carId"/>
        <input class="nui-hidden" name="carVin"/>
        <input class="nui-hidden" name="status"/>
        <input class="nui-hidden" name="drawOutReport"/>
        <input class="nui-hidden" name="contactorName"/>
        <input class="nui-hidden" name="identity"/>
        <input class="nui-hidden" name="billTypeId"/>
        <input class="nui-hidden" name="status"/>
        <input class="nui-hidden" name="isSettle"/>
        <input class="nui-hidden" name="serviceTypeId"/>
        <input class="nui-hidden" name="isFinish"/>
        <input class="nui-hidden" name="checkStatus"/>
        <input  class="nui-combobox" style="display:none; width:100%;" name="checkTypeA" id="checkTypeA"
	            textfield="name" valuefield="customid" dataFile="data"  allowInput="true"/>  
        <table style=" left:0;right:0;margin: 0 auto; width:100%">
			
            <tr>
                <!--  <td class="tbtext">客户名称：</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" name="guestFullName" id="guestFullName" enabled="false" style="width:100% ;disaply:none;" />
                </td> -->
                <!-- <td class="tbtext">客户手机：</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" name="guestMobile" id="guestMobile" enabled="false" style="width:100%"/>
                </td> -->

                <td class="tbtext">车牌号：</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" name="carNo" id="carNo"enabled="false" style="width:100%"/>
                    <input class="nui-textbox tabwidth" name="guestFullName" id="guestFullName"enabled="false" style="display:none" style="width:100%"/>
                    <input class="nui-textbox tabwidth" name="guestMobile" id="guestMobile"enabled="false" style="display:none" style="width:100%"/>
                </td>
                 <td class="tbtext" >品牌车型：</td>
                    <td class="tbCtrl" >
                       <input  class="nui-textbox" name="carModel" id="carModel" enabled="false" width="100%"/>
                    </td>      
                  <td class="title" > 车架号(VIN)：</td>
                  <td class="tbCtrl" >
                   <input  class="nui-textbox" name="carVin" id="carVin" enabled="false" width="100%"/>
                  </td>             
                <td class="tbtext" style="color: red;">检查模板：</td>
                <td class="tbCtrl">
                    <input class="nui-combobox tabwidth"  id="checkMainId" name="checkMainId" 
                    dataField="list" valueField="id" textField="name" onvaluechanged="ValueChanged" style="width:100%"/>
                    <input class="nui-combobox tabwidth"  id="checkMainName" name="checkMainName" visible="false" style="width:100%"/>
                </td>

                <td class="tbtext" style="width:100px">上次检查时间：</td>
                <td class="tbCtrl">
                    <input class="nui-datepicker tabwidth" enabled="false" name="lastChekDate" id="lastChekDate" format="yyyy-MM-dd" style="width:100%"/>
                </td>
            </tr> 
            <tr>
                <td class="tbtext" style="width:100px">上次检查里程：</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" enabled="false" name="lastKilometers" id="lastKilometers" style="width:100%"/>
                </td>

<!--                 <td class="tbtext">上次检查项目:</td> -->
<!--                 <td class="tbCtrl"> -->
<!--                     <input class="nui-textbox tabwidth" name="" id=""/> -->
<!--                 </td> -->
                <td class="tbtext" style="width:100px">上次检查得分：</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" enabled="false" name="lastPoint" id="lastPoint" style="width:100%"/>
                </td>
                
                <td class="tbtext" style="color: red;">本次里程：</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" vtype="float;range:0,100000000" name="enterKilometers" id="enterKilometers" style="width:100%"/>
                </td>
                <td class="tbtext" style="color: red;">查车技师：</td>
                <td >

                    <input name="checkManId"
                    id="checkManId"
                    class="nui-combobox width1"
                    textField="empName"
                    valueField="empId"
                    emptyText="请选择..."
                    url=""
                    style="width:100%"
                    allowInput="true"
                    showNullItem="false"
                    valueFromSelect="true"
                    nullItemText="请选择..."/>

                </td>
                <td  class="tbtext" style="width:100px">本次检查得：</td>
                <td class="tbCtrl">
                    <input class="nui-textbox tabwidth" name="checkPoint" id="checkPoint" enabled="false" style="width:100%"/>
                </td>

            </tr>
            <tr>
<!--                 <td class="tbtext">检查人:</td> -->
<!--                 <td class="tbCtrl"> -->
<!--                     <input class="nui-textbox tabwidth" id="checkMan" name="checkMan"/> -->
<!--                 </td> -->


            </tr>

        </table>
    </div>

    <div id="mainGrid" class="nui-datagrid" style="width:100%;height:auto;" showPager="false" 
    dataField="list"  allowCellSelect="true"  oncellcommitedit="onCellCommitEdit"
    url=""  showModified="false"
    allowCellEdit="true" ShowHGridLines="false" ShowVGridLines="false" >
    <div property="columns">
        <div type="indexcolumn" align="center" headerAlign="center" width="10px"><strong>序号</strong></div>
        <div field="id" name="id" visible="false">id</div>
        <div type="comboboxcolumn" field="checkType" name="checkType" width="30" headerAlign="center" align="center"><strong>检查类型</strong>
	        <input property="editor" class="nui-combobox" style="width:100%;" name="checkType" id="checkType"
	            textfield="name" valuefield="customid" dataFile="checkTypeList" data="checkTypeList" allowInput="true"/>  
        </div>
        <div field="checkName" name="checkName" width="30" headerAlign="center" align="center"><strong>检查项目</strong></div>
        <div field="checkCode" name="checkCode" width="30" headerAlign="center" align="center" visible="false"><strong>检查项目</strong></div>
        <div field="checkId" name="checkId" width="30" headerAlign="center" align="center" visible="false"><strong>配件名称id</strong></div>
        <div type="checkboxcolumn" field="status" name="status" trueValue="1" falseValue="0"  width="20" headerAlign="center" align="center" value="1"><strong>
        	正常&nbsp;<a title="批量设置为正常" plain="true" onclick="setNormal()"><span class="fa fa-edit fa-lg"></span></a></strong></div>
        <div type="checkboxcolumn" field="nostatus" name="nostatus" trueValue="1" falseValue="0"  width="10" headerAlign="center" align="center"><strong>异常</strong></div>
        <div field="checkRemark" name="checkRemark" width="80" headerAlign="center" align="center"><strong>检查说明</strong>
        	 <input property="editor" class="nui-textbox" style="width:100%;" allowInput="true"/>  
        </div>
       	<div field="remark" name="remark" width="90" headerAlign="center" align="center"><strong>检查结果</strong>
            <input property="editor" class="nui-combobox" style="width:100%;" 
            textfield="content" valuefield="content"  dataField="list" allowInput="true"/>  

        </div>
        <div field="operateBtn" name="operateBtn" width="30" headerAlign="center" align="center" ><strong>上传图片</strong></div>
        <div type="checkboxcolumn" field="settleType" name="settleType" trueValue="0" falseValue="1"  width="30" headerAlign="center" align="center" value="-1"><strong>下次处理</strong></div>
        <div type="checkboxcolumn" field="nosettleType" name="nosettleType" trueValue="1" falseValue="0"  width="30" headerAlign="center" align="center"><strong>本次处理</strong></div>
        <div field="careDueMileage" name="careDueMileage" width="30" vtype="float" headerAlign="center" align="center"><strong>下次处理里程</strong>
        	<input property="editor" class="nui-textbox" style="width:100%;" allowInput="true" vtype="float"/>  
        </div>
        <div field="careDueDate" name="careDueDate" width="30" headerAlign="center" align="center" dateFormat="yyyy-MM-dd""><strong>下次处理时间</strong>
        	<input property="editor" class="nui-datepicker tabwidth" name="" id="" dateFormat="yyyy-MM-dd"" format="yyyy-MM-dd"/>
        </div>
    </div>
</div>


<div class="vpanel" style="width:calc(100% - 2px);height:120px;">
    <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;">
        <span>客户描述</span>
    </div>
    <div class="nui-fit">
        <input class="nui-textarea " style="width:100%;height:100%;border:0px;" />
    </div>
</div>
<div style="clear: both;">
    <div class="vpanel" style="width:calc(100% - 2px);height:100px;margin-left: auto;margin-right: auto;margin-top: 20px;">
        <div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;">
            <span>检测照片</span>
        </div>
        <div class="vpanel_body"> 


        </div> 
    </div> 

</div>

<script type="text/javascript">
    nui.parse();
</script>
</body>

</html>
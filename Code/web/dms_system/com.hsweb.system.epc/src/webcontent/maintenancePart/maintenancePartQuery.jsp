<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-02-18 23:25:58
  - Description:
-->
<head>
    <title>零件号查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="<%=contextPath%>/epc/common/llqCommon.js?v=1.0.2" type="text/javascript"></script>
    <script src="<%=contextPath%>/epc/maintenancePart/js/maintenancePartQuery.js?v=1.0.0" type="text/javascript"></script>
    <style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        font-family: "微软雅黑";
        background-color: #fff;
    }

    .right{
        text-align: right;
    }  
    .fwidtha{
        width: 120px;
    }
    .fwidthb{
        width: 30px;
    }
    .mainwidth{
        width: 1100px;
    }

    .vpanel{
        border:1px solid #d9dee9;
        margin:10px 0px 0px 20px;
        height:248px;
        float:left;
    }
    .vpanel_heading{
        border-bottom:1px solid #d9dee9;
        width:100%;
        height:28px;
        line-height:28px;
    }
    .vpanel_heading span{
        margin:0 0 0 20px;
        font-size:16px;
        font-weight:normal;
    }
    .vpanel_bodyww{
        padding : 10 10 10 10px !important

    }

    .required {
        color: red;
    }

    .b a{
      color:black;
    }
    .b a:active {
     color:black;
    }
	 .intCity {
		width: 200px;
		height: 30px;
		line-height: 30px;
		font-size: 14px;
		text-indent: 10px;
		margin-top: 10px;
	}
	.seachBtn {
		width: 60px;
		height: 30px;
		line-height: 30px;
		font-size: 13px;
		color: #fff;
		text-align: center;
		background: #00BFFF;
		cursor: pointer;
		margin-top: 10px;
	}
	.seachBtn2 {
		width: 60px;
		height: 30px;
		line-height: 30px;
		font-size: 13px;
		text-align: center;
		cursor: pointer;
		margin-top: 10px;
	}	
</style>
</head>
<body>
    <div class="nui-fit">
                <div class="" id="partForm" style="width:100%;height:200px;" style="text-align:center;vertical-align:center;">
                      <table>
                          <tr>
                                <td width="100%">
                                  	<input id="carNo" name="carNo" class="intCity" type="text" placeholder="请输入车架号" />
									<button  type="button" style="margin-top: 10px;" value="查询" onclick="javascript:getViolation()"><span class="fa fa-search fa-lg"></span>&nbsp;&nbsp;查询</button>
                                    <button type="button" style="margin-top: 10px;" class="ant-btn ant-btn-sm"><span>车型查询</span></button>
                         		</td>
                          </tr>
                          <tr>
                                <td >
                                  	短号查询品牌：
									<label><input name="Fruit" type="radio" value="" />全部品牌 </label> 
									<label><input name="Fruit" type="radio" value="" />宝马</label> 
									<label><input name="Fruit" type="radio" value="" />MINI </label> 
									<label><input name="Fruit" type="radio" value="" />奔驰 </label> 
									<label><input name="Fruit" type="radio" value="" />Smart</label> 
									<label><input name="Fruit" type="radio" value="" />捷豹 </label> 
									<label><input name="Fruit" type="radio" value="" />路虎 </label> 
									<label><input name="Fruit" type="radio" value="" />玛莎拉蒂</label>
                                </td>
<!--                                 <div class="mini-radiobuttonlist" repeatItems="2" repeatLayout="table" repeatDirection="vertical"
								    textField="text" valueField="id" value="cn"
								    url="../data/countrys.txt" ></div>-->
                          </tr>
                          <tr>
                                <td width="100%">
                                  	选择品牌：
                                  	
                         		</td>
                          </tr>                          
                    </table>    
                </div>
                       
                    <div id="dgbasic" class="nui-datagrid"
                         style="width:100%;height:90%;"
                         showColumns="true"
                         allowCellSelect="true"
                         allowCellEdit="true"
                         showModified="false"
                         showVGridLines="false"
                         showPager="fasle" >                
                        <div property="columns">         
                            <div type="checkboxcolumn" field="check" trueValue="1" falseValue="0" 
                                width="25" headerAlign="center" header=""><span class="fa fa-check"></span>
                            </div>                                    
                            <div field="pid" headerAlign="center" width="20%" align="center">零件号</div>
                            <div field="label" headerAlign="center" width="50%" align="center">名称</div>
                            <div field="prices" headerAlign="center" visible="false" width="10%"  align="center">价格</div>
                            <div field="brandCode" headerAlign="center" width="10%"  align="center">品牌</div>
                            <div field="remark" headerAlign="center" width="10%"  align="center">备注</div>
                            <div field="action" headerAlign="center" width="10%" align="center">说明</div>
                            <!-- <div field="opt" width="10%" headerAlign="center" align="center" allowSort=false></div> -->
                        </div>
                    </div>
                
            
    </div>

    <div id="advancedSearchWin" class="nui-window"
         title="品牌选择" style="width:220px;height:130px;"
         showModal="true"
         allowResize="false"
         allowDrag="true">
        <div id="advancedSearchForm" class="form" style="text-align:center;padding:10px;">
            <table style="width:100%;">
                <tr>
                    <input name="searchCarbrandId"
                                   id="searchCarbrandId"
                                   class="nui-combobox"
                                   textField="brandname"
                                   valueField="brand"
                                   emptyText="关联品牌"
                                   url=""
                                   valueFromSelect="true"
                                   width="100%"
                                   allowInput="true"
                                   showNullItem="false"
                                   nullItemText="请选择..."/>
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
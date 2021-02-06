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
    <%@include file="/common/sysCommon2.jsp" %>
    <script src="<%=contextPath%>/llq/common/llqCommon.js?v=1.2" type="text/javascript"></script>
    <script src="<%=contextPath%>/llq/part/js/partQuery.js?v=1.2.1" type="text/javascript"></script>
    <style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        font-family: "微软雅黑";
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
    .htr{
        height: 20px;
    }
    .mainwidth{
        width: 1100px;
    }
    .tmargin{
        margin-top: 5px;
        margin-bottom: 5px;
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

</style>
</head>
<body>
    <!-- <div class="" style="padding:10px;border-top:0;border-left:0;border-right:0;text-align:left;vertical-align:center;">
        <a class="nui-button groupButton2" onclick="query_vin(0)" id="query0">上一步</a>
        <a class="nui-button groupButton2" onclick="query_vin(1)" id="query1">下一步</a>
    </div> -->
    <div class="nui-fit">
                <div class="" id="partForm" style="width:100%;height:40px;" style="text-align:center;vertical-align:center;">
                      <table class="tmargin" >
                          <tr class="htr">
                                <td >
                                  <input name="applyCarbrandId"
                                   id="applyCarBrandId"
                                   class="nui-combobox"
                                   textField="brandCn"
                                   valueField="brand"
                                   emptyText="全部品牌"
                                   url=""
                                   valueFromSelect="true"
                                   width="100%"
                                   allowInput="true"
                                   showNullItem="false"
                                   nullItemText="请选择..."/>
                                 </td>
                                <td>
                                    <input class="nui-textbox" width="100%" id="partCode" name="partCode" enabled="true" placeholder="输入零件号"/>
                                </td>
                                <td>
                                      <a class="nui-button" onclick="queryPartInfo" style="width:100%;">查询</a>
                                </td>
                          </tr>
                    </table>    
                </div>
                       
                    <div id="dgbasic" class="nui-datagrid"
                         style="width:100%;height:90%;"
                         showColumns="true"
                         showVGridLines="false"
                         showPager="fasle" >                
                        <div property="columns">                                             
                            <div field="pid" headerAlign="center" width="20%" align="left">零件号</div>
                            <div field="label" headerAlign="center" width="50%" align="left">名称</div>
                            <div field="prices" headerAlign="center" visible="false" width="10%"  align="left">价格</div>
                            <div field="brand" headerAlign="center" width="10%"  align="left">品牌</div>
                            <div field="remark" headerAlign="center" width="10%"  align="left">备注</div>
                            <div field="action" headerAlign="center" width="10%" align="center">说明</div>
                            <div field="opt" width="10%" headerAlign="center" align="center" allowSort=false></div>
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
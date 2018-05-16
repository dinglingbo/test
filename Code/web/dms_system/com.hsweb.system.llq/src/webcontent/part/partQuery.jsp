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
    <script src="<%=sysDomain%>/llq/common/llqCommon.js?v=1.2" type="text/javascript"></script>
    <script src="<%=sysDomain%>/llq/part/js/partQuery.js?v=1.0.0" type="text/javascript"></script>

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
        height: 30px;
    }
    .mainwidth{
        width: 1100px;
    }
    .tmargin{
        margin-top: 10px;
        margin-bottom: 10px;
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

</style>
</head>
<body>
    <!-- <div class="" style="padding:10px;border-top:0;border-left:0;border-right:0;text-align:left;vertical-align:center;">
        <a class="nui-button groupButton2" onclick="query_vin(0)" id="query0">上一步</a>
        <a class="nui-button groupButton2" onclick="query_vin(1)" id="query1">下一步</a>
    </div> -->
    <hr />
    <div class="nui-fit">
        <div class="nui-splitter" style="width:100%; height:100%;" id="queryPart" allowResize="false" handlerSize="0">
            <div size="15%" showCollapseButton="false">
                <div class="nui-fit" id="partForm">
                    <table class="tmargin">
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
                          </tr>
                          <tr class="htr">
                              <td>
                                    <textarea class="nui-textarea" emptyText="输入完整零件号" width="100%" style="height:100px;" id="partCodeList" name="partCodeList"></textarea>
                              </td>
                          </tr>
                          <tr class="htr">
                              <td>
                                    <a class="nui-button" onclick="queryPartInfo" style="width:100%;">查询</a>
                              </td>
                          </tr>
                          <tr class="htr">
                              <td>
                                    *说明:</br>
                                    1.仅支持<span style="color:blue;">同一品牌</span>的零件查询；</br>
                                    2. 查询多个零件需要换行；</br>
                                    3.最多支持5个零件号同时查询。
                              </td>
                          </tr>
                    </table>              
                </div>
            </div>
            <div size="75%" showCollapseButton="false">
                <div class="nui-fit">            
                    <div id="dgbasic" class="nui-datagrid"
                         style="width:100%;height:100%;"
                         showColumns="true"
                         showVGridLines="false"
                         showPager="fasle" >                
                        <div property="columns">                                             
                            <div field="pid" width="30%" align="right">零件号</div>
                            <div field="label" width="40%" align="left">名称</div>
                            <div field="brand" width="40%" visible = "false" align="left">名称</div>
                            <div field="action" width="30%" align="right">说明</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
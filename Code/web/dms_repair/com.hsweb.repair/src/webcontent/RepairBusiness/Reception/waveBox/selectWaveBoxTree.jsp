<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-08 09:09:08
  - Description:
-->
<head>
<title>变速箱查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
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


              #table1,#table2 {
                border-right:1px solid #CCC;
                border-bottom:1px solid #CCC;
                font-size: 14px;
                }
            #table1  td,#table2  td{
                border-left:1px solid #CCC;
                border-top:1px solid #CCC;
                text-align: center;
                padding:2px;
                }
            
            body {
                margin: 0;
                padding: 0;
                border: 0;
                width: 100%;
                height: 100%;
                overflow: hidden;
            }
            
            .tipStyle {
                position: absolute;
                background-color: #595959;
                color: #fff;
                border-radius: 4px;
                padding: 5px 10px 5px 10px;
                opacity: 0.9;
                font-size: 14px;
                display: none;
                z-index: 999;
            }
            
            .max_img {
                display: none;
                position: absolute;
                bottom: 0;
                left: 0;
                width: 1000px;
                height: 800px;
                background-color: aliceblue;
            }
              </style>
</head>
<body>
    <div class="nui-fit">

        <div class="nui-splitter" vertical="false" style="width:100%;height:100%;" style="border:0;" handlerSize=0>
            <div size="30%" showCollapseButton="false" style="border:0;">
                <div class="nui-fit">

                    <div id="tabs1" class="nui-tabs" activeIndex="0" style="width:100%;height:100%;" plain="false">
                        <div title="品牌查询" >
                                <div class="nui-toolbar" >
                                <input class="nui-textbox" id="text"  emptyTExt="请输入品牌"/>
                                <a class="nui-button" plain="false" iconCls="" onclick="" align="right"><span class="fa fa-search fa-lg"align="right"></span>&nbsp;查找</a>
                                    </div>
                                    <div class="nui-fit" >
                                <!-- <input type="button" value="过滤" onclick="filter()" style="margin-left:30px;font-weight:bold;"/> -->
                                <ul id="tree1" class="nui-tree" url="" style="width:100%;height:100%;padding:5px;" 
                                    showTreeIcon="true" textField="text" expandOnLoad="false" allowDrag="false" allowDrop="false" allowLeafDropIn="false"
                                    idField="id"  resultAsTree="false"
                                        >        
                                </ul>
                            </div>
                        </div>
                        <div title="VIN查询" >
                                <div class="nui-toolbar" >
                                        <input class="nui-textbox" id="text"  emptyTExt="请输入VIN"/>
                                        <a class="nui-button" plain="false" iconCls="" onclick="" align="right"><span class="fa fa-search fa-lg"align="right"></span>&nbsp;查找</a>
                                            </div>
                        </div>
                    </div>

    
</div>
</div>
<div showCollapseButton="false" style="border:0;">
    <div class="nui-fit" id="detailInfo">
            <fieldset id="fd3" style="width:99%;">
                    <legend><span>车型参数</span></legend>
                    <div class="fieldset-body">
                        <table id="table1" style="width:100%" cellspacing="0" cellpadding="0">
                            <tr>
                                <td style="width: 30%">
                                    车型信息
                                </td>
                                <td>
                                    奥迪200
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%">
                                    变速箱描述
                                </td>
                                <td>
                                    手动变速箱
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%">
                                    变速箱档位数
                                </td>
                                <td>
                                    5
                                </td>
                            </tr>
                        </table>
                    </div>
                </fieldset>
                <div style="padding-top: 10px;">
                </div>
                <div id="showDiv" class="tipStyle"></div>
                <fieldset id="fd3" style="width:99%;">
                    <legend><span>养护信息</span></legend>
                    <div class="fieldset-body">
                        <table id="table2" style="width:100%"  cellspacing="0" cellpadding="0">
                            <tr>
                                <td colspan="2" style="color: red;">
                                    该车型养护信息完善中
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%">
                                    变速箱型号
                                </td>
                                <td>
    
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%">
                                    保养总价
                                </td>
                                <td style="color: red;">
                                    ￥ 16.00 <span onmouseover="overShow(this,con8)" onmouseout="outHide()">（查看明细）</span>
                                    <!-- <span class="fa fa-question-circle fa-lg iconStyle" style="margin-top: 3px;" ></span> -->
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%">
                                    变速箱油
                                </td>
                                <td>
                                    IX<span id="boxOilPhoto" style="color: #ff8000;cursor:pointer" onclick="changeShow(1)">（查看图片）</span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%">
                                    油品单价
                                </td>
                                <td style="color: red;">
                                    ￥ 16.00
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%" rowspan="2">
                                    推荐换油量
                                </td>
                                <td>
                                    重力换油量：4.8L
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    循环换油量：12L
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%">
                                    接头型号
                                </td>
                                <td>
                                    A045<span id="JointTypePhoto" style="color: #ff8000;cursor:pointer" onclick="changeShow(2)">（查看图片）</span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%">
                                    工时费
                                </td>
                                <td style="color: red;">
                                    ￥ 16.80
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%">
                                    换油宝典
                                </td>
                                <td>
                                    <span id="biblePhoto" style="color: #ff8000;cursor:pointer" onclick="changeShow(3)">（查看图片）</span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%">
                                    注意事项
                                </td>
                                <td>
                                    暂无数据
                                </td>
                            </tr>
                        </table>
                    </div>
                </fieldset>
                <div class="nui-fit">
                    <div style="padding-top: 10px;padding:0px 5px;">
                        <!-- <input class="nui-textArea" style="width: 100%;height: 80%;" id="matters"> -->
                        <lable id="matters"></lable>  
                    </div>
                </div>
                <div class="max_img" style=" width:100%;height:100%;margin:0 auto">
                    <img src="" id="maxImgShow" onclick="changeHide();" width="100%" />
                </div>
</div>
</div>
</div>
</div>


	<script type="text/javascript">
        nui.parse();
        
        var con8 = '总价=油品价格+工时费<br>油品价格=单价*循环换油量';
                var matters = "查询系统使用说明：在使用连顺变速箱油产品之前，核实车辆配置信息是首要前提。本油品推荐仅供参考，具体用油规格以车辆用户手册的规定为准。建议使用VIN码查询，确保查询结果准确。连顺变速箱深度养护“小程序”会根据市场及应用的情况适时地更新产品推荐，在查看此版本时，所有先前的版本不再有效。任何形式的复制信息均需要得到广州市连顺汽车维修服务有限公司的书面许可。如有疑问，请联系客服。";
                document.getElementById("matters").innerHTML = matters;
                // nui.get("matters").setValue(matters);
                // nui.get("matters").disable();

                function overShow(e, con) {
                    var showDiv = document.getElementById('showDiv');
                    var pos = e.getBoundingClientRect();
                    $("#showDiv").css("top", pos.bottom); //设置提示div的位置
                    $("#showDiv").css("left", pos.right-100);
                    showDiv.style.display = 'block';
                    showDiv.innerHTML = con;
                }

                function outHide() {
                    var showDiv = document.getElementById('showDiv');
                    showDiv.style.display = 'none';
                    showDiv.innerHTML = '';
                }

                function changeShow(type) {
                    if (type == 1) {
                        $("#maxImgShow").attr("src", "https://photo.harsonserver.com/20190507202732334.png");
                    } else if (type == 2) {
                        $("#maxImgShow").attr("src", "https://photo.harsonserver.com/20190507203715657.png");
                    } else if (type == 3) {
                        $("#maxImgShow").attr("src", "https://photo.harsonserver.com/20190507203715957.png");
                    }
                    $(".max_img").show();
                }

                function changeHide() {
                    $(".max_img").hide();
                }


var treeData = [{
        "id": "奥迪",
        "text": "奥迪",
        "children": [{
                "id": "A3",
                "text": "A3",
                "children":[{
                    "id": "8VA(2014-2019)",
                    "text": "8VA(2014-2019)",
                    "children":[{
                    "id": "自动/7档/双离合变速器",
                    "text": "自动/7档/双离合变速器",
                },{
                    "id": "手动/5档/手动速器",
                    "text": "手动/5档/手动速器",
                }]
                },
                {
                    "id": "8VS(2014-2019)",
                    "text": "8VS(2014-2019)",
                    "children":[{
                    "id": "自动/7档/双离合变速器",
                    "text": "自动/7档/双离合变速器",
                },{
                    "id": "手动/5档/手动速器",
                    "text": "手动/5档/手动速器",
                }]
                }]
            },
            {
                "id": "A4",
                "text": "A4"
            },
            {
                "id": "Q5",
                "text": "Q5"
            }
        ]
    },
    {
        "id": "奔驰",
        "text": "奔驰",
        "children": [{
                "id": "A3",
                "text": "A3",
                "children":[{
                    "id": "8VA(2014-2019)",
                    "text": "8VA(2014-2019)",
                    "children":[{
                    "id": "自动/7档/双离合变速器",
                    "text": "自动/7档/双离合变速器",
                },{
                    "id": "手动/5档/手动速器",
                    "text": "手动/5档/手动速器",
                }]
                },
                {
                    "id": "8VS(2014-2019)",
                    "text": "8VS(2014-2019)",
                    "children":[{
                    "id": "自动/7档/双离合变速器",
                    "text": "自动/7档/双离合变速器",
                },{
                    "id": "手动/5档/手动速器",
                    "text": "手动/5档/手动速器",
                }]
                }]
            },
            {
                "id": "A4",
                "text": "A4"
            },
            {
                "id": "Q5",
                "text": "Q5"
            }
        ]
    } 
];
nui.get("tree1").setData(treeData);
$("#detailInfo").hide();

nui.get("tree1").on("nodeclick",function (e) {
    $("#detailInfo").show();
})
    </script>
</body>
</html>
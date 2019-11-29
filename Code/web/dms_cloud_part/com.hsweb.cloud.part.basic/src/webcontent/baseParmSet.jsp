<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>

<html>

<head>
    <title>自定义分类</title>
    <script src="<%=webPath + contextPath%>/basic/js/baseParamSet.js?v=1.0.11"></script>
    <style>

        html,
        body {
            margin: 0px;
            padding: 0px;
            border: 0px;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

    .mini-tabs-header-left .mini-tab-active {
    /* border-right-color: #f2f5f7; */
    /* border-bottom: 2px solid blue; */
    color: darkorange;
    height: 30px;
}
    

.test-1::-webkit-scrollbar {/*滚动条整体样式*/
        width: 10px;     /*高宽分别对应横竖滚动条的尺寸*/
        height: 1px;
    }
.test-1::-webkit-scrollbar-thumb {/*滚动条里面小方块*/
        /* border-radius: 10px; */
        box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
        background: #7fccde;
    }
.test-1::-webkit-scrollbar-track {/*滚动条里面轨道*/
        /* box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
        border-radius: 10px;
        background: #EDEDED; */
    }
    </style>
</head>

<body>
    <div class="nui-fit">
        <div style="width:100%; height:calc(100% - 2px);">
                <div style="float:left;height:100%;width:105px;overflow: scroll;" class="test-1">
                        <!--<a href="#" class="btn-two green large">Button</a>-->
                        <div style="float:left;height:770px;width:105px;">
                    <div id="mainTabs" class="nui-tabs" name="mainTabs" activeIndex="0" style="height:100%;"
                        plain="false" tabPosition="left" showBody="false">
                        <div title="产品线分类" id="productClass" name="productClass" url=""></div>
                        <div title="维修性质分类" id="maintainProClass" name="maintainProClass" url=""></div>
                        <div title="采购退货原因" id="pchsRtnClass" name="pchsRtnClass" url=""></div>
                        <div title="销售退货原因" id="sellRtnProClass" name="sellRtnProClass" url=""></div>
                 
                    </div>
                </div>
                </div>
                <div style="float:right;height:100%;width:calc(100% - 105px);">
                        <div class="nui-toolbar">
                                <a class="nui-button" plain="true" onclick="addShareUrl" id="addStationBtn">
                                    <span class="fa fa-plus fa-lg"></span>&nbsp;新增
                                </a>
                                <!-- <a class="nui-button" plain="true" onclick="del()" id="" plain="false"><span
                                    class="fa fa-close fa-lg"></span>&nbsp;删除
                                </a> -->
                                <a class="nui-button" plain="true" onclick="save()" id="addStationBtn">
                                    <span class="fa fa-save fa-lg"></span>&nbsp;保存
                                </a>
                            </div>
                    <div class="nui-fit">
                            <div id="dgGrid" class="nui-datagrid" style="width:100%;height:100%;" dataField="data" sortMode="client"
                                allowCellSelect="true" allowCellEdit="true" showModified="false" showPager="false"
                                style="width: 80%; height: 40%; margin-left:10%;">
                                <div property="columns">
                                    <div type="indexcolumn" headerAlign="center" >序号</div>
                                    <div field="name" name="name"allowSort="true" headerAlign="center" header="购车用途">
                                        <input property="editor" class="nui-textbox" />
                                    </div>
                                    <div field="property1" name="property1"allowSort="true" headerAlign="center" header="属性1" visible="false">
                                        <input property="editor" class="nui-textbox" />
                                    </div>
                                    <div field="property2" name="property2"allowSort="true" headerAlign="center" header="属性2" visible="false">
                                        <input property="editor" class="nui-textbox" />
                                    </div>
                                    <div field="property3" name="property3"allowSort="true" headerAlign="center" header="属性3" visible="false">
                                        <input property="editor" class="nui-textbox" />
                                    </div>
                                    <div field="isDisabled"  allowSort="true" headerAlign="center" header="状态">
                                        <input property="editor" class="nui-combobox" textField="name" data="statusList" valueField="id" />
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
                <div style="clear:both"></div>
        </div>
    </div>
</body>

</html>
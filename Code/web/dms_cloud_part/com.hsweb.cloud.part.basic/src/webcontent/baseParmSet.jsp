<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>

<html>

<head>
    <title>系统参数</title>
    <script src="<%=webPath + contextPath%>/sales/base/js/sellCarParamMgr.js?v=1.0.6"></script>
    <link href="<%=webPath + contextPath%>/sales/base/css/botton.css" rel="stylesheet" type="text/css" />
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
                        <div title="PDI检查分类" id="PDICheck" name="PDICheck" url=""></div>
                        <div title="身份" id="ID" name="ID" url=""></div>
                        <div title="行业" id="work" name="work" url=""></div>
                        <div title="职务" id="dept" name="dept" url=""></div>
                        <div title="来源" id="source" name="source" url=""></div>
                        <div title="关系阶段" id="relationship" name="relationship" url=""></div>
                        <div title="关注重点" id="attention" name="attention" url=""></div>
                        <div title="性格" id="character" name="character" url=""></div>
                        <div title="联系状态" id="contact" name="contact" url=""></div>
                        <div title="车辆级别" id="carLevel" name="carLevel" url=""></div>
                        <div title="国别" id="country" name="country" url=""></div>
                        <div title="车身结构" id="structure" name="structure" url=""></div>
                        <div title="排量" id="displacement" name="displacement" url=""></div>
                        <div title="座位数" id="sittingNum" name="sittingNum" url=""></div>
                        <div title="进气形式" id="intakeType" name="intakeType" url=""></div>
                        <div title="能源" id="useType" name="useType" url=""></div>
                        <div title="驱动方式" id="driveType" name="driveType" url=""></div>
                        <div title="变速箱" id="changeSpeed" name="changeSpeed" url=""></div>
                        <div title="生产方式" id="proType" name="proType" url=""></div>
                        <div title="车身颜色" id="carOutcolor" name="carOutcolor" url=""></div>
                        <div title="内饰颜色" id="carIncolor" name="carIncolor" url=""></div>
                        <div title="意向级别" id="IntentionLevel" name="IntentionLevel" url=""></div>
                        <div title="购车方式" id="buyCarType" name="buyCarType" url=""></div>
                        <div title="购车用途" id="buyCarUser" name="buyCarUser" url=""></div>
                        <div title="开户银行" id="bank" name="bank" url=""></div>
                        <div title="来访类型" id="visitType" name="visitType" url=""></div>
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
                                allowCellSelect="true" allowCellEdit="true" showModified="false"
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
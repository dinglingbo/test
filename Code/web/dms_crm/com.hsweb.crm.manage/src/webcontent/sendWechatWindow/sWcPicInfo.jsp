<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-03-26 10:16:08
  - Description:
-->

<head>
    <title>发送微信 图文消息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/commonRepair.jsp"%>

    <style>
        body {
        margin: 0; 
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%; 
        overflow: hidden;
        font-family: "微软雅黑";
    }
        .tbtext{
        text-align: right;
    }
    
    </style>
</head>

<body>
    <div class="nui-toolbar" style="padding:0px;border-bottom:0;" id="form1">
        <table style="width:100%;">
            <tr>
                <td style="font-size: 9pt;display: flex;">
                    <label class="labeltext">标题： </label>
                    <input id="imageTextTitle" name="imageTextTitle" class="nui-textbox inputLeft" style="margin-right: 30px;" />&nbsp;&nbsp;

                    <a class="nui-button" onclick="search()" plain="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" onclick="reset()" plain="true"><span class="fa fa-refresh fa-lg"></span>&nbsp;重置</a>

                    <span class="separator"></span>
                    <a class="nui-button" onclick="add()" plain="true"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" onclick="edit()" plain="true"><span class="fa fa-edit fa-lg"></span>&nbsp;编辑</a>
                    <a class="nui-button" onclick="pushUserList()" plain="true"><span class="fa fa-toggle-right fa-lg"></span>&nbsp;推送</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit" >
        <div id="imageTextData" class="nui-datagrid" style="height:100%;" allowResize="true" dataField="ImageTextMainDataArray"
            pageSize="12" showPageInfo="true" allowCellSelect="false" multiSelect="false">
            <div property="columns">
                <div type="checkcolumn" width="50">选择</div>
                <div field="storeName" headerAlign="center" align="left">微信门店</div>
                <div field="textTitle" headerAlign="center" align="center">标题</div>
                <div field="imageTextType" headerAlign="center" align="center" renderer="onImageTextType" width="65">类型</div>
                <div field="imageTextStatus" headerAlign="center" align="center" renderer="onImageTextStatus" width="65">状态</div>
                <div field="creator" headerAlign="center" align="center" width="70">创建人</div>
                <div field="createDate" headerAlign="center" align="center" width="140" dateFormat="yyyy-MM-dd HH:mm:ss">创建时间</div>
                <div field="modifier" headerAlign="center" align="center" width="70">更改人</div>
                <div field="modifyDate" headerAlign="center" align="center" width="140" dateFormat="yyyy-MM-dd HH:mm:ss">更改时间</div>
            </div>
        </div>
    </div>


    <script type="text/javascript">
        nui.parse();
        var pathapi = apiPath + wechatApi;
        var pathweb = webPath + wechatDomain;
        var imageTextData = nui.get("imageTextData");

        $(function () {
            imageTextData.setUrl(pathapi +
                "/com.hsapi.wechat.autoServiceBackstage.weChatImageTextMessage.queryImageTextMessageMain.biz.ext"
            );
            imageTextData.load({
                token: token
            });
        });

        //推送用户
        function pushUserList() {
            var row = imageTextData.getSelected();
            console.log(row);
            if (row) {
                nui.open({
                    url: pathweb + "/autoServiceSys/weChatMessage/pushUserList.jsp",
                    title: "推送用户",
                    width: 710,
                    height: 420,
                    onload: function () { //弹出页面加载完成
                        var iframe = this.getIFrameEl();
                        var data = {
                            imageTextData: row
                        };
                        iframe.contentWindow.setFormData(data);
                    },
                    ondestroy: function (action) { //弹出页面关闭前
                        if (action == 'saveSuccess') {
                            nui.alert("推送成功", "系统提示");
                            imageTextData.reload();
                        } else if (action == "saveFail") {
                            nui.alert("推送失败", "系统提示");
                        }
                    }
                });
            }
        }

        //新增
        function add() {
            nui.open({
                url: pathweb + "/autoServiceSys/weChatMessage/addWeChatImageTexr.jsp",
                title: "添加微信图文消息",
                width: "100%",
                height: 670,
                onload: function () { //弹出页面加载完成
                    var iframe = this.getIFrameEl();
                    var data = {
                        pageType: "add"
                    }; //传入页面的json数据
                    iframe.contentWindow.setFormData(data);
                },
                ondestroy: function (action) { //弹出页面关闭前
                    console.log(action);
                    if (action == 'saveSuccess') {
                        nui.alert("添加成功", "系统提示");
                        imageTextData.reload();
                    } else if (action == 'saveFail') {
                        nui.alert("添加失败", "系统提示");
                    }
                }
            });
        }

        //编辑
        function edit() {
            var row = imageTextData.getSelected();
            if (row) {
                nui.open({
                    url: pathweb + "/autoServiceSys/weChatMessage/addWeChatImageTexr.jsp",
                    title: "添加微信图文消息",
                    width: "100%",
                    height: 670,
                    onload: function () { //弹出页面加载完成
                        var iframe = this.getIFrameEl();
                        var data = {
                            pageType: "edit",
                            imageTextData: row
                        }; //传入页面的json数据
                        iframe.contentWindow.setFormData(data);
                    },
                    ondestroy: function (action) { //弹出页面关闭前
                        if (action == 'saveSuccess') {
                            nui.alert("编辑成功", "系统提示");
                            imageTextData.reload();
                        } else if (action == 'saveFail') {
                            nui.alert("编辑失败", "系统提示");
                        }
                    }
                });
            }
        }


        //消息类型
        function onImageTextType(e) {
            switch (Number(e.value)) {
                case 1:
                    return "文本";
                case 2:
                    return "图片";
                case 3:
                    return "单图文";
                case 4:
                    return "多图文";
            }
            return "";
        }

        //搜索
        function search() {
            var formData = new nui.Form("#form1").getData();
            imageTextData.load({
                map: formData,
                token: token
            });
        }

        //清空
        function reset() {
            var form = new nui.Form("#form1");
            form.reset();
        }

        //消息状态
        function onImageTextStatus(e) {
            return e.value == 0 ? "未推送" : "已推送";
        }
    </script>
</body>

</html>
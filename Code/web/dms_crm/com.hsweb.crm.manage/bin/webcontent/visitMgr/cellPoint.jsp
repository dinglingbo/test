<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-22 15:07:42
  - Description: 
-->

<head>
    <title>销售机会</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
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
    </style>
</head>

<body>
<input class="nui-combobox" name="chanceType" id="chanceType" valueField="customid" textField="name"  visible="false" />
    	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                        <a class="nui-button" iconCls="" plain="true" onclick="addSell()" id="auditBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增销售机会</a>
                            <a class="nui-button" iconCls="" plain="true" onclick="onCancel()" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                        </td>
                    </tr>
                </table>
            </div>
    <div class="nui-fit">
        <div id="carSellPointGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="false"
            dataField="list" idField="id" allowCellSelect="true" editNextOnEnterKey="true" url="">
            <div property="columns">
                <div field="prdtName" name="prdtName" width="80" headerAlign="center" header="项目"></div>
                <div field="prdtAmt" name="amt" width="40" headerAlign="center" header="金额"></div>
                <div field="chanceType" name="type" width="60" headerAlign="center" header="机会类型"></div>
                <div field="status" name="status" width="50" headerAlign="center" header="阶段"></div>
                <div field="chanceMan" name="creator" width="80" headerAlign="center" header="商机所有者"></div>
                <div field="nextFollowDate" name="nextFollowDate" width="100" dateFormat="yyyy-MM-dd " headeralign="center">下次跟进时间</div>
                <div field="planFinishDate" name="planFinishDate" width="100" dateFormat="yyyy-MM-dd " headeralign="center">预计成单时间</div>
                <div field="cardTimesOpt" name="cardTimesOpt" width="80" headerAlign="center" header="操作" align="center"></div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        nui.parse();
        var hash = new Array("尚未联系", "有兴趣", "意向明确", "成交" ,"输单");
        var carSellPointGrid = nui.get("carSellPointGrid");
        var sellUrl = apiPath + crmApi + "/com.hsapi.crm.basic.crmBasic.querySellList.biz.ext";
        carSellPointGrid.setUrl(sellUrl);
        var mainData = null;
        var sfData = [];

 initDicts({
    	chanceType:SELL_TYPE//商机
    },function(data){
    	sfData = nui.get("chanceType").data;
    });

  carSellPointGrid.on("drawcell", function(e) {
		switch (e.field) {
		case "status":
			e.cellHtml = hash[e.value];
			break;
		case "chanceType":
			for(var i=0;i<sfData.length;i++){
				if(e.value==sfData[i].customid){
					e.cellHtml =sfData[i].name;
					}
				}
			break;
		case "cardTimesOpt":
			e.cellHtml = '<a class="optbtn" href="javascript:void()" onclick="editSell()">跟进</a>';
			break;
		default:
			break;
		}

	});




        function search(guestId) {
            var params = {
                guestId: guestId
            };
            carSellPointGrid.load({
                token: token,
                params: params
            });
        }

        function setData(row) {
            mainData = row;
            if (mainData.guestId) {
                search(mainData.guestId);
            }
        }


function editSell() {
		var row = carSellPointGrid.getSelected();
		if (row) {
			nui.open({
				url : webPath + contextPath
				+ "/com.hsweb.part.manage.businessOpportunityEdit.flow?token="
				+ token,
				title : "更新商机",
				width : 550,
				height : 410,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = row;
					data.type = 'editT';
					// 直接从页面获取，不用去后台获取
					iframe.contentWindow.setData(data);
				},
				ondestroy : function(action) {
					if (action == "saveSuccess") {
						carSellPointGrid.reload();
					}
				}
			});
		} else {
			showMsg("请选中一条记录!", "W");
		}
	}


        function addSell() {
	
	nui.open({
		url : webPath + contextPath
				+ "/com.hsweb.part.manage.businessOpportunityEdit.flow?token="
				+ token,
		title : "添加商机",
		width : 550,
		height : 410,
		onload : function() {
			var iframe = this.getIFrameEl();
			//工单页面添加商机信息直接带过去
			var data = mainData;
			//新增页面商机的姓名字段是guestName
            data.guestName = data.guestFullName;
			data.type = "add";
			iframe.contentWindow.setData(data);
		},
		ondestroy : function(action) {
			if (action == "saveSuccess") {
				carSellPointGrid.reload();
			}
		}
	});
}

        function onCancel() {
            CloseWindow("cancel");
        }

        function CloseWindow(action) {
            if (window.CloseOwnerWindow)
                return window.CloseOwnerWindow(action);
            else
                window.close();
        }
    </script>
</body>

</html>
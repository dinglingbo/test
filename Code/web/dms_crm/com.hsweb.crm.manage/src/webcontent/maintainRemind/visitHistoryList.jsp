<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
  <div class="nui-fit">
        <input name="visitMode" id="visitMode" class="nui-combobox "textField="name" valueField="customid" visible="false"/>
    <div id="visitHis" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
        multiSelect="false" pageSize="20" showPageInfo="true" selectOnLoad="true"  onDrawCell="" onselectionchanged=""
        allowSortColumn="false" totalField='page.count' allowCellWrap="true">
        <div property="columns">
            <div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
            <div field="contactorName" headerAlign="center" allowSort="true" width="100px">客户名称</div>
            <div field="serviceType" headerAlign="center" allowSort="true" width="100px">回访类型</div>
            <div field="visitMode" headerAlign="center" allowSort="true" width="100px">回访方式</div>
            <div field="visitContent" headerAlign="center" allowSort="true" width="200px">回访内容</div>
            <div field="visitMan" headerAlign="center" allowSort="true" width="100px">回访员</div>
            <div field="visitDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="100px">回访日期</div>
        </div>
    </div>
</div>
<script type="text/javascript">
    nui.parse();
    var hisUrl = apiPath + crmApi+ "/com.hsapi.crm.svr.visit.queryCrmVisitRecordSql.biz.ext";
    var visitHis = null; //回访历史
    var serviceTypeList = [{},{ id: 1, text: '电销' }, { id: 2, text: '预约' }, { id: 3, text: '客户回访' }, { id: 4, text: '流失回访' }, { id: 5, text: '保养提醒' }, { id: 6, text: '商业险到期' }, { id: 7, text: '交强险到期' }, { id: 8, text: '驾照年审' }, { id: 9, text: '车辆年检' }, { id: 10, text: '生日' }, { id: 11, text: '其他' }];
    visitHis = nui.get("visitHis"); 
    visitHis.setUrl(hisUrl);

    initDicts({
        visitMode: "DDT20130703000021",//跟踪方式
        // visitStatus: "DDT20130703000081",//跟踪状态
        //query_visitStatus: "DDT20130703000081",//跟踪状态
        //artType: "DDT20130725000001"//话术类型        
    });

    visitHis.on("drawcell", function (e) {
        if (e.field == "serviceType") {
            e.cellHtml = serviceTypeList[e.value].text;
        } else if(e.field == "visitMode"){//跟踪方式
            e.cellHtml = setColVal('visitMode', 'customid', 'name', e.value);
        }
    });

    visitHis.on("rowdblclick", function (e) {

        nui.open({
            url: webPath + contextPath +'/manage/maintainRemind/visitHistoryListDet.jsp?token='+token,
            title: '修改', width: 600, height:300 ,
            onload: function () {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData(e.record);
            },
            ondestroy: function (action) {
                visitHis.reload();
            }
        });
    });

    function loadVisitHis(params) {//guestSource: 0系统客户  1电销客户
        // var params = {//系统
        //     guestId:guestId,
        //     guestSource:guestSource,
        //     token:token
        // };

        // var params = {//电销
        //     mainId:mainId,
        //     guestSource:guestSource,
        //     token:token
        // };
        visitHis.load({ params:params });
    }


</script>
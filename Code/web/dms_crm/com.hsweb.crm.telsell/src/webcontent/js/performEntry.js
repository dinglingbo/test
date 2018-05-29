var queryForm; //查询表单
var dgGrid; //列表
var currRow;//

$(document).ready(function(v){
    queryForm = new nui.Form("#queryForm");
    dgGrid = nui.get("dgGrid");
    dgGrid.on("beforeload",function(e){
    	e.data.token = token;
    });
    dgGrid.on("drawcell", function (e) { //表格绘制
        var field = e.field;
        if(field == "orgid"){
            e.cellHtml = setColVal('query_orgid', 'orgid', 'orgname', e.value);
        }else if(field == "deputyId"){//营销员
            e.cellHtml = setColVal('tracker', 'empId', 'empName', e.value);
        }else if(field == "type"){//来厂类型
            e.cellHtml = setColVal('achievType', 'customid', 'name', e.value);
        }else if(field == "status"){//是否审核
            e.cellHtml = setColVal(const_audit_status, 'value', 'text', e.value);
        }
    });

    init();
    query();
});

function init(){
    initComp("query_orgid");//公司组织
    initDicts({
        achievType: "DDT20130903000002",//业绩类型
        //visitStatus: "DDT20130703000081"//跟踪状态
    });
    initRoleMembers({
        tracker: "010815"
    })
}

/*
 *查询
 **/
function query(){
    var data = queryForm.getData();
    var params = {p: data};
    
    var params = {
        "p":{
            "def":{
                "ds":"DB10_MYSQL_WB_CRM", //数据源 必填
                "url":"com.hsapi.crm.data.crmTelsales.getAchieveList",  //命名SQL路径 必填
                "page":true
            },
            "orgid": currOrgId,
            "deputyId": currUserId
        },
        token:token
    }
    
    dgGrid.load(params,null,function(){
        //失败;
        nui.alert("数据加载失败！");
    });
}

function clearQueryForm(){
    queryForm.setData({});
}

function reLoadMain(data, json){
    if(json.errCode == "S"){
        nui.alert("设置成功！");
        dgGrid.reload();
    }
}

function add(){
    editWin("新增模板", {});
}

//修改资料
function editGuestInfo(){
    var row = dgGrid.getSelected();
    if (row) {
        editWin("修改模板", row);
    } else {
        alert("请选中一条记录");
    }
}

function editWin(title, data){
    data.artType = tree1.getData();
    nui.open({
        url: _crmWebRoot + "/com.hsweb.crm.telsales.clientInfo_edit.flow",
        title: title, width: 520, height: 520,
        onload: function () {
            var iframe = this.getIFrameEl();
            //var data = { action: "edit", id: row.id };
            iframe.contentWindow.setData(data);
        },
        ondestroy: function (action) {
            //var iframe = this.getIFrameEl();
            dgGrid.reload();
        }
    });
}
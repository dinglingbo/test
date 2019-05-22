var baseUrl = apiPath + sysApi + "/";
var gridUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.queryDict.biz.ext";
var saveUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.saveDictList.biz.ext";
var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
var statusHash = { 0: "启用", 1: "禁用" };
var mainTabs = null;
var dgGrid = null;
var DICTID = " ";//
var nullMsg = "";

$(document).ready(function() {
    mainTabs = nui.get("mainTabs");
    dgGrid = nui.get("dgGrid");
    dgGrid.setUrl(gridUrl);


    mainTabs.on("activechanged",function(e){
        showTabInfo();
    });

    dgGrid.on("drawcell",function(e){
        switch (e.field) {
            case "isDisabled":
                if (statusHash[e.value]) {
                    e.cellHtml = statusHash[e.value] || "";
                } else {
                    e.cellHtml = "";
                }
				break;
			// case "operateBtn":
			// 	e.cellHtml = '<span class="fa fa-plus" onClick="javascript:addR()" title="添加行">&nbsp;&nbsp;</span>';
			// 				 //' <span class="fa fa-close" onClick="javascript:deleteR()" title="删除行"></span>';
            //     break;
            default:
                break;
        }
    });
    	dgGrid.on("cellbeginedit",function(e){
		var field=e.field; 
		var row = e.row;
        if(row.orgid == 0){
			e.cancel = true;
		}
	});

});

function doSearch()
{
	var params = {
		params:{
			sortField:"record_date",
			sortOrder:"asc"
		},
		orgids:currOrgId,
		dictid:DICTID,
		fromDb:true,
		token:token
	};
	dgGrid.load(params);
}


function addShareUrl(){
    var newRow = {isDisabled:0};
    dgGrid.addRow(newRow);
}

function save(){
	var value = checkName();
	if(!value){
		parent.showMsg(nullMsg,"W");
		return;
	}
    var addList = dgGrid.getChanges("added");
	var updateList = dgGrid.getChanges("modified");

    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			addList : addList,
			updateList : updateList,
			dictid : DICTID,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				parent.showMsg("保存成功!","S");
				doSearch();
			} else {
				parent.showMsg(data.errMsg || "保存失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

}


function checkName(){
	var rows = dgGrid.findRows(function(row) {
		if (row.name == null || row.name == "" || row.name == undefined)
			return true;
	});
	if(rows && rows.length>0){
		return false;
	}
	return true;
}

//hideColumn ( column )		隐藏列	
//showColumn ( column )

function showTabInfo(){
	var tab = mainTabs.getActiveTab();
	var name = tab.name;
    var url = tab.url;
    dgGrid.hideColumn('property1');
    dgGrid.hideColumn('property2');
    dgGrid.hideColumn('property3');
    var col = dgGrid.getColumn('name');
    var tit = tab.title;
    DICTID = '';
	switch (name)
    {
        case "PDICheck"://PDI检测类型
            DICTID = '10361';
            tit = '分类名称';
            break;
        case "ID"://身份
            DICTID = 'DDT20171016000001';
            break;
        case "work"://行业
            DICTID = '10363';
            break;
        case "dept"://职务
            DICTID = '10362';
            break;
        case "source"://来源
            DICTID = 'DDT20130703000075';
            break;
        case "relationship"://关系阶段
            DICTID = 'DDT20140305000001';
            break;
        case "attention"://关注重点
            DICTID = 'DDT20130703000049';
            break;
        case "character"://性格
            DICTID = 'DDT20130703000078';
            break;
        case "contact"://联系状态
            DICTID = '10382';
            break;
        case "carLevel"://车辆级别
            DICTID = '10383';
            break;
        case "country"://国别
            DICTID = '10384';
            break;
        case "structure"://车身结构
            DICTID = '10385';
            break;
        case "displacement"://排量
            DICTID = 'DDT20130703000044';
            break;
        case "sittingNum"://座位数
            DICTID = '10386';
            break;
        case "intakeType"://进气形式
            DICTID = '10387';
            break;
        case "useType"://能源
            DICTID = '10388';
            break;
        case "driveType"://驱动方式
            DICTID = '10389';
            break;
        case "changeSpeed"://变速箱
            DICTID = 'DDT20130705000017';
            break;
        case "proType"://生产方式
            DICTID = '10390';
            break;
        case "carOutcolor"://车身颜色
            DICTID = 'DDT20130726000003';
            break;
        case "carIncolor"://内饰颜色
            DICTID = '10391';
            break;
        case "IntentionLevel"://意向级别
            DICTID = 'DDT20130703000050';
            break;
        case "buyCarType"://购车方式
            DICTID = '10392';
            break;
        case "buyCarUser"://购车用途  
            DICTID = '10341';
            break;
        case "bank"://银行定义
            tit = '银行名称';
            DICTID = 'DDT20140530000001';
            dgGrid.showColumn('property1');
            var colPro = dgGrid.getColumn('property1');
            dgGrid.updateColumn(colPro, { header: '贷款比例(%)'});
            break;
        case "visitType"://来访类型 
            DICTID = 'DDT20130731000003';
            break;
        default:
            break;
    }
    nullMsg = tit + '不能为空';
    doSearch();
    dgGrid.updateColumn(col, { header: tit});
}
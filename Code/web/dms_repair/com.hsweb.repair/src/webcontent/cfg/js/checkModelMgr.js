/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + repairApi + "/";;
var leftGridUrl = baseUrl+"com.hsapi.repair.baseData.query.queryCheckModel.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.repair.baseData.query.queryCheckModelDetail.biz.ext";
var contentGridUrl = baseUrl+"com.hsapi.repair.baseData.query.queryCheckModelDetailContent.biz.ext";
var leftGrid = null;
var rightGrid = null;
var nameEl = null;
var isDisabledEl = null;
var checkDetailContentForm = null;
var contentGrid = null;

var statusList = [{id:"2",name:"全部"},{id:"0",name:"启用"},{id:"1",name:"禁用"}];
var statusHash = {"0":"启用","1":"禁用"};
var dataList = [{id:"0",name:"启用"},{id:"1",name:"禁用"}];
$(document).ready(function(v)
{
	leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    contentGrid = nui.get("contentGrid");
    contentGrid.setUrl(contentGridUrl);
    checkDetailContentForm = document.getElementById("checkDetailContentForm");
    
    nameEl = nui.get("name");
    isDisabledEl = nui.get("isDisabled");

    isDisabledEl.setData(statusList);

    leftGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "isDisabled":
                if(statusHash && statusHash[e.value])
                {
                    e.cellHtml = statusHash[e.value];
                }
                break;
            default:
                break;
        }
    });

    leftGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "isDisabled":
                if(statusHash && statusHash[e.value])
                {
                    e.cellHtml = statusHash[e.value];
                }
                break;
            default:
                break;
        }
    });
    leftGrid.on("selectionchanged",function(e){
        var row = leftGrid.getSelected();
        var mainId = row.id;

	    loadCheckDetail(mainId);
    });
    rightGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "isDisabled":
                if(statusHash && statusHash[e.value])
                {
                    e.cellHtml = statusHash[e.value];
                }
                break;
            default:
                break;
        }
    });
    rightGrid.on("showrowdetail",function(e){
        var row = e.record;
        var checkId = row.id;
        
        //将editForm元素，加入行详细单元格内
        var td = rightGrid.getRowDetailCellEl(row);   
    
        td.appendChild(checkDetailContentForm);
        checkDetailContentForm.style.display = "";
        contentGrid.setData([]);
    
        contentGrid.load({
            checkId:checkId,
            token: token
        });
    });

    onSearch();
});
function getSearchParam(){
    var params = {};
   
    params.name = nameEl.getValue();
    var value = isDisabledEl.getValue();
    if(value && value<2){
        params.isDisabled = value;
    }
	params.orgid = currOrgId;
    return params;
}
function onSearch(){
	var params = getSearchParam();

    doSearch(params);
}
function doSearch(params)
{
    leftGrid.load({
        params:params,
        token:token
    });
}
function addCheckModel(){
    var newRow = {isDisabled:0, modifier: currUserName, modifyDate: (new Date())};
    leftGrid.addRow(newRow);
}
var leftSaveUrl = baseUrl + "com.hsapi.repair.baseData.crud.saveCheckModel.biz.ext";
function saveCheckModel(){

    var addList = leftGrid.getChanges("added");
    var updateList = leftGrid.getChanges("modified");
    var l1 = 0;
    var l2 = 0;
    if(addList && addList.length){
        l1 = addList.length;
    }
    if(updateList && updateList.length){
        l2 = updateList.length;
    }
    if(l1>0 || l2>0){

        var cv = checkLeftGrid();
        if(!cv){
            showMsg("存在模板名称为空的数据!","W");
            return;
        }

        nui.mask({
            el : document.body,
            cls : 'mini-mask-loading',
            html : '保存中...'
        });
    
        nui.ajax({
            url : leftSaveUrl,
            type : "post",
            data : JSON.stringify({
                addList : addList,
                updateList : updateList,
                token: token
            }),
            success : function(data) {
                nui.unmask(document.body);
                data = data || {};
                if (data.errCode == "S") {
                    showMsg("保存成功!","S");
                    onSearch()
                } else {
                    showMsg(data.errMsg || "保存失败!","W");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                // nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        });
    }else{
        showMsg("数据没有修改!","W");
    }
}
function checkLeftGrid(){
    var rows = leftGrid.findRows(function(row){
        var name = row.name;
        if(!name) return true;
    });

    if(rows && rows.length>0){
        return false;
    }

    return true;
}
function loadCheckDetail(mainId){
    rightGrid.load({
        mainId:mainId,
        token:token
    });
}
function addCheckType(){
    nui.open({
		targetWindow : window,
		url : webPath+repairDomain+"/com.hsweb.repair.DataBase.checkTypeSet.flow?token="+token,
		title : "检查项目类型设置",
		width : 280,
		height : 150,
		allowDrag : false,
		allowResize : false,
		onload : function() {
		},
		ondestroy : function(action) {
			if (action == 'ok') {
				
			}
		}
	});
}
function addCheckDetail(){
    nui.open({
		targetWindow : window,
		url : webPath+repairDomain+"/com.hsweb.repair.DataBase.checkDetailSet.flow?token="+token,
		title : "检查项目设置",
		width : 450,
		height : 350,
		allowDrag : false,
		allowResize : false,
		onload : function() {
		},
		ondestroy : function(action) {
			if (action == 'ok') {
				
			}
		}
	});
}
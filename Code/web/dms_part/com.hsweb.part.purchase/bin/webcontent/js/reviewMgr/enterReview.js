/**
 * Created by Administrator on 2018/2/2.
 */

var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGrid1 = null;
var rightGrid1Url = baseUrl+"com.hsapi.part.purchase.svr.queryPtsEnterMainList.biz.ext";
var rightGrid2 = null;
var rightGrid2Url = baseUrl+"com.hsapi.part.purchase.svr.queryPtsEnterDetailByEnterId.biz.ext";
var tree = null;
var storehouseHash = {};
var menuBtnDateQuickSearch = null;

var treeData = [
    {
        id:"050101",
        name:"采购入库"
    },
    {
        id:"050104",
        name:"销售退货"
    },
    {
        id:"050105",
        name:"盘盈入库"
    },
    {
        id:"050106",
        name:"调拨入库"
    }
];
var queryForm = null;
var billTypeIdHash = {};
var settTypeIdHash = {};
var partBrandIdHash = {};
$(document).ready(function(v)
{
	rightGrid1 = nui.get("rightGrid1");
    rightGrid1.setUrl(rightGrid1Url);
    rightGrid1.on("beforeload",function(e){
        e.data.token = token;
    });
    rightGrid2 = nui.get("rightGrid2");
    rightGrid2.setUrl(rightGrid2Url);
    rightGrid2.on("beforeload",function(e){
        e.data.token = token;
    });
    rightGrid2.on("drawcell",function(e)
    {
        switch (e.field)
        {
            case "partBrandId":
            	if(partBrandIdHash[e.value])
                {
//                    e.cellHtml = partBrandIdHash[e.value].name||"";
                	if(partBrandIdHash[e.value].imageUrl){
                		
                		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' weight=' '/><br> "+partBrandIdHash[e.value].name||"";
                	}else{
                		e.cellHtml =partBrandIdHash[e.value].name||"";
                	}
                }
                else{
                    e.cellHtml = "";
                }
                break;
            default:
                break;
        }
    });
    tree = nui.get("tree1");
    tree.on("beforeload",function(e){
        e.data.token = token;
    });
    menuBtnDateQuickSearch = nui.get("menuBtnDateQuickSearch");
    tree.loadData(treeData);
    queryForm = new nui.Form("#queryForm");
    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });

    getStorehouse(function(data) {
        var storehouse = data.storehouse || [];
        nui.get("storeId").setData(storehouse);
        storehouse.forEach(function (v) {
            if (v && v.id) {
                storehouseHash[v.id] = v;
            }
        });
    });
    initDicts({
        billTypeId:BILL_TYPE,//票据类型
        settType:SETT_TYPE //结算方式
    },function(){
        var node = tree.getRootNode().children[0];
        tree.selectNode(node);
        quickSearch(menuBtnDateQuickSearch, currType, '本日');
    });
});

var currType = 0;
function quickSearch(ctlid, value, text){
    ctlid.setValue(value);
    ctlid.setText(text);
    currType = value;
    onSearch();
}

function onSearch()
{
    var params = getSearchParam();
    doSearch(params);
}

function doSearch(params)
{
    //   params.enterTypeId = '050101';
    var node = tree.getSelectedNode();
    if(node)
    {
        params.enterTypeId = node.id;
        rightGrid1.load({
            params:params
        },function(){
            //rightGrid.mergeColumns(["enterId"]);
        });
    }
}

function getSearchParam()
{
    var params = queryForm.getData();

    var storeId = nui.get("storeId").getValue();
    params.storeId = storeId;

    var d = menuBtnDateQuickSearch.getValue();
    if (d == 0) {
        params.today = 1;
    } else if (d == 1) {
        params.yesterday = 1;
    }  else if (d == 2) {
        params.thisWeek = 1;
    } else if (d == 3) {
        params.lastWeek = 1;
    } else if (d == 4) {
        params.thisMonth = 1;
    } else if (d == 5) {
        params.lastMonth = 1;
    }

    if(params.startDate)
    {
        params.startDate = params.startDate.substr(0,10);
    }
    if(params.endDate)
    {
        params.endDate = params.endDate.substr(0,10);
    }

    console.log(params);
    return params;
}

function onNodeDblClick()
{
    onSearch();
}

function onRightGrid1RowClick(e){
    var row = e.record;
    var enterId = row.id;
    loadRightGrid2Data(enterId);
    if(row.auditStatus == 0)
    {
        nui.get("reViewBtn").enable();
    }
    else{
        nui.get("reViewBtn").disable();
    }
    nui.get("reViewBtn").enable();
}
function onRightGrid1DrawCell(e){
    switch (e.field)
    {
        case "storeId":
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
            break;
        default:
            onDrawCell(e);
            break;
    }
}
function loadRightGrid2Data(enterId)
{
    console.log(enterId);
    rightGrid2.load({
        enterId:enterId
    });
}
var reviewUrl = baseUrl+"com.hsapi.part.purchase.enterAudit.auditPtsEnterMain.biz.ext";
function review()
{
    var row = leftGrid.getSelected();
    if(!row || !row.id)
    {
        return;
    }
    var params = {
        param:{
            enterId:row.id,
            token:token
        }
    };
    nui.mask({
        html:'审核保存中...'
    });
    nui.ajax({
        url:reviewUrl,
        type:"post",
        data:JSON.stringify(params),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("审核成功");
                quickSearch(menuBtnDateQuickSearch, currType, '本日');
            }
            else{
                nui.alert(data.errMsg||"审核失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

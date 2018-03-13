/**
 * Created by Administrator on 2018/2/2.
 */

var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGrid1 = null;
var rightGrid1Url = baseUrl+"com.hsapi.part.purchase.svr.queryPtsEnterMainList.biz.ext";
var rightGrid2 = null;
var rightGrid2Url = baseUrl+"com.hsapi.part.purchase.svr.queryPtsEnterDetailByEnterId.biz.ext";
var tree = null;
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
    rightGrid2 = nui.get("rightGrid2");
    rightGrid2.setUrl(rightGrid2Url);
    rightGrid2.on("drawcell",function(e)
    {
        switch (e.field)
        {
            case "partBrandId":
                if(partBrandIdHash && partBrandIdHash[e.value])
                {
                    e.cellHtml = partBrandIdHash[e.value].name;
                }
                break;
            default:
                break;
        }
    });
    tree = nui.get("tree1");
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
    var dictIdList = [];
    dictIdList.push('DDT20130703000008');//票据类型
    dictIdList.push('DDT20130703000035');//结算方式
    getDictItems(dictIdList,function(data)
    {
        var node = tree.getRootNode().children[0];
     //   console.log(node);
        tree.selectNode(node);
        if(data && data.dataItems)
        {
            var dataItems = data.dataItems||[];
            var billTypeIdList = dataItems.filter(function(v)
            {
                if(v.dictid == "DDT20130703000008")
                {
                    billTypeIdHash[v.customid] = v;
                    return true;
                }
            });
            //      nui.get("billTypeId").setData(billTypeIdList);
            var settTypeIdList = dataItems.filter(function(v)
            {
                if(v.dictid == "DDT20130703000035")
                {
                    settTypeIdHash[v.customid] = v;
                    return true;
                }
            });
            quickSearch(currType);
        }
    });
});
var currType = 2;
function onSearch()
{
    var params = getSearchParam();
    if(currType && !(params.startDate||params.endDate))
    {
        switch (currType)
        {
            case 0:
                params.today = 1;
                break;
            case 1:
                params.yesterday = 1;
                break;
            case 2:
                params.thisWeek = 1;
                break;
            case 3:
                params.lastWeek = 1;
                break;
            case 4:
                params.thisMonth = 1;
                break;
            case 5:
                params.lastMonth = 1;
                break;
            case 6:
                params.auditStatus = 0;
                break;
            case 7:
                params.auditStatus = 1;
                break;
            case 8:
                params.postStatus = 1;
                break;
            case 10:
                params.thisYear = 1;
                break;
            case 11:
                params.lastYear = 1;
                break;
            default:
                break;
        }
    }
    doSearch(params);
}
function getSearchParam()
{
    var params = queryForm.getData();
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
function quickSearch(type){
    var params = {};
    currType = type;
    switch (type)
    {
        case 0:
            params.today = 1;
            break;
        case 1:
            params.yesterday = 1;
            break;
        case 2:
            params.thisWeek = 1;
            break;
        case 3:
            params.lastWeek = 1;
            break;
        case 4:
            params.thisMonth = 1;
            break;
        case 5:
            params.lastMonth = 1;
            break;
        case 6:
            params.auditStatus = 0;
            break;
        case 7:
            params.auditStatus = 1;
            break;
        case 8:
            params.postStatus = 1;
            break;
        case 10:
            params.thisYear = 1;
            break;
        case 11:
            params.lastYear = 1;
            break;
        default:
            break;
    }
    if($("a[id*='type']").length>0)
    {
        $("a[id*='type']").css("color","black");
    }
    if($("#type"+type).length>0)
    {
        $("#type"+type).css("color","blue");
    }
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
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
            break;
        case "settType":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        default:
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
            enterId:row.id
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
                quickSearch(currType);
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

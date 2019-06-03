
var baseUrl = apiPath + saleApi + "/";
var gridUrl = apiPath + saleApi + "/sales.base.searchCsbCarModel.biz.ext";
var updateUrl = apiPath + saleApi + "/sales.base.updateCsbCarModel.biz.ext";
var treeUrl = apiPath + repairApi + "/com.hsapi.repair.common.svr.queryCarBrandSeriesTree.biz.ext";
var isDisArr = [{id:'',text:'全部'},{id:0,text:'启用'},{id:1,text:'禁用'}];
var grid = null;
var tree = null;
var carBrandId = null;
var carSeriesId = null;
var fullName = null;
var arr = {};
$(document).ready(function () {
    grid = nui.get("grid1");
    carBrandId = nui.get('carBrandId');
    carBrandId.setUrl(treeUrl);
    carSeriesId = nui.get('carSeriesId');
    fullName = nui.get('fullName');
    grid.setUrl(gridUrl);
    grid.load();
    tree = nui.get("tree1"); 
    tree.setUrl(treeUrl);

    initDicts({
        level:'10383',//级别
        countryType:'10384',//国别
        carSeriesId:'',//车系
        carStructureType:'10385',//结构
        outputVolume:'DDT20130703000044',//排量
        seatQty:'10386',//座位数
        inletType:'10387',//进气形式
        powerType:'10388',//能源
        driveMode:'10389',//驱动方式
        gearBox:'DDT20130705000017',//变速箱
        productionMode:'10390',//生产方式

        //color: "DDT20130726000003"//车辆颜色
    },function () {});


    grid.on('drawcell', function (e) {
        var value = e.value;
        var field = e.field;
        if (field == 'launchDate') {
            e.cellHtml = nui.formatDate(new Date(value), 'yyyy-MM-dd');
        } else if (field == 'isDisabled') {
            e.cellHtml = (value == 0 ? '启用' : '禁用');
        } else if (field == 'level') {
            e.cellHtml = setColVal('level', 'customid', 'name', e.value);
        } else if (field == 'countryType') {
            e.cellHtml = setColVal('countryType', 'customid', 'name', e.value);
        } else if (field == 'carBrandId') {
            e.cellHtml = setColVal('carBrandId', 'nodeId', 'nodeName', e.value);
        } else if (field == 'carStructureType') {
            e.cellHtml = setColVal('carStructureType', 'customid', 'name', e.value);
        } else if (field == 'outputVolume') {
            e.cellHtml = setColVal('outputVolume', 'customid', 'name', e.value);
        } else if (field == 'seatQty') {
            e.cellHtml = setColVal('seatQty', 'customid', 'name', e.value);
        } else if (field == 'inletType') {
            e.cellHtml = setColVal('inletType', 'customid', 'name', e.value);
        } else if (field == 'powerType') {
            e.cellHtml = setColVal('powerType', 'customid', 'name', e.value);
        } else if (field == 'driveMode') {
            e.cellHtml = setColVal('driveMode', 'customid', 'name', e.value);
        } else if (field == 'gearBox') {
            e.cellHtml = setColVal('gearBox', 'customid', 'name', e.value);
        } else if (field == 'productionMode') {
            e.cellHtml = setColVal('productionMode', 'customid', 'name', e.value);
        } else if (field == 'isImported') {
            e.cellHtml = (value == 0 ? '是' : '否');
        }
        
    });

    //"nodedblclick":节点双击时发生
    tree.on("nodedblclick",function(e)
    {
        var node = e.node;
        var params = {};
        if("carSeries" == node.nodeType)
        {
            var pNode = tree.getParentNode(node);
            params.carSeriesId = node.nodeId;
            params.carBrandId = pNode.nodeId;
        }
        else{
            params.carBrandId = node.nodeId;
        }
        grid.load({ params: params, token: token });
    });
});

function onBrandChanged(e) {
    var id = carBrandId.getValue();
    var mUrl = null;
    
    if(id){
        mUrl = treeUrl + "?nodeId=" + id;
        carSeriesId.setUrl(mUrl);
    }
}

function edit(e) {
    var tit = null;
    var row = {};
    if (e == 1) {
        tit = '新增';
    } else if(e == 2){
        tit = '修改';
        row = grid.getSelected();
    } else if (e == 3) {
        tit = '复制';
        row = grid.getSelected();
        row.id = '';
    }
    nui.open({
        url: webPath + contextPath + '/sales/base/sCarModelTypeDet.jsp',
        title: tit,
        width: 540,
        height: 510,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(row,e);
        },
        ondestroy: function (action) {
            grid.reload();
        }
    });
}

function isEnabled() {
    var row = grid.getSelected();
    var params = nui.clone(row);
    var showTextS = null;
    var showTextE = null;
    if (row.isDisabled == 0) {
        params.isDisabled = 1;
        showTextS = '禁用成功';
        showTextE = '禁用失败';
    } else {
        params.isDisabled = 0;
        showTextS = '启用成功';
        showTextE = '启用失败';
    }
    nui.ajax({
        url: updateUrl,
        type: 'post',
        data: {
            data:params
        },
        success:function (res) {
            if (res.errCode == 'S') {
                showMsg(showTextS, 'S');
            } else {
                showMsg(showTextE, 'E');
            }
            grid.reload();
        }
        
    })
}


function search() {
    var params = {
        carBrandId:carBrandId.value,
        carSeriesId:carSeriesId.value,
        fullName: fullName.value,
        isDisabled: nui.get('isDisabled').value,
        code:nui.get('code').value
    }
    grid.load({ params: params, token: token });
}
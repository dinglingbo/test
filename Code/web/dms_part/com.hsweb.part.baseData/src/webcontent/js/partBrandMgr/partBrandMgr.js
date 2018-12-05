/**
 * Created by Administrator on 2018/1/24.
 */

var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryPartBrandList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryPartBrandList.biz.ext";
var bottomeGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryOrgPartBrandList.biz.ext";
var leftGrid = null;
var rightGrid = null;
var splitter = null;
var bottomGrid = null;
$(document).ready(function(v)
{
    //splitter = nui.get("splitter");
    //console.log(splitter);
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    bottomGrid = nui.get("bottomGrid");
    bottomGrid.setUrl(bottomeGridUrl);
    rightGrid.on("rowclick",function(e)
    {
        var row = e.record;
        if(row)
        {
            if(row.isDisabled == 1)
            {
                nui.get("disabledRight").hide();
                nui.get("enabledRight").show();
            }
            else{
                nui.get("enabledRight").hide();
                nui.get("disabledRight").show();
            }
        }
    });
    onSearch(2);

    loadBottom();
});
function addOrEditPartQuality(quality)
{
	var title = "新增品质";
    if(quality)
    {
        if(quality.orgid != currOrgid)
        {
            return;
        }
        title = "品质编辑";
    }
    nui.open({
        targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.baseData.partQualityDetail.flow?token=" + token,
        title: title, width: 350, height: 150,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            if(quality)
            {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData({
                    quality:quality
                });
            }
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                leftGrid.reload();
            }
        }
    });
}
function addPartQuality()
{
    addOrEditPartQuality();
}
function editPartQuality()
{
    var row = leftGrid.getSelected();
    if(row)
    {
        addOrEditPartQuality(row);
    }
}


function addOrEditPartBrand(brand)
{
	var title = "新增品牌";
	if(brand && brand.id)
    {
       if(brand.orgid != currOrgid)
        {
        	showMsg("不允许修改!","W");
            return;
        }
        title = "品牌编辑";
    }
    nui.open({
        targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.baseData.partBrandDetail.flow?token=" + token,
        title: title, width: 350, height: 200,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            if(brand)
            {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData({
                    brand:brand
                });
            }
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                rightGrid.reload();
            }
        }
    });
}

function addPartBrand()
{
    var quality = leftGrid.getSelected();
    if(quality)
    {
        var brand = {
            parentId:quality.id
        };
        addOrEditPartBrand(brand);
    }
}
function editPartBrand(){
    var brand = rightGrid.getSelected();
    if(brand)
    {
        addOrEditPartBrand(brand);
    }
}
function onDrawCell(e)
{
    switch (e.field)
    {
        case "isDisabled":
            e.cellHtml = e.value==1?"禁用":"启用";
            break;
        default:
            break;
    }
}
function onSearch(type)
{
    var params = {};
    if(type == 1||type == 0)
    {
        params.isDisabled = type;
    }
    if($("a[id*='type']").length>0)
    {
        $("a[id*='type']").css("color","black");
    }
    if($("#type"+type).length>0)
    {
        $("#type"+type).css("color","blue");
    }
    loadLeftGridData(params);
}
function loadLeftGridData(params)
{
    rightGrid.setData([]);
    leftGrid.load(params,function()
    {
        var row = leftGrid.getSelected();
        if(row)
        {
            if(row.isDisabled)
            {
                nui.get("disabledLeft").hide();
                nui.get("enabledLeft").show();
            }
            else{
                nui.get("disabledLeft").show();
                nui.get("enabledLeft").hide();
            }
            onLeftGridRowClick({
                record:row
            });
        }
    });
}
function onLeftGridRowClick(e)
{
    var row = e.record;
    if(row.isDisabled)
    {
        nui.get("disabledLeft").hide();
        nui.get("enabledLeft").show();
    }
    else{
        nui.get("disabledLeft").show();
        nui.get("enabledLeft").hide();
    }
    if(row.orgid == currOrgid || currTenantId=='default'){
        nui.get("disabledLeft").enable();
        nui.get("enabledLeft").enable();
        nui.get("editLeft").enable();
        //nui.get("addRight").enable();
        nui.get("editRight").enable();
        nui.get("disabledRight").enable();
        nui.get("enabledRight").enable();
    }else{
        nui.get("disabledLeft").disable();
        nui.get("enabledLeft").disable();
        nui.get("editLeft").disable();
        //nui.get("addRight").disable();
        nui.get("editRight").disable();
        nui.get("disabledRight").disable();
        nui.get("enabledRight").disable();
    }
    
    loadRightGridData(row.id);
}
function loadRightGridData(parentId)
{
    rightGrid.load({
        parentId:parentId
    },function(){
        var row = rightGrid.getSelected();
        if(row && row.isDisabled)
        {
            nui.get("disabledRight").hide();
            nui.get("enabledRight").show();
        }
        else{
            nui.get("disabledRight").show();
            nui.get("enabledRight").hide();
        }
    });
}
function reloadRightGrid(){
    rightGrid.reload()
}

function disablePartQuality(){
    var row = leftGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要禁用所选品质？","提示",function(action)
        {
            if(action == "ok")
            {
                updateIsDisabled({
                    id:row.id,
                    isDisabled:1,
                    name:row.name
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        row.isDisabled = 1;
                        leftGrid.updateRow(row,row);
                        nui.get("disabledLeft").hide();
                        nui.get("enabledLeft").show();
                        showMsg("禁用成功","S");
                    }
                    else{
                        showMsg(data.errMsg||"禁用失败","E");
                    }
                });
            }
        }.bind(row));
    }
}
function enablePartQuality(){
    var row = leftGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要启用所选品质？","提示",function(action)
        {
            if(action == "ok")
            {
                updateIsDisabled({
                    id:row.id,
                    isDisabled:0,
                    name:row.name
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        row.isDisabled = 0;
                        leftGrid.updateRow(row,row);
                        nui.get("disabledLeft").show();
                        nui.get("enabledLeft").hide();
                        showMsg("启用成功","S");
                    }
                    else{
                        showMsg(data.errMsg||"启用失败","E");
                    }
                });
            }
        }.bind(row));
    }
}
function disablePartBrand()
{
    var row = rightGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要禁用所选品牌？","提示",function(action)
        {
            if(action == "ok")
            {
                updateIsDisabled({
                    id:row.id,
                    isDisabled:1,
                    name:row.name
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        row.isDisabled = 1;
                        rightGrid.updateRow(row,row);
                        nui.get("disabledRight").hide();
                        nui.get("enabledRight").show();
                        showMsg("禁用成功","S");
                    }
                    else{
                        showMsg(data.errMsg||"禁用失败","E");
                    }
                });
            }
        }.bind(row));
    }
}
function enablePartBrand()
{
    var row = rightGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要启用所选品牌？","提示",function(action)
        {
            if(action == "ok")
            {
                updateIsDisabled({
                    id:row.id,
                    isDisabled:0,
                    name:row.name
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        row.isDisabled = 0;
                        rightGrid.updateRow(row,row);
                        nui.get("disabledRight").show();
                        nui.get("enabledRight").hide();
                        showMsg("启用成功","S");
                    }
                    else{
                        showMsg(data.errMsg||"启用失败","E");
                    }
                });
            }
        }.bind(row));
    }
}
var updateIsDisabledUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.savePartBrand.biz.ext";

function updateIsDisabled(brand,callback)
{
    console.log(brand);
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:updateIsDisabledUrl,
        type:"post",
        data:JSON.stringify({
            brand:brand,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            callback && callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function addLocalBrand()
{
    nui.open({
        targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.baseData.partBrandOrgDetail.flow?token=" + token,
        title: "新增关注品牌", width: 600, height: 350,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setInitData(bottomGrid.getData());
         
        },
        ondestroy: function (action)
        {
            loadBottom();
        }
    });
}
function loadBottom(){
    bottomGrid.load({
        token:token
    });
}
var saveLocalBrandUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.saveOrgPartBrand.biz.ext";
function delLocalBrand()
{
    var data = bottomGrid.getSelecteds();
    if(!data || data.length<=0) return;

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });
    nui.ajax({
        url:saveLocalBrandUrl,
        type:"post",
        data:JSON.stringify({
            deleteList:data,
            token:token
        }),
        success:function(rs)
        {
            nui.unmask();
            rs = rs||{};
            if(rs.errCode == "S")
            {
                showMsg("处理成功","S");
                loadBottom();
            }
            else{
                showMsg(data.errMsg||"处理失败","E");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
        }
    });
}
function saveLocalBrand(){
    var data = bottomGrid.getChanges("modified");

    if(!data || data.length<=0) return;

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });
    nui.ajax({
        url:saveLocalBrandUrl,
        type:"post",
        data:JSON.stringify({
            updateList:data,
            token:token
        }),
        success:function(rs)
        {
            nui.unmask();
            rs = rs||{};
            if(rs.errCode == "S")
            {
                showMsg("保存成功","S");
                loadBottom();
            }
            else{
                showMsg(data.errMsg||"保存失败","E");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
        }
    });
}
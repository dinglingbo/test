/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;

function initForm(){
    basicInfoForm = new nui.Form("#basicInfoForm");
}
var applyCarModel = null;
var abcType = null;
var partBrandId = null;
var qualityTypeId = null;
var unit = null;


var abcTypeList = [
    {
        customid:"A1",
        name:"A1"
    },
    {
        customid:"A2",
        name:"A2"
    },
    {
        customid:"A3",
        name:"A3"
    },
    {
        customid:"B1",
        name:"B1"
    },
    {
        customid:"B2",
        name:"B2"
    },
    {
        customid:"B3",
        name:"B3"
    },
    {
        customid:"C1",
        name:"C1"
    },
    {
        customid:"C2",
        name:"C2"
    },
    {
        customid:"C3",
        name:"C3"
    }
];
function initComboBox()
{
    applyCarModel = nui.get("applyCarbrandId");
    abcType = nui.get("abcType");
    abcType.setData(abcTypeList);
    partBrandId = nui.get("partBrandId");
    qualityTypeId = nui.get("qualityTypeId");
    unit = nui.get("unit");
}
$(document).ready(function(v)
{
    initComboBox();
    initForm();
});


function CloseWindow(action) {
    //if (action == "close" && form.isChanged()) {
    //    if (confirm("数据被修改了，是否先保存？")) {
    //        return false;
    //    }
    //}
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}

var requiredField = {
    qualityTypeId:"配件品质",
    partNameId:"名称",
    code:"编码",
    unit:"单位",
    partBrandId:"配件品牌",
    abcType:"ABC分类"
};
var oldData = null;
var saveUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.savePart.biz.ext";
function onOk()
{
    var data = basicInfoForm.getData();
    console.log(data);
    for(var key in requiredField)
    {
    	if(!data[key] || data[key].toString().trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
  //  return;
    if(partName)
    {
        data.carTypeIdF = partName.cartypef||"";
        data.carTypeIdS = partName.cartypes||"";
        data.carTypeIdT = partName.cartypet||"";
    }
  //  data.abcType = "";
    data.name = nui.get("partNameId").getText();
    data.fullName = data.name;
    if(data.spec)
    {
        data.fullName = data.fullName + " " + data.spec;
    }
    data.fullName = data.fullName + " " + partBrandIdHash[data.partBrandId].name;
    if(!data.id)
    {
        var matches = data.code.match(/([\w]*)/ig);
        data.queryCode = "";
        for(var i=0;i<matches.length;i++)
        {
            data.queryCode+=matches[i];
        }
        data.oemCode = data.code;
    }
    if(oldData && oldData.isUniform == 0 && data.isUniform == 1)
    {
        data.needSetUniformDate = "Y";
    }
    if(data.qualityTypeId == "000071")
    {
    	data.brandCode = data.code;
    }
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            part:data,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("保存成功");
                CloseWindow("ok");
            }
            else{
                nui.alert(data.errMsg||"保存失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

var applyCarModelList = [];
var partBrandIdList = [];
var partBrandIdHash = {};
var qualityTypeIdList = [];
var unitList = [];
function setData(data)
{
    if(!applyCarModel)
    {
        initComboBox();
    }
    applyCarModelList = data.applyCarModelList||[];
    partBrandIdList = data.partBrandIdList||[];
    partBrandIdList.forEach(function(v)
    {
        partBrandIdHash[v.id] = v;
    });
    unitList = data.unitList||[];
    qualityTypeIdList = data.qualityTypeIdList||[];

    applyCarModel.setData(applyCarModelList);
    applyCarModel.on("valuechanged",function()
    {
        var value = applyCarModel.getText();
        nui.get("applyCarModel").setValue(value);
    });
    qualityTypeId.setData(qualityTypeIdList);
    unit.setData(unitList);
    console.log(data);
    if(data.partData)
    {
        if(!basicInfoForm)
        {
            initForm();
        }
        var partData = data.partData;
        nui.mask({
            html:'数据加载中...'
        });
        getPartById(partData.id,function(data)
        {
        	nui.unmask();
            data = data||{};
            var part = data.part||{};
            if(!part.id)
            {
                nui.alert("数据加载出错");
                return;
            }
            oldData = part;
            basicInfoForm.setData(part);
            onQualityTypeIdChanged();
            basicInfoForm.setData(part);
            nui.get("partNameId").setText(part.name);
            nui.get("code").disable();
        });
    }
}

var partName = null;
function onButtonEdit()
{
    partName = null;
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.common.partNameSelect.flow",
        title: "配件名称查询",
        width:900, height: 650,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                console.log(data);
                partName = data.partName;
                nui.get("partNameId").setValue(partName.id);
                nui.get("partNameId").setText(partName.name);
            }
        }
    });
}
function onQualityTypeIdChanged(){
    var qId = qualityTypeId.getValue();
    var list = partBrandIdList.filter(function (v) {
        return v.parentId == qId;
    });
    partBrandId.setData(list);
}
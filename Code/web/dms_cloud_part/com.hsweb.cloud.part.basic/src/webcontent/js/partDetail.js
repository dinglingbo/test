/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;

function initForm(){
    basicInfoForm = new nui.Form("#basicInfoForm");
}
var applyCarModel = null;
var abcType = null;
var partBrandId = null;
var qualityTypeId = null;
var unit = null;
var qualityHash = {};
var partBrandIdHash = {};
var partBrandIdList = [];


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
    //abcType = nui.get("abcType");
    //abcType.setData(abcTypeList);
    partBrandId = nui.get("partBrandId");
    qualityTypeId = nui.get("qualityTypeId");
    unit = nui.get("unit");
}
$(document).ready(function(v)
{
    initComboBox();
    initForm();

    var dictDefs ={"unit":"DDT20130703000016"};
    initDicts(dictDefs, null);
    
    getAllPartBrand(function(data)
    {
        data = data||{};
        qualityTypeIdList = data.quality;
        qualityTypeIdList.forEach(function(v)
        {
            qualityHash[v.id] = v;
        });
        nui.get('qualityTypeId').setData(qualityTypeIdList);
        partBrandIdList = data.brand;
        partBrandIdList.forEach(function(v)
        {
        	partBrandIdHash[v.id] = v;
        });
        
        
        initPartBrand("partBrandId",function(){
            initDicts({

            },function(){

            });
        });

    });

    initCarBrand("applyCarbrandId",function(){
    	applyCarModelList=nui.get('applyCarbrandId').getData();
        initDicts({
            unit:UNIT,// --单位
//	                abcType:ABC_TYPE // --ABC分类
        },function(){
            //onSearch();          	
        });
    });

    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;

        switch(keyCode){
            case 27:
            window.CloseOwnerWindow("");
            break; 
        }

        if((keyCode==83)&&(event.shiftKey))  {  
            onOk();  
        } 

        if((keyCode==67)&&(event.shiftKey))  { 
            onCancel();
        }  
    }
    
    nui.get("qualityTypeId").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
      };
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
    partBrandId:"配件品牌",
    code:"编码",
    partNameId:"名称",
    unit:"单位"
};
var oldData = null;
var saveUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.savePart.biz.ext";
function onOk()
{
    var data = basicInfoForm.getData();
    for(var key in requiredField)
    {
    	if(!data[key] || data[key].toString().trim().length==0)
        {
            parent.showMsg(requiredField[key]+"不能为空","W");
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
    data.fullName = data.fullName + " " + partBrandIdHash[data.partBrandId].name;
    if(data.spec)
    {
        data.fullName = data.fullName + " " + data.spec;
    }
    if(!data.id)
    {
        var matches = data.code.match(/([\w]*)/ig);
        data.queryCode = "";
        for(var i=0;i<matches.length;i++)
        {
            data.queryCode+=matches[i];
        }
        //没有OEM码。OEM码=配件编码，有则以输入为准
        if(!data.oemCode ){    	
        	data.oemCode = data.code;
        }
    }
    if(oldData && oldData.isUniform == 0 && data.isUniform == 1)
    {
        data.needSetUniformDate = "Y";
    }
    if(data.qualityTypeId == "000071")
    {
    	data.brandCode = data.code;
    }
    if (data.modifyDate) {
        data.modifyDate = format(data.modifyDate, 'yyyy-MM-dd HH:mm:ss');
    }
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
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
                parent.showMsg("保存成功","S");
                CloseWindow("ok");
            }
            else{
            	parent.showMsg(data.errMsg||"保存失败","E");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
        }
    });
}
function format(time, format) {
    var t = new Date(time);
    var tf = function (i) { return (i < 10 ? '0' : '') + i; };
    return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a) {
    switch (a) {
    case 'yyyy':
    return tf(t.getFullYear());
    break;
    case 'MM':
    return tf(t.getMonth() + 1);
    break;
    case 'mm':
    return tf(t.getMinutes());
    break;
    case 'dd':
    return tf(t.getDate());
    break;
    case 'HH':
    return tf(t.getHours());
    break;
    case 'ss':
    return tf(t.getSeconds());
    break;
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
    
    if(data.applyCarModelList){
    applyCarModelList = data.applyCarModelList||[];
    }
    
    if(data.partBrandIdList){
    partBrandIdList = data.partBrandIdList||[];
    
    partBrandIdList.forEach(function(v)
    {
        partBrandIdHash[v.id] = v;
    });
    }
    
    if(data.unitList){
    unitList = data.unitList||[];
    }
    
    if(data.qualityTypeIdList){
    qualityTypeIdList = data.qualityTypeIdList||[];
    }
    
    applyCarModel.setData(applyCarModelList);
    applyCarModel.on("valuechanged",function()
    {
        var value = applyCarModel.getText();
        nui.get("applyCarModel").setValue(value);
        var partCode= nui.get('code').getValue().replace(/\s+/g, "");
        var firstCode=partCode.charCodeAt(0);
        if(value=='奔驰'){
        	//判断首字母是否为英文
        	if((firstCode>= 65 && firstCode <= 90) || (firstCode>= 97 && firstCode <= 122)){
        		
        	}else{
        		partCode="A"+partCode;
        		nui.get("code").setValue(partCode);
        	}
        }
    });
    qualityTypeId.setData(qualityTypeIdList);
    //unit.setData(unitList);
    
    if(data.comPartCode){
    	nui.get("code").setValue(data.comPartCode);
    }
    if(data.partData)
    {
        if(!basicInfoForm)
        {
            initForm();
        }
        var partData = data.partData;
       
        nui.mask({
            el : document.body,
            cls : 'mini-mask-loading',
            html : '数据加载中...'
        });
        getPartById(partData.id,function(data)
        {
        	nui.unmask();
            data = data||{};
            var part = data.part||{};
            if(!part.id)
            {
                showMsg("数据加载出错","W");
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
//        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.common.partNameSelect.flow?token="+token,
        title: "配件名称查询",
        width:940, height: 650,
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

function getData(){
	var data=basicInfoForm.getData();
	return data;
}
/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;

var partNameUrl =baseUrl+"com.hsapi.cloud.part.common.svr.queryPartName.biz.ext";
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
var partNameIdEl = null;
var partName = {};

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
	partNameIdEl =nui.get('partNameId');
	
	partNameIdEl.setUrl(partNameUrl);
	partNameIdEl.on("beforeload",function(e){
      
        var data = {};
        var params = {};
        var value = e.data.key;
        value = value.replace(/\s+/g, "");
        if(value.length<2){
            e.cancel = true;
            return;
        }
      
        data.searchKey = e.data.key.replace(/\s+/g, "");

        e.data =data;
        return;      
        
    });
	
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
    partBrandId:"配件品牌",
    code:"编码",
    name:"名称",
    unit:"单位"
};
var oldData = null;
var saveUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.savePart.biz.ext";
function onOk()
{
	
    var data = basicInfoForm.getData();
    data.tenantId = currTenantId;
    data.orgid = currOrgid;
    if(!data.name){    	
    	data.name = nui.get("partNameId").getText();
    }
    for(var key in requiredField)
    {
    	if(!data[key] || data[key].toString().trim().length==0)
        {
            parent.showMsg(requiredField[key]+"不能为空","W");
            return;
        }
    }
    
    if(typeof data.partNameId !== 'number' ){
    	data.partNameId =0;
    }
    if(partName)
    {
        data.carTypeIdF = partName.cartypef||"";
        data.carTypeIdS = partName.cartypes||"";
        data.carTypeIdT = partName.cartypet||"";
    }
  //  data.abcType = "";
    data.code =data.code.toUpperCase();
    
    data.fullName = data.name;
    if(data.spec)
    {
        data.fullName = data.fullName + " " + data.spec;
    }
    if(data.applyCarModel)
    {
        data.fullName = data.fullName + " " + data.applyCarModel;
    }
    
    data.fullName = data.fullName + " " + partBrandIdHash[data.partBrandId].name;
    
    data.customClassId =customClassId;
    data.customClassName =customClassName;
   
    if(!data.id)
    {
        var matches = data.code.match(/([\w\u4e00-\u9fa5]*)/ig);
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
    
    var cangHash ={};
    if(qualityHash && qualityHash[data.qualityTypeId]){
    	cangHash.part_type_id =qualityHash[data.qualityTypeId].cangBrandId;
    }
    cangHash.agency_id =currAgencyId;
    cangHash.part_id = data.cangPartId;
    cangHash.pid = data.code;
    cangHash.source_pid = data.code;
    cangHash.um = data.unit;
    cangHash.remark = data.remark?null:"";
    if(partBrandIdHash && partBrandIdHash[data.partBrandId]){    	
    	cangHash.origin = partBrandIdHash[data.partBrandId].name;
    }
    cangHash.label = data.fullName;
    cangHash.cars = data.applyCarModel;
    cangHash.spec =data.spec;
    if(data.isDisabled ==1){
    	cangHash.status =0;
    }else{
    	cangHash.status =1;
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
            cangHash :cangHash,
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

function applyPartBrand(qualityTypeIdList,partBrandIdList){
	var parentId =0;
	var result=[];
	for(var i=0;i<qualityTypeIdList.length;i++){
		if(qualityTypeIdList[i].name=='品牌件'){
			parentId=qualityTypeIdList[i].id;
		}
	}
	nui.get("qualityTypeId").setValue(parentId);
	for(var i=0;i<partBrandIdList.length;i++){
		if(partBrandIdList[i].parentId ==parentId){
			result.push(partBrandIdList[i]);
		}
	}
	return result;
}
function setData(data)
{
    if(!applyCarModel)
    {
        initComboBox();
    }
    
    if(data.applyCarModelList){
    applyCarModelList = data.applyCarModelList||[];
    }
    
    if(data.partBrandIdList && data.qualityTypeIdList){
    	data.partBrandIdList = applyPartBrand(data.qualityTypeIdList,data.partBrandIdList);
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
   
    if(data.partData){
    	if(data.partData.customClassId){
        	var  customClassId =data.partData.customClassId|| "";
        	nui.get("customClassId").setText(data.partData.customClassName);
            setHotWord(data.partData.customClassId);
        }
        
    }
    
    
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

function onPartNameValueChanged(e) {
	// 供应商中直接输入名称加载供应商信息
//	var params = {};
//	params.pny = e.value;
//	params.isSupplier = 1;
//	setGuestInfo(params);
	var data = e.selected;
	if (data) { 
		var id = data.id;
		var text = data.name;
		partName.cartypef =data.cartypef;
		partName.cartypes =data.cartypes;
		partName.cartypet =data.cartypet;
		
    }
}

var customClassId ="";
var customClassName = "";
function onButtonEdit2()
{
    partName = null;
    nui.open({
//        // targetWindow: window,
        url: webPath+contextPath+"/common/classTabShow.jsp",
        title: "自定义分类",
        width:440, height: 350,
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
                tmp = data.tmp;
                customClassName = data.customClassName;
                customClassId = data.customClassId;
                nui.get("customClassId").setValue(customClassId);
                nui.get("customClassId").setText(customClassName);
                $("#addAEl").html(tmp);
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

function setHotWord(customClassId){
	var hotUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.queryDict.biz.ext";
	var customClassIdList = customClassId.split(",");
	var dictids = ["10441","10442"];
	nui.ajax({
		url : hotUrl,
		type : "post",
		aynsc:false,
		data : {
			dictids:dictids,
			tenantIds:currTenantId,
			token:token
		},
		success : function(data) {
			var temp="";
			data = data || {};
			if (data.errCode == "S") {
				
				var list = nui.clone(data.data);
				
				
				for(var i=0;i<list.length;i++){
					for(var j=0;j<customClassIdList.length;j++){
						if(customClassIdList[j]==list[i].id){
							var aEl = "<a href='##' id='"+list[i].id+"' value="+list[i].name+"  name='HotWord' class='hui'>"+list[i].name+"</a>";
							temp +=aEl;
						}
						
					}									
				}
				$("#addAEl").html(temp);

//				selectclick();
			} else {
				showMsg(data.errMsg || "设置标签失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}



/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.part.invoice.svr.queryTurnOverDetail.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var brandHash = {};
var brandList = [];
var storehouseHash = {};

var settTypeIdHash = {};
var outTypeIdHash = {};
var partTypeList=[];
var partTypeHash={};
var orgidsEl = null;
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    startDateEl =nui.get('startDate');
    endDateEl = nui.get('endDate');
    
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }

    
	getAllPartBrand(function(data) {
		brandList = data.brand;
		nui.get('partBrandId').setData(brandList);
		brandList.forEach(function(v) {
			brandHash[v.id] = v;
		});
	});
	
	getAllPartType(function(data){
		partTypeList=data.partTypes;
		nui.get('partTypeId').setData(partTypeList);
		partTypeList.forEach(function(v){
			partTypeHash[v.id]=v;
		});
	});
	
	rightGrid.on("drawcell",function(e){
		switch (e.field) {
		
		case "partBrandId":
			 if(brandHash[e.value])
             {
//                 e.cellHtml = brandHash[e.value].name||"";
             	if(brandHash[e.value].imageUrl){
             		
             		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
             	}else{
             		e.cellHtml = brandHash[e.value].name||"";
             	}
             }
             else{
                 e.cellHtml = "";
             }
             break;
        case "carTypeIdF":
        case "carTypeIdS":
        case "carTypeIdT":
            if(partTypeHash[e.value])
            {
                e.cellHtml = partTypeHash[e.value].name||"";
            }
            else{
                e.cellHtml = "";
            }
            break;
        case  "orgid":
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName || "";
        		}
        	}
        	break; 

		default:
			break;
		}
	});
	
	document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		
		if ((keyCode == 13)) { // F9
			onSearch();
		}

	}
    quickSearch(0);


});
function getSearchParams(){
    var params = {};
    params.partCodeOrName=nui.get('partCodeOrName').getValue();
    params.partBrandId=nui.get('partBrandId').getValue();
    params.partTypeId=nui.get('partTypeId').getValue();
    params.startDate=nui.get("startDate").getFormValue();
    params.endDate=addDate(endDateEl.getValue(),1);
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }

    return params;
}
var currType = 2;
function quickSearch(type){
	var params = getSearchParams();
    var queryname = "最近7天";
    switch (type)
    {
        case 0:
            params.startDate = getDate(7);
            params.endDate = getDate(-1);
            queryname = "最近7天";
            break;
        case 1:
            params.startDate = getDate(30);
            params.endDate = getDate(-1);
            queryname = "最近30天";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getDate(30);
            params.endDate = getDate(-1);
            queryname = "最近90天";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getDate(180);
            params.endDate = getDate(-1);
            queryname = "最近180天";
            break;
        default:
            break;
    }
    currType = type;
    startDateEl.setValue(params.startDate);
    endDateEl.setValue(addDate(params.endDate,-1));
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}

function onSearch(){
	var params=getSearchParams();
	doSearch(params);
}
function doSearch(params)
{
//	params.orgid = currOrgid;
    rightGrid.load({
        params:params,
        token :token     
    });
}

function getDate(wantDay){
	var date=new Date();
	var returnDate=new Date(date-1000*60*60*24*wantDay);
	var year=returnDate.getFullYear();
	var month=returnDate.getMonth()+1;
	var day=returnDate.getDate();
	var returnSting=year+"-"+(month<10 ? "0"+month :month)+"-"+(day<10 ?"0"+day:day);
	return returnSting;
}
function onExport(){
	var detail = nui.clone(rightGrid.getData());
	exportNoMultistage(rightGrid.columns)
	for(var i=0;i<detail.length;i++){
/*		for(var j in servieTypeHash) {
		    if(detail[i].serviceTypeId ==servieTypeHash[j].id ){
		    	detail[i].serviceTypeId=servieTypeHash[j].name;
		    }
		}
		for(var j in storeHash) {
		    if(detail[i].storeId ==storeHash[j].id ){
		    	detail[i].storeId=storeHash[j].name;
		    }
		}
		if(detail[i].returnSign==0){
			detail[i].returnSign="否";
		}else{
			detail[i].returnSign="是";
		}
		for(var j in partTypeHash) {
			if(detail[i].carTypeIdF==partTypeHash[j].code){
				detail[i].carTypeIdF=partTypeHash[j].name;
			}
			if(detail[i].carTypeIdS==partTypeHash[j].code){
				detail[i].carTypeIdS=partTypeHash[j].name;
			}
			if(detail[i].carTypeIdT==partTypeHash[j].code){
				detail[i].carTypeIdT=partTypeHash[j].name;
			}
		}*/
	}
	if(detail && detail.length > 0){
		setInitExportDataNoMultistage( detail,rightGrid.columns,"库存周转明细表导出");
	}
	
}




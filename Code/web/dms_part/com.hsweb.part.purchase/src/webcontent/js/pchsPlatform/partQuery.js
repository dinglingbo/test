
var baseUrl = apiPath + partApi + "/";
var protoken=null;
var partGrid=null;
var protokenEl=null;
var innerPartGrid=null;
var editFormDetail = null;
var getToeknUrl='http://124.172.221.179:83/srm/router/rest?method=sys.sys.loginIndex&account=000dlb&password=123456&system=0';
var getDetailPartUrl =baseUrl+"com.hsapi.part.invoice.partInterface.queryDetailStock.biz.ext";
var partGridUrl=baseUrl+"com.hsapi.part.invoice.partInterface.queryJoinStock.biz.ext";
$(document).ready(function() {
    protokenEl=nui.get('protoken');
	partGrid =nui.get('partGrid');
	partGrid.setUrl(partGridUrl);
	innerPartGrid = nui.get("innerPartGrid");
    innerPartGrid.setUrl(getDetailPartUrl);
    editFormDetail = document.getElementById("editFormDetail");
});

function getToken(){
	nui.ajax({
        url : getToeknUrl,
        type : "post",
        data : '',
        success : function(data) {
            nui.unmask(document.body);
            data = data.data || {};
            if (data.status == "0") {
            	protoken=data.protoken;
            	protokenEl.setValue(protoken);
            }
               
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onSearch (){
	protoken =protokenEl.value;
	partGrid.load({
		protoken :protoken,
		key  :23
	});
}


function onShowRowDetail(e) {
    var row = e.record;
    
    //将editForm元素，加入行详细单元格内
    var td = partGrid.getRowDetailCellEl(row);
    td.appendChild(editFormDetail);
    editFormDetail.style.display = "";
    innerPartGrid.setData([]);
    var partId = row.partId;
    innerPartGrid.load({
    	sort :"partId",
    	key:partId,
    	protoken:protoken
    	});
    
}
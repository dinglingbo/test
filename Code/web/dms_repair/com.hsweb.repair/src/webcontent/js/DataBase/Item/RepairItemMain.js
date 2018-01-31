var basePath = window._rootUrl||"http://127.0.0.1:8080/default/";
var repairListUrl = basePath+"com.hsapi.repair.Item.queryRepairItemList.biz.ext";
var repairGrid = null;
var tree = null;
var treeUrl = basePath+"com.hsapi.part.common.svr.getPartTypeTree.biz.ext";

var treeList = [];
var treeHash = {};
var detailHash = {};
var detailList = [];
var unitList = [];
var abcTypeList = [];
$(document).ready(function(v)
		{
			repairGrid = nui.get("datagrid1");
			repairGrid.setUrl(repairListUrl);

		    tree = nui.get("tree1");
		    tree.setUrl(treeUrl);
		    

		    getAllRapairItem(function(data)
		    	    {
		    	        treeList = data.quality;
		    	        treeList.forEach(function(v)
		    	        {
		    	            treeHash[v.id] = v;
		    	        });
		    	        detailList = data.brand;
		    	        detailList.forEach(function(v)
		    	        {
		    	        	detailHash[v.id] = v;
		    	        });
		    	    });
		    
		});
		    function onDrawNode(e)
		    {
		        var node = e.node;
		        e.nodeHtml = node.code + " " + node.name;
		    }
		    function onNodeDblClick(e)
		    {
		        var currTree = e.sender;
		        var currNode = e.node;
		        var level = currTree.getLevel(currNode);
		        var list = [];
		        var tmpNode = currNode;
		        do{
		            list[level] = tmpNode.id;
		            tmpNode = currTree.getParentNode(tmpNode);
		            level = currTree.getLevel(tmpNode);
		        }while(tmpNode&&tmpNode.id);

		        var cartypef = list[0]||"";
		        var cartypes = list[1]||"";
		        var cartypet = list[2]||"";

		        var params = {
		            carTypeIdF:cartypef,
		            carTypeIdS:cartypes,
		            carTypeIdT:cartypet
		        };
		        doSearch(params);
		    }
		    var partTypeHash = null;
		    function onPartGridDraw(e)
		    {
		        if(!partTypeHash)
		        {
		            partTypeHash = {};
		            var partTypeList = tree.getList();
		            partTypeList.forEach(function(v)
		            {
		                partTypeHash[v.id] = v;
		            });
		        }

		        switch (e.field)
		        {
		            case "isDisabled":
		                e.cellHtml = e.value == 1?"失效":"有效";
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
		            case "qualityTypeId":
		                if(qualityHash[e.value])
		                {
		                    e.cellHtml = qualityHash[e.value].name||"";
		                }
		                else{
		                    e.cellHtml = "";
		                }
		                break;
		            case "partBrandId":
		                if(brandHash[e.value])
		                {
		                    e.cellHtml = brandHash[e.value].name||"";
		                }
		                else{
		                    e.cellHtml = "";
		                }
		                break;
		            default:
		                break;
		        }
		    }


		    function reloadData()
		    {
		        if(partGrid)
		        {
		            partGrid.reload();
		        }
		    }
		    function getSearchParams()
		    {
		        var params = {};
		        params.code = nui.get("search-code").getValue();
		        params.name = nui.get("search-name").getValue();
		        params.namePy = nui.get("search-namePy").getValue().toUpperCase();
		        params.applyCarModel = nui.get("search-applyCarModel").getValue();
		        return params;
		    }
		    function onSearch()
		    {
		        var params = getSearchParams();
		        doSearch(params);
		    }
		    function doSearch(params)
		    {
		    	partGrid.load({
		            params:params
		        });
		    }
		    function addPart(){
		        addOrEditPart();
		    }
		    function editPart(){
		        var row = partGrid.getSelected();
		        if(row)
		        {
		            addOrEditPart(row);
		        }

		    }
/*
		    function addOrEditPart(row)
		    {
		        nui.open({
		            targetWindow: window,
		            url: "./InsuranceDetail.jsp",
		            title: "维修项目",
		            width: 740, height: 350,
		            allowDrag:true,
		            allowResize:false,
		            onload: function ()
		            {
		                var iframe = this.getIFrameEl();
		                var params = {
		                    qualityTypeIdList:qualityList,
		                    partBrandIdList:brandList,
		                    unitList:unitList,
		                    abcTypeList:abcTypeList
		                };
		                if(row)
		                {
		                    params.partData = row;
		                }
		                iframe.contentWindow.setData(params);
		            },
		            ondestroy: function (action)
		            {
		                if(action == "ok")
		                {
		                    partGrid.reload();
		                }
		            }
		        });
		    }

*/
		    var getAllPartBrandUrl = basePath+"com.hsapi.part.common.svr.getAllPartBrand.biz.ext";
		    function getAllPartBrand(callback)
		    {
		        nui.ajax({
		            url:getAllPartBrandUrl,
		            type:"post",
		            success:function(data)
		            {
		                if(data && data.quality && data.brand)
		                {
		                    callback && callback(data);
		                }
		            },
		            error:function(jqXHR, textStatus, errorThrown){
		                //  nui.alert(jqXHR.responseText);
		                console.log(jqXHR.responseText);
		            }
		        });
		    }
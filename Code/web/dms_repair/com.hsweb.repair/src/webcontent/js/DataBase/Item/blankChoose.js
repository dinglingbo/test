var url = webPath + contextPath + "/repair/imag/select-path-back.png";
var selectColor = [];
var pathOpacity = null;
var nowitemspecialflg = null;
var blankGrid = null;
//var data = ["1":"拆装","2":"修复","3":"更换","4":"校正"];
//var statusList = [{id:1,name:"拆装"},{id:2,name:"修复"},{id:3,name:"更换"},{id:4,name:"校正"}];
//var statusHash = {1:"拆装",2:"修复",3:"更换",4:"校正"};
var statusHash = {};
var statusList = {};
var allSpecialItemList = {};
$(document).ready(function(){

	/*$("body").on("mouseenter","path",function(e){
		$(this).attr({'stroke':'#D1F900','stroke-width':'4','stroke-linecap':"round"});
	});*/
	//初始化参数
	//获取当前页面中可喷漆的面
	var self = this;
	this.pathCount = $('#path-list-2').find('path').length;
	//绑定鼠标移动到元素上的事件
	$('path').mouseenter(function(){
		$(this).attr({'stroke':'#D1F900','stroke-width':'4','stroke-linecap':"round"});
	});
	$('path').mouseout(function(){
		$(this).attr('stroke','none');
	});
	$("body").on("mouseenter","path",function(e){
		$(this).attr({'stroke':'#D1F900','stroke-width':'4','stroke-linecap':"round"});
	});
	//绑定鼠标点击事件
	$('path').bind('click',function(){
		selectPath(this);
	});
	//刷新页面数据
	//self.refreshSpecialData();
	selectColor = ["","#879b08","#2f80af","","#2f80af"];//钣金、喷漆 对应的色值
	pathOpacity = 0.6;
	nowitemspecialflg = 2;//表示选中
	blankGrid = nui.get("blankGrid");
	blankGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        switch (e.field) {
          	 case "blankOptBtn":
          		s =  ' <a class="optbtn" href="javascript:deletItem(\'' + uid + '\')">删除</a>';
                e.cellHtml = s;
                 break;
          	 case "action":
          		 if (statusHash[e.value]) {
                     e.cellHtml = statusHash[e.value] || "";
                 } else {
                     e.cellHtml = "";
                 }
            default:
                break;
        }
    });
	//行选中时发生
	blankGrid.on("select",function(e){
		var row = e.record;
		var dictids= [row.nameId];
	    $.post(apiPath + sysApi + "/"+"com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictids="+dictids+"&token="+token,{},function(text){
		    if(text.data){
		    	var setStatusList = text.data;
		    	nui.get("setAction").setData(setStatusList);
		        /*statusList = [{id:1,name:"拆装"},{id:2,name:"修复"},{id:3,name:"更换"}];*/
		    	
		    }
	    });
	});
	
	/*//查找动作接口
	initDicts({
    	chanceType:REPAIR_ACTION//商机
    },function(data){
    	statusList = nui.get("chanceType").value();
    	//statusList = data;
    });*/
	//查找维修动作接口
	var dictids= ['10321'];
    $.post(apiPath + sysApi + "/"+"com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictids="+dictids+"&token="+token,{},function(text){
	    if(text.data){
	    	statusList = text.data;
	    	for(var i = 0;i<text.data.length;i++){
	    		var temp = text.data[i]
	    		statusHash[temp.customid] = temp.name;
	    	}
	    	
	    }
    });
    //查找车对应的部位名称
    var parentid= 10281;
    $.post(apiPath + sysApi + "/"+"com.hsapi.system.dict.dictMgr.queryDictTree.biz.ext?parentid="+parentid+"&token="+token,{},function(text){
	    if(text.data){
	    	allSpecialItemList = text.data;
	    }
    });
	
});

function setData(){
	$("#imgShow").attr("src",url);
}

var allSpecialItemList1 = [
   {
	"cpno": "001",
	"cpstr": "左前后视镜",
	"itemdiscountprice": 0,
	"itemid": 1,
	"itemname": "左前后视镜",
	"itemprice": 0
	},
	{
	"cpno": "002",
	"cpstr": "左前保险杠",
	"itemdiscountprice": 0,
	"itemid": 2,
	"itemname": "左前后视镜",
	"itemprice": 0
	},
	{
	"cpno": "003",
	"cpstr": "左前车门外拉手",
	"itemdiscountprice": 0,
	"itemid": 3,
	"itemname": "左前车门外拉手",
	"itemprice": 0
	},
	
	{
	"cpno": "004",
	"cpstr": "左前车门饰条",
	"itemdiscountprice": 0,
	"itemid": 4,
	"itemname": "左前车门饰条",
	"itemprice": 0
	},
	{
	"cpno": "005",
	"cpstr": "左前叶子板",
	"itemdiscountprice": 0,
	"itemid": 5,
	"itemname": "左前叶子板",
	"itemprice": 0
	},
	{
	"cpno": "006",
	"cpstr": "左前铝合金钢圈",
	"itemdiscountprice": 0,
	"itemid": 6,
	"itemname": "左前铝合金钢圈",
	"itemprice": 0
	},
	{
	"cpno": "007",
	"cpstr": "左A柱",
	"itemdiscountprice": 0,
	"itemid": 7,
	"itemname": "左A柱",
	"itemprice": 0
	},
	{
	"cpno": "008",
	"cpstr": "左前车门",
	"itemdiscountprice": 0,
	"itemid": 8,
	"itemname": "左前车门",
	"itemprice": 0
	},
	{
	"cpno": "009",
	"cpstr": "左B柱",
	"itemdiscountprice": 0,
	"itemid": 9,
	"itemname": "左B柱",
	"itemprice": 0
	},
	{
	"cpno": "010",
	"cpstr": "左后车门",
	"itemdiscountprice": 0,
	"itemid": 10,
	"itemname": "左后车门",
	"itemprice": 0
	},
	{
	"cpno": "011",
	"cpstr": "左下边梁",
	"itemdiscountprice": 0,
	"itemid": 11,
	"itemname": "左下边梁",
	"itemprice": 0
	},
	{
	"cpno": "012",
	"cpstr": "左C柱",
	"itemdiscountprice": 0,
	"itemid": 12,
	"itemname": "左C柱",
	"itemprice": 0
	},
	
	 {
		"cpno": "013",
		"cpstr": "左后叶子板",
		"itemdiscountprice": 0,
		"itemid": 13,
		"itemname": "左后叶子板",
		"itemprice": 0
		},
		{
		"cpno": "014",
		"cpstr": "左后铝合金钢圈",
		"itemdiscountprice": 0,
		"itemid": 14,
		"itemname": "左后铝合金钢圈",
		"itemprice": 0
		},
		{
		"cpno": "015",
		"cpstr": "左后车门饰条",
		"itemdiscountprice": 0,
		"itemid": 15,
		"itemname": "左后车门饰条",
		"itemprice": 0
		},
		
		{
		"cpno": "016",
		"cpstr": "左后车门外拉手",
		"itemdiscountprice": 0,
		"itemid": 16,
		"itemname": "左后车门外拉手",
		"itemprice": 0
		},
		{
		"cpno": "017",
		"cpstr": "左后保险杠",
		"itemdiscountprice": 0,
		"itemid": 17,
		"itemname": "左后保险杠",
		"itemprice": 0
		},
		{
		"cpno": "018",
		"cpstr": "右前后视镜",
		"itemdiscountprice": 0,
		"itemid": 18,
		"itemname": "右前后视镜",
		"itemprice": 0
		},
		{
		"cpno": "019",
		"cpstr": "右前保险杠",
		"itemdiscountprice": 0,
		"itemid": 19,
		"itemname": "右前保险杠",
		"itemprice": 0
		},
		{
		"cpno": "020",
		"cpstr": "右前车门外拉手",
		"itemdiscountprice": 0,
		"itemid": 20,
		"itemname": "右前车门外拉手",
		"itemprice": 0
		},
		{
		"cpno": "021",
		"cpstr": "右前车门饰条",
		"itemdiscountprice": 0,
		"itemid": 21,
		"itemname": "右前车门饰条",
		"itemprice": 0
		},
		{
		"cpno": "022",
		"cpstr": "右前叶子板",
		"itemdiscountprice": 0,
		"itemid": 22,
		"itemname": "右前叶子板",
		"itemprice": 0
		},
		{
		"cpno": "023",
		"cpstr": "右前铝合金钢圈",
		"itemdiscountprice": 0,
		"itemid": 23,
		"itemname": "右前铝合金钢圈",
		"itemprice": 0
		},
		{
		"cpno": "024",
		"cpstr": "右A柱",
		"itemdiscountprice": 0,
		"itemid": 24,
		"itemname": "右A柱",
		"itemprice": 0
		},
		{
			"cpno": "025",
			"cpstr": "右前车门",
			"itemdiscountprice": 0,
			"itemid": 25,
			"itemname": "右前车门",
			"itemprice": 0
			},
			{
			"cpno": "026",
			"cpstr": "右B柱",
			"itemdiscountprice": 0,
			"itemid": 26,
			"itemname": "右B柱",
			"itemprice": 0
			},
			{
			"cpno": "027",
			"cpstr": "右后车门",
			"itemdiscountprice": 0,
			"itemid": 27,
			"itemname": "右后车门",
			"itemprice": 0
			},
			{
			"cpno": "028",
			"cpstr": "右下边梁",
			"itemdiscountprice": 0,
			"itemid": 28,
			"itemname": "右下边梁",
			"itemprice": 0
			},
			{
			"cpno": "029",
			"cpstr": "右C柱",
			"itemdiscountprice": 0,
			"itemid": 29,
			"itemname": "右C柱",
			"itemprice": 0
			},
			{
			"cpno": "030",
			"cpstr": "右后叶子板",
			"itemdiscountprice": 0,
			"itemid": 30,
			"itemname": "右后叶子板",
			"itemprice": 0
			},
			{
			"cpno": "031",
			"cpstr": "右后铝合金钢圈",
			"itemdiscountprice": 0,
			"itemid": 31,
			"itemname": "右后铝合金钢圈",
			"itemprice": 0
			},
			{
			"cpno": "032",
			"cpstr": "右后车门饰条",
			"itemdiscountprice": 0,
			"itemid": 32,
			"itemname": "右后车门饰条",
			"itemprice": 0
			},
			{
			"cpno": "033",
			"cpstr": "右后车门外拉手",
			"itemdiscountprice": 0,
			"itemid": 33,
			"itemname": "右后车门外拉手",
			"itemprice": 0
			},
			{
			"cpno": "034",
			"cpstr": "右后保险杠",
			"itemdiscountprice": 0,
			"itemid": 34,
			"itemname": "右后保险杠",
			"itemprice": 0
			},
			{
			"cpno": "035",
			"cpstr": "前中网",
			"itemdiscountprice": 0,
			"itemid": 35,
			"itemname": "前中网",
			"itemprice": 0
			},
			{
			"cpno": "036",
			"cpstr": "机盖",
			"itemdiscountprice": 0,
			"itemid": 36,
			"itemname": "机盖",
			"itemprice": 0
			},
			{
			"cpno": "037",
			"cpstr": "车顶",
			"itemdiscountprice": 0,
			"itemid": 37,
			"itemname": "车顶",
			"itemprice": 0
			},
			{
			"cpno": "038",
			"cpstr": "行李箱舱盖",
			"itemdiscountprice": 0,
			"itemid": 38,
			"itemname": "行李箱舱盖",
			"itemprice": 0
					},
			{
				"cpno": "039",
				"cpstr": "下部行李箱舱盖",
				"itemdiscountprice": 0,
				"itemid": 39,
				"itemname": "下部行李箱舱盖",
				"itemprice": 0
						}
   ];
function selectPath(path){
	//选中操作
	var self = this;
	this.lastSelectPath = path;
	
	if(this.nowitemspecialflg == $(path).attr('data-itemspecialflg') && $(path).attr('data-itemspecialflg') != "0"){
		//已经选中，并且与当前选择模式相同（小钣金、大钣金），则取消选中
		$(path).attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
		self.removeSpecialForView(path);
	}else{
		//选中、并设置为当前选中模式
		$(path).attr({'fill':self.selectColor[self.nowitemspecialflg],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':self.nowitemspecialflg});
		addSpecialForView($(path).attr('data-cpno'));
	}
}

//删除钣金喷漆项目，点击图形删除
function removeSpecialForView(path){
	var deletRow = null; 
	var row = blankGrid.findRow(function(row){
		if(row.code == $(path).attr('data-cpno')){
			deletRow = row;
		}
		
    });
	blankGrid.removeRow(deletRow);
	/*if($(obj).attr('data-wispecialitemflg') == 2){
		//钣金
		$('.special-item-list1').each(function(){
			if(this.dataset.cpno == $(obj).attr('data-cpno')){
				$(this).remove();
			}
		});
	}else{
		//喷漆
		$('.special-item-list2').each(function(){
			if(this.dataset.cpno == $(obj).attr('data-cpno')){
				$(this).remove();
			}
		});
	}*/
	//计算钣金、喷漆总价
	//this.funcCostCal();
}

//添加项目
function addSpecialForView(cpno){
	var data = getSpecialDataByParam(cpno);
	var addItem = {};
	addItem.itemName = data.name;
	addItem.code = data.customid;
	addItem.nameId = data.id;
	addItem.isPaint = 1;
	addItem.discountAmt = 0;
	addItem.amt = 0;
	//addItem.action = null;
	/*var data = {};
	data.itemname = addItem.itemname*/
	blankGrid.addRow(addItem);
	/*var row = blankGrid.findRow(function(row){
		blankGrid.beginEditRow(row);
    });*/
}


//获取对应面的数据
function getSpecialDataByParam(cpno){
	for(var i = 0 ; i < this.allSpecialItemList.length ; i ++){
		if(cpno == this.allSpecialItemList[i].customid){
			return this.allSpecialItemList[i];
		}
	}
}

//列表数据删除
function deletItem(row_uid){
	 var row = blankGrid.getRowByUID(row_uid);
	$('#path-list-1').find('path').each(function(){
		if($(this).attr('data-cpno') == row.code){
			$(this).attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
			/*if(wilifewealthflg){
				//如果是国寿财项目，删除时要扣除对应的优惠金额
				self.mindiscount1 = floatCal(self.mindiscount1,parseFloat(self.getSpecialDataByParam(obj.parentNode.parentNode.dataset.cpno,obj.parentNode.parentNode.dataset.itemspecialflg,"wirealgscdiscount")),"-",2);
			}*/
			blankGrid.removeRow(row);
		}
	});
}

/*循环遍历已有项目
 * $('#path-list-1').find('path').each(function(){
	if($(this).attr('data-cpno') == d[i].cpno && (d[i].riitemspecialflag == 1 || d[i].riitemspecialflag == 2)){
		self.mindiscount1 = floatCal(self.mindiscount1,parseFloat(d[i].wirealgscdiscount),"+",2);
		self.addSpecialForView(d[i].itemname,d[i].cpno,d[i].riitemspecialflag,2,d[i].itemprice,d[i].itemdiscountprice,1,d[i].wiid);
		$(this).attr({'fill':self.selectColor[d[i].riitemspecialflag],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg': d[i].riitemspecialflag,'data-itemid':d[i].itemid,'data-wispecialitemflg':'2'});
	}
});
*/

function saveItem(){
	//获取所有行
	
	
}




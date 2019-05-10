var url = webPath + contextPath + "/repair/imag/select-path-back.png";
var selectColor = [];
var pathOpacity = null;
var nowitemspecialflg = null;
var blankGrid = null;
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
	nowitemspecialflg = 2;
	blankGrid = nui.get("blankGrid");
	blankGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        switch (e.field) {
          	 case "blankOptBtn":
          		s =  ' <a class="optbtn" href="javascript:deletePackRow(\'' + uid + '\')">删除</a>';
                e.cellHtml = s;
                 break;
            default:
                break;
        }
    });
});

function setData(){
	$("#imgShow").attr("src",url);
}

var allSpecialItemList= [
   {"cpcolor": "#cc2db200",
	"cpno": 350,
	"cpstr": "钣金（左前门饰条）",
	"itemdiscountprice": 0,
	"itemid": 771,
	"itemname": "钣金（左前门饰条）",
	"itemprice": 0,
	"riitembasecost": 0,
	"riitembasecosttype": 0,
	"riitempricetype": 0,
	"riitemspecialflag": 2,
	"riwhprice1": 0,
	"riworkhour1": 0,
	"riworkinnerhour": 0,
	"sampleitem": 0,
	"wiid": 0,
	"wilifewealthflg": 0,
	"wilifewealthprice": 0,
	"wilifewealthtypeflg": 0,
	"wipriceeditable": 0,
	"wirealgscdiscount": 0,
	"withoutwork": 0}]
function selectPath(path){
	//选中操作
	var self = this;
	this.lastSelectPath = path;
	if(path.parentNode.parentNode.dataset.pathtype == "1"){
		//钣金
		if(this.nowitemspecialflg == $(path).attr('data-itemspecialflg') && $(path).attr('data-itemspecialflg') != "0"){
			//已经选中，并且与当前选择模式相同（小钣金、大钣金），则取消选中
			$(path).attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
			self.removeSpecialForView(path);
		}else{
			//选中、并设置为当前选中模式
			$(path).attr({'fill':self.selectColor[self.nowitemspecialflg],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':self.nowitemspecialflg});
			//self.addSpecialForView($(path).attr('data-name'),$(path).attr('data-cpno'),self.nowitemspecialflg,2,self.getSpecialDataByParam($(path).attr('data-cpno'),$(path).attr('data-itemspecialflg'),"itemprice"),self.getSpecialDataByParam($(path).attr('data-cpno'),$(path).attr('data-itemspecialflg'),'itemdiscountprice'),2,self.getSpecialDataByParam($(path).attr('data-cpno'),$(path).attr('data-itemspecialflg'),'wiid'));//添加钣金
			addSpecialForView($(path).attr('data-cpno'));
			/*if(!$('#all-special-btn').hasClass('selected')){
				$('#path-list-2').find('path').each(function(){
					if($(this).attr('data-code') == $(path).attr('data-code')){
						$(this).attr({'class':'selectPath','fill':self.selectColor[4],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':'4'});
						self.addSpecialForView($(this).attr('data-name'),$(this).attr('data-cpno'),$(this).attr('data-itemspecialflg'),$(this).attr('data-wispecialitemflg'),self.getSpecialDataByParam($(this).attr('data-cpno'),$(this).attr('data-itemspecialflg'),'itemprice'),self.getSpecialDataByParam($(this).attr('data-cpno'),$(this).attr('data-itemspecialflg'),'itemdiscountprice'),2,self.getSpecialDataByParam($(this).attr('data-cpno'),$(this).attr('data-itemspecialflg'),'wiid'));
						self.checkSpecialGroup();
					}
				});
			}*/
		}
	}else{
		//喷漆
		/*if($(path).attr('data-itemspecialflg') == "4"){
			//取消选中
			$(path).attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
			self.removeSpecialForView(path);
		}else{
			//选中
			$(path).attr({'fill':self.selectColor[4],'stroke':'none','fill-opacity':self.pathOpacity,'data-itemspecialflg':'4'});
			self.addSpecialForView($(path).attr('data-name'),$(path).attr('data-cpno'),$(path).attr('data-itemspecialflg'),$(path).attr('data-wispecialitemflg'),self.getSpecialDataByParam($(path).attr('data-cpno'),$(path).attr('data-itemspecialflg'),'itemprice'),self.getSpecialDataByParam($(path).attr('data-cpno'),$(path).attr('data-itemspecialflg'),'itemdiscountprice'),2,self.getSpecialDataByParam($(path).attr('data-cpno'),$(path).attr('data-itemspecialflg'),'wiid'));
		}
		self.checkSpecialGroup();
	}*/
	//self.addSpecialForPath(path,$(path).attr('data-itemprice'),$(path).attr('data-itemdiscountprice'));//添加钣金、喷漆项目至列表
		$(path).attr({'fill':'#ffffff','stroke':'none','fill-opacity':'0','data-itemspecialflg':'0'});
		self.removeSpecialForView(path);
	}
}

//删除钣金喷漆项目，点击图形删除
function removeSpecialForView(path){
	var row = blankGrid.findRow(function(row){
		if(row.code = $(path).attr('data-cpno')){
			blankGrid.removeRow(row);
		}
		
    });
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
	var addItem = getSpecialDataByParam(cpno);
	addItem.code = addItem.cpno;
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
		if(cpno == this.allSpecialItemList[i].cpno){
			return this.allSpecialItemList[i];
		}
	}
}



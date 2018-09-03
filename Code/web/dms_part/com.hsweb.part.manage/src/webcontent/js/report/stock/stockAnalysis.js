var baseUrl = apiPath + partApi + "/";

$(document).ready(function(v)
{
	
    showMainQty();

    showMainAmt();

});

//  仓库；实时库存，出库，入库
function showMainQty() {
	//省份
	var rot = 0;
	var storeArr,stockQty,outQty,inQty;
	var dataurl = baseUrl + "com.hsapi.part.query.stock.queryExandStockQtyWithStore.biz.ext";
	nui.ajax({               
		url : dataurl,
		type: 'post',
        async: false, //同步执行，返回成功后才能进行下面的操作
        data : nui.encode({token:token}),
        success:function(text){
        	if(text.errCode == 'S') {
        		storeArr = text.storeArr;
        		stockQty = text.stockQty;
        		outQty = text.outQty;
        		inQty = text.inQty;

        		/*if(tdata == "02"){
        			if(areaArr.length > 15){
        				rot = -30;
        			}
        		}*/
        	}

        },
        error : function(jqXHR, textStatus, errorThrown) {
        	console.log(jqXHR.responseText);
        }
    });
  

	var itemStyle = {
		normal: {
			color: [
			'#ff7f50','#87cefa','#da70d6'
			]
		}
	}

	var soption = {
		title: {
			text: '库存数量-' + parseInt(stockQty||0),
			subtext: '',
			x: 'left'
		},
		color: ['#3398DB', '#ff7f50','#da70d6'],
		tooltip: {
			trigger: 'axis',
	        axisPointer: {            // 坐标轴指示器，坐标轴触发有效
	            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        }
	    },
	    toolbox: {  
	    	show: false,
	        feature: {  
	        	mark : {show: true},  
	        	dataView : {show: true, readOnly: false}, 
	            myTool1: {  
	                show: true,  
	                title: '刷新',  
	                icon: 'fa-refresh',  
	                onclick: function (){  
	                    showMainQty(); 
	                }  
	            },  
            	saveAsImage : {show: true}
	        }  
	    },

	    legend: {
	    	data: ['库存数量','出库数量','入库数量']
	    },

	    grid: {
    		left: '10%',
	    	right: '4%',
	    /*		bottom: '3%',
	    	containLabel: true,*/
	    	y2:60
	    },
	    xAxis: [
	    {
	    	type: 'category',
	    	axisLabel:{
	    		interval:0,//横轴信息全部显示
	    		rotate:rot,//-30度角倾斜显示 (省份)
	    	},
	    	data: storeArr,
	    	axisTick: {
	    		alignWithLabel: true
	    	}
	    }
	    ],
	    yAxis: [
	    {
	    	type: 'value'
	    }
	    ],
	    series: [
	    {
	    	name: '库存数量',
	    	type: 'bar',
	    	data: stockQty
	    },
	    {
	    	name: '出库数量',
	    	type: 'bar',
	    	barGap: 0,
	    	data: outQty
	    },
	    {
	    	name: '入库数量',
	    	type: 'bar',
	    	barGap: 0,
	    	data: inQty
	    }
	    ]
	};

	var myChart = echarts.init(document.getElementById('mainQty'));

	//使用刚指定的配置项和数据显示图表。
	myChart.setOption(soption);
}

function showMainAmt() {
	//省份
	var rot = 0;
	var storeArr,stockAmt,outAmt,inAmt;
	var dataurl = baseUrl + "com.hsapi.part.report.stock.queryExandStockAmtWithStore.biz.ext";
	nui.ajax({
		url : dataurl,
		type: 'post',
        async: false, //同步执行，返回成功后才能进行下面的操作
        data : nui.encode({token:token}),
        success:function(text){
        	if(text.errCode == 'S') {
        		storeArr = text.storeArr;
        		stockAmt = text.stockAmt;
        		outAmt = text.outAmt;
        		inAmt = text.inAmt;

        		/*if(tdata == "02"){
        			if(areaArr.length > 15){
        				rot = -30;
        			}
        		}*/
        	}

        },
        error : function(jqXHR, textStatus, errorThrown) {
        	console.log(jqXHR.responseText);
        }
    });
  

	var itemStyle = {
		normal: {
			color: [
			'#ff7f50','#87cefa','#da70d6'
			]
		}
	}

	var soption = {
		title: {
			text: '库存金额-' + parseInt(stockAmt||0),
			subtext: '',
			x: 'left'
		},
		color: ['#3398DB', '#ff7f50','#da70d6'],
		tooltip: {
			trigger: 'axis',
	        axisPointer: {            // 坐标轴指示器，坐标轴触发有效
	            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        }
	    },

	    legend: {
	    	data: ['库存金额','出库金额','入库金额']
	    },

	    grid: {
    		left: '10%',
	    	right: '4%',
	    /*		bottom: '3%',
	    	containLabel: true,*/
	    	y2:60
	    },
	    xAxis: [
	    {
	    	type: 'category',
	    	axisLabel:{
	    		interval:0,//横轴信息全部显示
	    		rotate:rot,//-30度角倾斜显示 (省份)
	    	},
	    	data: storeArr,
	    	axisTick: {
	    		alignWithLabel: true
	    	}
	    }
	    ],
	    yAxis: [
	    {
	    	type: 'value'
	    }
	    ],
	    series: [
	    {
	    	name: '库存金额',
	    	type: 'bar',
	    	data: stockAmt
	    },
	    {
	    	name: '出库金额',
	    	type: 'bar',
	    	barGap: 0,
	    	data: outAmt
	    },
	    {
	    	name: '入库金额',
	    	type: 'bar',
	    	barGap: 0,
	    	data: inAmt
	    }
	    ]
	};

	var myChart = echarts.init(document.getElementById('mainAmt'));

	//使用刚指定的配置项和数据显示图表。
	myChart.setOption(soption);
}
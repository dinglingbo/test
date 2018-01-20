    function switchChartTable(isLeft) {
       var table_area = document.getElementById("left_area");
       var chart_area = document.getElementById("right_area");
       var leftBtn = document.getElementById("leftBtn");
       var rightBtn = document.getElementById("rightBtn");
       
       if(isLeft) { // toLeft
          if(table_area.style.display != 'none' && chart_area.style.display != 'none') {
             table_area.style.display = 'none';
             leftBtn.style.display = 'none';
             chart_area.style.width = "100%";
          } else if(chart_area.style.display == 'none') {
             chart_area.style.display = '';
             rightBtn.style.display = '';
             chart_area.style.width = "50%";
             table_area.style.width = "50%";
          }
       } else { // toRight
          if(table_area.style.display != 'none' && chart_area.style.display != 'none') {
             chart_area.style.display = 'none';
             rightBtn.style.display = 'none';
             table_area.style.width = "100%";
          } else if(table_area.style.display == 'none') {
             table_area.style.display = '';
             leftBtn.style.display = '';
             chart_area.style.width = "50%";
             table_area.style.width = "50%";
          }
       }
    }

	function doQuery(fa,param){
		parent.queryResult({
			fa:fa||'query',
			param:param
		});
		return false;
	}
	
	function initiFrame(){
		
		document.body.style.height="100%";
		document.body.style.overflow='hidden';
		
		var tabs=document.getElementsByTagName('table');
		for(var i=0,len=tabs.length;i<len;i++){
			var t=tabs[i];
			
			if(t.className=='workarea'){
				t.style.height='100%'
			}
		}
		/*
		var height=frameElement.parentNode.offsetHeight;
		frameElement.height=height;
		frameElement.style.height=height+"px";
		*/
		parent.addPath({});
		parent.createPath(document);
		parent.hideLoading();
		
		initChart();
	}
	function ofc_ready() {
		//alert('ofc_ready');
	}

	function open_flash_chart_data() {
		//alert( 'reading data' );
		return JSON.stringify(default_data);
	}
	
	function goTo(el){
		parent.goTo(el);
		history.go(-1);
		return false;
	}
	
	function initChart(conf){
		conf=conf||{
			renderTo:'chart',
			param:{}
		};
		
		var rd=conf.renderTo||'chart';
		
		var pn=document.getElementById(rd).parentNode;
		pn.style.verticalAlign='top';
		
		var h = pn.clientHeight;
		var exploerType = getExplorerType();
		if(exploerType == 'Firefox') {
		   h = h - 80;
		} else if(exploerType == "IE") {
		   h = h - 40;
		} 
		conf.height=h;
		conf.width='100%';
		
		swfobject.embedSWF(ctxPath+"/workflow/statistics/ofc/open-flash-chart.swf",conf.renderTo,conf.width, conf.height, "9.0.0","",conf.param,{wmode :"opaque"});
 
	}
	
	function getExplorerType() {
       if(navigator.userAgent.toLowerCase().indexOf("msie")>=0) { 
         return "IE"; 
       } else if(navigator.userAgent.toLowerCase().indexOf("firefox")>=0){ 
         return "Firefox"; 
      }
      return "others";
	}
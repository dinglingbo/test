nui.ajax = function (options) {
		var url=options.url;
		if(url){
		    if (!options.dataType) {
		        options.dataType = "json";
		
		    }
		    if (!options.contentType) {
		        options.contentType = "application/json; charset=UTF-8";
		    }
		
		    if (options.data && mini.isNull(options.data.pageIndex) == false) {
		        var page = options.data.page = {};
		        
		        page.begin = options.data.pageIndex*options.data.pageSize;
		        page.length = options.data.pageSize;
		    }		    
		
		    if (options.dataType == "json"&&typeof(options.data)=='object') {
		        options.data = mini.encode(options.data);
		        if(options.data=='{}'){
		        	delete options.data;
		        }
		    	options.type='POST';
		    }
		}	
	    return window.jQuery.ajax(options);
};
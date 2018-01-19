nui.bps = nui.bps || {};
nui.bps.BPSPager = function () {
    nui.bps.BPSPager.superclass.constructor.apply(this, arguments);
}
nui.extend(nui.bps.BPSPager, nui.Control, {
    uiCls : "nui-bpspager",
    datagridId : "",    
    setDatagridId : function (datagridId) {
       this.datagrid = nui.get(datagridId);
       this.datagridId = datagridId;
    },
    getDatagridId : function () {
       return this.datagridId;
    },
    index : "",
    setIndex : function (index) {
       this.index = index;
    },
    getIndex : function () {
       return this.index;
    },
    first : "← First",
    setFirst : function (first) {
       this.first = first;
    },
    getFirst : function () {
       return this.first;
    },
    last : "Last →",
    setLast : function (last) {
       this.last = last;
    },
    getLast : function () {
       return this.last;
    },
    previous : "← Previous",
    setPrevious : function (previous) {
       this.previous = previous;
    },
    getPrevious : function () {
       return this.previous;
    },
    next : "Next →",
    setNext : function (next) {
       this.next = next;
    },
    getNext : function () {
       return this.next;
    },
    pageInfoText:"Showing {start} to {end} of {total} entries",
    setPageInfoText : function (pageInfoText) {
       this.pageInfoText = pageInfoText;
    },
    getPageInfoText : function () {
       return this.pageInfoText;
    },
    noRecordPageInfoText:"No entries",
    setNoRecordPageInfoText : function (noRecordPageInfoText) {
       this.noRecordPageInfoText = noRecordPageInfoText;
    },
    getNoRecordPageInfoText : function () {
       return this.noRecordPageInfoText;
    },
    pageNum : "",
    setPageNum : function (pageNum) {
       this.pageNum = pageNum;
    },
    getPageNum : function () {
       return this.pageNum;
    },
    datagridParams : {},
    setDatagridParams : function (datagridParams) {
       this.datagridParams = nui.decode(datagridParams);
    },
    getDatagridParams : function () {
       return this.datagridParams;
    },
    _create: function () {
        var _this = this;
        this.el = document.createElement("div");
        this.el.innerHTML = '<div class="pagerText"></div>'
                          + '<div class="pagerControl"></div>';
        var pagerText = this.el.childNodes[0];
        var pagerControl = this.el.childNodes[1];
        setTimeout(function () {
            $(pagerControl).bind ("click",function (e) {
                e = e || window.event;
                var classList = e.target.classList || e.target.className.split(" ");
                for (prop in classList) {
                    if (classList[prop] == "btnDisable") {
                        return;
                    };
                };
                if (e.target.innerHTML == _this.last) {
                    _this.datagridParams.pageIndex = _this.pageNum - 1;
                    _this.datagrid.load(_this.datagridParams);
                }else if (e.target.innerHTML == _this.next) {
                    _this.datagridParams.pageIndex = _this.index + 1;
                    _this.datagrid.load(_this.datagridParams);
                }else if(e.target.innerHTML == _this.previous){
                    _this.datagridParams.pageIndex = _this.index - 1;
                    _this.datagrid.load(_this.datagridParams);
                }else if(e.target.innerHTML == _this.first){
                    _this.datagridParams.pageIndex = 0;
                    _this.datagrid.load(_this.datagridParams);
                }else if(!isNaN(e.target.innerHTML)){
                	var classList = e.target.classList ||  e.target.className.split(" ");
                    for (prop in classList) {
                        if (classList[prop] == "currentPage") {
                            return;
                        };
                    };
                    _this.datagridParams.pageIndex = e.target.innerHTML - 1;
                    _this.datagrid.load(_this.datagridParams);
                }
            });
            _this.datagrid.on("preload",function(e){
            _this.index = e.pageIndex;
            var total = e.total;
            var pageSize = e.pageSize;
            var start = _this.index  * pageSize + 1;
            var end = (_this.index + 1) * pageSize;
            end = end > total ? total : end;
            if (total > 0) {
                var tmp = _this.pageInfoText;
                tmp = tmp.replace('{start}',start);
                tmp = tmp.replace('{end}',end);
                tmp = tmp.replace('{total}',total);
                pagerText.innerHTML = tmp;
            }else{
                pagerText.innerHTML = _this.noRecordPageInfoText;
            }

            pagerControl.innerHTML = _this._renderPagerControl(_this.index + 1, pageSize, total);
        }) 
        },1)
        
    },
    _renderPagerControl : function(index, pageSize, total){
        this.pageNum = Math.floor(total / pageSize) + (total / pageSize ==  Math.floor(total / pageSize) ? 0 : 1);
        var ifLastEnable = this.pageNum > index ? "btnEnable" : "btnDisable";
        var tmp = '<div class="button ctrl ' + ifLastEnable + '">' + this.last + '</div>' 
                + '<div class="button ctrl ' + ifLastEnable + '">' + this.next + '</div>';
        for (var i = Math.min(this.pageNum,index + 2); i > index - 3 && i > 0; i--) {
            if (i == index) {
                tmp += '<div class="button number currentPage">' + i + '</div>';
            }else{
                tmp += '<div class="button number">' + i + '</div>';
            }
        };
        var ifFirstEnable =  index > 1 ? "btnEnable" : "btnDisable";    
        tmp += ('<div class="button ctrl ' + ifFirstEnable + '">' + this.previous + '</div>'
            +  '<div class="button ctrl ' +  ifFirstEnable + '">' + this.first + '</div>');
        return tmp;
    },
    getAttrs: function (el) {
        var attrs = nui.bps.ShowProcStartForm.superclass.getAttrs.call(this, el);
        var jq = jQuery(el);

        nui._ParseString(el, attrs,
            ["datagridId", "index", "datagridParams", "first", "next", "last", "previous","pageInfoText","noRecordPageInfoText"]
        );
        return attrs;
    }
});
nui.regClass(nui.bps.BPSPager, "bpspager");
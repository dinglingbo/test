var HeaderFilter = function (grid, options) {
    var me = this;
    me.grid = grid;
    me.options = options || {};
    me.init();
}
var xyme = null;
var xycolumn = null;
HeaderFilter.prototype = {

    init: function () {
        var me = this,
            grid = me.grid,
            columns = me.options.columns;

        me.filterColumns = [];

        for (var i = 0, l = columns.length; i < l; i++) {
            var o = columns[i];
            var column = grid.getColumn(o.name);
            if (!column) throw new Error('undefined column ' + o.name);
            o.column = column;
            column.header = column.header + '<div class="icon-filter headerfilter-trigger"></div>';

            me.filterColumns.push(column);
        }

        $(grid.el).on("click", ".headerfilter-trigger", function (e) {
            e.stopPropagation();

            var column = grid.getColumnByEvent(e);
            me.showFilterWindow(column);
        });

        grid.on("load", function (e) {
            //me.clearFilterAll();
        })
        grid.on("resize", function (e) {

        });

        grid.on("update", function (e) {
            me._updateFilterStatus();
        });

/*        $(document).on("mousedown", function (event) {
            if (!$(event.target).closest(".filterwindow")[0]) {
                $(".filterwindow").hide();
            }
        });*/

        ///////////////////////////////////////////////////////////////

        var within = grid.within;
        grid.within = function (e) {
            
            var result = within.call(this, e);
            if (!result && me.filterWindow) {
                result = mini.isAncestor(me.filterWindow[0], e.target);
            }

            return result;
        }
    },

    _createFilterListData: function (column) {

        var data = this.grid.getData(),     //getDataView
            sb = [],
            map = {},
            result = [];

        var blank = {};
        blank[column.displayField || column.field] = '全部';     //暂不知道具体逻辑
        result.push(blank);

        for (var i = 0, l = data.length; i < l; i++) {
            var record = data[i];
            var text = record[column.field] || '';
            if (column.displayField) {
                text = record[column.displayField] || '';
            } else {

            }
            if (!map[text]) {
                map[text] = text;
                result.push(record);
            }
        }

        return result;
    },
    

    _getFilterValues: function (column) {
        var win = this.filterWindow;
        var values = [];
        win.find("input:checked").not(".checkall").each(function () {
            values.push(this.value);
        });

        return values;
    },

    doFilter: function () {
        var me = this,
            columns = me.filterColumns;

        if (me.hasFiltered()) {

            me.grid.filter(function (record) {
                var pass = true;
                for (var i = 0, l = columns.length; i < l; i++) {
                    var column = columns[i];
                    if (column.filterData) {
                        var text = column.displayField ? record[column.displayField] : record[column.field];
                        if (text == null) text = "";
                        text = String(text);
                        if (!column._filterMap[text]) {
                            pass = false;
                            break;
                        }
                    }
                }
                return pass;
            });
        } else {
           me.grid.clearFilter();
        }

        me._updateFilterStatus();
        //alert("doFilter");
    },
    _updateFilterStatus: function () {
        var me = this,
            grid = me.grid,
            columns = me.filterColumns;

        for (var i = 0, l = columns.length; i < l; i++) {
            var column = columns[i];
            var headerCellEl = $(me._getHeaderCellEl(column));

            if (me.isFiltered(column)) headerCellEl.addClass("headerfilter-filtered");
            else headerCellEl.removeClass("headerfilter-filtered");
        }
    },
    _getHeaderCellEl: function (column) {
        var me = this,
            grid = me.grid;
        var columns = grid.getBottomColumns();
        var end = grid.getFrozenEndColumn();
        var columnIndex = columns.indexOf(column);
        var index = 1;
        if (columnIndex > end) {
            index = 2;
        }
        return grid.getHeaderCellEl(column, index);
    },
    showFilterWindow: function (column) {
        var me = this,
            grid = me.grid;



        headerCellEl = this._getHeaderCellEl(column)

        me.hideFilterWindow();

        me.filterColumn = column;
        me.filterWindow = me._createFilterWindow(column);

        var box = mini.getBox(headerCellEl),
            triggerEl = $(headerCellEl).find(".headerfilter-trigger")[0],
            triggerBox = mini.getBox(triggerEl);

        me.filterWindow.show();
        mini.setXY(me.filterWindow, triggerBox.left, box.bottom);
    },

    hideFilterWindow: function () {
        this.filterColumn = null;
        if (this.filterWindow) {
            this.filterWindow.remove();
            this.filterWindow = null;
        }
    },

    isFiltered: function (name) {
        var column = this.grid.getColumn(name);
        if (column) return !!column.filterData;
        return false;
    },

    hasFiltered: function () {
        var me = this,
            columns = me.filterColumns;
        for (var i = 0, l = columns.length; i < l; i++) {
            var column = columns[i];
            if (me.isFiltered(column)) return true;
        }
        return false;
    },

    filter: function (column, values) {
        var me = this;

        column.filterData = values;
        column._filterMap = {};
        for (var i = 0, l = values.length; i < l; i++) {
            var value = values[i];
            column._filterMap[value] = true;
        }

        me.doFilter();
        me.hideFilterWindow();
        if (me.options.callback) me.options.callback(column, true);
    },

    clearFilter: function (column) {
        var me = this;
        column.filterData = null;
        column._filterMap = null;
        me.doFilter();
        me.hideFilterWindow();

        if (me.options.callback) me.options.callback(column, false);
    },

    clearAllFilterData: function () {
        var me = this;

        var columns = me.filterColumns;
        for (var i = 0, l = columns.length; i < l; i++) {
            var column = columns[i];
            column.filterData = null;
            column._filterMap = null;
        }
    },

    clearAllFilter: function () {
        var me = this;

        me._updateFilterStatus();
        me.clearAllFilterData();
        me.grid.clearFilter();
        me.hideFilterWindow();
    },
    _createFilterWindow: function (column) {
        xyme = this;
        xycolumn = column;
       var el = $('<div class="filterwindow mini-popup"><div class="filterwindow-content"></div><div class="filterwindow-footer"><button class="filterwindow-button filter mini-button" noparser onclick="ok()">确定</button><button class="filterwindow-button clearfilter mini-button" noparser onclick="cancel()">取消</button></div></div>').appendTo('body');

       var data = this._createFilterListData(column),
           sb = [];
       var arr = [];
       for (var i = 0, l = data.length; i < l; i++) {
           var record = data[i];
           var text = record[column.field];
           if (column.displayField) text = record[column.displayField];
           if (text == null) text = '';
           
           var checked = false;
           if (column._filterMap) checked = !!column._filterMap[text];
           arr[arr.length] = text;
           var me = this;
           showcheckBox(column,text,sb,data,me);
       }
       
       el.find('.filterwindow-content').html(sb.join(''));

       return el;
   }
};



function ok(){
    var values = xyme._getFilterValues(xycolumn);
    if (values.length) {
        xyme.filter(xycolumn, values);
    } else {
        xyme.clearFilter(xycolumn);
    }
}

function cancel(){
	xyme.clearFilter(xycolumn);
}

function showcheckBox(column,text,sb,data,me){
	var value = null;
	var index = 0;
	if(me.options.tranCallBack) {
		value = me.options.tranCallBack(column.field);
	}
	if(!sb.length){
		sb[sb.length] = '<div class="filterwindow-item"><label><input class="filterwindow-item-checkbox checkall" type="checkbox"  value="全部"/>全部</label></div>';
		index ++;
	}
	if(value){
		for(var j = 0 ,  l = value.length ; j < l ; j ++){//判断是否已经存了相同数据到数组上
			if(value[j] != undefined){
				if(value[j].id == text){
					var str = '<div class="filterwindow-item"><label><input name="check" type="checkbox" value="'+text+'" />'+value[j].name+'</label></label></div>';
					var boo = contains(sb, str);
					if(!boo){
						sb[sb.length] = str;
						break;
					}
				}
			}
		}
	}
	if(!value && !index){//不需要特殊显示处理（value == text）
		var str = '<div class="filterwindow-item"><label><input name="check" type="checkbox" value="'+text+'" />'+text+'</label></label></div>';
		var boo = contains(sb, str);
		if(!boo){
			sb[sb.length] = str;
		}
	}
}

function contains(arr, obj) {//判断数组是否包含元素
    var i = arr.length;
    while (i--) {
        if (arr[i] == obj) {
            return true;
        }
    }
    return false;
}

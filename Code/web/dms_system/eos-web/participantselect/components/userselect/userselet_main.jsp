<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/coframe/tools/skins/common.jsp" %>

<html>

<head>
<title>参与者选择</title>
</head>
<body>
 
<div class="mini-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">                
	<% 
	String firstKey = "";
	if("true".equals(request.getParameter("recentSelect"))){ if(firstKey.equals("")) firstKey= "recent" ;  %>
	<a id="recent" class="mini-button" checkOnClick="true" groupName="select" iconCls="icon-function-group-open" plain="true" onclick="switchTab('recent')">最新访问</a>
	<% } %>
	<% if("true".equals(request.getParameter("deptSelect"))){ if(firstKey.equals("")) firstKey= "dept" ;%>
	<a id="dept" class="mini-button" checkOnClick="true" groupName="select" iconCls="icon-organization" plain="true" onclick="switchTab('dept')">机构</a>     
	  <% } %>          
	   <% if("true".equals(request.getParameter("roleSelect"))){ if(firstKey.equals("")) firstKey= "role" ;%>
	<a id="role" class="mini-button" checkOnClick="true" groupName="select" iconCls="icon-role" plain="true" onclick="switchTab('role')">角色</a>  
	 <% } %>
	 <% if("true".equals(request.getParameter("groupSelect"))){ if(firstKey.equals("")) firstKey= "group" ;%>    
	<a id="group" class="mini-button" checkOnClick="true" groupName="select" iconCls="icon-group" plain="true" onclick="switchTab('group')">工作组</a>  
	 <% } %>
	 <% if("true".equals(request.getParameter("onlineSelect"))){ if(firstKey.equals("")) firstKey= "online" ;%>
	<a id="online" class="mini-button" checkOnClick="true" groupName="select" iconCls="icon-duty-manager" plain="true" onclick="switchTab('online')">在线用户</a>     
	 <% } %> 
	 <% if("true".equals(request.getParameter("searchSelect"))){ if(firstKey.equals("")) firstKey= "search" ;%>
	<a id="search" class="mini-button" checkOnClick="true" groupName="select" iconCls="icon-search" plain="true" onclick="switchTab('search')">查询</a>     
	 <% } %> 
</div>
 
<div class="nui-fit">
	<!-- 在线用户 -->
	<div class="mini-splitter" style="width:100%;height:100%;">
		<div size="30%" showCollapseButton="true">
			<div id="recentsearch" class="mini-toolbar"
				style="text-align:center;line-height:30px;height:100%;display:none"
				borderStyle="border:0;">
				<label>名称：</label>
				<input id="username" class="mini-textbox"
					style="width:150px;" onenter="onKeyEnter" />
				</br>
				<a class="mini-button" style="width:110px;" iconCls="icon-search" 
					onclick="recentSearch()">
					最近访问查询
				</a>
			</div>

			<div id="rolesearch" class="nui-listbox"
				style="text-align:center;line-height:30px;height:100%;width:100%;display:none"
				textField="roleName" dataField="data" valueField="roleId"
				onvaluechanged="onRoleValueChanged" url=""
				borderStyle="border:0;">

			</div>

			<div id="deptsearch" class="mini-fit"
				style="height:100%;display:none" borderStyle="border:0;">
				<ul id="depttree" class="nui-tree" url=""
					style="width:100%;height:100%;" showTreeIcon="true"
					textField="name" idField="id" parentField="parentId"
					resultAsTree="false" onbeforeload="onBeforeTreeLoad"
					showExpandButtons="true" expandOnLoad="false">
				</ul>
			</div>
			<div id="groupsearch" class="mini-fit"
				style="height:100%;display:none" borderStyle="border:0;">
				<ul id="grouptree" class="nui-tree" url=""
					style="width:100%;height:100%;" showTreeIcon="true"
					textField="name" idField="id" parentField="parentId"
					resultAsTree="false" onbeforeload="onBeforeGroupTreeLoad"
					showExpandButtons="true" expandOnLoad="false">
				</ul>
			</div>
			<div id="onlinesearch" class="mini-toolbar"
				style="text-align:center;line-height:30px;height:100%;display:none"
				borderStyle="border:0;">
				<label>名称：</label>
				<input id="onlineusername" class="mini-textbox"
					style="width:150px;" onenter="onKeyEnter" />
				</br>
				<a class="mini-button" style="width:90px;" iconCls="icon-search"  
					onclick="onlineSearch()">
					在线用户查询
				</a>
			</div>
			<div id="searchsearch" class="mini-toolbar"
				style="text-align:center;line-height:30px;height:100%;display:none"
				borderStyle="border:0;">
				<label>名称：</label>
				<input id="generalusername" class="mini-textbox"
					style="width:150px;" onenter="onKeyEnter" />
				</br>
				<a class="mini-button" style="width:90px;" iconCls="icon-search"  
					onclick="generalSearch()">
					用户查询
				</a>
			</div>

		</div>
		<div showCollapseButton="true">
			<div class="mini-toolbar"
				style="text-align:right;line-height:30px;"
				borderStyle="border:0;">
				<a class="mini-button" iconCls="icon-add" plain="true"
					onclick="selectAll()">
					全部选中
				</a>
				<a class="mini-button" iconCls="icon-remove"
					plain="true" onclick="removeAll()">
					全部删除
				</a>
			</div>
			<div class="mini-fit">

				<div id="usergrid1" class="mini-datagrid"
					style="width:100%;height:100%;" borderStyle="border:0;" url=""
					allowCellSelect="true" showPager="false" totalField="page.count"
					sizeList=[20,40,60,100] allowRowSelect="true"
					onrowclick="onrowclick">

					<div property="columns">
						<div field="userid" width="80"
							headerAlign="center" align="center" allowSort="true">
							员工帐号
						</div>
						<div field="targetName" width="100"
							headerAlign="center" align="center" allowSort="true">
							员工姓名
						</div>
						<div field="pemail" width="100"
							headerAlign="center" align="center" allowSort="true">
							邮箱
						</div>
						<div field="mobileno" width="100"
							headerAlign="center" align="center" allowSort="true">
							手机
						</div>
						<div field="orgname" width="100"
							headerAlign="center" align="center" allowSort="true">
							所属机构
						</div>
						<div field="empid" width="100" visible="false" 
							headerAlign="center" align="center" allowSort="true">
							empid
						</div>
						<div field="targetId" width="80"
							headerAlign="center" visible="false" align="center" allowSort="true">
							员工帐号
						</div>
						<div field="userselect" width="30"
							headerAlign="center" align="center" renderer="showcheckbox">
							选择

						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

</div>
<div property="footer" class="mini-toolbar"
	style="padding:2px;border-top:0;border-left:0;border-right:0;">
	<div>选择用户：</div>
	<div>
		<input id="selectUsers" class="mini-textboxlist"
			name="selectUsers" textName="selectUsersName" required="true"
			style="width:100%;height:80px;" value="" text="" valueField="id"
			textField="text" />
	</div>
</div>
<div class="mini-toolbar"
	style="text-align:center;padding-top:8px;padding-bottom:8px;"
	borderStyle="border:0;">
	<a class="mini-button" style="width:60px;" iconCls="icon-ok"  
		onclick="closeWindow('ok')">
		确定
	</a>
	<span style="display:inline-block;width:25px;"></span>
	<a class="mini-button" style="width:60px;" iconCls="icon-cancel"  
		onclick="closeWindow('clean')">
		清除
	</a>
	<span style="display:inline-block;width:25px;"></span>
	<a class="mini-button" style="width:60px;"  iconCls="icon-close"  
		onclick="closeWindow('cancel')">
		取消
	</a>
</div>
<script type="text/javascript">
	nui.parse();
	var _deptconfig ="" ;
    var _deptlist = "" ;
    var _deptconfigval = "" ;
    var _datatype = "" ;
    var _minSize = 0;//最小选择
    
    var _maxSize= -1;//最大选择
    
	var grid=nui.get("usergrid1");
	var selectUserObj = nui.get("selectUsers");
	var lastSearch;
	var _selectVal = new Array();
	selectUserObj.on("valuechanged", onValueChanged);
	
	//机构查询
	 var tree = nui.get("depttree");
     
     tree.on("nodeselect", function (e) {
    
    	grid.setUrl("org.gocom.components.coframe.participantselect.userselect.deptUserList.biz.ext");	
		grid.load({ orgid: e.node.id ,datatype:_datatype}) ;
	});
	
	
	
	//机构查询
	 var grouptree = nui.get("grouptree");
     
     grouptree.on("nodeselect", function (e) {
    
    	grid.setUrl("org.gocom.components.coframe.participantselect.userselect.groupUserList.biz.ext");	
		grid.load({ groupid: e.node.id ,datatype:_datatype}) ;
	});
	function chkClick(obj){
		 
		obj.checked=!obj.checked;
	}
	 function onrowclick(e){
		//debugger;
		var record = e.record;
		var checked = $("#chk_" + record.empid).attr("checked");
		if(checked){
			$("#chk_" + record.empid).removeAttr("checked");
		}else{
			$("#chk_" + record.empid).attr("checked"  ,'true') ;
        }
        checkboxChange("#chk_" + record.empid) ;
	}
	
	/////
	function onRoleValueChanged(e) {
            var listbox = e.sender;
            var value = listbox.getValue();
            grid.setUrl("org.gocom.components.coframe.participantselect.userselect.roleUserList.biz.ext");	
			grid.load({ roleId: value }) ;
   }
	
	/**
	* 
	*/
	function recentSearch() {
		
		
		grid.setUrl("org.gocom.components.coframe.participantselect.userselect.recentUserList.biz.ext");
	    var sname = nui.get("username").value ;
	    grid.load({ name: sname ,datatype:_datatype}) ;
	   
	}
	
	function generalSearch() {
		
		grid.setUrl("org.gocom.components.coframe.participantselect.userselect.queryUserListByName.biz.ext") ;
	    var sname = nui.get("generalusername").value ;
	    grid.load({ name: sname,datatype:_datatype}) ;
	   
	}
	
	function showcheckbox(e){
		var record=e.record;
		
		//判断是否在结果集中
		// debugger;
		var checkstr = isUserSelectExist(record.empid) ? " checked" : "" ;
		return '<input id="chk_'+record.empid+'" type="checkbox" userid="'+record.targetId+'" targetName="'+record.targetName
			+'" empid="' + record.empid +  '" mobileno="' + record.mobileno+  
			'" pemail="' + record.pemail + '" name="useselect" ' + checkstr + ' class="selcheckbox" onClick="chkClick(this)">';
	
	}
	
	function checkboxChange(obj) {
		var userid = $(obj).attr("userid");
		var targetName = $(obj).attr("targetName");
		var checked = $(obj).attr("checked");
		var mobileno = $(obj).attr("mobileno");
		var pemail = $(obj).attr("pemail");
		var empid = $(obj).attr("empid");
		 
		if(checked){
			addSelectUser(targetName ,empid,mobileno,pemail,userid) ;
		}else{
			removeSelectUser(empid,mobileno,pemail);
		}
	}
	/**
	* tab切换
	*/
	function switchTab(tabid){
		var btn = nui.get(tabid);
		btn.setChecked(true);
		lastSearch==""? "" : $(lastSearch).hide();
		
		lastSearch="#"+tabid + "search" ;
		
		$("#"+tabid+"search").show();
		//debugger;
		 switch (tabid) {
                case "role": 
               	 	var rolesearch = nui.get("rolesearch");
               	 	rolesearch.setUrl("org.gocom.components.coframe.participantselect.roleselect.roleList.biz.ext");
               	 	if(rolesearch.getCount()>0){
               	 		rolesearch.select(rolesearch.getAt(0))
               	 		rolesearch.setValue(rolesearch.getAt(0).roleId);
               	 		grid.setUrl("org.gocom.components.coframe.participantselect.userselect.roleUserList.biz.ext");	
						grid.load({ roleId: rolesearch.getAt(0).roleId ,datatype:_datatype}) ;
					} 
					nui.get("usergrid1").setShowPager(false) ;
               	 	break ;
                case "recent":
		 			recentSearch();
		 			nui.get("usergrid1").setShowPager(false) ;
					break;
               case "search": 
					 generalSearch();
				 	 nui.get("usergrid1").setShowPager(true) ;
			 		break;
                case "dept": 
			
					var depttree = nui.get("depttree");
				 	depttree.setUrl("org.gocom.components.coframe.participantselect.deptselect.deptList.biz.ext") ;
               	 	var rootNode = depttree.getRootNode();
               	 	var nodes = depttree.getChildNodes(rootNode) ;
               	 	
					if(nodes != "undefined" || nodes.length>0){
						depttree.selectNode(nodes[0]);
					}
					nui.get("usergrid1").setShowPager(false) ;
					break;
				case "online": 
					 
					onlineSearch();
					nui.get("usergrid1").setShowPager(false) ;
					break;
				case "group":
					//debugger;
					//var grouptree = nui.get("grouptree");
					grouptree.setUrl("org.gocom.components.coframe.participantselect.groupselect.groupList.biz.ext") ;
               	 	var rootNode = grouptree.getRootNode();
               	 	var nodes = grouptree.getChildNodes(rootNode) ;
               	 	
					if(nodes != "undefined" || nodes.length>0){
						grouptree.selectNode(nodes[0]);
					}
					
					nui.get("usergrid1").setShowPager(false) ;
            }
	
	}
	
	/**
	* 判断该用户是否已经被选中
	*/ 
	function isUserSelectExist( val ){
		//debugger;
		var _selectuser_val = selectUserObj.getValue() ;
	 	var _selectArray = _selectuser_val.split(",") ;
	 	var _index = $.inArray(val+"",_selectArray) ;
	 	return _index < 0 ? false : true ;
	}
    /**
    * 添加用户
    */
    function addSelectUser(name,val,mobileno,pemail,userid) {
          
          
            var _selectuser_val = selectUserObj.getValue() ;
            var _selectuser_name = selectUserObj.getText() ;
          
            var _selectArray = _selectuser_val.split(",") ;
            var _index=$.inArray(val,_selectArray) ;
          
           	var seprator =  _selectuser_val=="" ?"" : ",";
            if(_index < 0){
            	_selectuser_val = _selectuser_val + seprator + val ;
	            _selectuser_name = _selectuser_name + seprator + getSelectViewName(name,mobileno ,pemail) ;
	           
	            selectUserObj.setValue(_selectuser_val) ;
	            selectUserObj.setText(_selectuser_name) ;
	           
	            _selectVal.push(getEmpVal(val, mobileno ,pemail,name,userid)) ;
            }
            
    }
     
     function getSelectViewName(name,mobileno,pemail){
    	 var _retVal = "";
    	 switch(_datatype){

	            	case "2":
	            		_retVal= name + ":" + pemail ;
	            		break;
	            	case "1":
	            		_retVal= name ;
	            		break;
	            	case "3":
	            		_retVal= name + ":" + mobileno  ;
	            		break;
	            		default:
	            		_retVal= name ;
	            		
	     }
	     return _retVal ;
    }
    function getViewName(obj){
    	return getSelectViewName(obj.data.username,obj.data.mobileno,obj.data.pemail);
    }
    function getViewValue(obj){
    	return obj.data.empid;
    }
    /**
    * 删除选择的用户
    */
	function removeSelectUser(val,mobileno,pemail) {
		 
		var _selectuser_val = selectUserObj.getValue();
		var _selectuser_name = selectUserObj.getText();
		
		var _selectArray = _selectuser_val.split(",") ;
		var _nameArray = _selectuser_name.split(",") ;
		
		var _index = $.inArray(val,_selectArray) ;
		
		if(_index >= 0){
		    _selectArray.splice(_index , 1) ;
		    _nameArray.splice(_index , 1) ;
			 
		    _selectVal.splice(_index ,1) ;
		}
		
		selectUserObj.setValue(_selectArray.join(",")) ;
		selectUserObj.setText(_nameArray.join(",")) ;
	}
	/**
    * 创建机构json数据
    */
    function getEmpVal(v_empid,v_mobileno,v_pemail,v_username,v_userid) {
    	return {type:"emp",data:{userid:v_userid , mobileno:v_mobileno,pemail:v_pemail,username:v_username,empid:v_empid}} ;
    }
	   
	function onValueChanged(e){
		 
		var _data = grid.getData() ;
		var _isExist ;
		$.each(_data ,function(_index,record) {  
           _isExist = isUserSelectExist(record.empid) ;
            
           if(_isExist){
           		$("#chk_" + record.empid).attr("checked"  ,'true') ;
           }else{
           		$("#chk_" + record.empid).removeAttr("checked");
           }
        });  
        
         //结果集合内删除被用户点击的取消的记录
        var valArray = selectUserObj.getValue().split(",") ;
        
        $.each(_selectVal ,function(_index,record) {
          	var empid = record.data.empid ;
          	if (empid!= valArray[_index]) {
            	_selectVal.splice(_index ,1) ;
            	return false ;
            }
             
         });              
	}
	function selectAll(){
		var _data = grid.getData() ;
		$.each(_data ,function(_index,record) {  
          	 $("#chk_" + record.empid).attr("checked"  ,'true') ;
          	 checkboxChange("#chk_" + record.empid);
         });
   	}
	function removeAll(){
		var _data = grid.getData() ;
		$.each(_data ,function(_index,record) {  
          	$("#chk_" + record.empid).removeAttr("checked") ;
          	 checkboxChange("#chk_" + record.empid) ;
         });
	}
	
	function onBeforeTreeLoad(e) {
        var tree = e.sender;    //树控件
        var node = e.node;      //当前节点
        var params = e.params;  //参数对象
        
        //全局机构
        //params.depttype = "1" ;
        //我所在的部门
        //params.depttype = "2" ;
        //我的上级部门
        // params.depttype = "3" ;
        //我的下级机构
        //  params.depttype = "4" ;
        
        //指定层级
        //params.depttype = "5" ;
        //params.orglevel = "2" ;
        //指定范围
       // debugger;
        params.depttype = _deptconfig ;
        params.orglevel =	_deptconfigval;
        params.orglists = _deptlist ;
        
        params.orgid = node.id ;
    }
    
    function onBeforeGroupTreeLoad(e) {
        var tree = e.sender;    //树控件
        var node = e.node;      //当前节点
        var params = e.params;  //参数对象
        
        params.groupid = node.id ;
    }
    
    
	function setData(data) {
		//debugger;
		_deptconfig = data.deptConfig ;
		_deptlist = data.deptList ;
		_deptconfigval = data.deptConfigVal ;
		_minSize = data.minSize ;
		_maxSize = data.maxSize;
		_datatype = data.dataType ;
		_selectVal=data.data;
		init() ;
	}
		
	function onlineSearch(){
		var sname = nui.get("onlineusername").value ;
		grid.setUrl("org.gocom.components.coframe.participantselect.userselect.onlineUserList.biz.ext");	
	    grid.load({ name: sname ,datatype:_datatype});
	}
	
	/**
	* 初始化页面的时候执行
	*/
	function init(){
		
		var wfVals=[];
		var wfNames=[];
		for(var i=0,len=_selectVal.length;i<len;i++){
			var obj = _selectVal[i];
			  wfVals.push(getViewValue(obj));
				wfNames.push(getViewName(obj));
		}
		selectUserObj.setValue(wfVals.join(','));
		selectUserObj.setText(wfNames.join(','));
		
		grid.hideColumn(grid.getColumns()[2]);
	    grid.hideColumn(grid.getColumns()[3]);
	     
	    switch (_datatype){
	    	case "1":
	    		
	    		break ;
	    	case "2":
	    		grid.showColumn(grid.getColumns()[2]);
	    		break;
	  		case "3" :
	  			grid.showColumn(grid.getColumns()[3]);
	  			break ;
	  		default :
	  			break;
	  	}
		switchTab("<%=firstKey %>");
	}
 
	
	var retData = {};
	 function closeWindow(action) {            
            
            if (action == "ok"){
            	var _val = selectUserObj.getValue();
            	var valArray = _val.split(",") ;
            	var aLen = (_val == "") ? 0 :valArray.length ;
            	if(aLen < _minSize){
            		//当记录少于最少值时候
            		nui.alert("选择用户低于最少用户数：" + _minSize);
            		return ;
            	}
            	if(_maxSize >=0 && aLen > _maxSize){
            		//
            		nui.alert("选择用户超过最多用户数：" + _maxSize);
            		return ;
            	}
            	 
            	retData.data = _selectVal;
				retData.value= selectUserObj.getValue();
				retData.name = selectUserObj.getText() ;
            	saveRecent();
            }else if (action == "cancel"){
            	//取消所有
            }else if (action =="clean"){
            	//清除
            }
            if (window.CloseOwnerWindow) 
            	return window.CloseOwnerWindow(action);
            else window.close() ;            
        }
        function getData(){
        	return retData ;
        }
        function saveRecent(){
    	//
    	var selList=_selectVal;
    	var dataList=[];
    	for(var i=0,len=selList.length;i<len;i++){
    		var selItem=selList[i];
    		
    		var dataItem={};
    		switch(selItem.type){
    			case 'org':
    				dataItem.targetId=selItem.data.orgid;
    				break;
    			case 'emp':
    				dataItem.targetId=selItem.data.empid;
    				break;
    		}
    		dataItem.targetType=selItem.type;
    		dataList.push(dataItem);
    	}
    	
    	
    	nui.ajax({
            url: "org.gocom.components.coframe.participantselect.recentvisit.add.biz.ext",
            type: 'POST' ,
            data: {
            	dataList:dataList
            } ,
            cache: false ,
            contentType:'text/json' ,
            
            success: function (text) {
            	var response = text.retCode ;
            	if(response!="1"){
	            	 nui.alert("处理失败，请联系管理员");
            	}
            },
            error: function (jqXHR, textStatus, errorThrown) {
                nui.alert("插入最新访问入库出错");
                //nui.alert(jqXHR.responseText);
                //closeWindow();
            }
        });
    }
    
 </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): huang
- Date: 2014-08-13 12:27:01
- Description:
  --%>
  <head>
    <title>
      会员卡操作
    </title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript">
    </script>
  </head>
  <body style="width:98%;height:95%;">
   
    <!--footer-->
   
    <div class="nui-panel" title="会员卡列表" iconCls="icon-add" style="width:100%;height:100%;" showToolbar="false" showFooter="false" >
      <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
      <div id="queryform" class="nui-form" align="center" style="height:100%">
              <!-- 数据实体的名称 -->
        <input class="nui-hidden" name="criteria/_entity" value="com.hsapi.repair.data.rpb.RpbCardStored">
        <!-- 排序字段 -->
   
        <table style="width:100%;" id="table1">
          <tr>
          	<td style="width:100%;">
          		 会员卡名称:             
          		 <input class="nui-textbox" name="criteria/_expr[1]/name"/>
             	 <input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
             	 <input class="nui-hidden" name="criteria/_expr[1]/_likeRule" value="all">
           <a class="nui-button" onclick="search()">
       			 查询
     		 </a>
             	 <span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
              <a class="nui-button" iconCls="icon-add" onclick="add()">
                增加
              </a>
              <a id="update" class="nui-button" iconCls="icon-edit" onclick="edit()">
                编辑
              </a>

            </td>
          </tr>
        </table>
      </div>
      </div>
      <div class="nui-fit">
        <div id="datagrid1" dataField="card" class="nui-datagrid" style="width:100%;height:100%;" url="com.hsapi.repair.baseData.crud.queryCard.biz.ext" pageSize="20" showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" allowSortColumn="false">
          <div property="columns">
            <div type="indexcolumn">
            </div>
            <div type="checkcolumn">
            </div>
            <div field="id" headerAlign="center" allowSort="true" visible="false">
             会员卡ID
            </div>
            <div field="name" headerAlign="center" allowSort="true" >
              会员卡名称
            </div>
            
            <div field="useRange" renderer="onuseRange" headerAlign="center" allowSort="true" >
              适用范围
            </div>
            <div field="canModify" renderer="oncanModify" headerAlign="center" allowSort="true" >
              是否允许修改金额
            </div>
            <div field="periodValidity"   headerAlign="center" allowSort="true" >
              有效期(月)
            </div>
            <div field="rechargeAmt" headerAlign="center" allowSort="true" >
             充值金额
            </div>
            <div field="giveAmt" headerAlign="center" allowSort="true" >
              赠送金额
            </div>
            <div field="totalAmt" headerAlign="center" allowSort="true" >
              总金额
            </div>
            <div field="packageRate" headerAlign="center" allowSort="true" >
             套餐优惠率
            </div>
            <div field="itemRate" headerAlign="center" allowSort="true" >
              工时优惠率
            </div>
            <div field="partRate" headerAlign="center" allowSort="true" >
              配件优惠率
            </div>
            <div field="salesDeductType" renderer="onsalesDeductType" headerAlign="center" allowSort="true" >
            销售提成方式
            </div>
         	 <div field="salesDeductValue" headerAlign="center" allowSort="true" >
             销售提成值
            </div>
            <div field="status" renderer="onstatus" headerAlign="center" allowSort="true" >
              状态
            </div>
            <div field="remark" headerAlign="center" allowSort="true" >
              卡说明
            </div>
          </div>
        </div>
      </div>
    </div>
    <script type="text/javascript">
      nui.parse();
      var grid = nui.get("datagrid1");
      var formData = new nui.Form("#queryform").getData(false,false);
      grid.load(formData);

      //新增
      function add() {
        nui.open({
          url: "cardAdd.jsp",
          title: "新增记录", width: 700, height: 500,
          onload: function () {
           var iframe = this.getIFrameEl();
          var data = {pageType:"add"};//传入页面的json数据
          iframe.contentWindow.setData(data);
          
          },
          ondestroy: function (action) {//弹出页面关闭前
          if(action=="saveSuccess"){
            grid.reload();
          }
        }
        });
      }

      //编辑
      function edit() {
        var row = grid.getSelected();
        if (row) {
          nui.open({
            url: "cardAdd.jsp",
            title: "编辑数据",
            width: 700,
            height: 500,
            onload: function () {
              var iframe = this.getIFrameEl();
              var data = row;
              //直接从页面获取，不用去后台获取
              iframe.contentWindow.setData(data);
              },
              ondestroy: function (action) {
                if(action=="saveSuccess"){
                  grid.reload();
                }
              }
              });
            } else {
              nui.alert("请选中一条记录","提示");
            }
          }

          //删除
          function remove(){
            var rows = grid.getSelecteds();
            if(rows.length > 0){
              nui.confirm("确定删除选中记录？","系统提示",
              function(action){
                if(action=="ok"){
                  var json = nui.encode({card:rows});
                  grid.loading("正在删除中,请稍等...");
                  
                  $.ajax({
                  	
                    url: apiPath + repairApi + "/com.hsapi.repair.baseData.crud.updateCardStatus.biz.ext",
                    type:'POST',
                    data:json,
                    cache: false,
                    contentType:'text/json',
                    success:function(text){
                      var returnJson = nui.decode(text);
                      if(returnJson.exception == null){
                        grid.reload();
                        nui.alert("删除成功", "系统提示", function(action){
                          });
                        }else{
                          grid.unmask();
                          nui.alert("删除失败", "系统提示");
                        }
                      }
                      });
                    }
                    });
                  }else{
                    nui.alert("请选中一条记录！");
                  }
                }

                //重新刷新页面
                function refresh(){
                  var form = new  nui.Form("#queryform");
                  var json = form.getData(false,false);
                  grid.load(json);//grid查询
                  nui.get("update").enable();
                }

                //查询
                function search() {

                  var form = new nui.Form("#queryform");
                  var json = form.getData(false,false);
                  grid.load(json);//grid查询
                }

                //重置查询条件
                function reset(){
                  var form = new nui.Form("#queryform");//将普通form转为nui的form
                  form.reset();
                }

                //enter键触发查询
                function onKeyEnter(e) {
                  search();
                }

                //当选择列时
                function selectionChanged(){
                  var rows = grid.getSelecteds();
                  if(rows.length>1){
                    nui.get("update").disable();
                  }else{
                    nui.get("update").enable();
                  }
                }
        function onuseRange(e) {
        var Genders = [{ id: 0, text: '本店' }, { id: 1, text: '连锁'}];
            for (var i = 0, l = Genders.length; i < l; i++) {
                var g = Genders[i];
                if (g.id == e.value) return g.text;
            }
            return "";
        }

        function oncanModify(e) {
        var Genders = [{ id: 0, text: '否' }, { id: 1, text: '是'}];
            for (var i = 0, l = Genders.length; i < l; i++) {
                var g = Genders[i];
                if (g.id == e.value) return g.text;
            }
            return "";
        }   
         function onsalesDeductType(e) {
        var Genders = [{ id: 0, text: '按原价比例' }, { id: 1, text: '按折后价比例'},{ id: 2, text: '按产值比例' }, { id: 3, text: '固定金额'}];
            for (var i = 0, l = Genders.length; i < l; i++) {
                var g = Genders[i];
                if (g.id == e.value) return g.text;
            }
            return "";
        }  
          
		  function onstatus(e) {
        var Genders = [{ id: 0, text: '启用' }, { id: 1, text: '禁用'}];
            for (var i = 0, l = Genders.length; i < l; i++) {
                var g = Genders[i];
                if (g.id == e.value) return g.text;
            }
            return "";
        } 
              </script>
            </body>
          </html>

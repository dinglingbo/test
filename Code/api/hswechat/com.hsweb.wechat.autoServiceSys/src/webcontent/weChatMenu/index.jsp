<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>自定义菜单</title>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/menu.css">
 <script src="js/vue.min.js"></script>
 <script src="https://unpkg.com/axios/dist/axios.min.js"></script>

</head>
<body>
  <div id="box">
    <div class="container">
      <!-- 自定义菜单 -->
      <h3>自定义菜单</h3>
      <div class="custom-menu-edit-con">
        <div class="hbox">
          <div class="inner-left">
            <div class="custom-menu-view-con">
              <div class="custom-menu-view">
                <div class="custom-menu-view__title">公众号名称</div>
                <div class="custom-menu-view__body">
                  <div class="weixin-msg-list"><ul class="msg-con"></ul></div>
                </div>
                <div id="menuMain" class="custom-menu-view__footer">
                  <div class="custom-menu-view__footer__left"></div>
                  <div id="customBtns" class="custom-menu-view__footer__right" >
                    <div class="custom-menu-view__menu"  v-if="menuObj.button.length>0"
                         v-for="(item,index) in menuObj.button"
                         :class="{subbutton__actived:menuIndex[index].isActive}"
                         :style="{width:buttonWidth}">
                      <div class="text-ellipsis" @click="menuTab(index)">{{item.name}}</div>
                      <ul class="custom-menu-view__menu__sub">
                        <li v-for="(subItem,subIndex) in item.sub_button"
                            class="custom-menu-view__menu__sub__add"
                            :class="{subbutton__actived:subIndex==subBtnIndex[index].num}"
                            @click="liTab(index,subIndex)">
                            {{subItem.name}}
                        </li>
                        <li v-if="item.sub_button.length<5" @click="subAddBtn(index)">
                            <i class="glyphicon glyphicon-plus text-info"></i>
                        </li>
                      </ul>
                    </div>
                    <div class="custom-menu-view__menu" v-if="menuObj.button.length==0" @click="addBtn(0)" style="width: 100%;">
                      <div class="text-ellipsis">
                        <i class="glyphicon glyphicon-plus text-info iBtn"></i>
                      </div>
                    </div>
                    <div class="custom-menu-view__menu" v-if="menuObj.button.length==1" @click="addBtn(1)" style="width: 50%;">
                      <div class="text-ellipsis">
                        <i class="glyphicon glyphicon-plus text-info iBtn"></i>
                      </div>
                    </div>
                    <div class="custom-menu-view__menu" v-if="menuObj.button.length==2" @click="addBtn(2)" style="width: 33.33%;">
                      <div class="text-ellipsis">
                        <i class="glyphicon glyphicon-plus text-info iBtn"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="inner-right">
            <div class="cm-edit-after">
              <div class="cm-edit-right-header b-b"><span>{{rightTitle}}</span> <a @click="del()" class="pull-right" href="javascript:;">删除菜单</a></div>
              <form class="form-horizontal wrapper-md" name="custom_form">
                <div class="form-group">
                  <label class="col-sm-2 control-label">菜单名称:</label><div class="col-sm-5">
                  <input name="custom_input_title" type="text" class="form-control"
                         v-model="rightTitle"
                         v-on:input="updateValue()"></div><div class="col-sm-5 help-block">
                  <div v-show="isRightTitle">字数不超过5个汉字或16个字符</div>
                  <div v-show="rightTitle.length==0">菜单内容不能为空</div>
                </div>
                </div>
              </form>

              <div class="cm-edit-content-con" id="editPage" v-if="urlShow">
                <div class="cm-edit-page">
                  <div class="row">
                    <label class="col-sm-6 control-label" style="text-align: left;">粉丝点击该菜单会跳转到以下链接:
                    </label>
                  </div>
                  <div class="row">
                    <label class="col-sm-2 control-label" style="text-align: left;">页面地址:
                    </label>
                    <div class="col-sm-5">
                      <input type="text" name="url" class="form-control"
                             v-model="url" v-on:input="updateUrl()" placeholder="认证号才可手动输入地址">
                      <span class="help-block" v-if="isUrl">必填,必须是正确的URL格式</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="cm-edit-before" v-if="menuObj.button.length==0 || operationShow"><h5>点击左侧菜单进行操作</h5></div>
          </div>
        </div>
      </div>
      <div class="cm-edit-footer">
        <button @click="save" type="button" class="btn btn-info1">保存</button>
      </div>
    </div>
  </div>
  <script>
      new Vue({
        el:'#box',
        data:{
          rightTitle:'',
          url:'',
          dataIndex:[0,0,null],
          operationShow: true,
          urlShow: true,
          isRightTitle: false,
          isUrl: false,
          menuIndex:[
            {isActive:false},
            {isActive:false},
            {isActive:false}
          ],
          subBtnIndex: [
            {num:-1},
            {num:-1},
            {num:-1}
          ],
          menuObj:{
            "button": []
          },
          buttonObj:{
            "name": "新建菜单",
            "url": "",
            "sub_button": []
          },
          subObj:{
            "name": "新建子菜单",
            "url": ""
          }
        },
        computed:{
          buttonWidth: function(){
            return this.menuObj.button.length==3?'33.33%':100/(this.menuObj.button.length+1)+'%';
          }
        },
        created(){
        	this.init();
        },
        methods:{
          del: function(){//删除菜单
            let x=this.dataIndex[0];
            let y=this.dataIndex[1];
            let z=this.dataIndex[2];
            z==0?this.menuObj.button.splice(x,1):this.menuObj.button[x].sub_button.splice(y,1);//判断删除一级菜单还是二级菜单
            for(let i=0;i<this.menuObj.button.length;i++){
              this.subBtnIndex[i].num=-1;//重置所有子菜单选中状态
              this.menuIndex[i].isActive=false;//重置一级菜单
            }
            this.operationShow=true;//右侧隐藏操作框
          },
          addBtn: function(index){//添加一级菜单
            var button=this.menuObj.button;
            button.splice(button.length,0,JSON.parse(JSON.stringify(this.buttonObj)));//添加菜单按钮
            for(let i=0;i<this.menuObj.button.length;i++){
              this.subBtnIndex[i].num=-1;//重置所有子菜单选中状态
              this.menuIndex[i].isActive=false;//重置一级菜单
            }
            this.menuIndex[index].isActive=true;
            let menu_name=this.menuObj.button[index].name;
            let menu_url=this.menuObj.button[index].url;
            this.getInfo(menu_name,menu_url);
            this.urlWindow(index);

            this.dataIndex.splice(0,1,index);
            this.dataIndex.splice(2,1,0);
            this.operationShow=false;
          },
          subAddBtn: function(index){//添加子菜单
              for(let i=0;i<this.menuObj.button.length;i++){
                this.subBtnIndex[i].num=-1;//重置所有子菜单选中状态
                this.menuIndex[i].isActive=false;//重置一级菜单
                if(i ==index){
                  var sub_button=this.menuObj.button[i].sub_button;
                  sub_button.splice(this.menuObj.button[i].sub_button.length,0,JSON.parse(JSON.stringify(this.subObj)));//添加子菜单按钮
                  if(sub_button.length>0){
                    this.subBtnIndex[index].num=sub_button.length-2;
                    this.menuObj.button[i].url='';//增加子菜单，清空一级菜单url
                  }
                  this.subBtnIndex[index].num++;//子菜单选中状态
                }
              }
              let sub_name=this.menuObj.button[index].sub_button[this.subBtnIndex[index].num].name;
              let sub_url=this.menuObj.button[index].sub_button[this.subBtnIndex[index].num].url;
              this.getInfo(sub_name,sub_url);
              this.urlWindow(index,true);

              this.dataIndex.splice(0,1,index);
              this.dataIndex.splice(1,1,this.subBtnIndex[index].num);
              this.dataIndex.splice(2,1,1);
              this.operationShow=false;
          },
          menuTab: function(index){//点击一级菜单
            for(let i=0;i<this.menuObj.button.length;i++){
              this.subBtnIndex[i].num=-1;//重置所有子菜单选中状态
              this.menuIndex[i].isActive=false;//重置一级菜单
            }
            this.menuIndex[index].isActive=true;
            let menu_name=this.menuObj.button[index].name;
            let menu_url=this.menuObj.button[index].url;
            this.getInfo(menu_name,menu_url);
            this.urlWindow(index);

            this.dataIndex.splice(0,1,index);
            this.dataIndex.splice(2,1,0);
            this.operationShow=false;
          },
          liTab: function(index,subIndex){//点击子菜单
            for(let i=0;i<this.menuObj.button.length;i++){
              this.subBtnIndex[i].num=-1;//重置所有子菜单选中状态
              this.menuIndex[i].isActive=false;//重置一级菜单
            }
            this.subBtnIndex[index].num=subIndex;
            let sub_name=this.menuObj.button[index].sub_button[subIndex].name;
            let sub_url=this.menuObj.button[index].sub_button[subIndex].url;
            this.getInfo(sub_name,sub_url);
            this.urlWindow(index,true);

            this.dataIndex.splice(0,1,index);
            this.dataIndex.splice(1,1,subIndex);
            this.dataIndex.splice(2,1,1);
            this.operationShow=false;
          },
          updateValue: function(){//更新按钮name
            let match1=/^[\u4E00-\u9FA5]{1,5}$/;
            let isName1=match1.test(this.rightTitle);
            let match2=/^[a-zA-Z0-9]{1,16}$/;
            let isName2=match2.test(this.rightTitle);

            let x=this.dataIndex[0];
            let y=this.dataIndex[1];
            let z=this.dataIndex[2];
            isName1 || isName2?this.isRightTitle=false:this.isRightTitle=true;
            z==0?this.setmenu(x):this.setSubmenu(x,y);
          },
          updateUrl: function(){//更新按钮url
            let match = /^((ht|f)tps?):\/\/[\w\-]+(\.[\w\-]+)+([\w\-\.,@?^=%&:\/~\+#]*[\w\-\@?^=%&\/~\+#])?$/;//验证url
            let isUrl = match.test(this.url);
            let x=this.dataIndex[0];
            let y=this.dataIndex[1];
            let z=this.dataIndex[2];
            isUrl?this.isUrl=false:this.isUrl=true;
            z==0?this.setmenu(x):this.setSubmenu(x,y);
          },
          getInfo: function(name,url){//显示name，url
            this.rightTitle=name;
            this.url=url;
          },
          setmenu: function(x){
            this.menuObj.button[x].name=JSON.parse(JSON.stringify(this.rightTitle));//必须用JSON.parse(JSON.stringify(value)
            this.menuObj.button[x].url=JSON.parse(JSON.stringify(this.url));
          },
          setSubmenu: function(x,y){
            this.menuObj.button[x].sub_button[y].name=JSON.parse(JSON.stringify(this.rightTitle));
            this.menuObj.button[x].sub_button[y].url=JSON.parse(JSON.stringify(this.url));
          },
          urlWindow: function(index,subIndex){//显示右侧url窗口
            if(!subIndex && this.menuObj.button[index].sub_button.length>0){
              this.urlShow = false;
            }else{
              this.urlShow = true;
            }
          },
          init: function() { //获取数据
              const _this = this;
              axios.post('http://127.0.0.1:8080/default/com.hsapi.wechat.autoServiceBackstage.weChatMenu.queryNewMenu.biz.ext',{}).then(res =>{
                    if(res.data.result.code == 'S'){
                        for(let i = 0;i<res.data.result.data.length;i++){
                        	if(res.data.result.data[i].sub_button == undefined){
                        		res.data.result.data[i].sub_button = [];
                              };
                           }
                    	_this.menuObj.button = res.data.result.data;
                    }else{
                  	  alert('初始化失败');
                    }
                }).catch(res => {
                  console.log(res);
                 	alert('初始化失败');
                });
          },
          save: function(){
            let button=this.menuObj.button;
            for(let i=0;i<button.length;i++){//验证url是否为空
              if(button[i].sub_button.length==0){
                if(button[i].url=='' || button[i].name==''){
                  alert('一级菜单内容不能为空');
                  return;
                }
              }else{
                for(let j=0;j<button[i].sub_button.length;j++){
                  if(button[i].sub_button[j].url=='' || button[i].sub_button[j].name==''){
                    alert('二级菜单内容不能为空');
                    return;
                  }
                }
              }
            }
            //ajax保存至后台
            axios.post('http://127.0.0.1:8080/default/com.hsapi.wechat.autoServiceBackstage.weChatMenu.saveNewMenu.biz.ext', {
            	params:button
              }).then(res =>{
                  if(res.data.result.code == 'S'){
                	  alert('保存成功');
                  }else{
                	  alert('保存失败');
                  }
              })
              .catch(res => {
                console.log(res);
               	alert('保存失败');
              });
        	
          }
        }
      })
  </script>
</body>
</html>






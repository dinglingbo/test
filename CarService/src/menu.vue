<template>
  <div id="menu">
  		 <!--子页面渲染-->
	    <div class="main">
	     <router-view></router-view>
	    </div>
  	<!--菜单栏-->
  	<div class="menus">
	    <tabbar class="menu-tabbar" :value="index">
	      	<tabbar-item  link="/home" >
		        <img style="height: 0.4rem;width: 0.4rem;    margin-top: 0.06rem; " slot="icon" src="./assets/icons/icon_home1.png">
		        <img style="height: 0.4rem;width: 0.4rem;     margin-top: 0.06rem;" slot="icon-active" src="./assets/icons/icon_home.png">
		        <span slot="label"  class="menu-txt">首页</span>
	      	</tabbar-item>
		      <tabbar-item   link="/autoServiceItem">
		        <img  style="height: 0.4rem;width: 0.4rem;    margin-top: 0.06rem;" slot="icon" src="./assets/icons/icon_fuwu1.png">
						<img style="height: 0.4rem;width: 0.4rem;     margin-top: 0.06rem;" slot="icon-active" src="./assets/icons/icon_fuwu.png">
		        <span slot="label" class="menu-txt">服务</span>
		      </tabbar-item>
		      <tabbar-item  link="/store">
		        <img style="height: 0.4rem;width: 0.4rem;     margin-top: 0.06rem;" slot="icon" src="./assets/icons/icon_mendian1.png">
		       	<img style="height: 0.4rem;width: 0.4rem;     margin-top: 0.06rem;" slot="icon-active" src="./assets/icons/icon_mendian.png">
		        <span slot="label" class="menu-txt">门店</span>
		      </tabbar-item>
		      <tabbar-item  link="/my">
		        <img style="height: 0.4rem;width: 0.4rem;     margin-top: 0.06rem; " slot="icon" src="./assets/icons/icon_me1.png">
		      	<img style="height:0.4rem;width: 0.4rem;     margin-top: 0.06rem;" slot="icon-active" src="./assets/icons/icon_me.png">
		        <span slot="label" class="menu-txt" :class="">我的</span>
		      </tabbar-item>
	    </tabbar>
  	</div>


  </div>
</template>

<script>
import { Tabbar, TabbarItem,  } from 'vux'
		export default {
			name: 'registered',
		  components: {
		  	name: 'registered',
		    Tabbar,
		    TabbarItem,
      },
      computed: {
        index() {
          return [
            'home',
            'autoServiceItem',
            'store',
            'my'
          ].indexOf(this.$route.name)
        }
      }
		}
</script>
<style >
	.menu-txt{
    font-size: 0.24rem;
   /* letter-spacing:1px;*/
    }
  .main{
    min-height: calc(100vh - 1.06rem);
    padding-bottom: 1.06rem;
    position: relative;
  	/* float: left;
    height: 94%;
    width: 100%;
    position: absolute;
    top: 0;
    overflow: scroll;
    overflow-x: hidden; */
  }
  .menus{
    position: fixed;
    left: 0;
    width: 100%;
    bottom: 0;
  }

</style>

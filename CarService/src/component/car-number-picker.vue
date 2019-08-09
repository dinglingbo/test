<template>
	<div class="keyword" v-if="showPopup && showXxxx" @click="popuoClose">
    <div class="j_xxxx" style="height: 100px;"></div>
    <div class="van-popup van-popup--bottom j_popup">
      <div class="van-popup-close j_popuo-close" style="background: #f4f4f4;" @click="popuoClose">
        <svg class="put-away" viewBox="0 0 1479 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="38986" xmlns:xlink="http://www.w3.org/1999/xlink" >
          <path fill="#666" d="M0 56.888889a56.888889 56.888889 0 0 0 56.206222 56.888889h1366.698667a56.888889 56.888889 0 1 0 0-113.777778H56.206222A57.116444 57.116444 0 0 0 0 56.888889z m1414.712889 430.762667c39.480889-32.199111 64.284444-110.364444 49.038222-169.528889-11.605333-44.942222-106.268444-93.297778-106.268444-93.297778H77.255111s-62.464 46.193778-73.955555 104.789333c-11.719111 58.709333 9.102222 125.838222 48.469333 158.151111l615.537778 508.245334c47.672889 44.828444 110.023111 28.899556 134.826666 0.113777l612.579556-508.472888z" p-id="38987"></path>
        </svg>
      </div>

      <div class="van-popup-main">
        <div class="j_carno clearfix" v-if="showCarno">
          <div class="btn-wrap btn-wrap1" v-for="item in carno">
            <button class="btn-pick btn-carno j_btn-carno" @click.stop="carnoBtn(item)">{{item}}</button>
          </div>
        </div>
        <div class="j_keyword clearfix" v-if="showKeyword">
          <div class="pick-number">
            <div class="btn-wrap" v-for="item in number">
              <button class="btn-pick btn-number j_btn-carno" @click.stop="carnoBtn(item)">{{item}}</button>
            </div>
          </div>

          <div class="pick-letter">
            <div class="btn-wrap" v-for="item in letter">
              <button class="btn-pick btn-letter j_btn-carno" @click.stop="carnoBtn(item)">{{item}}</button>
            </div>
            <div class="btn-wrap fr"><button class="btn-pick btn-go j_btn-go" @click.stop="btnGo">GO</button></div>
            <div class="btn-wrap fr"><button class="btn-pick btn-close j_btn-close" @click.stop="btnClose">删</button></div>
          </div>
        </div>
      </div>

    </div>
	</div>
</template>
<script>
	export default{
		name: 'keyWord',
    // props: {
    //     val: {
    //       type: String,
    //       default: '粤'
    //     }
    // },
    // props: {
    //   showPicker: {
    //       type: Boolean,
    //       default: false
    //     }
    // },
		data(){
			return{
        carno: ['京', '津', '冀', '晋', '蒙', '辽', '吉', '黑', '沪', '苏', '浙', '皖', '闽', '赣', '鲁', '豫', '鄂', '湘', '粤', '桂', '琼', '渝', '川', '贵', '云', '藏', '陕', '甘', '青', '宁', '新'],
        number: [1, 2, 3, 4, 5, 6, 7, 8, 9, 0],
        letter: ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M'],
        carplate: '',
        showCarno: false,
        showKeyword: false,
        showXxxx: false,
        showPopup: false
			}
		},
		methods:{
      pickToggle(carplate){
        if (carplate.length >= 1) {
          this.showCarno = false
          this.showKeyword = true
        } else {
          this.showCarno = true
          this.showKeyword = false
        }
      },
      //父级调用
      carplateFn(){
        this.showPopup = true
        this.showXxxx = true
        let carplate = this.carplate
        this.pickToggle(carplate)
      },
      carnoBtn(val){
        let carplate = this.carplate

        if (carplate.length >= 6) {
          this.showPopup = false
          this.showXxxx = false
        }
        if (carplate.length > 6) {return}
        carplate += val
        this.carplate = carplate
        //改变input值
        this.$emit('change',carplate)
        this.pickToggle(carplate)
        // console.log(this.carplate)
      },
      btnClose(){
        let carplate = this.carplate.slice(0, this.carplate.length - 1)
        this.carplate = carplate
        //改变input值
        this.$emit('change',carplate)
        this.pickToggle(carplate)
      },
      popuoClose(){
        this.showPopup = false
        this.showXxxx = false
      },
      btnGo(){
        this.showPopup = false
        this.showXxxx = false
      }
		}
	}
</script>
<style scoped lang="less">
  .keyword{
    width: 100%;
    height: 100%;
    position: fixed;
    left: 0;
    top: 0;
    z-index: 9999;
    background-color: rgba(0,0,0,0.3);
  }
  .clearfix::after{
    content: '';
    display: table;
    clear: both;
  }
  .fr {
    float: right !important;
  }
  .van-popup {
    position: fixed;
    top: 50%;
    left: 50%;
    z-index: 1000;
    max-height: 100%;
    overflow-y: auto;
    background-color: #fff;
    -webkit-transition: .2s ease-out;
    transition: .2s ease-out;
    -webkit-overflow-scrolling: touch;
    -webkit-transform: translate3d(-50%, -50%, 0);
    transform: translate3d(-50%, -50%, 0);
    box-sizing: border-box;
  }
  .van-popup--bottom {
    width: 100%;
    top: auto;
    bottom: 0;
    right: auto;
    left: 50%;
    -webkit-transform: translate3d(-50%, 0, 0);
    transform: translate3d(-50%, 0, 0);
  }
  .van-popup-close {
    padding: 5px;
    height: 20px;
    text-align: center;
    line-height: 30px;
  }
  .put-away {
    width: 20px;
    height: 20px;
  }
  .van-popup-main {
    padding:10px 5px;
    /* height: 300px; */
  }
  .btn-wrap {
    float: left;
    width: 10%;
    padding: 5px;
    box-sizing: border-box;
  }
  .btn-wrap1 {
    width: 12.5%;
  }
  .btn-pick {
    outline: none;
    border:1px solid #ddd;
    width: 100%;
    background: #fff;
    padding: 7px 0;
    text-align: center;
    border-radius: 3px;
  }
  .btn-go {
    border-color: #2e94e4;
    background: #2e94e4;
    color: #fff;
  }
  .btn-close {
    background: #eee;
  }
</style>

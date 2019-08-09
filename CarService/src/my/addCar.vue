<template>
  <div id="addCar">
    <group gutter="0">
      <x-input placeholder="请输入车牌号" :value="carNo" readonly @click.native="pickCarNo">
        <img
          slot="label"
          style="padding-right:0.2rem;display:block;width: 0.4rem; height: 0.4rem;"
          src="../assets/icons/icon_car.png"
        >
      </x-input>
      <x-input
        placeholder="请选择车型"
        :value="carModel || carbrand ? carModel ? carModel:carbrand + ' ' + carLine  : '' "
        readonly
        @click.native="pickCarModel"
      >
        <img
          slot="label"
          style="padding-right:0.2rem;display:block;width: 0.4rem; height: 0.4rem;"
          src="../assets/icons/icon_chexing.png"
        >
      </x-input>
    </group>
    <car-number-picker ref="picker" @change="onCarNoSelected"/>
    <btn-area class="btn-area">
      <button @click="saveCar">保存爱车</button>
    </btn-area>
  </div>
</template>

<script>
import axios from 'axios';
import api from '../Api/api';
import CarNumberPicker from '../component/car-number-picker.vue';
import BtnArea from '../component/btn-area.vue';
import { Group, Cell, XInput, XButton } from 'vux';
export default {
  components: {
    CarNumberPicker,
    BtnArea,
    Group,
    Cell,
    XInput,
    XButton
  },
  data() {
    return {
      key: Math.random().toString().slice(2),
      carNo: '',
      carBrandIds: '',
      carSeriesIds: '',
      carModelIds: '',
      carbrand: '',
      carLine: '',
      carModel: '',
      carBrandName: '',
      carSeriesName: ''
    };
  },
  created() {
		this.getToken();
		this.activated();
	},
  methods: {
  	 getToken(){
				this.$vux.loading.show({text: 'Loading'});
				axios.post(api.getTokenApi,{password:api.getPassword,userId:api.getUserId}).then(response => {
					 var  token = response.data.data.attributes.token;
					 localStorage.setItem("token",token);
					 this.$vux.loading.hide();
				});
		},
    /**
     * 输入车牌号
     */
    pickCarNo() {
      this.$refs.picker.carplateFn();
    },

    /**
     * 选取车牌号成功
     */
    onCarNoSelected(carNo) {
      this.carNo = carNo;
    },

    /**
     * 选取车型
     */
    pickCarModel() {
      this.$router.push('/carType?key=' + this.key+'&carNo='+ this.carNo);
    },

    /**
     * 保存爱车
     */
    async saveCar() {
      try {
        if (!this.carNo) throw new Error('请输入车牌号');
        var vehicleNumber = this.carNo;
        var express = /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;   //!express.test(this.carNo)
        var   r =  vehicleNumber.match(express);
        if (r == null){
        	throw new Error('车牌号格式不正确');
        } 
        if (!this.carBrandIds) throw new Error('请选择车型');
        const { data } = await axios.post(api.addNewUserorCarApi, {
          token: localStorage.token,
          action:"addCar",
          insGuest: {
            id: localStorage.guestId,
            mobile: localStorage.userPhone,
            orgid:localStorage.orgid,
            tenantId:localStorage.tenantId
          },
          /*shortName:,
            fullName:*/
          insCar: {
              carNo: this.carNo,
              carBrandId: this.carBrandIds,
              carModel: this.carModel,
              carModelFullName: this.carModel,
              carModelId: this.carModelIds,
              carSeriesId: this.carSeriesIds,
              guestId: localStorage.guestId,
              orgid:localStorage.orgid,
              tenantId:localStorage.tenantId
            },
          insContactor: {}
        });
        console.log(data);
        if (data.errCode === 'E') {
          throw new Error(data.errMsg || '保存失败');
        }else if( data.carList[0].carModelId != null && data.carList[0].carModelId != this.carModelIds){
        	debugger;
        	throw new Error('车牌对应的车型填写错误，请重新填写' || '温馨提示');
        }else if( !data.carList[0].carModelId && data.carList[0].carSeriesId != null && data.carList[0].carSeriesId != this.carSeriesIds){
        	debugger;
        	throw new Error('车牌对应的车系填写错误，请重新填写' || '温馨提示');
        }
        const res = await axios.post(api.addCarApi, {
          userCarData: {
            userId: localStorage.userId,
            userCarId: data.carList[0].id,
            carNo: this.carNo,
            carBrandId: this.carBrandIds,
            carBrandName: this.carBrandName,
            carModelName: this.carModel || this.carbrand + ' ' + this.carLine,
            carModelId: this.carModelIds,
            carSeriesId: this.carSeriesIds,
            carSeriesName: this.carSeriesName,
            guestId: localStorage.guestId,
            lastPatronageCar: 1,
            
          },token:localStorage.token
        });
        if (res.data.errCode === 'E') {
          this.$vux.toast.text(res.data.errMsg || '保存失败');
        }
        //清空缓存
        sessionStorage.removeItem('车型');
        this.$vux.toast.text('保存成功');
        this.$router.back();
      } catch (err) {
        this.$vux.toast.text(err.message);
      }
    },
    
    activated() {
	    const carInfo = JSON.parse(sessionStorage.getItem('车型'));
	    debugger;
	    if (carInfo) {
	      //车辆品牌id
	      var carBrandId = carInfo.carBrandId;
	      //车系id
	      var carSeriesId = carInfo.carSeriesId;
	      //车型id
	      var carModelId = carInfo.carModelId;
	      //车name
	      var routerParamsB = carInfo.carbrand;
	      var routerParamsl = carInfo.carLine;
	      var routerParamsC = carInfo.carModel;
	      //车牌号
	      var carNo = carInfo.carNo; 
	      this.carNo = carNo || '';
	      this.carBrandIds = carBrandId || '';
	      this.carSeriesIds = carSeriesId || '';
	      this.carModelIds = carModelId || '';
	      this.carbrand = routerParamsB || '';
	      this.carLine = routerParamsl || '';
	      this.carBrandName = carInfo.carBrandName || '';
	      this.carSeriesName = carInfo.carSeriesName || '';
	      this.carModel = routerParamsC || '';
	    }
	    this.key = Math.random().toString().slice(2);
	  }
    
  }

  
};
</script>

<style scoped>
.btn-area {
  margin-top: 0.2rem;
}
</style>

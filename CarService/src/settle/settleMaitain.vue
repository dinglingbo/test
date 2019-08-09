<template>
    <div>
        <div class="tit-color">
            <load-more tip="待支付信息" :show-loading="false" background-color="#fbf9fe"></load-more>
        </div>
        <div style="padding:0 15px;">
            <x-table>
                <thead>
                    <tr>
                        <th>交易单号</th>
                        <th>{{preBill.billCode}}</th>
                    </tr> 
                </thead>
                <tbody>
                    <tr>
                        <td>客户</td>
                        <td>{{preBill.guestName}}</td>
                    </tr>
                    <tr v-if="preBill.carNo">
                        <td>车牌号</td>
                        <td>{{preBill.carNo}}</td>
                    </tr>
                    <tr>
                        <td>金额</td>
                        <td>{{preBill.totalAmt}}<span v-if="preBill.totalAmt != 0">元</span></td>
                    </tr>
                    <tr>
                        <td>包含项目</td>
                        <td>{{preBill.rpBillNames}}</td>
                    </tr>
                    <tr>
                        <td>支付状态</td>
                        <td><span v-if="preBill.settleStatus == 0">未支付</span><span v-if="preBill.settleStatus == 1">已支付</span></td>
                    </tr>
                </tbody>
            </x-table>
        </div>
        <div style="padding:15px;margin-top:10px;" v-if="preBill.settleStatus == 0">
            <x-button type="primary" @click.native="payOrder()">支付</x-button>
        </div>
		<div style="padding:15px;margin-top:10px;" v-if="preBill.settleStatus == 1">
            <x-button type="primary" @click.native="1">确定</x-button>
        </div>
    </div>
</template> 
<script>
import axios from "axios";
import api from "../Api/api.js";
import wx from "weixin-js-sdk";
import { XButton, XTable, LoadMore,AlertModule} from "vux";
export default {
    components: {
        XButton,
        XTable,
        LoadMore
    },

    data() {
        //存放数据对象，以此在元素标签里使用
        return {
            preBill: {
                billCode:"",
                guestName:"",
                carNo:"",
                totalAmt:0,
                rpBillNames:"",
                settleStatus:""
            },
            url:"",
            openId:"",
            ordersCode:"",
            orderId:""
        };
    },
    created: function() {
        
        this.getUserInfo();
		this.initWechat();
		// console.log(this.getQueryString("id"));
    },
    //离开页面触发事件
    destroyed: function() {},
    methods: {
        getUserInfo() {
            this.openId = this.getQueryString("openId")||"obdhQ5nKX01f_uE-MQ7_RH_6D9_Y";
            this.ordersCode = this.getQueryString("id")||"XMD123123123456789";
            this.orderId = this.getQueryString("orderId")||"123453";
            this.url = "http://tomato.harsonserver.com/app/chedaoWeixin/settleMaitain?id="+this.getQueryString("id");
            console.log( this.openId)
            const _this = this;
            axios
                .post(api.queryFisPreBillApi, {
                    billCode: this.getQueryString("id"),
                    token: localStorage.token
                })
                .then(res => {
                    if(res.data.data&&res.data.data.length == 1){
                        _this.preBill = res.data.data[0];
					}else{
						_this.$vux.toast.text('数据加载失败');
						_this.preBill.settleStatus =999;//设置按钮不显示
                    }
                }).catch(err =>{
					_this.$vux.toast.text('数据加载失败');
					_this.preBill.settleStatus =999;//设置按钮不显示
				});
        },
        //将单个日期的数字加零
        fromeDate(num) {
            return Number(num) < 10 ? "0" + num : num;
        },
        initWechat() {
            var _this = this;
            _this.$http
                .post(api.mapUserApi, {
                    url: _this.url,
                    token: localStorage.token
                })
                .then(
                    function(resDatas) {
                        var data = resDatas.data.map;
                        _this.initWechatDatas(
                            data.timestamp,
                            data.nonceStr,
                            data.qianm1
                        );
                    },
                    function(resDatas) {
                    }
                );
        },
        //初始化微信接口授权
        initWechatDatas(timestamp, nonceStr, qianm1) {
            var _this = this;
            wx.config({
                beta: true, // 必须这么写，否则在微信插件有些jsapi会有问题
                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                appId: "wxd10b49dcb45e5591", // 必填，企业号的唯一标识，此处填写企业号corpid
                timestamp: timestamp, // 必填，生成签名的时间戳
                nonceStr: nonceStr, // 必填，生成签名的随机串
                signature: qianm1, // 必填，签名
                jsApiList: [
                    "checkJsApi",
                    "chooseImage",
                    "previewImage",
                    "uploadImage",
                    "downloadImage",
                    "getNetworkType", //网络状态接口
                    "openLocation", //使用微信内置地图查看地理位置接口
                    "getLocation", //获取地理位置接口
                    "hideOptionMenu", //界面操作接口1
                    "showOptionMenu", //界面操作接口2
                    "closeWindow", ////界面操作接口3
                    "hideMenuItems", ////界面操作接口4
                    "showMenuItems", ////界面操作接口5
                    "hideAllNonBaseMenuItem", ////界面操作接口6
                    "showAllNonBaseMenuItem",
                    "chooseWXPay" ////界面操作接口7
                ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
            });
            
            wx.error(function(res) {
                console.log(res);
                console.log("微信接口初始化失败");
                // alert(res);config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
            });
        },
        payOrder() {
            let timestamp = new Date().getTime(); //当前的时间戳
            timestamp = timestamp + 24 * 60 * 60 * 1000;
            //格式化时间获取年月日
            var dateAfter = new Date(timestamp);
            let tnow = this.formatDate(new Date(), "yyyyMMddhhmmss");
            dateAfter = this.formatDate(dateAfter, "yyyyMMddhhmmss");
            this.wechatInfor(
                this.preBill.totalAmt ,
                this.ordersCode,
                tnow,
                dateAfter,
                this.openId,
                this.orderId
            );
        },
        //调用接口的参数
        wechatInfor(
            itemAmountPrice,
            ordersCode,
            timeStart,
            timeExpire,
            userOpenid,
            orderId
        ) {
            var _this = this;
            _this.$http
                .post(api.weChatPayApi, {
                    orderId: orderId,
                    userOpenid: userOpenid,
                    itemAmountPrice: itemAmountPrice,
                    ordersCode: ordersCode,
                    timeStart: timeStart,
                    timeExpire: timeExpire,
                    token: localStorage.token
                })
                .then(
                    function(resDatas) {
                        var userWechatOrder = resDatas.data.userWechatOrder;
                        if (userWechatOrder&&userWechatOrder.package) {
                            _this.pay(userWechatOrder, orderId);
                        } else {
                            AlertModule.show({
                                title: "温馨提示",
                                content: userWechatOrder.errMesg,
                                onHide() {}
                            });
                        }
                    },
                    function(resDatas) {
                        console.log(resDatas);
                    }
                );
        },
        //微信支付接口
        pay(config, orderId) {
            var _this = this;
            wx.chooseWXPay({
                timestamp: config["timeStamp"], // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
                nonceStr: config["nonceStr"], // 支付签名随机串，不长于 32 位
                package: config["package"], // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=\*\*\*）
                signType: config["signType"], // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
                paySign: config["paySign"], // 支付签名
                success: function(res) {
                    console.log(res,'success');
                    // 支付成功后的回调函数
                    AlertModule.show({
                        title: "温馨提示",
                        content: "支付成功",
                        onHide() {
                            //加上让订单页面刷新
                        }
                    });
                },
                //如果你按照正常的jQuery逻辑，下面如果发送错误
                fail: function(res) {
                    //接口调用失败时执行的回调函数。
                     console.log(res,'fail');
                },
                complete: function(res) {
                    //接口调用完成时执行的回调函数，无论成功或失败都会执行。
                    console.log(res,'complete');
                },
                cancel: function(res) {
                    //用户点击取消时的回调函数，仅部分有用户取消操作的api才会用到。
                    console.log(res,'cancel');
                },
                trigger: function(res) {
                    //监听Menu中的按钮点击时触发的方法，该方法仅支持Menu中的相关接口。
                    console.log(res,'trigger');
                }
            });
        },
        formatDate(date, format) {
            //格式化日期
            var paddNum = function(num) {
                num += "";
                return num.replace(/^(\d)$/, "0$1");
            };
            //指定格式字符
            var cfg = {
                yyyy: date.getFullYear(), //年 : 4位
                yy: date .getFullYear() .toString() .substring(2), //年 : 2位
                M: date.getMonth() + 1, //月 : 如果1位的时候不补0
                MM: paddNum(date.getMonth() + 1), //月 : 如果1位的时候补0
                d: date.getDate(), //日 : 如果1位的时候不补0
                dd: paddNum(date.getDate()), //日 : 如果1位的时候补0
                hh: paddNum(date.getHours()), //时
                mm: paddNum(date.getMinutes()), //分
                ss: paddNum(date.getSeconds()) //秒
            };
            format || (format = "yyyy-MM-dd hh:mm:ss");
            return format.replace(/([a-z])(\1)*/gi, function(m) {
                return cfg[m];
            });
		},
		getQueryString(name){
			var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
			var r = window.location.search.substr(1).match(reg);
			if(r!=null)return  unescape(r[2]); return null;
		}
    }
};
</script>

<style lang="less" scoped="scoped">
@black: #3f3f3f;

.tit-color /deep/ .weui-loadmore_line .weui-loadmore__tips {
    color: #3f3f3f !important;
}
</style>
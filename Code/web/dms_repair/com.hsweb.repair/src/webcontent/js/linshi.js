//丰田卡罗拉

var da1 = [
    { "val1": "制动液", "val2": "08823-80030", "val3": "1.40 升", "val4": "0.354升/瓶,DOT-3", "val5": "42.00 x 4", "val6": "120", "val7": "288" },
    { "val1": "发动机油", "val2": "08880-83524", "val3": "4.00 升", "val4": "4升/瓶,全合成,5W-40,SM", "val5": "369.00 x 1", "val6": "180", "val7": "549" },
    { "val1": "发动机油", "val2": "08880-83517", "val3": "", "val4": "4升/瓶,全合成,5W-20,SM", "val5": "266.00 x 1", "val6": "180", "val7": "446" },
    { "val1": "机油滤清器", "val2": "90915-10003", "val3": "1 件", "val4": "", "val5": "68.00 x", "val6": "0", "val7": "0" },
    { "val1": "空气滤清器芯", "val2": "17801-0T020", "val3": "1 件", "val4": "", "val5": "83.00 x", "val6": "30", "val7": "30" },
    { "val1": "空调滤清器", "val2": "87139-06060", "val3": "1 件", "val4": "", "val5": "110.00 x", "val6": "60", "val7": "60" },
    
];
var da2 = [
    { "val1": "前制动片", "val2": "04465-02220", "val3": "1 副", "val4": "", "val5": "482.00 x", "val6": "360", "val7": "360" },
    { "val1": "前制动盘", "val2": "43512-02220", "val3": "2 片", "val4": "", "val5": "207.00 x", "val6": "240", "val7": "240" },
    { "val1": "发动机皮带", "val2": "90916-02664", "val3": "1 件", "val4": "", "val5": "223.00 x", "val6": "60", "val7": "60" },
    { "val1": "发动机防冻液", "val2": "08889-80029", "val3": "8.00 升", "val4": "4升/瓶,-37,红色,否", "val5": "126.00 x 2", "val6": "120", "val7": "372" },
    { "val1": "右前雨刮片", "val2": "85212-12430", "val3": "1.00 件", "val4": "1个,无骨,14,通用接口", "val5": "101.00 x 1", "val6": "15", "val7": "116" },
    { "val1": "后制动片", "val2": "04466-02260", "val3": "1 副", "val4": "", "val5": "210.00 x", "val6": "360", "val7": "360" },
    { "val1": "后制动盘", "val2": "42431-02190", "val3": "2 片", "val4": "", "val5": "188.00 x", "val6": "240", "val7": "240" },
    { "val1": "左前雨刮片", "val2": "85222-42830", "val3": "1.00 件", "val4": "1个,无骨,26,通用接口", "val5": "223.00 x 1", "val6": "15", "val7": "238" },
    { "val1": "燃油添加剂", "val2": "08813-80020", "val3": "0.20 升", "val4": "0.2升/瓶,清洁", "val5": "39.00 x 1", "val6": "0", "val7": "39" },
    { "val1": "蓄电池", "val2": "28800-YZZET", "val3": "1.00 个", "val4": "1个,免维护,12,356,60,55D23L", "val5": "525.00 x 1", "val6": "30", "val7": "555" },
    
];

//宝马
var db1 = [
    { "val1": "制动液", "val2": "83122405979", "val3": "1.00 升", "val4": "1升/瓶,DOT-4", "val5": "176.99 x 1", "val6": "49", "val7": "225.99" },
    { "val1": "发动机油", "val2": "83212365513", "val3": "5.00 升", "val4": "1升/瓶,全合成,5W-30,SN,A3/B4", "val5": "129.99 x 6", "val6": "245", "val7": "1,024.94" },
    { "val1": "机油滤清器滤芯", "val2": "11 42 8 575 211", "val3": "1 件", "val4": "", "val5": "204.00 x", "val6": "0", "val7": "0" },
    
];

var db2 = [
    { "val1": "前制动片", "val2": "34 10 6 888 459", "val3": "1 副", "val4": "", "val5": "1830.00 x", "val6": "392.00", "val7": "392.00" },
    { "val1": "前雨刮片", "val2": "61 61 2 408 631", "val3": "1.00 副", "val4": "1个,无骨,26,18,专用接口", "val5": "813.00 x 1", "val6": "0.00", "val7": "813.00" },
    { "val1": "发动机皮带", "val2": "11 28 8 613 616", "val3": "1 件", "val4": "", "val5": "334.00 x", "val6": "784.00", "val7": "784.00" },
    { "val1": "发动机防冻液", "val2": "83192211195", "val3": "9.90 升", "val4": "1.5升/瓶,-40,蓝色,是", "val5": "151.99 x 3", "val6": "147.00", "val7": "602.97" },
    { "val1": "变速箱油", "val2": "83222289720", "val3": "8.80 升", "val4": "1升/瓶", "val5": "793.00 x 9", "val6": "490.00", "val7": "7,627.00" },
    { "val1": "右前制动盘", "val2": "35 11 6 860 912", "val3": "1 片", "val4": "", "val5": "2040.00 x", "val6": "0.00", "val7": "0.00" },
    { "val1": "后制动片", "val2": "34 21 6 870 552", "val3": "1 副", "val4": "", "val5": "1157.00 x", "val6": "392.00", "val7": "392.00" },
    { "val1": "后制动盘", "val2": "34 21 6 860 925", "val3": "2 片", "val4": "", "val5": "1152.00 x", "val6": "490.00", "val7": "490.00" },
    { "val1": "左前制动盘", "val2": "34 11 6 860 911", "val3": "1 片", "val4": "", "val5": "2040.00 x", "val6": "0.00", "val7": "0.00" },
    { "val1": "燃油添加剂", "val2": "83192165917", "val3": "0.10 升", "val4": "0.1升/瓶,清洁", "val5": "107.80 x 1", "val6": "0.00", "val7": "107.80" },
    { "val1": "燃油滤清器", "val2": "16 12 7 233 840", "val3": "1 件", "val4": "", "val5": "290.00 x", "val6": "0.00", "val7": "0.00" },
    { "val1": "蓄电池", "val2": "61 21 6 924 013", "val3": "1.00 个", "val4": "1个,免维护,12,680,88,088-20", "val5": "2830.00 x 1", "val6": "490.00", "val7": "3,320.00" },
    { "val1": "雨刮清洗液", "val2": "83122298203", "val3": "0.05 升", "val4": "0.05升/瓶,是", "val5": "40.00 x 1", "val6": "0.00", "val7": "40.00" },
    { "val1": "齿轮油", "val2": "83222148570", "val3": "1.00 升", "val4": "1升/瓶", "val5": "493.99 x 1", "val6": "147.00", "val7": "640.99" },
    
];


//奥迪A5 Coupe 2016款 2.0T 45TFSI CVT 进取版
var dc1 = [
    { "val1": "发动机油", "val2": "LN 052 169 A1", "val3": "5.00 升", "val4": "1升/瓶,全合成,0W-30,SN", "val5": "219.87 x 5", "val6": "480.00", "val7": "1,579.35" },
    { "val1": "变速箱油", "val2": "G 052 516 A2", "val3": "7.00 升", "val4": "1升/瓶", "val5": "331.87 x 7", "val6": "305.00", "val7": "2,628.09" },
    { "val1": "机油滤清器", "val2": "06L 115 562", "val3": "1 件", "val4": "", "val5": "130.65 x", "val6": "0.00", "val7": "0.00" },
    { "val1": "火花塞", "val2": "06K 905 611 C", "val3": "4 个", "val4": "", "val5": "175.50 x", "val6": "245.00", "val7": "245.00" },
    { "val1": "空调滤清器", "val2": "8K0 819 439 B", "val3": "1 件", "val4": "", "val5": "390.29 x", "val6": "98.00", "val7": "98.00" },
    
];

var dc2 = [
    { "val1": "制动液", "val2": "LB 000 750 M3", "val3": "2.00 升", "val4": "1升/瓶,DOT-4", "val5": "93.75 x 2", "val6": "245.00", "val7": "432.50" },
    { "val1": "前制动片", "val2": "8K0 698 151 H", "val3": "1 副", "val4": "", "val5": "1638.59 x", "val6": "343.00", "val7": "343.00" },
    { "val1": "前制动盘", "val2": "8R0 615 301", "val3": "2 片", "val4": "", "val5": "1675.23 x", "val6": "343.00", "val7": "343.00" },
    { "val1": "发动机油底壳放油螺丝", "val2": "06L 103 801", "val3": "1 件", "val4": "", "val5": "26.00 x", "val6": "0.00", "val7": "0.00" },
    { "val1": "发动机防冻液", "val2": "LG 012 A8G M140A", "val3": "6.00 升", "val4": "1.5升/瓶,-40,红色,否", "val5": "58.33 x 4", "val6": "539.00", "val7": "772.32" },
    { "val1": "右前雨刮片", "val2": "8K1 955 426 A", "val3": "1.00 件", "val4": "1个,无骨,20,专用接口", "val5": "296.24 x 1", "val6": "25.00", "val7": "321.24" },
    { "val1": "后制动片", "val2": "8K0 698 451 A", "val3": "1 副", "val4": "", "val5": "1061.32 x", "val6": "367.00", "val7": "367.00" },
    { "val1": "后制动盘", "val2": "8K0 615 60B", "val3": "2 片", "val4": "", "val5": "878.40 x", "val6": "343.00", "val7": "343.00" },
    { "val1": "左前雨刮片", "val2": "8K1 955 425 A", "val3": "1.00 件", "val4": "1个,无骨,24,专用接口", "val5": "245.88 x 1", "val6": "25.00", "val7": "270.88" },
    { "val1": "燃油添加剂", "val2": "G 001 770 A2", "val3": "0.09 升", "val4": "0.09升/瓶,清洁", "val5": "94.66 x 1", "val6": "0.00", "val7": "94.66" },
    { "val1": "蓄电池", "val2": "000 915 105 CE", "val3": "1.00 个", "val4": "1个,免维护,12,640,82,58043", "val5": "3016.97 x 1", "val6": "196.00", "val7": "3,212.97" },
    { "val1": "雨刮清洗液", "val2": "LN 052 164 05C08", "val3": "3.00 升", "val4": "1.5升/瓶,否", "val5": "17.31 x 2", "val6": "0.00", "val7": "34.62" }
];

//大众 Golf GTI 2008款 2.0T DCT 3门
var dd1 = [
    { "val1": "制动液", "val2": "B 000750M3", "val3": "2.00 升", "val4": "1升/瓶,DOT-4", "val5": "105.42 x 2", "val6": "384.00", "val7": "594.84" },
    { "val1": "发动机油", "val2": "G 052 545 M4", "val3": "5.00 升", "val4": "5升/瓶,全合成,0W-30,SM", "val5": "640.00 x 1", "val6": "288.00", "val7": "928.00" },
    { "val1": "变速箱油", "val2": "G 052182A2", "val3": "6.00 升", "val4": "1升/瓶", "val5": "288.60 x 8", "val6": "576.00", "val7": "2,884.80" },
    { "val1": "机油滤清器", "val2": "06J 115 403 C", "val3": "1 件", "val4": "", "val5": "130.95 x", "val6": "0.00", "val7": "0.00" },
    { "val1": "火花塞", "val2": "06H 905 611", "val3": "4 个", "val4": "", "val5": "150.79 x", "val6": "576.00", "val7": "576.00" },
    { "val1": "空气滤清器芯", "val2": "06F 133 843 A", "val3": "1 件", "val4": "", "val5": "206.75 x", "val6": "96.00", "val7": "96.00" },
    { "val1": "空调滤清器", "val2": "1K0 819 644 B", "val3": "1 件", "val4": "", "val5": "118.53 x", "val6": "96.00", "val7": "96.00" },
    { "val1": "自动变速箱过滤网", "val2": "02E 305 051 C", "val3": "1 件", "val4": "", "val5": "186.17 x", "val6": "0.00", "val7": "0.00" }
];

var dd2 = [
    { "val1": "前制动片", "val2": "3C0 698 151 C", "val3": "1 副", "val4": "", "val5": "790.05 x", "val6": "384.00", "val7": "384.00" },
    { "val1": "前制动盘", "val2": "1K0 615 301 AA", "val3": "2 片", "val4": "", "val5": "772.20 x", "val6": "576.00", "val7": "576.00" },
    { "val1": "发动机皮带", "val2": "06F 260 849 L", "val3": "1 件", "val4": "", "val5": "233.42 x", "val6": "192.00", "val7": "192.00" },
    { "val1": "发动机防冻液", "val2": "G 012A8GM1", "val3": "3.00 升", "val4": "1升/瓶,-40,红色,否", "val5": "130.00 x 3", "val6": "192.00", "val7": "582.00" },
    { "val1": "右前雨刮片", "val2": "5K1 955 426", "val3": "1.00 件", "val4": "1个,无骨,20,专用接口", "val5": "399.03 x 1", "val6": "0.00", "val7": "399.03" },
    { "val1": "后制动片", "val2": "1K0 698 451 G", "val3": "1 副", "val4": "", "val5": "836.55 x", "val6": "384.00", "val7": "384.00" },
    { "val1": "后制动盘", "val2": "1K0 615 601 AD", "val3": "2 片", "val4": "", "val5": "806.32 x", "val6": "576.00", "val7": "576.00" },
    { "val1": "后雨刮片", "val2": "6Q6 955 425 A", "val3": "1.00 件", "val4": "1个,无骨,12,专用接口", "val5": "82.41 x 1", "val6": "0.00", "val7": "82.41" },
    { "val1": "左前雨刮片", "val2": "5K1 955 425", "val3": "1.00 件", "val4": "1个,无骨,21,专用接口", "val5": "399.03 x 1", "val6": "0.00", "val7": "399.03" },
    { "val1": "正时皮带", "val2": "06D 109 119 B", "val3": "1 件", "val4": "", "val5": "724.00 x", "val6": "2524.00", "val7": "2,524.00" },
    { "val1": "正时皮带张紧轮", "val2": "06D 109 243 B", "val3": "1 件", "val4": "", "val5": "1531.85 x", "val6": "0.00", "val7": "0.00" },
    { "val1": "正时皮带惰轮", "val2": "06B 109 244", "val3": "1 件", "val4": "", "val5": "571.01 x", "val6": "0.00", "val7": "0.00" },
    { "val1": "燃油添加剂", "val2": "G 001770A2", "val3": "0.10 升", "val4": "0.1升/瓶,清洁", "val5": "94.67 x 1", "val6": "0.00", "val7": "94.67" },
    { "val1": "燃油滤清器", "val2": "1K0 201 051 K", "val3": "1 件", "val4": "", "val5": "276.86 x", "val6": "96.00", "val7": "96.00" },
    { "val1": "蓄电池", "val2": "000 915 105 DG", "val3": "1.00 个", "val4": "1个,免维护,12,700,72,072-20", "val5": "2198.16 x 1", "val6": "96.00", "val7": "2,294.16" },
    { "val1": "雨刮清洗液", "val2": "G 052164M2", "val3": "1.00 升", "val4": "1升/瓶,是", "val5": "78.47 x 1", "val6": "0.00", "val7": "78.47" }
];


var tyear = [{
    text: "2013年"
}, {
    text: "2014年"
}, {
    text: "2015年"
}, {
    text: "2016年"
}, {
    text: "2017年"
}, {
    text: "2018年"
}, {
    text: "2019年"
}];
var tmonth = [{
    text: "1月"
}, {
    text: "2月"
}, {
    text: "3月"
}, {
    text: "4月"
}, {
    text: "5月"
}, {
    text: "6月"
}, {
    text: "7月"
}, {
    text: "8月"
}, {
    text: "9月"
}, {
    text: "10月"
}, {
    text: "11月"
}, {
    text: "12月"
}];
var kili = [{
    text: "1万公里"
}, {
    text: "2万公里"
}, {
    text: "3万公里"
}, {
    text: "4万公里"
}, {
    text: "5万公里"
}, {
    text: "6万公里"
}, {
    text: "7万公里"
}, {
    text: "8万公里"
}, {
    text: "9万公里"
}, {
    text: "10万公里"
}, {
    text: "11万公里"
}, {
    text: "12万公里"
}, {
    text: "13万公里"
}, {
    text: "14万公里"
}, {
    text: "15万公里"
}, {
    text: "16万公里"
}, {
    text: "17万公里"
}, {
    text: "18万公里"
}, {
    text: "19万公里"
}, {
    text: "20万公里"
}];




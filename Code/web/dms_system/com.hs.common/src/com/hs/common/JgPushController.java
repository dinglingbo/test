package com.hs.common;

import cn.jiguang.common.ClientConfig;
import cn.jiguang.common.resp.APIConnectionException;
import cn.jiguang.common.resp.APIRequestException;
import cn.jpush.api.JPushClient;
import cn.jpush.api.push.PushResult;
import cn.jpush.api.push.model.Options;
import cn.jpush.api.push.model.Platform;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.notification.AndroidNotification;
import cn.jpush.api.push.model.notification.IosNotification;
import cn.jpush.api.push.model.notification.Notification;




import com.eos.system.annotation.Bizlet;

/**
 * java后台极光推送方式：使用Java SDK
 */
@Bizlet("")
public class JgPushController {
    public static String jgMasterSecret;
    public static String jgAppKey;
    public static boolean jgApnsProduction;

    //private static OMSRemote omsRemote;

    //@Autowired
    //public void setOMSRemote(OMSRemote omsRemote) {
    //    JiguangPushController.omsRemote = omsRemote;
    //}

    //private static final Logger log = LoggerFactory.getLogger(JiguangPushController.class);
    //生产：c478c2699aec473c6eb5d887  8cf7f0614fc2c386e5565152
    //测试：bbef39eca55336ad83e1e3ed  95135fcf0f74e787f3ac7521
//    private static String jgMasterSecret = "c478c2699aec473c6eb5d887";
//    private static String jgAppKey = "8cf7f0614fc2c386e5565152";
//
//        private static String jgMasterSecret = "bbef39eca55336ad83e1e3ed";
//    private static String jgAppKey = "95135fcf0f74e787f3ac7521";
//    private static boolean jgApnsProduction = true;

//    /**
//	 * 极光推送
//	 */
//	public static void main(String[] args) {
//		String tag = "MEM20170417000005";//声明别名
//		log.info("对技师" + tag + "的用户推送信息");
//		PushResult result = push(String.valueOf(tag),"sdhrtj");
//		if(result != null && result.isResultOK()){
//			log.info("针对技师" + tag + "的信息推送成功！");
//		}else{
//			log.info("针对技师" + tag + "的信息推送失败！");
//		}
//	}

    public static void pushMessageByJiGuang(String tag, String message) {
    	System.out.println(tag +":"+message+ "的推送信息");
        PushResult result = push(tag,message);
        if(result != null && result.isResultOK()){
        	System.out.println(tag +message+ "的信息推送成功！");
        }else{
        	System.out.println(tag +message+ "的信息推送失败！");
            System.out.println(result.toString());
        }
        //插入数据到数据库
    }

//    public static void pushMessageByJiGuang(JiguangMesRecordDTO message) {
//    	System.out.println(message+ "的推送信息");
//        if(!DataUtil.isEmpty(message)&&!DataUtil.isEmpty(message.getToUserId())&&!DataUtil.isEmpty(message.getContent())) {
//            PushResult result = push(message.getToUserId(), message.getContent());
//            if (result != null && result.isResultOK()) {
//            	System.out.println( message + "的信息推送成功！");
//                message.setPushedSt(1);
//            } else {
//            	System.out.println( message + "的信息推送失败！");
//                message.setPushedSt(2);
//            }
//        }
//        //插入数据到数据库
//        //omsRemote.saveJiguangMessageRecord(BeanUtils.copyProperties(message, JiguangMessageRecordDTO.class));
//    }

    public static void pushMessageByJiGuang(String message) {
    	System.out.println(message+ "的推送信息");
        //if(!DataUtil.isEmpty(message)&&!DataUtil.isEmpty(message.getToUserId())&&!DataUtil.isEmpty(message.getContent())) {
            PushResult result = push("112", message);
            if (result != null && result.isResultOK()) {
            	System.out.println( message + "的信息推送成功！");
                //message.setPushedSt(1);
            } else {
            	System.out.println( message + "的信息推送失败！");
                //message.setPushedSt(2);
            }
        //}
        //插入数据到数据库
        //omsRemote.saveJiguangMessageRecord(BeanUtils.copyProperties(message, JiguangMessageRecordDTO.class));
    }
    /**
     * 生成极光推送对象PushPayload（采用java SDK）
     * @param tag
     * @param message
     * @return PushPayload
     */
    public static PushPayload buildPushObject_android_tag_message(String tag, String message){
        return PushPayload.newBuilder()
                .setPlatform(Platform.android())
                .setAudience(Audience.tag(tag))
//                .setAudience(Audience.alias((jgApnsProduction)?"":""))
                .setNotification(Notification.alert(message))
                //.setNotification(Notification.newBuilder()
                //        .addPlatformNotification(AndroidNotification.newBuilder()
               //                 .addExtra("type", "infomation")
               //                 .setAlert(message)
                //                .build())
               //         .build())
                .setOptions(Options.newBuilder()
                        .setApnsProduction(jgApnsProduction)//true-推送生产环境 false-推送开发环境（测试使用参数）
                        .setTimeToLive(90)//消息在JPush服务器的失效时间（测试使用参数）
                        .build())
                .build();
    }
    
    public static PushPayload buildPushObject_all_title_alias_alert(String tile, String alias, String message) {
        return PushPayload.newBuilder()
                .setPlatform(Platform.all())
                .setAudience(Audience.alias(alias))
                //.setNotification(Notification.alert(message))
                .setNotification(Notification.newBuilder()
	               .addPlatformNotification(AndroidNotification.newBuilder()
	                        .addExtra("type",tile)
	                        .setAlert(message)
	                        .build())
	               .addPlatformNotification(IosNotification.newBuilder()
	                        .addExtra("type",tile)
	                        .setAlert(message)
                            .setSound("happy")
	                        .build())
	                .build())
                .setOptions(Options.newBuilder()
                		.setApnsProduction(false)
                		.setTimeToLive(90)
                		.build())
                .build();
    }
    
    public static PushPayload buildPushObject_all_alias_alert(String alias, String message) {
        return PushPayload.newBuilder()
                .setPlatform(Platform.all())
                .setAudience(Audience.alias(alias))
                .setNotification(Notification.alert(message))
                .setOptions(Options.newBuilder()
                		.setApnsProduction(false)
                		.setTimeToLive(90)
                		.build())
                .build();
    }

    /**
     * 极光推送方法(采用java SDK)
     * @param tag
     * @param message
     * @return PushResult
     */
    @Bizlet("")
    public static PushResult push(String userId,String message){
        ClientConfig clientConfig = ClientConfig.getInstance();
        //洗美  "f54213bf24f3ce7e32bb3f6b", "cb4e8779dcdacc44d3bee944"
        //车道  AppKey 25759c5a258bdee3096097fa  Master Secret 080a425fd00b1aa376b27637 
        JPushClient jpushClient = new JPushClient("080a425fd00b1aa376b27637", "25759c5a258bdee3096097fa", null, clientConfig);
        //PushPayload payload = buildPushObject_android_tag_message(tag,message);
        PushPayload payload = buildPushObject_all_alias_alert(userId,message);
        try {
            return jpushClient.sendPush(payload);
        } catch (APIConnectionException e) {
            System.out.println("Connection error. Should retry later. ");
            return null;
        } catch (APIRequestException e) {
        	System.out.println("Error response from JPush server. Should review and fix it. ");
        	System.out.println("HTTP Status: " + e.getStatus());
        	System.out.println("Error Code: " + e.getErrorCode());
        	System.out.println("Error Message: " + e.getErrorMessage());
        	System.out.println("Msg ID: " + e.getMsgId());
            return null;
        }
    }
    

    public static PushPayload buildPushObject_all_all_alert(String message) {
        return PushPayload.alertAll(message);
    }
    
    @Bizlet("")
    public static PushResult pushByTitle(String title, String userId, String message){
        ClientConfig clientConfig = ClientConfig.getInstance();
        JPushClient jpushClient = new JPushClient("080a425fd00b1aa376b27637", "25759c5a258bdee3096097fa", null, clientConfig);
        //PushPayload payload = buildPushObject_android_tag_message(tag,message);
        PushPayload payload = buildPushObject_all_title_alias_alert(title, userId, message);
        try {
            return jpushClient.sendPush(payload);
        } catch (APIConnectionException e) {
            System.out.println("Connection error. Should retry later. ");
            return null;
        } catch (APIRequestException e) {
        	System.out.println("Error response from JPush server. Should review and fix it. ");
        	System.out.println("HTTP Status: " + e.getStatus());
        	System.out.println("Error Code: " + e.getErrorCode());
        	System.out.println("Error Message: " + e.getErrorMessage());
        	System.out.println("Msg ID: " + e.getMsgId());
            return null;
        }
    }
}
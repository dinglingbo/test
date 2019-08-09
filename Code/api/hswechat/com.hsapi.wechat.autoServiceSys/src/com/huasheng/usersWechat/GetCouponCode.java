package com.huasheng.usersWechat;

import java.util.Random;

import com.eos.system.annotation.Bizlet;
@Bizlet("")
public class GetCouponCode {
	
	/**
	 * 获得优惠劵的编码
	 * @param couponId
	 * @param couponType
	 * @param isCarUse
	 * @param isStoreUse
	 * @param isTenantUse
	 * @param dataTimeString
	 * @return
	 */
	@Bizlet("")
	public String getCouponCode(int couponId , String couponType , int isCarUse,int isStoreUse,int isTenantUse, String dataTimeString){
		return getRandomStr(5)+dataTimeString+couponId+couponType+isCarUse+isStoreUse+isTenantUse;
	}
	
	@Bizlet("")
	public String getCouponUserCode(String dataTimeString){
		return getRandomStr(5)+dataTimeString+getRandomNumber(5);
	}
	
	@Bizlet("")
	public String getUserOrderCode(String dataTimeString){
		return getRandomStr(3)+dataTimeString+getRandomNumber(2);
	}
	
	public static String getRandomNumber(int length) {
        String base = "1234567890";
        int randomNum;
        char randomChar;
        Random random = new Random();
        // StringBuffer类型的可以append增加字符
        StringBuffer str = new StringBuffer();
 
        for (int i = 0; i < length; i++) {
            // 可生成[0,n)之间的整数，获得随机位置
            randomNum = random.nextInt(base.length());
            // 获得随机位置对应的字符
            randomChar = base.charAt(randomNum);
            // 组成一个随机字符串
            str.append(randomChar);
        }
        return str.toString();
    }
	
	 public static String getRandomStr(int length) {
	        String base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	        int randomNum;
	        char randomChar;
	        Random random = new Random();
	        // StringBuffer类型的可以append增加字符
	        StringBuffer str = new StringBuffer();
	 
	        for (int i = 0; i < length; i++) {
	            // 可生成[0,n)之间的整数，获得随机位置
	            randomNum = random.nextInt(base.length());
	            // 获得随机位置对应的字符
	            randomChar = base.charAt(randomNum);
	            // 组成一个随机字符串
	            str.append(randomChar);
	        }
	        return str.toString();
	    }
	 
	    /*public static void main(String[] args) {
	        // TODO Auto-generated method stub
	        System.out.println(getRandomStr(5));
	    }*/
	    
}

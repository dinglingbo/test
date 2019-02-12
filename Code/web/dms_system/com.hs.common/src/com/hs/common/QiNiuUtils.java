/**
 * 
 */
package com.hs.common;

import com.eos.system.annotation.Bizlet;
import com.qiniu.util.Auth;

/** 
 * @author 作者 ding: 
 * @version 创建时间：2019年1月31日 下午3:36:34 
 * 类说明 
 */
/**
 * @author Administrator
 * @date 2019-01-31 15:36:34
 *
 */
@Bizlet("")
public class QiNiuUtils {
	@Bizlet("")
	public static String uploadToken() {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "QNACCESSKEY", "serverType");
		String accessKey = Env.getContributionConfig("com.vplus.login",
				"cfg", "QNACCESSKEY", envType);

		String secretKey = Env.getContributionConfig("com.vplus.login",
				"cfg", "QNSECRETKEY", envType);

		String bucketName = Env.getContributionConfig("com.vplus.login",
				"cfg", "QNBUCKETNAME", envType);

		Auth auth = Auth.create(accessKey, secretKey);
		String upToken = auth.uploadToken(bucketName);
		System.out.println(upToken);
		
		return upToken;

	}
}

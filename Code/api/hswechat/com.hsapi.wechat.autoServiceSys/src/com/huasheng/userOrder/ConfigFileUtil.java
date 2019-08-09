package com.huasheng.userOrder;



import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;

import com.eos.infra.config.Configuration;
import com.eos.runtime.core.ApplicationContext;

public class ConfigFileUtil {
	/**
	 * 获取配置文件对象
	 * 
	 * @param path
	 *            配置文件路径
	 * @return
	 */
	public static Configuration getConfigFile(String path) {
		// WEB-INF/AS400IpFile/AS400-ip-config.xml
		String configPath;
		Configuration ipConfig;
		try {
			configPath = ApplicationContext.getInstance().getWarRealPath()
					+ path;
			ipConfig = Configuration.initConfiguration(configPath);
		} catch (Exception e) {
			ipConfig = null;
		}
		return ipConfig;
	}

	public static String txt2String(File file) {
		String result = "";
		try {
			InputStreamReader read = new InputStreamReader(new FileInputStream(file),"UTF-8");       
            BufferedReader br=new BufferedReader(read);   
			String s = null;
			while ((s = br.readLine()) != null) {// 使用readLine方法，一次读一行
				result = result + s;
			}
			br.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public static void main(String[] args) {
		File file = new File("D:/test.txt");
		System.out.println(txt2String(file));
	}
}


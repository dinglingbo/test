package com.hs.common;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.UnsupportedEncodingException;

import com.eos.system.annotation.Bizlet;

@Bizlet("Serialize工具类")
public class SerializeUtil {
	public final static String CHARSET_ISO88591 = "iso-8859-1";

	// public final static String CHARSET_UTF8 = "utf8";
	// //utf8、utf-8、UTF-8测试均未成功
	// public final static String CHARSET_UTF8 = "UTF-8";

	public static String serialize(Object original) {
		if (null == original)
			return null;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ObjectOutputStream oos;
		try {
			oos = new ObjectOutputStream(baos);
			oos.writeObject(original);
			byte[] str = baos.toByteArray();
			oos.close();
			baos.close();
			return new String(str, CHARSET_ISO88591);
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * @Title: deserialize
	 * @Description: 序列化的String对象的反序列化<br>
	 *               需要自己进行强制转换得到最终类型<br>
	 *               eg:<br>
	 *               Map newmap =
	 *               (Map)SerializeUtil.deserialize(serializedMapStr);
	 * @param serializedstr
	 *            经序列化处理过的信息
	 * @return Object 反序列化后生成的Object。<br>
	 * @throws IOException
	 * @throws UnsupportedEncodingException
	 * @throws ClassNotFoundException
	 * 
	 * 
	 */
	public static Object deserialize(String serializedstr) {
		if (null == serializedstr)
			return null;
		BufferedInputStream bis;
		try {
			bis = new BufferedInputStream(new ByteArrayInputStream(
					serializedstr.getBytes(CHARSET_ISO88591)));
			ObjectInputStream ois = new ObjectInputStream(bis);
			Object obj = ois.readObject();
			ois.close();
			bis.close();
			return obj;
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			return null;
		}
	}

	public static byte[] objectToByteArray(Object original) {
		if (null == original)
			return null;

		ByteArrayOutputStream bout = new ByteArrayOutputStream();
		ObjectOutputStream oout;
		try {
			oout = new ObjectOutputStream(bout);
			oout.writeObject(original);
			return bout.toByteArray();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public static Object byteArrayToObject(byte[] bytearry) {
		if (bytearry.length == 0)
			return null;
		try {
			return new ObjectInputStream(new ByteArrayInputStream(bytearry))
					.readObject();
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 序列化并压缩
	 * 
	 * @param object
	 * @return
	 */
	@Bizlet("")
	public static String serialize2GzipStr(Object object) {
		byte[] aa = objectToByteArray(object);
		try {
			return new String(GZipUtils.compress(aa),
					SerializeUtil.CHARSET_ISO88591);
		} catch (UnsupportedEncodingException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 反序列化
	 * 
	 * @param param
	 * @return
	 */
	@Bizlet("")
	public static Object unserialize(String param) {
		return byteArrayToObject(param.getBytes());
	}

	/**
	 * 解压并反序列化
	 * 
	 * @param param
	 * @return
	 */
	@Bizlet("")
	public static Object decompressUnserialize(String param) {
		byte[] xx = null;
		try {
			xx = param.getBytes(SerializeUtil.CHARSET_ISO88591);
		} catch (UnsupportedEncodingException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return byteArrayToObject(GZipUtils.decompress(xx));
	}

}

package com.hs.common;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

import com.eos.system.annotation.Bizlet;

/**
 * GZIP工具
 * 
 */
@Bizlet("GZIP工具类")
public abstract class GZipUtils {

	public static final int BUFFER = 1024;
	public static final String EXT = ".gz";

	/**
	 * 数据压缩
	 * 
	 * @param data
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	public static byte[] compress(byte[] data) {
		ByteArrayInputStream bais = new ByteArrayInputStream(data);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();

		// 压缩
		compress(bais, baos);

		byte[] output = baos.toByteArray();

		try {
			baos.flush();
			baos.close();

			bais.close();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}

		return output;
	}

	/**
	 * 文件压缩
	 * 
	 * @param file
	 * @throws Exception
	 */
	public static void compress(File file) {
		compress(file, true);
	}

	/**
	 * 文件压缩
	 * 
	 * @param file
	 * @param delete
	 *            是否删除原始文件
	 * @throws Exception
	 */
	public static void compress(File file, boolean delete) {
		FileInputStream fis;
		try {
			fis = new FileInputStream(file);

			FileOutputStream fos = new FileOutputStream(file.getPath() + EXT);

			compress(fis, fos);

			fis.close();
			fos.flush();
			fos.close();

			if (delete) {
				file.delete();
			}
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}

	/**
	 * 数据压缩
	 * 
	 * @param is
	 * @param os
	 * @throws IOException
	 * @throws Exception
	 */
	public static void compress(InputStream is, OutputStream os) {

		GZIPOutputStream gos;
		try {
			gos = new GZIPOutputStream(os);

			int count;
			byte data[] = new byte[BUFFER];
			while ((count = is.read(data, 0, BUFFER)) != -1) {
				gos.write(data, 0, count);
			}

			gos.finish();

			gos.flush();
			gos.close();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}

	/**
	 * 文件压缩
	 * 
	 * @param path
	 * @throws Exception
	 */
	public static void compress(String path) {
		compress(path, true);
	}

	/**
	 * 文件压缩
	 * 
	 * @param path
	 * @param delete
	 *            是否删除原始文件
	 * @throws Exception
	 */
	public static void compress(String path, boolean delete) {
		File file = new File(path);
		compress(file, delete);
	}

	/**
	 * 数据解压缩
	 * 
	 * @param data
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	public static byte[] decompress(byte[] data) {
		ByteArrayInputStream bais = new ByteArrayInputStream(data);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();

		// 解压缩

		decompress(bais, baos);

		data = baos.toByteArray();

		try {
			baos.flush();
			baos.close();

			bais.close();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}

		return data;
	}

	/**
	 * 文件解压缩
	 * 
	 * @param file
	 * @throws Exception
	 */
	public static void decompress(File file) {
		decompress(file, true);
	}

	/**
	 * 文件解压缩
	 * 
	 * @param file
	 * @param delete
	 *            是否删除原始文件
	 * @throws Exception
	 */
	public static void decompress(File file, boolean delete) {
		FileInputStream fis;
		try {
			fis = new FileInputStream(file);

			FileOutputStream fos = new FileOutputStream(file.getPath().replace(
					EXT, ""));
			decompress(fis, fos);
			fis.close();
			fos.flush();
			fos.close();

			if (delete) {
				file.delete();
			}
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}

	/**
	 * 数据解压缩
	 * 
	 * @param is
	 * @param os
	 * @throws IOException
	 * @throws Exception
	 */
	public static void decompress(InputStream is, OutputStream os) {

		GZIPInputStream gis;
		try {
			gis = new GZIPInputStream(is);

			int count;
			byte data[] = new byte[BUFFER];
			while ((count = gis.read(data, 0, BUFFER)) != -1) {
				os.write(data, 0, count);
			}

			gis.close();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}

	/**
	 * 文件解压缩
	 * 
	 * @param path
	 * @throws Exception
	 */
	public static void decompress(String path) {
		decompress(path, true);
	}

	/**
	 * 文件解压缩
	 * 
	 * @param path
	 * @param delete
	 *            是否删除原始文件
	 * @throws Exception
	 */
	public static void decompress(String path, boolean delete) {
		File file = new File(path);
		decompress(file, delete);
	}

}

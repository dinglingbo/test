package com.hs.common;

import org.apache.commons.io.IOUtils;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * @author Guine 新类2018
 * 
 */
public class MyResettableServletRequest extends HttpServletRequestWrapper {
	// 保存流中的数据
	private byte[] data;

	public MyResettableServletRequest(HttpServletRequest request)
			{
		super(request);
		// 从流中获取数据
		try {
			data = IOUtils.toByteArray(request.getInputStream());
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			//data=null;
		}
	}

	public ServletInputStream getInputStream() {
		// 在调用getInputStream函数时，创建新的流，包含原先数据流中的信息，然后返回
		return new MyServletInputStream(new ByteArrayInputStream(data));
	}

	class MyServletInputStream extends ServletInputStream {
		private InputStream inputStream;

		public MyServletInputStream(InputStream inputStream) {
			this.inputStream = inputStream;
		}

		@Override
		public int read() throws IOException {
			return inputStream.read();
		}
	}
}
/**
 * 
 */
package com.hs.common;

import java.awt.BasicStroke;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Shape;
import java.awt.geom.RoundRectangle2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;

import com.eos.system.annotation.Bizlet;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.Binarizer;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.EncodeHintType;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.NotFoundException;
import com.google.zxing.Result;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import com.hs.common.BufferedImageLuminanceSource;

/**
 * @author Administrator
 * @date 2019-07-08 14:12:59
 *
 */
@Bizlet("二维码生成和解析")
public class QRCodeUtil {
	
	//二维码颜色  
    private static final int BLACK = 0xFF000000;  
    //二维码颜色  
    private static final int WHITE = 0xFFFFFFFF;
    
    private static final String CHARSET = "utf-8";
    private static final String FORMAT_NAME = "JPG";
    // 二维码尺寸
    private static final int QRCODE_SIZE = 300;
    // LOGO宽度
    private static final int WIDTH = 60;
    // LOGO高度
    private static final int HEIGHT = 60;

	 /**  生成七牛二维码
     * @param text    二维码内容
     * @param width    二维码宽
     * @param height    二维码高
     * @param outPutPath    二维码生成保存路径
     * @param imageType     二维码生成格式
     */
	@Bizlet("生成七牛二维码")
    public static String zxingCodeCreate(String text, int width, int height){
        Map<EncodeHintType, String> his = new HashMap<EncodeHintType, String>();
        //设置编码字符集
        his.put(EncodeHintType.CHARACTER_SET, "utf-8");
        try {
            //1、生成二维码
            BitMatrix encode = new MultiFormatWriter().encode(text, BarcodeFormat.QR_CODE, width, height, his);
            //2、获取二维码宽高
            int codeWidth = encode.getWidth();
            int codeHeight = encode.getHeight();
            //3、将二维码放入缓冲流
            BufferedImage image = new BufferedImage(codeWidth, codeHeight, BufferedImage.TYPE_INT_RGB);
            for (int i = 0; i < codeWidth; i++) {
                for (int j = 0; j < codeHeight; j++) {
                    //4、循环将二维码内容定入图片
                    image.setRGB(i, j, encode.get(i, j) ?BLACK : WHITE);
                }
            }
            // 自定义内容
            ByteArrayOutputStream os = new ByteArrayOutputStream();
            ImageIO.write(image, "jpg", os);
            InputStream is = new ByteArrayInputStream(os.toByteArray());
            String key = "PartEnterQRCode";//批次库存二维码前缀
        	String str = UUID.randomUUID().toString().replaceAll("\\-", "");
        	key = key + str;
            Map<String,Object> retMap = QiNiuUtils.uploadByParams(is,key);          
            String path =  retMap.get("url").toString();
            System.out.println(path);
            //返回生成的二维码七牛路径
            return path;
            /*//存储到本地
            File outPutImage = new File(outPutPath);
            if(!outPutImage.exists())
            	//outPutImage.createNewFile();
            //5、将二维码写入图片
            ImageIO.write(image, imageType, outPutImage);  */
        } catch (WriterException e) {
            e.printStackTrace();
            System.out.println("二维码生成失败");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("生成二维码图片失败");
        }
        return null;
    }
	
	/**
     * 解析二维码
     * @param analyzePath
     * @return
     * @throws Exception
     */
	@Bizlet("解析二维码")
    public static String zxingCodeAnalyze(String analyzePath) throws Exception{
        BufferedImage image ;
        MultiFormatReader formatReader = new MultiFormatReader();
        String resultStr = null;
        try {
            File file = new File(analyzePath);
            //本地路径不存在，判断解析网络图片
            if (!file.exists())
            {
                InputStream  is =getImageStream(analyzePath);
                image = ImageIO.read(is);
            }
            //本地图片
            else {
                image = ImageIO.read(file);
            }
            LuminanceSource source = new BufferedImageLuminanceSource(image);
            Binarizer binarizer = new HybridBinarizer(source);
            BinaryBitmap binaryBitmap = new BinaryBitmap(binarizer);
            Map hints = new HashMap();
            hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
            Result result = formatReader.decode(binaryBitmap, hints);
            resultStr = result.getText();
        } catch (NotFoundException e) {
            e.printStackTrace();
        } catch (IOException e){
            e.printStackTrace();
        }
        System.out.println(resultStr);
        return resultStr;
    }
	
	
	@Bizlet("将网络图片转化为输入流")
  	public static InputStream getImageStream(String url) {
        try {
            HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
            connection.setReadTimeout(5000);
            connection.setConnectTimeout(5000);
            connection.setRequestMethod("GET");
            if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                InputStream inputStream = connection.getInputStream();
                return inputStream;
            }
        } catch (IOException e) {
            System.out.println("获取网络图片出现异常，图片路径为：" + url);
            e.printStackTrace();
        }
        return null;
    }
	
	private static String insertImage(BufferedImage source, String imgPath, boolean needCompress) throws Exception {
        Image src;
        String path = "";
        try {
            File file = new File(imgPath);
            //网络图片
            if (!file.exists()) {
                InputStream is = getImageStream(imgPath);
                src = ImageIO.read(is);

            }
            //本地图片
            else {
                src = ImageIO.read(file);

            }
            int width = src.getWidth(null);
            int height = src.getHeight(null);
            if (needCompress) { // 压缩LOGO
                if (width > WIDTH) {
                    width = WIDTH;
                }
                if (height > HEIGHT) {
                    height = HEIGHT;
                }
                Image image = src.getScaledInstance(width, height, Image.SCALE_SMOOTH);
                BufferedImage tag = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
                Graphics g = tag.getGraphics();
                g.drawImage(image, 0, 0, null); // 绘制缩小后的图
                g.dispose();
                src =  image;
            }
            // 插入LOGO
            Graphics2D graph = source.createGraphics();
            int x = (QRCODE_SIZE - width) / 2;
            int y = (QRCODE_SIZE - height) / 2;
            graph.drawImage(src, x, y, width, height, null);
            Shape shape = new RoundRectangle2D.Float(x, y, width, width, 6, 6);
            graph.setStroke(new BasicStroke(3f));
            graph.draw(shape);
            graph.dispose();      
            // 自定义内容
            ByteArrayOutputStream os = new ByteArrayOutputStream();
            ImageIO.write(source, "jpg", os);
            InputStream is = new ByteArrayInputStream(os.toByteArray());
            Map<String, Object> retMap = QiNiuUtils.upload(is);
            path = retMap.get("url").toString();
            return path;
           
        }catch (IOException e){
            e.printStackTrace();
            System.out.println("生成二维码图片失败");
        }catch (Exception e){
            e.printStackTrace();
        }
        return  null;
    }
	 
	@Bizlet("生成带logo的二维码")
	public static String createQRCodeWithLogo(String logoPath,String text){
        Map<EncodeHintType, String> his = new HashMap<EncodeHintType, String>();
        //设置编码字符集
        his.put(EncodeHintType.CHARACTER_SET, "utf-8");
        his.put(EncodeHintType.ERROR_CORRECTION, String.valueOf(ErrorCorrectionLevel.H));

        try {
            //1、生成二维码
            BitMatrix encode = new MultiFormatWriter().encode(text, BarcodeFormat.QR_CODE, QRCODE_SIZE, QRCODE_SIZE, his);
            //2、获取二维码宽高
            int codeWidth = encode.getWidth();
            int codeHeight = encode.getHeight();
            //3、将二维码放入缓冲流
            BufferedImage image = new BufferedImage(codeWidth, codeHeight, BufferedImage.TYPE_INT_RGB);
            for (int i = 0; i < codeWidth; i++) {
                for (int j = 0; j < codeHeight; j++) {
                    //4、循环将二维码内容定入图片
                    image.setRGB(i, j, encode.get(i, j) ? 0xFF000000 : 0xFFFFFFFF);
                }
            }
            // 自定义内容
            ByteArrayOutputStream os = new ByteArrayOutputStream();
            ImageIO.write(image, "jpg", os);
            InputStream is = new ByteArrayInputStream(os.toByteArray());
            Map<String,Object> retMap = QiNiuUtils.upload(is);
            //二维码插入图片
            String path =QRCodeUtil.insertImage(image, logoPath, true);
            return  path;

        } catch (WriterException e) {
            e.printStackTrace();
            System.out.println("二维码生成失败");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("生成二维码图片失败");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
	
	public static void main(String[] args) throws Exception {
	    // 存放在二维码中的内容
	    String text = "我是小铭";
	    //生成二维码
	    String  path = QRCodeUtil.zxingCodeCreate(text,150,150);
	    // 解析二维码	
		String str = QRCodeUtil.zxingCodeAnalyze(path);
	    // 打印出解析出的内容
	    System.out.println(str);
	    
	    String destPath = "C:/Users/Administrator/Desktop/icon.jpg";
        String urlpath = QRCodeUtil.createQRCodeWithLogo(destPath,text);
        String str2 = QRCodeUtil.zxingCodeAnalyze(path);
        System.out.println(str2);
	
	}
}

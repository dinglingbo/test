/**
 * 
 */
package com.hs.common;


import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.Stroke;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;

import com.eos.system.annotation.Bizlet;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.oned.Code128Writer;
import com.harsons.hscp.common.util.StringUtils;

/**
 * @author Administrator
 * @date 2019-07-08 16:19:35
 *
 */
@Bizlet("条形码生成")
public class GoogleBarCodeUtils {

	 /** 条形码宽度 */
    private static final int WIDTH = 300;

    /** 条形码高度 */
    private static final int HEIGHT = 50;

    /** 加文字 条形码 */
    private static final int WORDHEIGHT = 75;
    /**
     * 设置 条形码参数
     */
    private static HashMap<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>() {
        private static final long serialVersionUID = 1L;
        {
            // 设置编码方式
            put(EncodeHintType.CHARACTER_SET, "utf-8");
        }
    };
    /**
     * 生成 图片缓冲
     * @author fxbin
     * @param vaNumber  VA 码
     * @return 返回BufferedImage
     */
    @Bizlet("生成 图片缓冲")
    public static BufferedImage getBarCode(String vaNumber){
        try {
            Code128Writer writer = new Code128Writer();
            // 编码内容, 编码类型, 宽度, 高度, 设置参数
            BitMatrix bitMatrix = writer.encode(vaNumber, BarcodeFormat.CODE_128, WIDTH, HEIGHT, hints);
            return MatrixToImageWriter.toBufferedImage(bitMatrix);
        } catch (WriterException e) {
            e.printStackTrace();
        }
        return null;
    }
    /**
     * 把带logo的二维码下面加上文字
     * @author fxbin
     * @param image  条形码图片
     * @param words  文字
     * @return 返回BufferedImage
     */
    @Bizlet("把带logo的二维码下面加上文字")
    public static BufferedImage insertWords(BufferedImage image, String words){
        // 新的图片，把带logo的二维码下面加上文字
        if (!StringUtils.isEmpty(words)) {

            BufferedImage outImage = new BufferedImage(WIDTH, WORDHEIGHT, BufferedImage.TYPE_INT_RGB);

            Graphics2D g2d = outImage.createGraphics();

            // 抗锯齿
            setGraphics2D(g2d);
            // 设置白色
            setColorWhite(g2d);

            // 画条形码到新的面板
            g2d.drawImage(image, 0, 0, image.getWidth(), image.getHeight(), null);
            // 画文字到新的面板
            Color color=new Color(0, 0, 0);
            g2d.setColor(color);
            // 字体、字型、字号
            g2d.setFont(new Font("微软雅黑", Font.PLAIN, 18));
            //文字长度
            int strWidth = g2d.getFontMetrics().stringWidth(words);
            //总长度减去文字长度的一半  （居中显示）
            int wordStartX=(WIDTH - strWidth) / 2;
            //height + (outImage.getHeight() - height) / 2 + 12
            int wordStartY=HEIGHT+20;

            // 画文字
            g2d.drawString(words, wordStartX, wordStartY);
            g2d.dispose();
            outImage.flush();
            return outImage;
        }
        return null;
    }

    /**
     * 设置 Graphics2D 属性  （抗锯齿）
     * @param g2d  Graphics2D提供对几何形状、坐标转换、颜色管理和文本布局更为复杂的控制
     */
    private static void setGraphics2D(Graphics2D g2d){
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g2d.setRenderingHint(RenderingHints.KEY_STROKE_CONTROL, RenderingHints.VALUE_STROKE_DEFAULT);
        Stroke s = new BasicStroke(1, BasicStroke.CAP_ROUND, BasicStroke.JOIN_MITER);
        g2d.setStroke(s);
    }

    /**
     * 设置背景为白色
     * @param g2d Graphics2D提供对几何形状、坐标转换、颜色管理和文本布局更为复杂的控制
     */
    private static void setColorWhite(Graphics2D g2d){
        g2d.setColor(Color.WHITE);
        //填充整个屏幕
        g2d.fillRect(0,0,600,600);
        //设置笔刷
        g2d.setColor(Color.BLACK);
    }

    /**
     * 生成 七牛图片(底下无字)
     * @param vaNumber
     * @param width
     * @param height
     * @return
     */
    @Bizlet("生成 七牛条码图片(底下无字)")
    public  static String createBarCode(String vaNumber, int width, int height){
        try {
            Code128Writer writer = new Code128Writer();
            // 编码内容, 编码类型, 宽度, 高度, 设置参数
            BitMatrix bitMatrix = writer.encode(vaNumber, BarcodeFormat.CODE_128, width, height, hints);
            BufferedImage image  =MatrixToImageWriter.toBufferedImage(bitMatrix);
            ByteArrayOutputStream os = new ByteArrayOutputStream();
            ImageIO.write(image, "jpg", os);
            InputStream is = new ByteArrayInputStream(os.toByteArray());
            Map<String,Object> retMap = QiNiuUtils.upload(is);
            String path =  retMap.get("url").toString();
            System.out.println(path);
            //返回生成的二维码七牛路径
            return path;

        } catch (WriterException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 生成 七牛图片(底下有字)
     * @param image
     * @param words
     * @return
     * @throws IOException
     */
    @Bizlet("生成 七牛图片(底下有字)")
    public static String addWords(BufferedImage image, String words) throws IOException {
        // 新的图片，把带logo的二维码下面加上文字
        if (!StringUtils.isEmpty(words)) {

            BufferedImage outImage = new BufferedImage(WIDTH, WORDHEIGHT, BufferedImage.TYPE_INT_RGB);

            Graphics2D g2d = outImage.createGraphics();

            // 抗锯齿
            setGraphics2D(g2d);
            // 设置白色
            setColorWhite(g2d);

            // 画条形码到新的面板
            g2d.drawImage(image, 0, 0, image.getWidth(), image.getHeight(), null);
            // 画文字到新的面板
            Color color=new Color(0, 0, 0);
            g2d.setColor(color);
            // 字体、字型、字号
            g2d.setFont(new Font("微软雅黑", Font.PLAIN, 18));
            //文字长度
            int strWidth = g2d.getFontMetrics().stringWidth(words);
            //总长度减去文字长度的一半  （居中显示）
            int wordStartX=(WIDTH - strWidth) / 2;
            //height + (outImage.getHeight() - height) / 2 + 12
            int wordStartY=HEIGHT+20;

            // 画文字
            g2d.drawString(words, wordStartX, wordStartY);
            g2d.dispose();
            outImage.flush();
            try {
                ByteArrayOutputStream os = new ByteArrayOutputStream();
                ImageIO.write(outImage, "jpg", os);
                InputStream is = new ByteArrayInputStream(os.toByteArray());
                Map<String,Object> retMap = QiNiuUtils.upload(is);
                String path =  retMap.get("url").toString();
                System.out.println(path);
                //返回生成的二维码七牛路径
                return  path;
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
        return null;
    }
    public static void main(String[] args) throws Exception {
//        BufferedImage image = insertWords(getBarCode("123456789"), "123456789");
//        A80/90R8A(8A侧通孔)
//        BufferedImage image = insertWords(getBarCode("A80/90R8A8A"), "A80/90R8A(8A侧通孔)");
//        ImageIO.write(image, "jpg", new File("D:/barcode.png"));
//          craeteBarCode("A80/90R8A8A",300,50);
         String path =addWords(getBarCode("A80/90R8A8A"), "A80/90R8A(8A侧通孔)");
         //解析条形码内容
         QRCodeUtil.zxingCodeAnalyze(path);
    }
}

/**
 ***************************************************************************************
 *  @Author     1044053532@qq.com   
 *  @License    http://www.apache.org/licenses/LICENSE-2.0
 ***************************************************************************************
 */
package com.chedao.websocket.server;

import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.server.connertor.impl.ImConnertorImpl;
import com.chedao.websocket.server.exception.InitErrorException;
import com.chedao.websocket.server.model.proto.MessageProto;
import com.chedao.websocket.server.proxy.MessageProxy;
import com.chedao.websocket.server.connertor.impl.ImConnertorImpl;
import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.*;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import io.netty.handler.codec.protobuf.ProtobufDecoder;
import io.netty.handler.codec.protobuf.ProtobufEncoder;
import io.netty.handler.codec.protobuf.ProtobufVarint32FrameDecoder;
import io.netty.handler.codec.protobuf.ProtobufVarint32LengthFieldPrepender;
import io.netty.handler.timeout.IdleStateHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

@Service("imServer")
public class ImServer  {

    private final static Logger log = LoggerFactory.getLogger(ImServer.class);
    
    private ProtobufDecoder decoder = new ProtobufDecoder(MessageProto.Model.getDefaultInstance());
    private ProtobufEncoder encoder = new ProtobufEncoder();

    @Autowired
    private MessageProxy proxy;
    @Autowired
    private ImConnertorImpl connertor;
    @Value("${imServer.port}")
    private int port;
 
    private final EventLoopGroup bossGroup = new NioEventLoopGroup();
    private final EventLoopGroup workerGroup = new NioEventLoopGroup();
    private Channel channel;

    @PostConstruct
    public void init() throws Exception {
        log.info("start im server ...");

        // Server 服务启动
        ServerBootstrap bootstrap = new ServerBootstrap();

        bootstrap.group(bossGroup, workerGroup);
        bootstrap.channel(NioServerSocketChannel.class);
        bootstrap.childHandler(new ChannelInitializer<SocketChannel>() {
            @Override
            public void initChannel(SocketChannel ch) throws Exception {
    		ChannelPipeline pipeline = ch.pipeline();
             pipeline.addLast("frameDecoder", new ProtobufVarint32FrameDecoder());
             pipeline.addLast("decoder", decoder);
             pipeline.addLast("frameEncoder", new ProtobufVarint32LengthFieldPrepender());
             pipeline.addLast("encoder",encoder);
             pipeline.addLast(new IdleStateHandler(Constants.ImserverConfig.READ_IDLE_TIME, Constants.ImserverConfig.WRITE_IDLE_TIME, 0));
             pipeline.addLast("handler", new ImServerHandler(proxy,connertor));	
            }
        });
        
        // 可选参数
    	bootstrap.childOption(ChannelOption.TCP_NODELAY, true);
        // 绑定接口，同步等待成功
        log.info("start im server at port[" + port + "].");
        ChannelFuture future = bootstrap.bind(port).sync();
    	channel = future.channel();
        future.addListener(new ChannelFutureListener() {
            public void operationComplete(ChannelFuture future) throws Exception {
                if (future.isSuccess()) {
                    log.info("Server have success bind to " + port);
                } else {
                    log.error("Server fail bind to " + port);
                   throw new InitErrorException("Server start fail !", future.cause());
                }
            }
        });
       // future.channel().closeFuture().syncUninterruptibly();
    }

    @PreDestroy
    public void destroy() {
        log.info("destroy im server ...");
        // 释放线程池资源
        if (channel != null) {
			channel.close();
		}
        bossGroup.shutdownGracefully();
        workerGroup.shutdownGracefully();
        log.info("destroy iim server complate.");
    }
    
 

    public void setPort(int port) {
        this.port = port;
    }

	public void setProxy(MessageProxy proxy) {
		this.proxy = proxy;
	}


    public void setConnertor(ImConnertorImpl connertor) {
		this.connertor = connertor;
	}
    
    
}

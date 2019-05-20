// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: proto/java/MessageBody.proto

package com.chedao.websocket.server.model.proto;

public final class MessageBodyProto {
  private MessageBodyProto() {}
  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistryLite registry) {
  }

  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistry registry) {
    registerAllExtensions(
        (com.google.protobuf.ExtensionRegistryLite) registry);
  }
  public interface MessageBodyOrBuilder extends
      // @@protoc_insertion_point(interface_extends:com.chedao.websocket.server.model.proto.MessageBody)
      com.google.protobuf.MessageOrBuilder {

    /**
     * <pre>
     *标题
     * </pre>
     *
     * <code>string title = 1;</code>
     */
    String getTitle();
    /**
     * <pre>
     *标题
     * </pre>
     *
     * <code>string title = 1;</code>
     */
    com.google.protobuf.ByteString
        getTitleBytes();

    /**
     * <pre>
     *内容
     * </pre>
     *
     * <code>string content = 2;</code>
     */
    String getContent();
    /**
     * <pre>
     *内容
     * </pre>
     *
     * <code>string content = 2;</code>
     */
    com.google.protobuf.ByteString
        getContentBytes();

    /**
     * <pre>
     *发送时间
     * </pre>
     *
     * <code>string time = 3;</code>
     */
    String getTime();
    /**
     * <pre>
     *发送时间
     * </pre>
     *
     * <code>string time = 3;</code>
     */
    com.google.protobuf.ByteString
        getTimeBytes();

    /**
     * <pre>
     *0 文字   1 文件
     * </pre>
     *
     * <code>uint32 type = 4;</code>
     */
    int getType();

    /**
     * <pre>
     *扩展字段
     * </pre>
     *
     * <code>string extend = 5;</code>
     */
    String getExtend();
    /**
     * <pre>
     *扩展字段
     * </pre>
     *
     * <code>string extend = 5;</code>
     */
    com.google.protobuf.ByteString
        getExtendBytes();
  }
  /**
   * Protobuf type {@code com.chedao.websocket.server.model.proto.MessageBody}
   */
  public  static final class MessageBody extends
      com.google.protobuf.GeneratedMessageV3 implements
      // @@protoc_insertion_point(message_implements:com.chedao.websocket.server.model.proto.MessageBody)
      MessageBodyOrBuilder {
  private static final long serialVersionUID = 0L;
    // Use MessageBody.newBuilder() to construct.
    private MessageBody(com.google.protobuf.GeneratedMessageV3.Builder<?> builder) {
      super(builder);
    }
    private MessageBody() {
      title_ = "";
      content_ = "";
      time_ = "";
      type_ = 0;
      extend_ = "";
    }

    @Override
    public final com.google.protobuf.UnknownFieldSet
    getUnknownFields() {
      return this.unknownFields;
    }
    private MessageBody(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      this();
      int mutable_bitField0_ = 0;
      com.google.protobuf.UnknownFieldSet.Builder unknownFields =
          com.google.protobuf.UnknownFieldSet.newBuilder();
      try {
        boolean done = false;
        while (!done) {
          int tag = input.readTag();
          switch (tag) {
            case 0:
              done = true;
              break;
            default: {
              if (!parseUnknownFieldProto3(
                  input, unknownFields, extensionRegistry, tag)) {
                done = true;
              }
              break;
            }
            case 10: {
              String s = input.readStringRequireUtf8();

              title_ = s;
              break;
            }
            case 18: {
              String s = input.readStringRequireUtf8();

              content_ = s;
              break;
            }
            case 26: {
              String s = input.readStringRequireUtf8();

              time_ = s;
              break;
            }
            case 32: {

              type_ = input.readUInt32();
              break;
            }
            case 42: {
              String s = input.readStringRequireUtf8();

              extend_ = s;
              break;
            }
          }
        }
      } catch (com.google.protobuf.InvalidProtocolBufferException e) {
        throw e.setUnfinishedMessage(this);
      } catch (java.io.IOException e) {
        throw new com.google.protobuf.InvalidProtocolBufferException(
            e).setUnfinishedMessage(this);
      } finally {
        this.unknownFields = unknownFields.build();
        makeExtensionsImmutable();
      }
    }
    public static final com.google.protobuf.Descriptors.Descriptor
        getDescriptor() {
      return MessageBodyProto.internal_static_com_chedao_websocket_server_model_proto_MessageBody_descriptor;
    }

    protected FieldAccessorTable
        internalGetFieldAccessorTable() {
      return MessageBodyProto.internal_static_com_chedao_websocket_server_model_proto_MessageBody_fieldAccessorTable
          .ensureFieldAccessorsInitialized(
              MessageBody.class, Builder.class);
    }

    public static final int TITLE_FIELD_NUMBER = 1;
    private volatile Object title_;
    /**
     * <pre>
     *标题
     * </pre>
     *
     * <code>string title = 1;</code>
     */
    public String getTitle() {
      Object ref = title_;
      if (ref instanceof String) {
        return (String) ref;
      } else {
        com.google.protobuf.ByteString bs = 
            (com.google.protobuf.ByteString) ref;
        String s = bs.toStringUtf8();
        title_ = s;
        return s;
      }
    }
    /**
     * <pre>
     *标题
     * </pre>
     *
     * <code>string title = 1;</code>
     */
    public com.google.protobuf.ByteString
        getTitleBytes() {
      Object ref = title_;
      if (ref instanceof String) {
        com.google.protobuf.ByteString b = 
            com.google.protobuf.ByteString.copyFromUtf8(
                (String) ref);
        title_ = b;
        return b;
      } else {
        return (com.google.protobuf.ByteString) ref;
      }
    }

    public static final int CONTENT_FIELD_NUMBER = 2;
    private volatile Object content_;
    /**
     * <pre>
     *内容
     * </pre>
     *
     * <code>string content = 2;</code>
     */
    public String getContent() {
      Object ref = content_;
      if (ref instanceof String) {
        return (String) ref;
      } else {
        com.google.protobuf.ByteString bs = 
            (com.google.protobuf.ByteString) ref;
        String s = bs.toStringUtf8();
        content_ = s;
        return s;
      }
    }
    /**
     * <pre>
     *内容
     * </pre>
     *
     * <code>string content = 2;</code>
     */
    public com.google.protobuf.ByteString
        getContentBytes() {
      Object ref = content_;
      if (ref instanceof String) {
        com.google.protobuf.ByteString b = 
            com.google.protobuf.ByteString.copyFromUtf8(
                (String) ref);
        content_ = b;
        return b;
      } else {
        return (com.google.protobuf.ByteString) ref;
      }
    }

    public static final int TIME_FIELD_NUMBER = 3;
    private volatile Object time_;
    /**
     * <pre>
     *发送时间
     * </pre>
     *
     * <code>string time = 3;</code>
     */
    public String getTime() {
      Object ref = time_;
      if (ref instanceof String) {
        return (String) ref;
      } else {
        com.google.protobuf.ByteString bs = 
            (com.google.protobuf.ByteString) ref;
        String s = bs.toStringUtf8();
        time_ = s;
        return s;
      }
    }
    /**
     * <pre>
     *发送时间
     * </pre>
     *
     * <code>string time = 3;</code>
     */
    public com.google.protobuf.ByteString
        getTimeBytes() {
      Object ref = time_;
      if (ref instanceof String) {
        com.google.protobuf.ByteString b = 
            com.google.protobuf.ByteString.copyFromUtf8(
                (String) ref);
        time_ = b;
        return b;
      } else {
        return (com.google.protobuf.ByteString) ref;
      }
    }

    public static final int TYPE_FIELD_NUMBER = 4;
    private int type_;
    /**
     * <pre>
     *0 文字   1 文件
     * </pre>
     *
     * <code>uint32 type = 4;</code>
     */
    public int getType() {
      return type_;
    }

    public static final int EXTEND_FIELD_NUMBER = 5;
    private volatile Object extend_;
    /**
     * <pre>
     *扩展字段
     * </pre>
     *
     * <code>string extend = 5;</code>
     */
    public String getExtend() {
      Object ref = extend_;
      if (ref instanceof String) {
        return (String) ref;
      } else {
        com.google.protobuf.ByteString bs = 
            (com.google.protobuf.ByteString) ref;
        String s = bs.toStringUtf8();
        extend_ = s;
        return s;
      }
    }
    /**
     * <pre>
     *扩展字段
     * </pre>
     *
     * <code>string extend = 5;</code>
     */
    public com.google.protobuf.ByteString
        getExtendBytes() {
      Object ref = extend_;
      if (ref instanceof String) {
        com.google.protobuf.ByteString b = 
            com.google.protobuf.ByteString.copyFromUtf8(
                (String) ref);
        extend_ = b;
        return b;
      } else {
        return (com.google.protobuf.ByteString) ref;
      }
    }

    private byte memoizedIsInitialized = -1;
    public final boolean isInitialized() {
      byte isInitialized = memoizedIsInitialized;
      if (isInitialized == 1) return true;
      if (isInitialized == 0) return false;

      memoizedIsInitialized = 1;
      return true;
    }

    public void writeTo(com.google.protobuf.CodedOutputStream output)
                        throws java.io.IOException {
      if (!getTitleBytes().isEmpty()) {
        com.google.protobuf.GeneratedMessageV3.writeString(output, 1, title_);
      }
      if (!getContentBytes().isEmpty()) {
        com.google.protobuf.GeneratedMessageV3.writeString(output, 2, content_);
      }
      if (!getTimeBytes().isEmpty()) {
        com.google.protobuf.GeneratedMessageV3.writeString(output, 3, time_);
      }
      if (type_ != 0) {
        output.writeUInt32(4, type_);
      }
      if (!getExtendBytes().isEmpty()) {
        com.google.protobuf.GeneratedMessageV3.writeString(output, 5, extend_);
      }
      unknownFields.writeTo(output);
    }

    public int getSerializedSize() {
      int size = memoizedSize;
      if (size != -1) return size;

      size = 0;
      if (!getTitleBytes().isEmpty()) {
        size += com.google.protobuf.GeneratedMessageV3.computeStringSize(1, title_);
      }
      if (!getContentBytes().isEmpty()) {
        size += com.google.protobuf.GeneratedMessageV3.computeStringSize(2, content_);
      }
      if (!getTimeBytes().isEmpty()) {
        size += com.google.protobuf.GeneratedMessageV3.computeStringSize(3, time_);
      }
      if (type_ != 0) {
        size += com.google.protobuf.CodedOutputStream
          .computeUInt32Size(4, type_);
      }
      if (!getExtendBytes().isEmpty()) {
        size += com.google.protobuf.GeneratedMessageV3.computeStringSize(5, extend_);
      }
      size += unknownFields.getSerializedSize();
      memoizedSize = size;
      return size;
    }

    @Override
    public boolean equals(final Object obj) {
      if (obj == this) {
       return true;
      }
      if (!(obj instanceof MessageBody)) {
        return super.equals(obj);
      }
      MessageBody other = (MessageBody) obj;

      boolean result = true;
      result = result && getTitle()
          .equals(other.getTitle());
      result = result && getContent()
          .equals(other.getContent());
      result = result && getTime()
          .equals(other.getTime());
      result = result && (getType()
          == other.getType());
      result = result && getExtend()
          .equals(other.getExtend());
      result = result && unknownFields.equals(other.unknownFields);
      return result;
    }

    @Override
    public int hashCode() {
      if (memoizedHashCode != 0) {
        return memoizedHashCode;
      }
      int hash = 41;
      hash = (19 * hash) + getDescriptor().hashCode();
      hash = (37 * hash) + TITLE_FIELD_NUMBER;
      hash = (53 * hash) + getTitle().hashCode();
      hash = (37 * hash) + CONTENT_FIELD_NUMBER;
      hash = (53 * hash) + getContent().hashCode();
      hash = (37 * hash) + TIME_FIELD_NUMBER;
      hash = (53 * hash) + getTime().hashCode();
      hash = (37 * hash) + TYPE_FIELD_NUMBER;
      hash = (53 * hash) + getType();
      hash = (37 * hash) + EXTEND_FIELD_NUMBER;
      hash = (53 * hash) + getExtend().hashCode();
      hash = (29 * hash) + unknownFields.hashCode();
      memoizedHashCode = hash;
      return hash;
    }

    public static MessageBody parseFrom(
        java.nio.ByteBuffer data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data);
    }
    public static MessageBody parseFrom(
        java.nio.ByteBuffer data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data, extensionRegistry);
    }
    public static MessageBody parseFrom(
        com.google.protobuf.ByteString data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data);
    }
    public static MessageBody parseFrom(
        com.google.protobuf.ByteString data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data, extensionRegistry);
    }
    public static MessageBody parseFrom(byte[] data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data);
    }
    public static MessageBody parseFrom(
        byte[] data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data, extensionRegistry);
    }
    public static MessageBody parseFrom(java.io.InputStream input)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseWithIOException(PARSER, input);
    }
    public static MessageBody parseFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseWithIOException(PARSER, input, extensionRegistry);
    }
    public static MessageBody parseDelimitedFrom(java.io.InputStream input)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseDelimitedWithIOException(PARSER, input);
    }
    public static MessageBody parseDelimitedFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseDelimitedWithIOException(PARSER, input, extensionRegistry);
    }
    public static MessageBody parseFrom(
        com.google.protobuf.CodedInputStream input)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseWithIOException(PARSER, input);
    }
    public static MessageBody parseFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseWithIOException(PARSER, input, extensionRegistry);
    }

    public Builder newBuilderForType() { return newBuilder(); }
    public static Builder newBuilder() {
      return DEFAULT_INSTANCE.toBuilder();
    }
    public static Builder newBuilder(MessageBody prototype) {
      return DEFAULT_INSTANCE.toBuilder().mergeFrom(prototype);
    }
    public Builder toBuilder() {
      return this == DEFAULT_INSTANCE
          ? new Builder() : new Builder().mergeFrom(this);
    }

    @Override
    protected Builder newBuilderForType(
        BuilderParent parent) {
      Builder builder = new Builder(parent);
      return builder;
    }
    /**
     * Protobuf type {@code com.chedao.websocket.server.model.proto.MessageBody}
     */
    public static final class Builder extends
        com.google.protobuf.GeneratedMessageV3.Builder<Builder> implements
        // @@protoc_insertion_point(builder_implements:com.chedao.websocket.server.model.proto.MessageBody)
        MessageBodyOrBuilder {
      public static final com.google.protobuf.Descriptors.Descriptor
          getDescriptor() {
        return MessageBodyProto.internal_static_com_chedao_websocket_server_model_proto_MessageBody_descriptor;
      }

      protected FieldAccessorTable
          internalGetFieldAccessorTable() {
        return MessageBodyProto.internal_static_com_chedao_websocket_server_model_proto_MessageBody_fieldAccessorTable
            .ensureFieldAccessorsInitialized(
                MessageBody.class, Builder.class);
      }

      // Construct using com.chedao.websocket.server.model.proto.MessageBodyProto.MessageBody.newBuilder()
      private Builder() {
        maybeForceBuilderInitialization();
      }

      private Builder(
          BuilderParent parent) {
        super(parent);
        maybeForceBuilderInitialization();
      }
      private void maybeForceBuilderInitialization() {
        if (com.google.protobuf.GeneratedMessageV3
                .alwaysUseFieldBuilders) {
        }
      }
      public Builder clear() {
        super.clear();
        title_ = "";

        content_ = "";

        time_ = "";

        type_ = 0;

        extend_ = "";

        return this;
      }

      public com.google.protobuf.Descriptors.Descriptor
          getDescriptorForType() {
        return MessageBodyProto.internal_static_com_chedao_websocket_server_model_proto_MessageBody_descriptor;
      }

      public MessageBody getDefaultInstanceForType() {
        return MessageBody.getDefaultInstance();
      }

      public MessageBody build() {
        MessageBody result = buildPartial();
        if (!result.isInitialized()) {
          throw newUninitializedMessageException(result);
        }
        return result;
      }

      public MessageBody buildPartial() {
        MessageBody result = new MessageBody(this);
        result.title_ = title_;
        result.content_ = content_;
        result.time_ = time_;
        result.type_ = type_;
        result.extend_ = extend_;
        onBuilt();
        return result;
      }

      public Builder clone() {
        return (Builder) super.clone();
      }
      public Builder setField(
          com.google.protobuf.Descriptors.FieldDescriptor field,
          Object value) {
        return (Builder) super.setField(field, value);
      }
      public Builder clearField(
          com.google.protobuf.Descriptors.FieldDescriptor field) {
        return (Builder) super.clearField(field);
      }
      public Builder clearOneof(
          com.google.protobuf.Descriptors.OneofDescriptor oneof) {
        return (Builder) super.clearOneof(oneof);
      }
      public Builder setRepeatedField(
          com.google.protobuf.Descriptors.FieldDescriptor field,
          int index, Object value) {
        return (Builder) super.setRepeatedField(field, index, value);
      }
      public Builder addRepeatedField(
          com.google.protobuf.Descriptors.FieldDescriptor field,
          Object value) {
        return (Builder) super.addRepeatedField(field, value);
      }
      public Builder mergeFrom(com.google.protobuf.Message other) {
        if (other instanceof MessageBody) {
          return mergeFrom((MessageBody)other);
        } else {
          super.mergeFrom(other);
          return this;
        }
      }

      public Builder mergeFrom(MessageBody other) {
        if (other == MessageBody.getDefaultInstance()) return this;
        if (!other.getTitle().isEmpty()) {
          title_ = other.title_;
          onChanged();
        }
        if (!other.getContent().isEmpty()) {
          content_ = other.content_;
          onChanged();
        }
        if (!other.getTime().isEmpty()) {
          time_ = other.time_;
          onChanged();
        }
        if (other.getType() != 0) {
          setType(other.getType());
        }
        if (!other.getExtend().isEmpty()) {
          extend_ = other.extend_;
          onChanged();
        }
        this.mergeUnknownFields(other.unknownFields);
        onChanged();
        return this;
      }

      public final boolean isInitialized() {
        return true;
      }

      public Builder mergeFrom(
          com.google.protobuf.CodedInputStream input,
          com.google.protobuf.ExtensionRegistryLite extensionRegistry)
          throws java.io.IOException {
        MessageBody parsedMessage = null;
        try {
          parsedMessage = PARSER.parsePartialFrom(input, extensionRegistry);
        } catch (com.google.protobuf.InvalidProtocolBufferException e) {
          parsedMessage = (MessageBody) e.getUnfinishedMessage();
          throw e.unwrapIOException();
        } finally {
          if (parsedMessage != null) {
            mergeFrom(parsedMessage);
          }
        }
        return this;
      }

      private Object title_ = "";
      /**
       * <pre>
       *标题
       * </pre>
       *
       * <code>string title = 1;</code>
       */
      public String getTitle() {
        Object ref = title_;
        if (!(ref instanceof String)) {
          com.google.protobuf.ByteString bs =
              (com.google.protobuf.ByteString) ref;
          String s = bs.toStringUtf8();
          title_ = s;
          return s;
        } else {
          return (String) ref;
        }
      }
      /**
       * <pre>
       *标题
       * </pre>
       *
       * <code>string title = 1;</code>
       */
      public com.google.protobuf.ByteString
          getTitleBytes() {
        Object ref = title_;
        if (ref instanceof String) {
          com.google.protobuf.ByteString b = 
              com.google.protobuf.ByteString.copyFromUtf8(
                  (String) ref);
          title_ = b;
          return b;
        } else {
          return (com.google.protobuf.ByteString) ref;
        }
      }
      /**
       * <pre>
       *标题
       * </pre>
       *
       * <code>string title = 1;</code>
       */
      public Builder setTitle(
          String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  
        title_ = value;
        onChanged();
        return this;
      }
      /**
       * <pre>
       *标题
       * </pre>
       *
       * <code>string title = 1;</code>
       */
      public Builder clearTitle() {
        
        title_ = getDefaultInstance().getTitle();
        onChanged();
        return this;
      }
      /**
       * <pre>
       *标题
       * </pre>
       *
       * <code>string title = 1;</code>
       */
      public Builder setTitleBytes(
          com.google.protobuf.ByteString value) {
        if (value == null) {
    throw new NullPointerException();
  }
  checkByteStringIsUtf8(value);
        
        title_ = value;
        onChanged();
        return this;
      }

      private Object content_ = "";
      /**
       * <pre>
       *内容
       * </pre>
       *
       * <code>string content = 2;</code>
       */
      public String getContent() {
        Object ref = content_;
        if (!(ref instanceof String)) {
          com.google.protobuf.ByteString bs =
              (com.google.protobuf.ByteString) ref;
          String s = bs.toStringUtf8();
          content_ = s;
          return s;
        } else {
          return (String) ref;
        }
      }
      /**
       * <pre>
       *内容
       * </pre>
       *
       * <code>string content = 2;</code>
       */
      public com.google.protobuf.ByteString
          getContentBytes() {
        Object ref = content_;
        if (ref instanceof String) {
          com.google.protobuf.ByteString b = 
              com.google.protobuf.ByteString.copyFromUtf8(
                  (String) ref);
          content_ = b;
          return b;
        } else {
          return (com.google.protobuf.ByteString) ref;
        }
      }
      /**
       * <pre>
       *内容
       * </pre>
       *
       * <code>string content = 2;</code>
       */
      public Builder setContent(
          String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  
        content_ = value;
        onChanged();
        return this;
      }
      /**
       * <pre>
       *内容
       * </pre>
       *
       * <code>string content = 2;</code>
       */
      public Builder clearContent() {
        
        content_ = getDefaultInstance().getContent();
        onChanged();
        return this;
      }
      /**
       * <pre>
       *内容
       * </pre>
       *
       * <code>string content = 2;</code>
       */
      public Builder setContentBytes(
          com.google.protobuf.ByteString value) {
        if (value == null) {
    throw new NullPointerException();
  }
  checkByteStringIsUtf8(value);
        
        content_ = value;
        onChanged();
        return this;
      }

      private Object time_ = "";
      /**
       * <pre>
       *发送时间
       * </pre>
       *
       * <code>string time = 3;</code>
       */
      public String getTime() {
        Object ref = time_;
        if (!(ref instanceof String)) {
          com.google.protobuf.ByteString bs =
              (com.google.protobuf.ByteString) ref;
          String s = bs.toStringUtf8();
          time_ = s;
          return s;
        } else {
          return (String) ref;
        }
      }
      /**
       * <pre>
       *发送时间
       * </pre>
       *
       * <code>string time = 3;</code>
       */
      public com.google.protobuf.ByteString
          getTimeBytes() {
        Object ref = time_;
        if (ref instanceof String) {
          com.google.protobuf.ByteString b = 
              com.google.protobuf.ByteString.copyFromUtf8(
                  (String) ref);
          time_ = b;
          return b;
        } else {
          return (com.google.protobuf.ByteString) ref;
        }
      }
      /**
       * <pre>
       *发送时间
       * </pre>
       *
       * <code>string time = 3;</code>
       */
      public Builder setTime(
          String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  
        time_ = value;
        onChanged();
        return this;
      }
      /**
       * <pre>
       *发送时间
       * </pre>
       *
       * <code>string time = 3;</code>
       */
      public Builder clearTime() {
        
        time_ = getDefaultInstance().getTime();
        onChanged();
        return this;
      }
      /**
       * <pre>
       *发送时间
       * </pre>
       *
       * <code>string time = 3;</code>
       */
      public Builder setTimeBytes(
          com.google.protobuf.ByteString value) {
        if (value == null) {
    throw new NullPointerException();
  }
  checkByteStringIsUtf8(value);
        
        time_ = value;
        onChanged();
        return this;
      }

      private int type_ ;
      /**
       * <pre>
       *0 文字   1 文件
       * </pre>
       *
       * <code>uint32 type = 4;</code>
       */
      public int getType() {
        return type_;
      }
      /**
       * <pre>
       *0 文字   1 文件
       * </pre>
       *
       * <code>uint32 type = 4;</code>
       */
      public Builder setType(int value) {
        
        type_ = value;
        onChanged();
        return this;
      }
      /**
       * <pre>
       *0 文字   1 文件
       * </pre>
       *
       * <code>uint32 type = 4;</code>
       */
      public Builder clearType() {
        
        type_ = 0;
        onChanged();
        return this;
      }

      private Object extend_ = "";
      /**
       * <pre>
       *扩展字段
       * </pre>
       *
       * <code>string extend = 5;</code>
       */
      public String getExtend() {
        Object ref = extend_;
        if (!(ref instanceof String)) {
          com.google.protobuf.ByteString bs =
              (com.google.protobuf.ByteString) ref;
          String s = bs.toStringUtf8();
          extend_ = s;
          return s;
        } else {
          return (String) ref;
        }
      }
      /**
       * <pre>
       *扩展字段
       * </pre>
       *
       * <code>string extend = 5;</code>
       */
      public com.google.protobuf.ByteString
          getExtendBytes() {
        Object ref = extend_;
        if (ref instanceof String) {
          com.google.protobuf.ByteString b = 
              com.google.protobuf.ByteString.copyFromUtf8(
                  (String) ref);
          extend_ = b;
          return b;
        } else {
          return (com.google.protobuf.ByteString) ref;
        }
      }
      /**
       * <pre>
       *扩展字段
       * </pre>
       *
       * <code>string extend = 5;</code>
       */
      public Builder setExtend(
          String value) {
        if (value == null) {
    throw new NullPointerException();
  }
  
        extend_ = value;
        onChanged();
        return this;
      }
      /**
       * <pre>
       *扩展字段
       * </pre>
       *
       * <code>string extend = 5;</code>
       */
      public Builder clearExtend() {
        
        extend_ = getDefaultInstance().getExtend();
        onChanged();
        return this;
      }
      /**
       * <pre>
       *扩展字段
       * </pre>
       *
       * <code>string extend = 5;</code>
       */
      public Builder setExtendBytes(
          com.google.protobuf.ByteString value) {
        if (value == null) {
    throw new NullPointerException();
  }
  checkByteStringIsUtf8(value);
        
        extend_ = value;
        onChanged();
        return this;
      }
      public final Builder setUnknownFields(
          final com.google.protobuf.UnknownFieldSet unknownFields) {
        return super.setUnknownFieldsProto3(unknownFields);
      }

      public final Builder mergeUnknownFields(
          final com.google.protobuf.UnknownFieldSet unknownFields) {
        return super.mergeUnknownFields(unknownFields);
      }


      // @@protoc_insertion_point(builder_scope:com.chedao.websocket.server.model.proto.MessageBody)
    }

    // @@protoc_insertion_point(class_scope:com.chedao.websocket.server.model.proto.MessageBody)
    private static final MessageBody DEFAULT_INSTANCE;
    static {
      DEFAULT_INSTANCE = new MessageBody();
    }

    public static MessageBody getDefaultInstance() {
      return DEFAULT_INSTANCE;
    }

    private static final com.google.protobuf.Parser<MessageBody>
        PARSER = new com.google.protobuf.AbstractParser<MessageBody>() {
      public MessageBody parsePartialFrom(
          com.google.protobuf.CodedInputStream input,
          com.google.protobuf.ExtensionRegistryLite extensionRegistry)
          throws com.google.protobuf.InvalidProtocolBufferException {
          return new MessageBody(input, extensionRegistry);
      }
    };

    public static com.google.protobuf.Parser<MessageBody> parser() {
      return PARSER;
    }

    @Override
    public com.google.protobuf.Parser<MessageBody> getParserForType() {
      return PARSER;
    }

    public MessageBody getDefaultInstanceForType() {
      return DEFAULT_INSTANCE;
    }

  }

  private static final com.google.protobuf.Descriptors.Descriptor
    internal_static_com_chedao_websocket_server_model_proto_MessageBody_descriptor;
  private static final 
    com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
      internal_static_com_chedao_websocket_server_model_proto_MessageBody_fieldAccessorTable;

  public static com.google.protobuf.Descriptors.FileDescriptor
      getDescriptor() {
    return descriptor;
  }
  private static  com.google.protobuf.Descriptors.FileDescriptor
      descriptor;
  static {
    String[] descriptorData = {
      "\n\034proto/java/MessageBody.proto\022\'com.ched" +
      "ao.websocket.server.model.proto\"Y\n\013Messa" +
      "geBody\022\r\n\005title\030\001 \001(\t\022\017\n\007content\030\002 \001(\t\022\014" +
      "\n\004time\030\003 \001(\t\022\014\n\004type\030\004 \001(\r\022\016\n\006extend\030\005 \001" +
      "(\tB\022B\020MessageBodyProtob\006proto3"
    };
    com.google.protobuf.Descriptors.FileDescriptor.InternalDescriptorAssigner assigner =
        new com.google.protobuf.Descriptors.FileDescriptor.    InternalDescriptorAssigner() {
          public com.google.protobuf.ExtensionRegistry assignDescriptors(
              com.google.protobuf.Descriptors.FileDescriptor root) {
            descriptor = root;
            return null;
          }
        };
    com.google.protobuf.Descriptors.FileDescriptor
      .internalBuildGeneratedFileFrom(descriptorData,
        new com.google.protobuf.Descriptors.FileDescriptor[] {
        }, assigner);
    internal_static_com_chedao_websocket_server_model_proto_MessageBody_descriptor =
      getDescriptor().getMessageTypes().get(0);
    internal_static_com_chedao_websocket_server_model_proto_MessageBody_fieldAccessorTable = new
      com.google.protobuf.GeneratedMessageV3.FieldAccessorTable(
        internal_static_com_chedao_websocket_server_model_proto_MessageBody_descriptor,
        new String[] { "Title", "Content", "Time", "Type", "Extend", });
  }

  // @@protoc_insertion_point(outer_class_scope)
}

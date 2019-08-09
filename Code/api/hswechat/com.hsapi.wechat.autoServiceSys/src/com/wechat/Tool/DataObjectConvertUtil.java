package com.wechat.Tool;
import java.io.StringWriter;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONWriter;
import org.w3c.dom.Node;

import com.eos.system.annotation.Bizlet;
import com.primeton.ext.data.serialize.ExtendedXMLSerializer;
import com.primeton.ext.data.serialize.SerializeOption;
import com.primeton.ext.data.serialize.marshal.IMarshallingNode;

import commonj.sdo.DataObject;

/**
 * @author linfeng
 * @date 2016-01-12 15:34:58
 *
 */
//@Bizlet("转换DataObject对象返回Json字符串")
public class DataObjectConvertUtil {

   // @Bizlet("转换一个DataObject返回Json字符串")
    public static String convertDataObjectToJsonString(DataObject dataObject) {
        DataObject[] dataObjects = new DataObject[]{dataObject};
        String jsonString = convertDataObjectsToJsonString(dataObjects);
        jsonString = jsonString.substring(1, jsonString.length() - 1);
        return jsonString;
    }
    /**
     * @param dataObject
     * @author linfeng
     */
    //@Bizlet("转换DataObject数组返回Json字符串")
    public static String convertDataObjectsToJsonString(DataObject[] dataObjects) {
        Map<String,DataObject[]> root = new HashMap<String,DataObject[]>();
        root.put("data", dataObjects);

        StringWriter stringWriter = new StringWriter();
        JSONWriter jsonWriter = new JSONWriter(stringWriter);
        try {
            ExtendedXMLSerializer serializer = new ExtendedXMLSerializer();
            SerializeOption operation = new SerializeOption();
            operation.setCreateOuterCollectionNode(true);
            serializer.setOption(operation);
            IMarshallingNode node = serializer.marshallToNode(root, "root");
            jsonWriter.object();
            List<IMarshallingNode> children = node.getChildren();
            for (IMarshallingNode child : children) {
                write(child, jsonWriter);
            }
            jsonWriter.endObject();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }
        String jsonString = stringWriter.toString();
        jsonString = jsonString.substring(8, jsonString.length() - 1);
        return jsonString;
    }

    private static void write(IMarshallingNode node, JSONWriter writer)
            throws JSONException {
        int type = getNodeType(node);
        List<IMarshallingNode> children = null;
        switch (type) {
        case 1:
            Object nodeValue = node.getValue();
            boolean writeValue = false;
            if ((nodeValue == null) || (Boolean.class == nodeValue.getClass())
                    || (Number.class.isAssignableFrom(nodeValue.getClass()))) {
                writeValue = true;
            }
            if (node.isEntry()) {
                writer.value(writeValue == true ? nodeValue : node.getText());
            } else
                writer.key(node.getName()).value(
                        writeValue == true ? nodeValue : node.getText());

            break;
        case 2:
            if (!node.isEntry()) {
                writer.key(node.getName());
            }
            writer.array();
            children = node.getChildren();
            for (IMarshallingNode child : children) {
                write(child, writer);
            }
            writer.endArray();
            break;
        case 3:
            if (!node.isEntry()) {
                writer.key(node.getName());
            }
            writer.object();
            children = node.getChildren();
            for (IMarshallingNode child : children) {
                write(child, writer);
            }
            writer.endObject();
            break;
        case 4:
            String xml = com.eos.system.utility.XmlUtil.node2String(
                    (Node) node.getValue(), false, false, "UTF-8");

            if (node.isEntry())
                writer.value(xml);
            else {
                writer.key(node.getName()).value(xml);
            }
            break;
        case -1:
        case 0:
            break;
        }
    }

    private static int getNodeType(IMarshallingNode node) {
        if (!node.isSet()) {
            return -1;
        }
        if (node.isXml()) {
            return 4;
        }
        if (node.getChildren().size() <= 0) {
            if (node.getText() != null)
                return 1;
            if ("null".equals(node.getAttribute("__isNullOrEmpty"))) {
                return 1;
            }
            if ("empty".equals(node.getAttribute("__isNullOrEmpty"))) {
                String type = node.getAttribute("__type");
                if (type == null)
                    return 3;
                try {
                    Class clazz = Class
                            .forName(type.substring("java:".length()));

                    if ((clazz != null)
                            && ((clazz.isArray()) || (Collection.class
                                    .isAssignableFrom(clazz)))) {

                        return 2;
                    }
                    return 3;
                } catch (ClassNotFoundException e) {
                }
            }
        } else if (((IMarshallingNode) node.getChildren().get(0)).isEntry()) {
            return 2;
        }
        return 3;
    }
}

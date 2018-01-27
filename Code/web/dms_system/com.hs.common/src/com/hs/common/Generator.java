/**
 * 
 */
package com.hs.common;

import com.eos.system.annotation.Bizlet;

/**
 * @author Guine
 * @date 2017-08-13 21:59:22
 * 
 */
@Bizlet("")
public class Generator {
	private String code = "123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";// 35个

	/**
	 * 获取树节点ID
	 * 
	 * @param currMaxCode
	 *            当前层级中最大ID
	 * @return
	 */
	@Bizlet("")
	public String treeId(String currMaxCode) {// A

		if (currMaxCode == null || "".equals(currMaxCode)) {
			return "A";
		} else {
			int num = 1;
			if (currMaxCode.length() > 4) {
				num = 2;
			} else if (currMaxCode.length() > 1) {
				num = 3;
			}
			String endStr = currMaxCode.substring(currMaxCode.length() - num);// TID最后num位字符
			return currMaxCode.substring(0, currMaxCode.length() - num)
					+ getNextChar(endStr);
		}
	}

	/**
	 * treeId层级列表
	 * 
	 * @param treeId
	 * @param outPutInit
	 * @return
	 */
	@Bizlet("")
	public String getTreeIdList(String treeId, String outPutInit) {// A
		if (outPutInit == null) {
			outPutInit = "";
		}
		if (treeId == null || "".equals(treeId)) {
			return "''";
		} else {
			if(outPutInit.indexOf("'" + treeId + "'")<1){
				outPutInit += ", '" + treeId + "'";
			}
			if (treeId.length() > 4) {
				return getTreeIdList(treeId.substring(0, treeId.length() - 2),
						outPutInit);
			} else if (treeId.length() > 1) {
				return getTreeIdList(treeId.substring(0, 1), outPutInit);
			} else {
				if(outPutInit.startsWith(",")){
					return outPutInit.substring(1);
				}else{
					return outPutInit;
				}
			}
		}
	}

	private String getNextChar(String currChar) {
		char[] chars = currChar.toCharArray();// currChar.split("");

		for (int i = chars.length - 1; i > -1; i--) {
			char s = chars[i];

			int nextIndex = code.indexOf(s) + 1;
			if (nextIndex == 35) {
				chars[i] = '0';
			} else {
				chars[i] = code.charAt(nextIndex);// (nextIndex, nextIndex + 1);
				break;
			}
		}
		return String.valueOf(chars);
	}

	public static void main(String[] args) {
		/*
		 * String basic = ""; //测试生成TreeId System.out.println(basic +
		 * " next is：" + treeId(basic)); basic = "A"; System.out.println(basic +
		 * " next is：" + treeId(basic)); basic = "A000";
		 * System.out.println(basic + " next is：" + treeId(basic)); basic =
		 * "A0AA"; System.out.println(basic + " next is：" + treeId(basic));
		 * basic = "A0A100"; System.out.println(basic + " next is：" +
		 * treeId(basic)); basic = "A0A10Z"; System.out.println(basic +
		 * " next is：" + treeId(basic));
		 */
		Generator x = new Generator();
		System.out.println(x.getTreeIdList("", ""));
		System.out.println(x.getTreeIdList("A", ""));
		System.out.println(x.getTreeIdList("A001", ""));
		System.out.println(x.getTreeIdList("A0010", ""));
	}
}

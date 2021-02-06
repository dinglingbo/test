/**
 * 
 */
package com.hs.kinginterface;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;

import com.alibaba.fastjson.JSONObject;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import com.hs.common.DateUtils;
import com.hs.common.Menu;
import com.kingdee.bos.webapi.sdk.K3CloudApi;
import com.kingdee.bos.webapi.sdk.OperateParam;
import com.kingdee.bos.webapi.sdk.OperatorResult;
import com.kingdee.bos.webapi.sdk.RepoError;
import com.kingdee.bos.webapi.sdk.SaveParam;
import com.kingdee.bos.webapi.sdk.SaveResult;
import com.kingdee.bos.webapi.sdk.SuccessEntity;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * @author dlb
 * @date 2020-06-01 09:25:12
 *
 */
@Bizlet("金塔凭证接口对接")
public class KingAccountInterface {
	
	/*
	 * 每家店，每个月的凭证号从 1 开始
	 */
	
	
	/*
	 * 预收预付退款
	 * dc 1预付退款（收款） -1预收退款（付款）
	 */
	@Bizlet("预收预付退款")
	public static HashMap addAdvanceRtn(String serviceNo, String bookId, String date, String year, String month, String day,
			Integer dc, String guestId, String guestName, Double amt, DataObject[] data) throws Exception {    	
		
		String vname = "预付退款生成凭证";
		int vtype = 20;
		
		String title = "收到";
		if(dc == -1) {
			title = "支付";
			vname = "预收退款生成凭证";
			vtype = 21;
		}
		String preTitle = "";
		
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");
		try{
			
			lp.add("part");
			lp.add(serviceNo);
			lp.add(vname);
			lp.add("addAdvanceRtn");
			lp.add(vtype);
			
			if(serviceNo != null && serviceNo != "") {
				preTitle = serviceNo + "-";
			}
		
			List<DataObject> list = new ArrayList<DataObject>(Arrays.asList(data));
			
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + title + guestName + amt;
			
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			List<VoucherEntity> FEntity = new ArrayList();
			if(dc == 1) {
				for(int i=0; i<list.size(); i++) {
					DataObject doj = list.get(i);
					VoucherEntity vd = getVoucherEntity(serviceNo, doj.getString("voucherId"), 
							"D", fEXPLANATION, doj.getString("deptCode"), guestId, 
							doj.getDouble("amt"));
					FEntity.add(vd);
					
					VoucherEntity ve = getVoucherEntity(serviceNo, "1123", "D", fEXPLANATION, 
							doj.getString("deptCode"), guestId, doj.getDouble("amt")*-1.0);
		        	FEntity.add(ve);
				}
				
			}else {
	        	
	        	for(int i=0; i<list.size(); i++) {
					DataObject doj = list.get(i);
					VoucherEntity ve = getVoucherEntity(serviceNo, "2203", "C", fEXPLANATION, doj.getString("deptCode"), 
							guestId, doj.getDouble("amt")*-1.0);
		        	FEntity.add(ve);
		        	
					VoucherEntity vd = getVoucherEntity(serviceNo, doj.getString("voucherId"), 
							"C", fEXPLANATION, doj.getString("deptCode"), guestId, 
							doj.getDouble("amt"));
					FEntity.add(vd);
				}
			}
	
			vc.setFEntity(FEntity);
			
			lp.add(new SaveParam<Voucher>(vc).toJson());
			
			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> ls = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = ls.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
				
			} else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
		}catch(Throwable e){
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println(vname + "失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败：" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
		
	}
	
	/*
	 * 单笔销售退货付款，单笔采购退货收款
	 * dc 1采购退货 2销售退货
	 */
	@Bizlet("单笔销售退货付款，单笔采购退货收款")
	public static HashMap addRtn(String serviceNo, String bookId, String date, String year, String month, String day,
			Integer dc, String guestId, String guestName, Double amt, DataObject[] data) throws Exception {    	
		
		String vname = "采购退货收款生成凭证";
		int vtype = 14;
		
		String title = "收到";
		if(dc == 2) {
			title = "支付";
			vname = "销售退货付款生成凭证";
			vtype = 15;
		}
		String preTitle = "";
		if(serviceNo != null && serviceNo != "") {
			preTitle = serviceNo + "-";
		}
		
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");
		try{
			lp.add("part");
			lp.add(serviceNo);
			lp.add(vname);
			lp.add("addRtn");
			lp.add(vtype);
		
			List<DataObject> list = new ArrayList<DataObject>(Arrays.asList(data));
			
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + title + guestName + amt;
			
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			List<VoucherEntity> FEntity = new ArrayList();
			if(dc == 1) {
				for(int i=0; i<list.size(); i++) {
					DataObject doj = list.get(i);
					VoucherEntity vd = getVoucherEntity(serviceNo, doj.getString("voucherId"), 
							"D", fEXPLANATION, doj.getString("deptCode"), guestId, 
							doj.getDouble("amt"));
					FEntity.add(vd);
					
					VoucherEntity ve = getVoucherEntity(serviceNo, "2202.02", "D", fEXPLANATION, 
							doj.getString("deptCode"), guestId, doj.getDouble("amt")*-1.0);
		        	FEntity.add(ve);
				}
				
			}else {
	        	
	        	for(int i=0; i<list.size(); i++) {
					DataObject doj = list.get(i);
					VoucherEntity ve = getVoucherEntity(serviceNo, "1122", "C", fEXPLANATION, doj.getString("deptCode"), 
							guestId, doj.getDouble("amt")*-1.0);
		        	FEntity.add(ve);
		        	
					VoucherEntity vd = getVoucherEntity(serviceNo, doj.getString("voucherId"), 
							"C", fEXPLANATION, doj.getString("deptCode"), guestId, 
							doj.getDouble("amt"));
					FEntity.add(vd);
				}
			}
	
			vc.setFEntity(FEntity);
			
			lp.add(new SaveParam<Voucher>(vc).toJson());
			
			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> ls = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = ls.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
				
			} else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
		}catch(Throwable e){
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println(vname + "失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败：" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
		
	}
	
	/*
	 * 费用月结费用现结
	 * DataObject[] accountDetail 结算账户对应的数据, DataObject[] detail 收款明细对应的数据
	 */
	@Bizlet("费用月结费用现结")
	public static HashMap addBillExpense(String serviceNo, String bookId, String date, String year, String month, String day,
			String guestId, String guestName, DataObject[] accountDetail, Double amt) throws Exception {    	
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");
		try{
			lp.add("part");
			lp.add(serviceNo);
			lp.add("费用月结或现结生成凭证");
			lp.add("addBillExpense");
			lp.add(13);
			
			String preTitle = "";

			if(serviceNo != null && serviceNo != "") {
				preTitle = serviceNo + "-";
			}
			
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + "付" + guestName + amt;
			
			String deptCode = "";
			
			List<DataObject> alist = new ArrayList<DataObject>(Arrays.asList(accountDetail));
			
			if(alist != null && alist.size() > 0) {
				DataObject t = alist.get(0);
				deptCode = t.getString("deptCode");
			}
			
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			List<VoucherEntity> FEntity = new ArrayList();
			
			VoucherEntity ve = getVoucherEntity(serviceNo, "2241.02", 
					"D", fEXPLANATION, deptCode, guestId, amt);
			FEntity.add(ve);
			
			for(int i=0; i<alist.size(); i++) {
				DataObject doj = alist.get(i);
				VoucherEntity vd = getVoucherEntity(serviceNo, doj.getString("voucherId"), 
						"C", fEXPLANATION, doj.getString("deptCode"), guestId, 
						doj.getDouble("amt"));
				FEntity.add(vd);
			}
	
			vc.setFEntity(FEntity);
			
			//Gson gsons = new Gson();
		    //String s = gsons.toJson(vc);
			
			lp.add(new SaveParam<Voucher>(vc).toJson());
			
			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> ls = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = ls.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
				
			} else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
		}catch(Throwable e){
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println("费用月结或现结凭证生成失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败：" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
		
	}
	
	/*
	 * 其他应收应付收款付款
	 * 1收款，-1付款
	 * DataObject[] accountDetail 结算账户对应的数据, DataObject[] detail 收款明细对应的数据
	 */
	@Bizlet("其他应收应付收款付款")
	public static HashMap addSettleOther(String serviceNo, String bookId, String date, String year, String month, String day,
			Integer dc, String guestId, String guestName, DataObject[] accountDetail, DataObject[] detail, Double amt) throws Exception {    	
		
		String vname = "其他应收单收款生成凭证";
		int vtype = 16;
		
		String title = "收到客户/供应商/员工/备用金/押金/采购优惠";
		if(dc == -1) {
			title = "支付客户/供应商/员工/备用金/押金/采购优惠/销售优惠";
			vname = "其他应付单付款生成凭证";
			vtype = 17;
		}
		
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");
		try{
			lp.add("part");
			lp.add(serviceNo);
			lp.add(vname);
			lp.add("addSettleOther");
			lp.add(vtype);
			
			String preTitle = "";

			if(serviceNo != null && serviceNo != "") {
				preTitle = serviceNo + "-";
			}
		
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + title + guestName + amt;
			
			String deptCode = "";
			
			List<DataObject> alist = new ArrayList<DataObject>(Arrays.asList(accountDetail));
			
			List<DataObject> dlist = new ArrayList<DataObject>(Arrays.asList(detail));
			
			if(alist != null && alist.size() > 0) {
				DataObject t = alist.get(0);
				deptCode = t.getString("deptCode");
			}
			
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			List<VoucherEntity> FEntity = new ArrayList();
			if(dc == 1) {
				for(int i=0; i<alist.size(); i++) {
					DataObject doj = alist.get(i);
					VoucherEntity vd = getVoucherEntity(serviceNo, doj.getString("voucherId"), 
							"D", fEXPLANATION, doj.getString("deptCode"), guestId, 
							doj.getDouble("amt"));
					FEntity.add(vd);
				}
				
				for(int j=0; j<dlist.size(); j++) {
					DataObject doj = dlist.get(j);
					VoucherEntity vd = getVoucherEntity(serviceNo, doj.getString("voucherId"), 
							"C", fEXPLANATION, deptCode, guestId, 
							doj.getDouble("amt"));
					FEntity.add(vd);
				}
				
			}else {
				for(int j=0; j<dlist.size(); j++) {
					DataObject doj = dlist.get(j);
					VoucherEntity vd = getVoucherEntity(serviceNo, doj.getString("voucherId"), 
							"D", fEXPLANATION, deptCode, guestId, 
							doj.getDouble("amt"));
					FEntity.add(vd);
				}
				
				for(int i=0; i<alist.size(); i++) {
					DataObject doj = alist.get(i);
					VoucherEntity vd = getVoucherEntity(serviceNo, doj.getString("voucherId"), 
							"C", fEXPLANATION, doj.getString("deptCode"), guestId, 
							doj.getDouble("amt"));
					FEntity.add(vd);
				}
			}
	
			vc.setFEntity(FEntity);
			
			//Gson gsons = new Gson();
		    //String s = gsons.toJson(vc);
			
			lp.add(new SaveParam<Voucher>(vc).toJson());
			
			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> ls = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = ls.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
				
			} else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
			
		}catch(Throwable e){
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println(vname + "失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败：" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
	}
	
	/*
	 * 内部转账单 内部账户划转 支付 收到
	 * type 9内部账户调账；18费用支出单；19其他收入单
	 */
	@Bizlet("内部转账单，费用支出，其他收入")
	public static HashMap addInternalTransfer(String serviceNo, String title, String bookId, String date, String year, String month, String day,
			 Double amt, DataObject[] data, Integer type) throws Exception {    	
		
		String vname = "内部账户调账生成凭证";
		int vtype = 9;
		
		if(type == 18) {
			vname = "费用支出单生成凭证";
			vtype = 18;
		}
		
		if(type == 19) {
			vname = "其他收入单生成凭证";
			vtype = 19;
		}
		
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");
		try{
			lp.add("part");
			lp.add(serviceNo);
			lp.add(vname);
			lp.add("addInternalTransfer");
			lp.add(vtype);
			
			String preTitle = "";

			if(serviceNo != null && serviceNo != "") {
				preTitle = serviceNo + "-";
			}
			
			List<DataObject> list = new ArrayList<DataObject>(Arrays.asList(data));
			
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + title + amt;
			
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			List<VoucherEntity> FEntity = new ArrayList();
			String dc = "C";
			for(int i=0; i<list.size(); i++) {
				DataObject doj = list.get(i);
				if(dc.equals("C")) {
					dc = "D";
				}else {
					dc = "C";
				}
				VoucherEntity vd = getVoucherEntity(serviceNo, doj.getString("voucherId"), 
						dc, fEXPLANATION, doj.getString("deptCode"), null, 
						doj.getDouble("amt"));
				FEntity.add(vd);
			}
				
	
			vc.setFEntity(FEntity);
			
			//Gson gsons = new Gson();
		    //String s = gsons.toJson(vc);
			
			lp.add(new SaveParam<Voucher>(vc).toJson());
			
			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> ls = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = ls.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
				
			} else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
		}catch(Throwable e){
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println(vname + "失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
	}
	
	/*
	 * 正常收付款，预收预付抵扣
	 * 1收款，-1付款
	 */
	@Bizlet("正常收付款，预收预付抵扣")
	public static HashMap addSettle(String serviceNo, String bookId, boolean isAdvance, String date, String year, String month, String day,
			Integer dc, String guestId, String guestName, DataObject[] data, Double amt) throws Exception {    	
		
		String vname = "收款生成凭证";
		int vtype = 6;
		
		String title = "收";
		if(dc == -1) {
			title = "付";
			vname = "付款生成凭证";
			vtype = 10;
		}
		
		if(isAdvance) {
			vname = "预收抵扣生成凭证";
			vtype = 8;
			if(dc == -1) {
				vname = "预付抵扣生成凭证";
				vtype = 12;
			}
		}
		
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");
		try{
			
			lp.add("part");
			lp.add(serviceNo);
			lp.add(vname);
			lp.add("addSettle");
			lp.add(vtype);
			
			String preTitle = "";

			if(serviceNo != null && serviceNo != "") {
				preTitle = serviceNo + "-";
			}
		
			List<DataObject> list = new ArrayList<DataObject>(Arrays.asList(data));
			
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + title + guestName + amt;
			
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			List<VoucherEntity> FEntity = new ArrayList();
			if(dc == 1) {
				for(int i=0; i<list.size(); i++) {
					DataObject doj = list.get(i);
					if(!isAdvance) {
						VoucherEntity vd = getVoucherEntity(serviceNo, doj.getString("voucherId"), 
								"D", fEXPLANATION, doj.getString("deptCode"), guestId, 
								doj.getDouble("amt"));
						FEntity.add(vd);
						
						VoucherEntity ve = getVoucherEntity(serviceNo, "1122", 
								"C", fEXPLANATION, doj.getString("deptCode"), guestId, 
								doj.getDouble("amt"));
			        	FEntity.add(ve);
		        	}else {
						VoucherEntity vd = getVoucherEntity(serviceNo, "2203", 
								"D", fEXPLANATION, doj.getString("deptCode"), guestId, 
								doj.getDouble("amt"));
						FEntity.add(vd);
						
						VoucherEntity ve = getVoucherEntity(serviceNo, "1122", 
								"C", fEXPLANATION, doj.getString("deptCode"), guestId, 
								doj.getDouble("amt"));
			        	FEntity.add(ve);
		        	}
				}
				
			}else {
	        	
	        	for(int i=0; i<list.size(); i++) {
					DataObject doj = list.get(i);
					if(!isAdvance) {
						VoucherEntity ve = getVoucherEntity(serviceNo, "2202.02", 
								"D", fEXPLANATION, doj.getString("deptCode"), guestId, 
								doj.getDouble("amt"));
						FEntity.add(ve);
						
						VoucherEntity vd = getVoucherEntity(serviceNo, doj.getString("voucherId"), 
								"C", fEXPLANATION, doj.getString("deptCode"), guestId, 
								doj.getDouble("amt"));
						FEntity.add(vd);
					}else{
						VoucherEntity ve = getVoucherEntity(serviceNo, "2202.02", 
								"D", fEXPLANATION, doj.getString("deptCode"), guestId, 
								doj.getDouble("amt"));
						FEntity.add(ve);
						
						VoucherEntity vd = getVoucherEntity(serviceNo, "1123", 
								"C", fEXPLANATION, doj.getString("deptCode"), guestId, 
								doj.getDouble("amt"));
						FEntity.add(vd);
					}
				}
			}
	
			vc.setFEntity(FEntity);
			
			lp.add(new SaveParam<Voucher>(vc).toJson());
			
			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> ls = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = ls.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
				
			} else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
		}catch(Throwable e){
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println(vname + "失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
		
	}
	
	/*
	 * 预收预付
	 * 2预收，-2预付
	 */
	@Bizlet("预收预付收款凭证")
	public static HashMap addAdvance(Long mainId, String serviceNo, String bookId, String date, String year, String month, String day,
			Integer dc, String guestId, String guestName, Double amt, DataObject[] data) throws Exception {    	
		
		String vname = "预存收款生成凭证";
		int vtype = 7;
		String title = "收";
		if(dc == -2) {
			title = "付";
			vname = "预付付款生成凭证";
			vtype = 11;
		}
		
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");
		
		try{
			
			lp.add("part");
			lp.add(serviceNo);
			lp.add(vname);
			lp.add("addAdvance");
			lp.add(vtype);
			
			String preTitle = "";

			if(serviceNo != null && serviceNo != "") {
				preTitle = serviceNo + "-";
			}
		
			List<DataObject> list = new ArrayList<DataObject>(Arrays.asList(data));
			
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + title + guestName + amt;
			
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			List<VoucherEntity> FEntity = new ArrayList();
			if(dc == 2) {
				for(int i=0; i<list.size(); i++) {
					DataObject doj = list.get(i);
					VoucherEntity vd = getVoucherEntity(serviceNo, doj.getString("voucherId"), 
							"D", fEXPLANATION, doj.getString("deptCode"), guestId, 
							doj.getDouble("amt"));
					FEntity.add(vd);
					
					VoucherEntity ve = getVoucherEntity(serviceNo, "2203", "C", fEXPLANATION, 
							doj.getString("deptCode"), guestId, doj.getDouble("amt"));
		        	FEntity.add(ve);
				}
				
				//VoucherEntity ve = getVoucherEntity(serviceNo, "2203", "C", fEXPLANATION, kingDeptCode, guestId, amt);
	        	//FEntity.add(ve);
			}else {
				//VoucherEntity ve = getVoucherEntity(serviceNo, "1123", "D", fEXPLANATION, kingDeptCode, guestId, amt);
	        	//FEntity.add(ve);
	        	
	        	for(int i=0; i<list.size(); i++) {
					DataObject doj = list.get(i);
					VoucherEntity ve = getVoucherEntity(serviceNo, "1123", "D", fEXPLANATION, doj.getString("deptCode"), 
							guestId, doj.getDouble("amt"));
		        	FEntity.add(ve);
		        	
					VoucherEntity vd = getVoucherEntity(serviceNo, doj.getString("voucherId"), 
							"C", fEXPLANATION, doj.getString("deptCode"), guestId, 
							doj.getDouble("amt"));
					FEntity.add(vd);
				}
			}
	
			vc.setFEntity(FEntity);
			
			//Gson gsons = new Gson();
		    //String s = gsons.toJson(vc);
			
			lp.add(new SaveParam<Voucher>(vc).toJson());
			
			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> ls = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = ls.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
				
			} else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
		}catch(Throwable e){
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println(vname + "失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败：" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
		
	}
	
	/**
	 * 采购入库
	 * FAccountBookID 账簿   日期  年  月
	 *  String fEXPLANATION 摘要, Double amt 商品金额, Double taxAmt 进项税额, Double payAmt 应付款
	 *  order_type 订单类型 ：1常规订单，2备货订单，3急件订单
	 *  expenseAmt 费用金额   orderAmt采购金额
	 *  
	 *  年-月-日从XXX采购入库多少金额（例：2020-06-04从北京新华奥商贸有限责任公司采购入库5789.65）单据的金额
	 *  
	 *  采购入库-常规订单和备货订单
	 *  d	1405	库存商品	部门
		d	2221.01.01	应交税费_应交增值税_进项税额	部门
		c	2202.02	应付账款_明细应付款	供应商+部门
		c	2241.02	其他应付款	供应商(物流公司)+部门
 		采购入库-急件订单
 		d	1405	库存商品
		d	6601.05.01	销售费用-采购运费
		d	2221.01.01	应交税费_应交增值税_进项税额
		c	2202.02	应付账款_明细应付款
		c	2241.02	其他应付款

	 */
	@Bizlet("采购入库生成凭证")
	public static HashMap addPurchase(Long enterMainId, String serviceNo, String orderServiceNo, String bookId, String date, String year, String month, String day,
			Integer orderType, Integer taxSign, String supplierId, String guestName, Double expenseAmt, Double orderAmt) throws Exception {
		
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");
		try{
			lp.add("part");
			lp.add(serviceNo);
			lp.add("采购入库生成凭证");
			lp.add("addPurchase");
			lp.add(1);
			
			String preTitle = "";

			if(serviceNo != null && serviceNo != "") {
				preTitle = serviceNo + "-";
			}
			
			Double amt = expenseAmt + orderAmt;
			BigDecimal bamt = new BigDecimal(amt);
			amt = bamt.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + "从" + guestName + "采购入库" + amt;
			
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			//获取凭证号
			//vc.setFVOUCHERGROUPNO(groupNo);
			
			Double dsum = 0.0;
			Double csum = 0.0;
			Double sellExpSum = 0.0;//销售费用-采购运费 运费总和
			Double otherExpSum = 0.0; //其他应付款-捷捷物流 运费总和
			List<VoucherEntity> FEntity = new ArrayList();
			
			//查询库存商品
			HashMap pr = new HashMap();
	    	pr.put("pchsEnterMainId",enterMainId);
	    	Object[] objr = DatabaseExt.queryByNamedSql("part","com.hs.kinginterface.query.queryPchsAmt", pr);
	    	List<DataObject> pchsList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(pchsList, objr);
	    	List<VoucherEntity> FEntity0 = new ArrayList();//库存商品
	    	List<VoucherEntity> FEntity1 = new ArrayList();//应交税费-应交增值税-进项税额-保时捷571.77
	    	List<VoucherEntity> FEntity2 = new ArrayList();//销售费用-采购运费-保时捷8
	    	List<VoucherEntity> FEntity3 = new ArrayList();//应付账款- 广州市万德汽车配件有限公司-保时捷4970
	    	List<VoucherEntity> FEntity4 = new ArrayList();//其他应付款-捷捷物流-保时捷     28.58
	    	
	    	
	    	for(int i = 0; i<pchsList.size(); i++) {
	        	DataObject d = pchsList.get(i);
	        	
	        	String kingDeptCode = d.getString("kingDeptCode");
	        	Double noTaxCostAmt = d.getDouble("noTaxCostAmt");
	        	Double taxDiff = d.getDouble("taxDiff");
	        	Double expAmt = d.getDouble("expenseAmt");
	        	Double enterAmt = d.getDouble("enterAmt");
	        	
	        	
	        	BigDecimal b = new BigDecimal(noTaxCostAmt);
	        	noTaxCostAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	BigDecimal p1 = new BigDecimal(Double.toString(dsum));
	            BigDecimal p2 = new BigDecimal(Double.toString(noTaxCostAmt));
	            //dsum = p1.add(p2).doubleValue();
	        	
	        	VoucherEntity ve = getVoucherEntity(serviceNo, "1405", "D", fEXPLANATION, kingDeptCode, supplierId, noTaxCostAmt);
	        	FEntity0.add(ve);
	        	
	        	if(taxSign == 1) {
		        	b = new BigDecimal(taxDiff);
		        	taxDiff = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
		        	p1 = new BigDecimal(Double.toString(dsum));
		            p2 = new BigDecimal(Double.toString(taxDiff));
		            //dsum = p1.add(p2).doubleValue();
		            
		            VoucherEntity vt = getVoucherEntity(serviceNo, "2221.01.01", "D", fEXPLANATION, kingDeptCode, supplierId, taxDiff);
		        	FEntity1.add(vt);
	        	}
	        	
	        	//销售费用-采购运费-保时捷8
	        	if(expenseAmt > 0 && orderType == 3) {
		        	b = new BigDecimal(expAmt);
		        	expAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
		        	p1 = new BigDecimal(Double.toString(dsum));
		            p2 = new BigDecimal(Double.toString(expAmt));
		            //dsum = p1.add(p2).doubleValue();
		            
		            BigDecimal p3 = new BigDecimal(Double.toString(sellExpSum));
		            sellExpSum = p2.add(p3).doubleValue();
		            
		            VoucherEntity vs = getVoucherEntity(serviceNo, "6601.05.01", "D", fEXPLANATION, kingDeptCode, supplierId, expAmt);
		        	FEntity2.add(vs);
	        	}
	        	
	        	b = new BigDecimal(enterAmt);
	        	enterAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
	        	p1 = new BigDecimal(Double.toString(csum));
	            p2 = new BigDecimal(Double.toString(enterAmt));
	            //csum = p1.add(p2).doubleValue();
	        	
	        	VoucherEntity vth = getVoucherEntity(serviceNo, "2202.02", "C", fEXPLANATION, kingDeptCode, supplierId, enterAmt);
	        	FEntity3.add(vth);
	        	
	        }
			
			if(expenseAmt > 0) {
				//其他应付款-捷捷物流-保时捷     28.58
				HashMap pre = new HashMap();
				pre.put("orderServiceNo",orderServiceNo);
		    	Object[] objexp = DatabaseExt.queryByNamedSql("part","com.hs.kinginterface.query.queryPchsExpenseRecordAmt", pre);
		    	List<DataObject> expRecordList = new ArrayList<DataObject>();
		    	CollectionUtils.addAll(expRecordList, objexp);
		    	
		    	for(int i = 0; i<expRecordList.size(); i++) {
		        	DataObject d = expRecordList.get(i);
		        	
		        	String logisticsGuestId = d.getString("logisticsGuestId");
		        	Double expRecordAmt = d.getDouble("expenseAmt");
		        	Double dispatchExpSum = 0.0;
		        	
		        	for(int j = 0; j<pchsList.size(); j++) {
		            	DataObject pchs = pchsList.get(j);
		            	
		            	String kingDeptCode = pchs.getString("kingDeptCode");
		            	Double enterAmt = pchs.getDouble("enterAmt");
		            	
		            	BigDecimal b1 = new BigDecimal(enterAmt.toString());
		            	BigDecimal b2 = new BigDecimal(expRecordAmt.toString());
		            	enterAmt =  new Double(b1.multiply(b2).doubleValue());
		            	
		            	b1 = new BigDecimal(enterAmt.toString());
		            	b2 = new BigDecimal(orderAmt.toString());
		            	Double otherExpAmt = 0.0;
		            	if(j == pchsList.size() - 1) {
		            		BigDecimal p1 = new BigDecimal(Double.toString(expRecordAmt));
		                    BigDecimal p2 = new BigDecimal(Double.toString(dispatchExpSum));
		            		otherExpAmt = p1.subtract(p2).doubleValue();
		            	}else {
		            		otherExpAmt = new Double(b1.divide(b2, 10, BigDecimal.ROUND_HALF_UP)
		    	                            .doubleValue());
		            	}
		            	
		            	//BigDecimal b1 = new BigDecimal(enterAmt.toString());
		                //BigDecimal b2 = new BigDecimal(orderAmt.toString());
		                //enterAmt = new Double(b1.divide(b2, 10, BigDecimal.ROUND_HALF_UP)
		                //        .doubleValue());
		                
		                //b1 = new BigDecimal(enterAmt.toString());
		                //b2 = new BigDecimal(expRecordAmt.toString());
		            	
		            	//Double otherExpAmt = new Double(b1.multiply(b2).doubleValue());//enterAmt / orderAmt * expRecordAmt;
		            	BigDecimal b = new BigDecimal(otherExpAmt);
		            	otherExpAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
		            	//logisticsGuestId = "VEN00002";
		            	
		            	BigDecimal p1 = new BigDecimal(Double.toString(dispatchExpSum));
		                BigDecimal p2 = new BigDecimal(Double.toString(otherExpAmt));
		                dispatchExpSum = p1.add(p2).doubleValue();
		            	
		                BigDecimal p3 = new BigDecimal(Double.toString(otherExpSum));
		                otherExpSum = p2.add(p3).doubleValue();
		            	
		            	VoucherEntity vt = getVoucherEntity(serviceNo, "2241.02", "C", fEXPLANATION, kingDeptCode, logisticsGuestId, otherExpAmt);
		            	FEntity4.add(vt);
		            }
		        	
		        }
			}
	    	
	    	//借方总金额 = 贷发总金额 = 订单金额 + 费用（误差数据处理）
	    	//如果存在运费， 运费 = 其他应付款-捷捷物流 的总和 = 销售费用-采购运费 的总和（误差数据处理）
	    	if(expenseAmt > 0) {
	    		BigDecimal p1 = new BigDecimal(Double.toString(expenseAmt));
	            BigDecimal p2 = new BigDecimal(Double.toString(sellExpSum));
	            BigDecimal p3 = new BigDecimal(Double.toString(otherExpSum));
	            if(sellExpSum > 0  && orderType == 3) {
	            	 Double diffsum = p1.subtract(p2).doubleValue();
	            	 if(diffsum > 0.0001 || diffsum < -0.0001) {
	             		for(int j = FEntity2.size() - 1; j > 0; j--) {
	             			VoucherEntity ve = FEntity2.get(j);
	             			Double c = ve.getFDEBIT();
	             			if(ve != null) {
	             				BigDecimal s1 = new BigDecimal(Double.toString(c));
	         	                BigDecimal s2 = new BigDecimal(Double.toString(diffsum));
	         	                c = s1.add(s2).doubleValue();
	         	                if(c > 0) {
	         	                	ve.setFDEBIT(c);
	    		                	ve.setFAMOUNTFOR(c);
	         	                	break;
	         	                }
	             			}
	             			 
	             		}
	             	}
	            }
	           
	            Double otherdiffsum = p1.subtract(p3).doubleValue();
	        	if(otherdiffsum != 0) {
	        		for(int j = FEntity4.size() - 1; j >= 0; j--) {
	        			VoucherEntity ve = FEntity4.get(j);
	        			Double c = ve.getFCREDIT();
	        			if(ve != null) {
	        				BigDecimal s1 = new BigDecimal(Double.toString(c));
	    	                BigDecimal s2 = new BigDecimal(Double.toString(otherdiffsum));
	    	                c = s1.add(s2).doubleValue();
	    	                if(c > 0) {
	    	                	ve.setFCREDIT(c);
			                	ve.setFAMOUNTFOR(c);
	    	                	break;
	    	                }
	        			}
	        			 
	        		}
	        	}
	    	}
	    	
	    	for(int i = 0; i<FEntity0.size(); i++) {
	    		VoucherEntity ve = FEntity0.get(i);
				Double d = ve.getFDEBIT();
				BigDecimal p1 = new BigDecimal(Double.toString(dsum));
		        BigDecimal p2 = new BigDecimal(Double.toString(d));
		        dsum = p1.add(p2).doubleValue();
	    	}
	    	for(int i = 0; i<FEntity1.size(); i++) {
	    		VoucherEntity ve = FEntity1.get(i);
				Double d = ve.getFDEBIT();
				BigDecimal p1 = new BigDecimal(Double.toString(dsum));
		        BigDecimal p2 = new BigDecimal(Double.toString(d));
		        dsum = p1.add(p2).doubleValue();
	    	}
	    	for(int i = 0; i<FEntity2.size(); i++) {
	    		VoucherEntity ve = FEntity2.get(i);
				Double d = ve.getFDEBIT();
				BigDecimal p1 = new BigDecimal(Double.toString(dsum));
		        BigDecimal p2 = new BigDecimal(Double.toString(d));
		        dsum = p1.add(p2).doubleValue();
	    	}
	    	for(int i = 0; i<FEntity3.size(); i++) {
	    		VoucherEntity ve = FEntity3.get(i);
				Double c = ve.getFCREDIT();
				BigDecimal p1 = new BigDecimal(Double.toString(csum));
		        BigDecimal p2 = new BigDecimal(Double.toString(c));
		        csum = p1.add(p2).doubleValue();
	    	}
	    	for(int i = 0; i<FEntity4.size(); i++) {
	    		VoucherEntity ve = FEntity4.get(i);
				Double c = ve.getFCREDIT();
				BigDecimal p1 = new BigDecimal(Double.toString(csum));
		        BigDecimal p2 = new BigDecimal(Double.toString(c));
		        csum = p1.add(p2).doubleValue();
	    	}
	    	
	    	BigDecimal p1 = new BigDecimal(Double.toString(amt));
	        BigDecimal p2 = new BigDecimal(Double.toString(dsum));
	        BigDecimal p3 = new BigDecimal(Double.toString(csum));
	        Double ddiffsum = p1.subtract(p2).doubleValue();//借方存在差异
	        Double cdiffsum = p1.subtract(p3).doubleValue();//贷方存在差异
	
	    	if(ddiffsum != 0) {
	    		for(int j = FEntity0.size() - 1; j >= 0; j--) {
	    			VoucherEntity ve = FEntity0.get(j);
	    			Double c = ve.getFDEBIT();
	    			if(ve != null) {
	    				BigDecimal s1 = new BigDecimal(Double.toString(c));
		                BigDecimal s2 = new BigDecimal(Double.toString(ddiffsum));
		                c = s1.add(s2).doubleValue();
		                if(c > 0) {
		                	ve.setFDEBIT(c);
		                	ve.setFAMOUNTFOR(c);
		                	break;
		                }
	    			}
	    			 
	    		}
	    	}
	    	if(cdiffsum != 0) {
	    		for(int j = FEntity3.size() - 1; j >= 0; j--) {
	    			VoucherEntity ve = FEntity3.get(j);
	    			Double c = ve.getFCREDIT();
	    			if(ve != null) {
	    				BigDecimal s1 = new BigDecimal(Double.toString(c));
		                BigDecimal s2 = new BigDecimal(Double.toString(cdiffsum));
		                c = s1.add(s2).doubleValue();
		                if(c > 0) {
		                	ve.setFCREDIT(c);
		                	ve.setFAMOUNTFOR(c);
		                	break;
		                }
	    			}
	    			 
	    		}
	    	}
	    	
	    	FEntity.addAll(FEntity0);
	    	FEntity.addAll(FEntity1);
	    	FEntity.addAll(FEntity2);
	    	FEntity.addAll(FEntity3);
	    	FEntity.addAll(FEntity4);
	    	
	    	/*for(int i=0; i< FEntity.size(); i++) {
	    		VoucherEntity ve = FEntity.get(i);
				Double d = ve.getFDEBIT();
				Double c = ve.getFCREDIT();
				if(d != null) {
					System.out.println("=====d====" + d);
				}
				if(c != null) {
					System.out.println("=====c====" + c);
				}
	    	}*/
	
			vc.setFEntity(FEntity);
			
			//Gson gsons = new Gson();
		    //String s = gsons.toJson(vc);
			
			lp.add(new SaveParam<Voucher>(vc).toJson());

			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> list = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = list.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
			}else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
		}catch(Throwable e){
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println("采购入库凭证生成失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败：" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
		
	}
	
	/**
	 * 采购退货
	 * FAccountBookID 账簿   日期  年  月
	 *  String fEXPLANATION 摘要, Double amt 商品金额, Double taxAmt 进项税额, Double payAmt 应付款
	 *  orderAmt采购退货金额
	 *  
	 *  年-月-日从XXX采购退货多少金额（例：2020-06-04从北京新华奥商贸有限责任公司采购退货5789.65）单据的金额
	 *  
	 *  采购退货-常规订单和备货订单
	 *  d	1405	库存商品
		d	2221.01.01	应交税费_应交增值税_进项税额
		d	6601.05.01	销售运费-采购运费
		c	2202.02	应付账款_明细应付款
 		采购退货-急件订单
 		d	1405	库存商品
		d	2221.01.01	应交税费_应交增值税_进项税额
		c	2202.02	应付账款_明细应付款
		
		退货金额和成本差异
		d	1901.01 待处理财产损溢_采购退货成本差异
		d	2221.01.01	应交税费_应交增值税_进项税额
		c	2202.02	应付账款_明细应付款
		
	 */
	@Bizlet("采购退货生成凭证")
	public static HashMap addPurchaseRtn(Long pchsRtnMainId, String serviceNo, String bookId, String date, String year, String month, String day, 
			String supplierId, String guestName, Double orderAmt, Integer taxSign, Double taxRate) throws Exception {
		
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");
		try{
			lp.add("part");
			lp.add(serviceNo);
			lp.add("采购退货生成凭证");
			lp.add("addPurchaseRtn");
			lp.add(2);
			
			String preTitle = "";

			if(serviceNo != null && serviceNo != "") {
				preTitle = serviceNo + "-";
			}
		
			BigDecimal bamt = new BigDecimal(orderAmt);
			orderAmt = bamt.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + "从" + guestName + "采购退货" + orderAmt;
			
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			//获取凭证号
			//vc.setFVOUCHERGROUPNO(groupNo);
			
			Double dsum = 0.0;
			Double csum = 0.0;
			List<VoucherEntity> FEntity = new ArrayList();
			
			//查询库存商品
			HashMap pr = new HashMap();
	    	pr.put("pchsRtnMainId",pchsRtnMainId);
	    	Object[] objr = DatabaseExt.queryByNamedSql("part","com.hs.kinginterface.query.queryPchsRtnAmt", pr);
	    	List<DataObject> pchsRtnList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(pchsRtnList, objr);
	    	
	    	//含税
	    	Object[] objrt = DatabaseExt.queryByNamedSql("part","com.hs.kinginterface.query.queryPchsRtnTaxAmt", pr);
	    	List<DataObject> pchsRtnTaxList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(pchsRtnTaxList, objrt);
	    	
	    	List<VoucherEntity> FEntity0 = new ArrayList();//库存商品
	    	List<VoucherEntity> FEntity1 = new ArrayList();//应交税费-应交增值税-进项税额-保时捷571.77
	    	List<VoucherEntity> FEntity2 = new ArrayList();//销售费用-采购运费-保时捷8
	    	List<VoucherEntity> FEntity3 = new ArrayList();//应付账款- 广州市万德汽车配件有限公司-保时捷4970
	    	List<VoucherEntity> FEntity4 = new ArrayList();//差异借
	    	List<VoucherEntity> FEntity5 = new ArrayList();//差异贷
	    	
	    	//库存商品    	
	    	for(int i = 0; i<pchsRtnList.size(); i++) {
	        	DataObject d = pchsRtnList.get(i);
	        	
	        	String kingDeptCode = d.getString("kingDeptCode");
	        	Double noTaxCostAmt = d.getDouble("noTaxCostAmt");
	        	Double expAmt = d.getDouble("expenseAmt");
	        	Double enterAmt = d.getDouble("enterAmt");
	        	Double diffAmt = d.getDouble("diffAmt");
	        	BigDecimal b = new BigDecimal(noTaxCostAmt);
	        	noTaxCostAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	BigDecimal p1 = new BigDecimal(Double.toString(dsum));
	            BigDecimal p2 = new BigDecimal(Double.toString(noTaxCostAmt));
	            dsum = p1.add(p2).doubleValue();
	        	
	            if(noTaxCostAmt!=0) {
		        	VoucherEntity ve = getVoucherEntity(serviceNo, "1405", "D", fEXPLANATION, kingDeptCode, supplierId, noTaxCostAmt);
		        	FEntity0.add(ve);
	            }
	        	
	        	b = new BigDecimal(expAmt);
	        	expAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(expAmt > 0) {
		        	
		        	p1 = new BigDecimal(Double.toString(dsum));
		            p2 = new BigDecimal(Double.toString(expAmt));
		            dsum = p1.add(p2).doubleValue();
		            
		        	VoucherEntity vt = getVoucherEntity(serviceNo, "6601.05.01", "D", fEXPLANATION, kingDeptCode, supplierId, expAmt);
		        	FEntity2.add(vt);
	        	}
	        	
	        	b = new BigDecimal(enterAmt);
	        	enterAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	p1 = new BigDecimal(Double.toString(csum));
	            p2 = new BigDecimal(Double.toString(enterAmt));
	            csum = p1.add(p2).doubleValue();
	        	
	            if(enterAmt != 0) {
		        	VoucherEntity vt = getVoucherEntity(serviceNo, "2202.02", "C", fEXPLANATION, kingDeptCode, supplierId, enterAmt);
		        	FEntity3.add(vt);
	            }
	            
	            if(diffAmt != 0){
	            	if(taxSign == 0) {
	            		b = new BigDecimal(diffAmt);
	            		diffAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	            		
	            		p1 = new BigDecimal(Double.toString(dsum));
			            p2 = new BigDecimal(Double.toString(diffAmt));
			            dsum = p1.add(p2).doubleValue();
	    	        	
	            		VoucherEntity vt = getVoucherEntity(serviceNo, "1901.01", "D", fEXPLANATION, kingDeptCode, supplierId, diffAmt);
			        	FEntity4.add(vt);
			        	
			        	p1 = new BigDecimal(Double.toString(csum));
			            p2 = new BigDecimal(Double.toString(diffAmt));
			            csum = p1.add(p2).doubleValue();
			        	
			        	VoucherEntity vt2 = getVoucherEntity(serviceNo, "2202.02", "C", fEXPLANATION, kingDeptCode, supplierId, diffAmt);
			        	FEntity5.add(vt2);
	            	}else {
	            		BigDecimal b1 = new BigDecimal(diffAmt.toString());
		            	BigDecimal b2 = new BigDecimal(1+taxRate);
		            	BigDecimal b3 = new BigDecimal(taxRate);
		            	Double diffAmtTax = new Double(b1.divide(b2, 10, BigDecimal.ROUND_HALF_UP).multiply(b3)
		                        .doubleValue());
		            	b = new BigDecimal(diffAmtTax);
		            	diffAmtTax = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
		            	
		            	BigDecimal d1 = new BigDecimal(Double.toString(diffAmt));
		    	        BigDecimal d2 = new BigDecimal(Double.toString(diffAmtTax));
		    	        Double loseAmt = d1.subtract(d2).doubleValue();//待处理财产损溢_采购退货成本差异
		    	        
		    	        if(loseAmt != 0) {
		    	        	p1 = new BigDecimal(Double.toString(dsum));
				            p2 = new BigDecimal(Double.toString(loseAmt));
				            dsum = p1.add(p2).doubleValue();
				            
		    	        	VoucherEntity vt = getVoucherEntity(serviceNo, "1901.01", "D", fEXPLANATION, kingDeptCode, supplierId, loseAmt);
				        	FEntity4.add(vt);
		    	        }
		    	        if(diffAmtTax != 0) {
		    	        	p1 = new BigDecimal(Double.toString(dsum));
				            p2 = new BigDecimal(Double.toString(diffAmtTax));
				            dsum = p1.add(p2).doubleValue();
				            
		    	        	VoucherEntity vt = getVoucherEntity(serviceNo, "2221.01.01", "D", fEXPLANATION, kingDeptCode, supplierId, diffAmtTax);
				        	FEntity4.add(vt);
		    	        }
		    	        
		    	        
		    	        p1 = new BigDecimal(Double.toString(csum));
			            p2 = new BigDecimal(Double.toString(diffAmt));
			            csum = p1.add(p2).doubleValue();
			            
		    	        VoucherEntity vt2 = getVoucherEntity(serviceNo, "2202.02", "C", fEXPLANATION, kingDeptCode, supplierId, diffAmt);
			        	FEntity5.add(vt2);
		            	
	            	}
	            }
	        }
	    	
	    	//应交税费-应交增值税-进项税额-保时捷571.77
	    	for(int i = 0; i<pchsRtnTaxList.size(); i++) {
	        	DataObject d = pchsRtnTaxList.get(i);
	        	
	        	String kingDeptCode = d.getString("kingDeptCode");
	        	Double taxDiff = d.getDouble("taxDiff");
	        	BigDecimal b = new BigDecimal(taxDiff);
	        	taxDiff = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	BigDecimal p1 = new BigDecimal(Double.toString(dsum));
	            BigDecimal p2 = new BigDecimal(Double.toString(taxDiff));
	            dsum = p1.add(p2).doubleValue();
	            
	        	VoucherEntity vt = getVoucherEntity(serviceNo, "2221.01.01", "D", fEXPLANATION, kingDeptCode, supplierId, taxDiff);
	        	FEntity1.add(vt);
	        }
	    	
	    	//销售费用-采购运费-保时捷8
	    	/*for(int i = 0; i<pchsRtnList.size(); i++) {
	        	DataObject d = pchsRtnList.get(i);
	        	
	        	String kingDeptCode = d.getString("kingDeptCode");
	        	Double expAmt = d.getDouble("expenseAmt");
	        	

	        	BigDecimal b = new BigDecimal(expAmt);
	        	expAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(expAmt > 0) {
		        	
		        	BigDecimal p1 = new BigDecimal(Double.toString(dsum));
		            BigDecimal p2 = new BigDecimal(Double.toString(expAmt));
		            dsum = p1.add(p2).doubleValue();
		            
		        	VoucherEntity vt = getVoucherEntity(serviceNo, "6601.05.01", "D", fEXPLANATION, kingDeptCode, supplierId, expAmt);
		        	FEntity2.add(vt);
	        	}
	        }*/
			
	    	//应付账款- 广州市万德汽车配件有限公司-保时捷4970
	    	/*for(int i = 0; i<pchsRtnList.size(); i++) {
	        	DataObject d = pchsRtnList.get(i);
	        	
	        	String kingDeptCode = d.getString("kingDeptCode");
	        	Double enterAmt = d.getDouble("enterAmt");
	        	BigDecimal b = new BigDecimal(enterAmt);
	        	enterAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	BigDecimal p1 = new BigDecimal(Double.toString(csum));
	            BigDecimal p2 = new BigDecimal(Double.toString(enterAmt));
	            csum = p1.add(p2).doubleValue();
	        	
	        	VoucherEntity vt = getVoucherEntity(serviceNo, "2202.02", "C", fEXPLANATION, kingDeptCode, supplierId, enterAmt);
	        	FEntity3.add(vt);
	        }*/
	    	
	    	BigDecimal p1 = new BigDecimal(Double.toString(orderAmt*-1.0));
	        BigDecimal p2 = new BigDecimal(Double.toString(dsum));
	        BigDecimal p3 = new BigDecimal(Double.toString(csum));
	        Double ddiffsum = p1.subtract(p2).doubleValue();//借方存在差异
	        Double cdiffsum = p1.subtract(p3).doubleValue();//贷方存在差异
	        
	        if(ddiffsum != 0) {
	    		for(int j = FEntity1.size() - 1; j >= 0; j--) {
	    			VoucherEntity ve = FEntity1.get(j);
	    			Double c = ve.getFDEBIT();
	    			if(ve != null) {
	    				BigDecimal s1 = new BigDecimal(Double.toString(c));
		                BigDecimal s2 = new BigDecimal(Double.toString(ddiffsum));
		                c = s1.add(s2).doubleValue();
		                if(c != 0) {
		                	ve.setFDEBIT(c);
		                	ve.setFAMOUNTFOR(c);
		                	break;
		                }
	    			}
	    			 
	    		}
	    	}
	    	if(cdiffsum != 0) {
	    		for(int j = FEntity5.size() - 1; j >= 0; j--) {
	    			VoucherEntity ve = FEntity5.get(j);
	    			Double c = ve.getFCREDIT();
	    			if(ve != null) {
	    				BigDecimal s1 = new BigDecimal(Double.toString(c));
		                BigDecimal s2 = new BigDecimal(Double.toString(cdiffsum));
		                c = s1.add(s2).doubleValue();
		                if(c != 0) {
		                	ve.setFCREDIT(c);
		                	ve.setFAMOUNTFOR(c);
		                	break;
		                }
	    			}
	    			 
	    		}
	    	}
	
	    	/*System.out.println("===========diffsum========="+diffsum);
	    	//如果借方和贷方存在金额差异，则将差异金额加到贷方
	    	if(diffsum > 0.0001 || diffsum < -0.0001) {
	    		for(int j = FEntity.size() - 1; j > 0; j--) {
	    			VoucherEntity ve = FEntity.get(j);
	    			Double c = ve.getFCREDIT();
	    			if(ve != null) {
	    				BigDecimal s1 = new BigDecimal(Double.toString(c));
		                BigDecimal s2 = new BigDecimal(Double.toString(diffsum));
		                c = s1.add(s2).doubleValue();
		                if(c > 0) {
		                	ve.setFCREDIT(c);
		                	break;
		                }
	    			}
	    			 
	    		}
	    	}*/
	
	    	FEntity.addAll(FEntity0);
	    	FEntity.addAll(FEntity1);
	    	FEntity.addAll(FEntity2);
	    	FEntity.addAll(FEntity3);
	    	FEntity.addAll(FEntity4);
	    	FEntity.addAll(FEntity5);
	    	
			vc.setFEntity(FEntity);
			
			lp.add(new SaveParam<Voucher>(vc).toJson());
			
			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> list = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = list.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
				
			} else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
		}catch(Throwable e) {
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println("采购退货凭证生成失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败：" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
		
	}
	
	/**
	 *           年-月-日销售给XXX多少金额（例：2020-06-04销售给铜陵智远之星汽车服务有限公司5789.65）单据的金额
	 *           orderTypeAccountCode 销售类型在金蝶中对应的科目编码
	 *  d	1122	应收账款
		d	6601.29.01	销售费用-销售优惠-开单差异额
		d	6601.29.02	销售费用-销售优惠-结算单位返点
		d	6601.29.03	销售费用-销售优惠-销售类型返点
		c	6001.01	主营业务收入
		c	2221.01.02	应交税费_应交增值税_销项税额
		c	2241.06.01	其他应付款-销售优惠-开单差异额
		c	2241.06.02	其他应付款-销售优惠-结算单位返点
		c	2241.06.03.01	其他应付款-销售优惠-销售类型返点-正常销售
		c	2241.06.03.02	其他应付款-销售优惠-销售类型返点-保险业务
		c	2241.06.03.03	其他应付款-销售优惠-销售类型返点-开思平台
		c	2241.06.03.04	其他应付款-销售优惠-销售类型返点-创配平台（平安）
		c	2241.06.03.05	其他应付款-销售优惠-销售类型返点-驾安配平台（人保）
		c	2241.06.03.06	其他应付款-销售优惠-销售类型返点-商铺开思平台
		d	6401.01	主营业务成本
		c	1405	库存商品

	 * 
	 */
	@Bizlet("销售出库生成凭证")
	public static HashMap addSell(Long orderMainId, Long outMainId, String serviceNo, String bookId, String date, String year, String month, String day, 
			String orderTypeAccountCode,Integer taxSign, String clientId, String guestName, Double orderAmt) throws Exception {
		
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");
		try{
			lp.add("part");
			lp.add(serviceNo);
			lp.add("销售出库生成凭证");
			lp.add("addSell");
			lp.add(3);
			
			String preTitle = "";

			if(serviceNo != null && serviceNo != "") {
				preTitle = serviceNo + "-";
			}
			
			//如果 amt 是不含税金额，怎么处理
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			BigDecimal bamt = new BigDecimal(orderAmt);
			orderAmt = bamt.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + "销售给" + guestName + orderAmt;
			
			//clientId = "192716501";
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			Double dsum = 0.0;
			Double csum = 0.0;
			List<VoucherEntity> FEntity0 = new ArrayList();//应收账款
			List<VoucherEntity> FEntity1 = new ArrayList();//销售费用-销售优惠-开单差异额  	
			List<VoucherEntity> FEntity2 = new ArrayList();//销售费用-销售优惠-结算单位返点	
			List<VoucherEntity> FEntity3 = new ArrayList();//销售费用-销售优惠-销售类型返点	
			
			//应收账款
			HashMap pr = new HashMap();
	    	pr.put("orderMainId",orderMainId);
	    	Object[] objr = DatabaseExt.queryByNamedSql("part","com.hs.kinginterface.query.querySellOrderAmt", pr);
	    	List<DataObject> sellOrderList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(sellOrderList, objr);
	    	
	    	//库存商品
	    	pr.put("outMainId",outMainId);
	    	Object[] objrt = DatabaseExt.queryByNamedSql("part","com.hs.kinginterface.query.querySellOutAmt", pr);
	    	List<DataObject> sellOutList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(sellOutList, objrt);
	    	
	    	//应收账款  	
	    	for(int i = 0; i<sellOrderList.size(); i++) {
	        	DataObject d = sellOrderList.get(i);
	        	
	        	String kingDeptCode = d.getString("kingDeptCode");
	        	Double showAmt = d.getDouble("showAmt");
	        	Double showDiffAmt = d.getDouble("showDiffAmt");
	        	Double settleGuestRebateAmt = d.getDouble("settleGuestRebateAmt");
	        	Double businessTypeRebateAmt = d.getDouble("businessTypeRebateAmt");
	        	
	        	BigDecimal b = new BigDecimal(showAmt);
	        	showAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	BigDecimal p1 = new BigDecimal(Double.toString(dsum));
	            BigDecimal p2 = new BigDecimal(Double.toString(showAmt));
	            dsum = p1.add(p2).doubleValue();
	        	
	        	VoucherEntity ve = getVoucherEntity(serviceNo, "1122", "D", fEXPLANATION, kingDeptCode, clientId, showAmt);
	        	FEntity0.add(ve);
	        	

	        	b = new BigDecimal(showDiffAmt);
	        	showDiffAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(showDiffAmt > 0) {
		        	
		        	p1 = new BigDecimal(Double.toString(dsum));
		            p2 = new BigDecimal(Double.toString(showDiffAmt));
		            dsum = p1.add(p2).doubleValue();
		        	
		        	VoucherEntity vshowDiff = getVoucherEntity(serviceNo, "6601.29.01", "D", fEXPLANATION, kingDeptCode, clientId, showDiffAmt);
		        	FEntity1.add(vshowDiff);
	        	}
	        	

	        	b = new BigDecimal(settleGuestRebateAmt);
	        	settleGuestRebateAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(settleGuestRebateAmt > 0) {
		        	
		        	p1 = new BigDecimal(Double.toString(dsum));
		            p2 = new BigDecimal(Double.toString(settleGuestRebateAmt));
		            dsum = p1.add(p2).doubleValue();
		        	
		        	VoucherEntity vsettleGuestRebateAmt = getVoucherEntity(serviceNo, "6601.29.02", "D", fEXPLANATION, kingDeptCode, clientId, settleGuestRebateAmt);
		        	FEntity2.add(vsettleGuestRebateAmt);
	        	}
	        	

	        	b = new BigDecimal(businessTypeRebateAmt);
	        	businessTypeRebateAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(businessTypeRebateAmt > 0) {
		        	
		        	p1 = new BigDecimal(Double.toString(dsum));
		            p2 = new BigDecimal(Double.toString(businessTypeRebateAmt));
		            dsum = p1.add(p2).doubleValue();
		        	
		        	VoucherEntity vbusinessTypeRebateAmt = getVoucherEntity(serviceNo, "6601.29.03", "D", fEXPLANATION, kingDeptCode, clientId, businessTypeRebateAmt);
		        	FEntity3.add(vbusinessTypeRebateAmt);
	        	}
	        }
	    	
	    	List<VoucherEntity> FEntity4 = new ArrayList();//主营业务收入
	    	List<VoucherEntity> FEntity5 = new ArrayList();//应交税费_应交增值税_销项税额
	    	//如果不含税销售，主营业务收入 = 应收账款，且不用 生成   2221.01.02	应交税费_应交增值税_销项税额
			//如果含税销售，主营业务收入 = 应收账款/1.13，且 生成   2221.01.02	应交税费_应交增值税_销项税额 应收账款/1.13*0.13
			// 100 = 100/1.13 + 100/1.13 * 0.13
	    	if(taxSign == 1) {
	    		for(int i = 0; i<sellOrderList.size(); i++) {
	            	DataObject d = sellOrderList.get(i);
	            	
	            	String kingDeptCode = d.getString("kingDeptCode");
	            	Double showAmt = d.getDouble("showAmt");
	            	
	            	BigDecimal b1 = new BigDecimal(showAmt.toString());
	            	BigDecimal b2 = new BigDecimal("1.13");
	            	showAmt = new Double(b1.divide(b2, 10, BigDecimal.ROUND_HALF_UP)
	                        .doubleValue());
	            	
	            	b1 = new BigDecimal(showAmt.toString());
	            	b2 = new BigDecimal("0.13");
	            	Double brandShowAmt =  new Double(b1.multiply(b2).doubleValue());
	            	
	            	BigDecimal b = new BigDecimal(showAmt);
	            	showAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	            	
	            	b = new BigDecimal(brandShowAmt);
	            	brandShowAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	            	
	            	BigDecimal p1 = new BigDecimal(Double.toString(csum));
	                BigDecimal p2 = new BigDecimal(Double.toString(showAmt));
	                csum = p1.add(p2).doubleValue();
	                
	                p1 = new BigDecimal(Double.toString(csum));
	                p2 = new BigDecimal(Double.toString(brandShowAmt));
	                csum = p1.add(p2).doubleValue();
		        	
	                if(showAmt > 0) {
			        	VoucherEntity ve = getVoucherEntity(serviceNo, "6001.01", "C", fEXPLANATION, kingDeptCode, clientId, showAmt);
			        	FEntity4.add(ve);
	                }
		        	
	                if(brandShowAmt>0) {
			        	VoucherEntity vb = getVoucherEntity(serviceNo, "2221.01.02", "C", fEXPLANATION, kingDeptCode, clientId, brandShowAmt);
			        	FEntity5.add(vb);
	                }
	            }
	    	}else {
	    		for(int i = 0; i<sellOrderList.size(); i++) {
	            	DataObject d = sellOrderList.get(i);
	            	
	            	String kingDeptCode = d.getString("kingDeptCode");
	            	Double showAmt = d.getDouble("showAmt");
	            
	            	BigDecimal p1 = new BigDecimal(Double.toString(csum));
	                BigDecimal p2 = new BigDecimal(Double.toString(showAmt));
	                csum = p1.add(p2).doubleValue();
	                
	                if(showAmt > 0) {
			        	VoucherEntity ve = getVoucherEntity(serviceNo, "6001.01", "C", fEXPLANATION, kingDeptCode, clientId, showAmt);
			        	FEntity4.add(ve);
	                }
	            }
	    	}
	    	
	
			List<VoucherEntity> FEntity6 = new ArrayList();//其他应付款-销售优惠-开单差异额	
			List<VoucherEntity> FEntity7 = new ArrayList();//其他应付款-销售优惠-结算单位返点	
			List<VoucherEntity> FEntity8 = new ArrayList();//其他应付款-销售优惠-销售类型返点-正常销售
			for(int i = 0; i < FEntity1.size(); i++) {
				VoucherEntity FEntity = FEntity1.get(i);
				Double showDiffAmt = FEntity.getFAMOUNTFOR();
				String kingDeptCode = FEntity.getFDetailID().getFDETAILID__FFLEX5().getFNumber();
				
				BigDecimal p1 = new BigDecimal(Double.toString(csum));
	            BigDecimal p2 = new BigDecimal(Double.toString(showDiffAmt));
	            csum = p1.add(p2).doubleValue();
				if(showDiffAmt>0){
		        	VoucherEntity ve = getVoucherEntity(serviceNo, "2241.06.01", "C", fEXPLANATION, kingDeptCode, clientId, showDiffAmt);
		        	FEntity6.add(ve);
				}
			}
			
			for(int i = 0; i < FEntity2.size(); i++) {
				VoucherEntity FEntity = FEntity2.get(i);
				Double settleGuestRebateAmt = FEntity.getFAMOUNTFOR();
	        	//Double settleGuestRebateAmt = d.getDouble("settleGuestRebateAmt");
	        	//Double businessTypeRebateAmt = d.getDouble("businessTypeRebateAmt");
				String kingDeptCode = FEntity.getFDetailID().getFDETAILID__FFLEX5().getFNumber();
				
				BigDecimal p1 = new BigDecimal(Double.toString(csum));
	            BigDecimal p2 = new BigDecimal(Double.toString(settleGuestRebateAmt));
	            csum = p1.add(p2).doubleValue();
				
	            if(settleGuestRebateAmt>0){
		        	VoucherEntity ve = getVoucherEntity(serviceNo, "2241.06.02", "C", fEXPLANATION, kingDeptCode, clientId, settleGuestRebateAmt);
		        	FEntity7.add(ve);
	            }
			}
			
			for(int i = 0; i < FEntity3.size(); i++) {
				VoucherEntity FEntity = FEntity3.get(i);
				Double businessTypeRebateAmt = FEntity.getFAMOUNTFOR();
				String kingDeptCode = FEntity.getFDetailID().getFDETAILID__FFLEX5().getFNumber();
				
				BigDecimal p1 = new BigDecimal(Double.toString(csum));
	            BigDecimal p2 = new BigDecimal(Double.toString(businessTypeRebateAmt));
	            csum = p1.add(p2).doubleValue();
				
	            if(businessTypeRebateAmt>0){
		        	VoucherEntity ve = getVoucherEntity(serviceNo, orderTypeAccountCode, "C", fEXPLANATION, kingDeptCode, clientId, businessTypeRebateAmt);
		        	FEntity8.add(ve);
	            }
			}
	    	
	    	
	
			List<VoucherEntity> FEntity9 = new ArrayList();//主营业务成本
			List<VoucherEntity> FEntity10 = new ArrayList();//库存商品
	    	//主营业务成本
	    	for(int i = 0; i<sellOutList.size(); i++) {
	        	DataObject d = sellOutList.get(i);
	        	
	        	String kingDeptCode = d.getString("kingDeptCode");
	        	Double noTaxCostAmt = d.getDouble("noTaxCostAmt");
	        	
	        	BigDecimal p1 = new BigDecimal(Double.toString(dsum));
	            BigDecimal p2 = new BigDecimal(Double.toString(noTaxCostAmt));
	            BigDecimal p3 = new BigDecimal(Double.toString(csum));
	            dsum = p1.add(p2).doubleValue();
	            csum = p2.add(p3).doubleValue();
	        	
	        	BigDecimal b = new BigDecimal(noTaxCostAmt);
	        	noTaxCostAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(noTaxCostAmt>0) {
		        	VoucherEntity vt = getVoucherEntity(serviceNo, "6401.01", "D", fEXPLANATION, kingDeptCode, clientId, noTaxCostAmt);
		        	FEntity9.add(vt);
	        	
		        	VoucherEntity ve = getVoucherEntity(serviceNo, "1405", "C", fEXPLANATION, kingDeptCode, clientId, noTaxCostAmt);
		        	FEntity10.add(ve);
		    	}
	        }
	
	    	BigDecimal p1 = new BigDecimal(Double.toString(dsum));
	        BigDecimal p2 = new BigDecimal(Double.toString(csum));
	        Double diffsum = p1.subtract(p2).doubleValue();
	
	    	//如果借方和贷方存在金额差异，则将差异金额加到贷方
	    	if(diffsum != 0) {
	    		for(int j = FEntity4.size() - 1; j >= 0; j--) {
	    			VoucherEntity ve = FEntity4.get(j);
	    			Double c = ve.getFCREDIT();
	    			if(ve != null) {
	    				BigDecimal s1 = new BigDecimal(Double.toString(c));
		                BigDecimal s2 = new BigDecimal(Double.toString(diffsum));
		                c = s1.add(s2).doubleValue();
		                if(c > 0) {
		                	ve.setFCREDIT(c);
		                	ve.setFAMOUNTFOR(c);
		                	break;
		                }
	    			}
	    			 
	    		}
	    	}
	    	
	    	List<VoucherEntity> FEntity = new ArrayList();//主营业务成本
	    	FEntity.addAll(FEntity0);
	    	FEntity.addAll(FEntity1);
	    	FEntity.addAll(FEntity2);
	    	FEntity.addAll(FEntity3);
	    	FEntity.addAll(FEntity4);
	    	FEntity.addAll(FEntity5);
	    	FEntity.addAll(FEntity6);
	    	FEntity.addAll(FEntity7);
	    	FEntity.addAll(FEntity8);
	    	FEntity.addAll(FEntity9);
	    	FEntity.addAll(FEntity10);
	
	
			vc.setFEntity(FEntity);
				
			lp.add(new SaveParam<Voucher>(vc).toJson());
			
			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> list = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = list.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
				
			} else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
		}catch(Throwable e) {
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println("销售出库凭证生成失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败：" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
		
	}
	
	/**
	 *           年-月-日销售给XXX多少金额（例：2020-06-04销售给铜陵智远之星汽车服务有限公司5789.65）单据的金额
	 *           orderTypeAccountCode 销售类型在金蝶中对应的科目编码
	 *  d	1122	应收账款
		d	6601.29.01	销售费用-销售优惠-开单差异额
		d	6601.29.02	销售费用-销售优惠-结算单位返点
		d	6601.29.03	销售费用-销售优惠-销售类型返点
		c	6001.01	主营业务收入
		c	2221.01.02	应交税费_应交增值税_销项税额
		c	2241.06.01	其他应付款-销售优惠-开单差异额
		c	2241.06.02	其他应付款-销售优惠-结算单位返点
		c	2241.06.03.01	其他应付款-销售优惠-销售类型返点-正常销售
		c	2241.06.03.02	其他应付款-销售优惠-销售类型返点-保险业务
		c	2241.06.03.03	其他应付款-销售优惠-销售类型返点-开思平台
		c	2241.06.03.04	其他应付款-销售优惠-销售类型返点-创配平台（平安）
		c	2241.06.03.05	其他应付款-销售优惠-销售类型返点-驾安配平台（人保）
		c	2241.06.03.06	其他应付款-销售优惠-销售类型返点-商铺开思平台
		d	6401.01	主营业务成本
		c	1405	库存商品

	 * 
	 */
	@Bizlet("销售退货生成凭证")
	public static HashMap addSellRtn(Long orderMainId, Long outMainId, String serviceNo, String bookId, String date, String year, String month, String day, 
			String orderTypeAccountCode,Integer taxSign, String clientId, String guestName, Double orderAmt) throws Exception {
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");
		
		try{
			lp.add("part");
			lp.add(serviceNo);
			lp.add("销售退货生成凭证");
			lp.add("addSellRtn");
			lp.add(4);
			
			String preTitle = "";

			if(serviceNo != null && serviceNo != "") {
				preTitle = serviceNo + "-";
			}
		
			//如果 amt 是不含税金额，怎么处理
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			BigDecimal bamt = new BigDecimal(orderAmt);
			orderAmt = bamt.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + guestName + "销售退货" + orderAmt;
			
			//clientId = "192716501";
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			Double dsum = 0.0;
			Double csum = 0.0;
			List<VoucherEntity> FEntity0 = new ArrayList();//应收账款
			List<VoucherEntity> FEntity1 = new ArrayList();//销售费用-销售优惠-开单差异额  	
			List<VoucherEntity> FEntity2 = new ArrayList();//销售费用-销售优惠-结算单位返点	
			List<VoucherEntity> FEntity3 = new ArrayList();//销售费用-销售优惠-销售类型返点	
			
			//应收账款
			HashMap pr = new HashMap();
	    	pr.put("orderMainId",orderMainId);
	    	Object[] objr = DatabaseExt.queryByNamedSql("part","com.hs.kinginterface.query.querySellRtnOrderAmt", pr);
	    	List<DataObject> sellOrderList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(sellOrderList, objr);
	    	
	    	//库存商品
	    	pr.put("outMainId",outMainId);
	    	Object[] objrt = DatabaseExt.queryByNamedSql("part","com.hs.kinginterface.query.querySellRtnOutAmt", pr);
	    	List<DataObject> sellOutList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(sellOutList, objrt);
	    	
	    	//应收账款  	
	    	for(int i = 0; i<sellOrderList.size(); i++) {
	        	DataObject d = sellOrderList.get(i);
	        	
	        	String kingDeptCode = d.getString("kingDeptCode");
	        	Double showAmt = d.getDouble("showAmt");
	        	Double showDiffAmt = d.getDouble("showDiffAmt");
	        	Double settleGuestRebateAmt = d.getDouble("settleGuestRebateAmt");
	        	Double businessTypeRebateAmt = d.getDouble("businessTypeRebateAmt");
	        	
	        	BigDecimal b = new BigDecimal(showAmt);
	        	showAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	BigDecimal p1 = new BigDecimal(Double.toString(dsum));
	            BigDecimal p2 = new BigDecimal(Double.toString(showAmt));
	            dsum = p1.add(p2).doubleValue();
	        	
	        	VoucherEntity ve = getVoucherEntity(serviceNo, "1122", "D", fEXPLANATION, kingDeptCode, clientId, showAmt);
	        	FEntity0.add(ve);
	        	

	        	b = new BigDecimal(showDiffAmt);
	        	showDiffAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(showDiffAmt < 0) {
		        	
		        	p1 = new BigDecimal(Double.toString(dsum));
		            p2 = new BigDecimal(Double.toString(showDiffAmt));
		            dsum = p1.add(p2).doubleValue();
		        	
		        	VoucherEntity vshowDiff = getVoucherEntity(serviceNo, "6601.29.01", "D", fEXPLANATION, kingDeptCode, clientId, showDiffAmt);
		        	FEntity1.add(vshowDiff);
	        	}
	        	

	        	b = new BigDecimal(settleGuestRebateAmt);
	        	settleGuestRebateAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(settleGuestRebateAmt < 0) {
		        	
		        	p1 = new BigDecimal(Double.toString(dsum));
		            p2 = new BigDecimal(Double.toString(settleGuestRebateAmt));
		            dsum = p1.add(p2).doubleValue();
		        	
		        	VoucherEntity vsettleGuestRebateAmt = getVoucherEntity(serviceNo, "6601.29.02", "D", fEXPLANATION, kingDeptCode, clientId, settleGuestRebateAmt);
		        	FEntity2.add(vsettleGuestRebateAmt);
	        	}
	        	

	        	b = new BigDecimal(businessTypeRebateAmt);
	        	businessTypeRebateAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(businessTypeRebateAmt < 0) {
		        	
		        	p1 = new BigDecimal(Double.toString(dsum));
		            p2 = new BigDecimal(Double.toString(businessTypeRebateAmt));
		            dsum = p1.add(p2).doubleValue();
		        	
		        	VoucherEntity vbusinessTypeRebateAmt = getVoucherEntity(serviceNo, "6601.29.03", "D", fEXPLANATION, kingDeptCode, clientId, businessTypeRebateAmt);
		        	FEntity3.add(vbusinessTypeRebateAmt);
	        	}
	        }
	    	
	    	List<VoucherEntity> FEntity4 = new ArrayList();//主营业务收入
	    	List<VoucherEntity> FEntity5 = new ArrayList();//应交税费_应交增值税_销项税额
	    	//如果不含税销售，主营业务收入 = 应收账款，且不用 生成   2221.01.02	应交税费_应交增值税_销项税额
			//如果含税销售，主营业务收入 = 应收账款/1.13，且 生成   2221.01.02	应交税费_应交增值税_销项税额 应收账款/1.13*0.13
			// 100 = 100/1.13 + 100/1.13 * 0.13
	    	if(taxSign == 1) {
	    		for(int i = 0; i<sellOrderList.size(); i++) {
	            	DataObject d = sellOrderList.get(i);
	            	
	            	String kingDeptCode = d.getString("kingDeptCode");
	            	Double showAmt = d.getDouble("showAmt");
	            	
	            	BigDecimal b1 = new BigDecimal(showAmt.toString());
	            	BigDecimal b2 = new BigDecimal("1.13");
	            	showAmt = new Double(b1.divide(b2, 10, BigDecimal.ROUND_HALF_UP)
	                        .doubleValue());
	            	
	            	b1 = new BigDecimal(showAmt.toString());
	            	b2 = new BigDecimal("0.13");
	            	Double brandShowAmt =  new Double(b1.multiply(b2).doubleValue());
	            	
	            	BigDecimal b = new BigDecimal(showAmt);
	            	showAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	            	
	            	b = new BigDecimal(brandShowAmt);
	            	brandShowAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	            	
	            	BigDecimal p1 = new BigDecimal(Double.toString(csum));
	                BigDecimal p2 = new BigDecimal(Double.toString(showAmt));
	                csum = p1.add(p2).doubleValue();
	                
	                p1 = new BigDecimal(Double.toString(csum));
	                p2 = new BigDecimal(Double.toString(brandShowAmt));
	                csum = p1.add(p2).doubleValue();
		        	
	                if(showAmt < 0) {
			        	VoucherEntity ve = getVoucherEntity(serviceNo, "6001.01", "C", fEXPLANATION, kingDeptCode, clientId, showAmt);
			        	FEntity4.add(ve);
	                }
		        	
	                if(brandShowAmt<0) {
			        	VoucherEntity vb = getVoucherEntity(serviceNo, "2221.01.02", "C", fEXPLANATION, kingDeptCode, clientId, brandShowAmt);
			        	FEntity5.add(vb);
	                }
	            }
	    	}else {
	    		for(int i = 0; i<sellOrderList.size(); i++) {
	            	DataObject d = sellOrderList.get(i);
	            	
	            	String kingDeptCode = d.getString("kingDeptCode");
	            	Double showAmt = d.getDouble("showAmt");
	            
	            	BigDecimal p1 = new BigDecimal(Double.toString(csum));
	                BigDecimal p2 = new BigDecimal(Double.toString(showAmt));
	                csum = p1.add(p2).doubleValue();
	                
	                if(showAmt < 0) {
			        	VoucherEntity ve = getVoucherEntity(serviceNo, "6001.01", "C", fEXPLANATION, kingDeptCode, clientId, showAmt);
			        	FEntity4.add(ve);
	                }
	            }
	    	}
	    	
	
			List<VoucherEntity> FEntity6 = new ArrayList();//其他应付款-销售优惠-开单差异额	
			List<VoucherEntity> FEntity7 = new ArrayList();//其他应付款-销售优惠-结算单位返点	
			List<VoucherEntity> FEntity8 = new ArrayList();//其他应付款-销售优惠-销售类型返点-正常销售
			for(int i = 0; i < FEntity1.size(); i++) {
				VoucherEntity FEntity = FEntity1.get(i);
				Double showDiffAmt = FEntity.getFAMOUNTFOR();
				String kingDeptCode = FEntity.getFDetailID().getFDETAILID__FFLEX5().getFNumber();
				
				BigDecimal p1 = new BigDecimal(Double.toString(csum));
	            BigDecimal p2 = new BigDecimal(Double.toString(showDiffAmt));
	            csum = p1.add(p2).doubleValue();
				if(showDiffAmt<0){
		        	VoucherEntity ve = getVoucherEntity(serviceNo, "2241.06.01", "C", fEXPLANATION, kingDeptCode, clientId, showDiffAmt);
		        	FEntity6.add(ve);
				}
			}
			
			for(int i = 0; i < FEntity2.size(); i++) {
				VoucherEntity FEntity = FEntity2.get(i);
				Double settleGuestRebateAmt = FEntity.getFAMOUNTFOR();
	        	//Double settleGuestRebateAmt = d.getDouble("settleGuestRebateAmt");
	        	//Double businessTypeRebateAmt = d.getDouble("businessTypeRebateAmt");
				String kingDeptCode = FEntity.getFDetailID().getFDETAILID__FFLEX5().getFNumber();
				
				BigDecimal p1 = new BigDecimal(Double.toString(csum));
	            BigDecimal p2 = new BigDecimal(Double.toString(settleGuestRebateAmt));
	            csum = p1.add(p2).doubleValue();
				
	            if(settleGuestRebateAmt<0){
		        	VoucherEntity ve = getVoucherEntity(serviceNo, "2241.06.02", "C", fEXPLANATION, kingDeptCode, clientId, settleGuestRebateAmt);
		        	FEntity7.add(ve);
	            }
			}
			
			for(int i = 0; i < FEntity3.size(); i++) {
				VoucherEntity FEntity = FEntity3.get(i);
				Double businessTypeRebateAmt = FEntity.getFAMOUNTFOR();
				String kingDeptCode = FEntity.getFDetailID().getFDETAILID__FFLEX5().getFNumber();
				
				BigDecimal p1 = new BigDecimal(Double.toString(csum));
	            BigDecimal p2 = new BigDecimal(Double.toString(businessTypeRebateAmt));
	            csum = p1.add(p2).doubleValue();
				
	            if(businessTypeRebateAmt<0){
		        	VoucherEntity ve = getVoucherEntity(serviceNo, orderTypeAccountCode, "C", fEXPLANATION, kingDeptCode, clientId, businessTypeRebateAmt);
		        	FEntity8.add(ve);
	            }
			}
	    	
	    	
	
			List<VoucherEntity> FEntity9 = new ArrayList();//主营业务成本
			List<VoucherEntity> FEntity10 = new ArrayList();//库存商品
	    	//主营业务成本
	    	for(int i = 0; i<sellOutList.size(); i++) {
	        	DataObject d = sellOutList.get(i);
	        	
	        	String kingDeptCode = d.getString("kingDeptCode");
	        	Double noTaxCostAmt = d.getDouble("noTaxCostAmt");
	        	
	        	BigDecimal p1 = new BigDecimal(Double.toString(dsum));
	            BigDecimal p2 = new BigDecimal(Double.toString(noTaxCostAmt));
	            BigDecimal p3 = new BigDecimal(Double.toString(csum));
	            dsum = p1.add(p2).doubleValue();
	            csum = p2.add(p3).doubleValue();
	        	
	        	BigDecimal b = new BigDecimal(noTaxCostAmt);
	        	noTaxCostAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(noTaxCostAmt<0) {
		        	VoucherEntity vt = getVoucherEntity(serviceNo, "6401.01", "D", fEXPLANATION, kingDeptCode, clientId, noTaxCostAmt);
		        	FEntity9.add(vt);
	        	
		        	VoucherEntity ve = getVoucherEntity(serviceNo, "1405", "C", fEXPLANATION, kingDeptCode, clientId, noTaxCostAmt);
		        	FEntity10.add(ve);
		    	}
	        }
	
	    	BigDecimal p1 = new BigDecimal(Double.toString(dsum));
	        BigDecimal p2 = new BigDecimal(Double.toString(csum));
	        Double diffsum = p1.subtract(p2).doubleValue();
	
	    	//如果借方和贷方存在金额差异，则将差异金额加到贷方
	    	if(diffsum != 0) {
	    		for(int j = FEntity4.size() - 1; j >= 0; j--) {
	    			VoucherEntity ve = FEntity4.get(j);
	    			Double c = ve.getFCREDIT();
	    			if(ve != null) {
	    				BigDecimal s1 = new BigDecimal(Double.toString(c));
		                BigDecimal s2 = new BigDecimal(Double.toString(diffsum));
		                c = s1.add(s2).doubleValue();
		                if(c != 0) {
		                	ve.setFCREDIT(c);
		                	ve.setFAMOUNTFOR(c);
		                	break;
		                }
	    			}
	    			 
	    		}
	    	}
	    	
	    	List<VoucherEntity> FEntity = new ArrayList();//主营业务成本
	    	FEntity.addAll(FEntity0);
	    	FEntity.addAll(FEntity1);
	    	FEntity.addAll(FEntity2);
	    	FEntity.addAll(FEntity3);
	    	FEntity.addAll(FEntity4);
	    	FEntity.addAll(FEntity5);
	    	FEntity.addAll(FEntity6);
	    	FEntity.addAll(FEntity7);
	    	FEntity.addAll(FEntity8);
	    	FEntity.addAll(FEntity9);
	    	FEntity.addAll(FEntity10);
	
	
			vc.setFEntity(FEntity);
			
			lp.add(new SaveParam<Voucher>(vc).toJson());
			
			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> list = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = list.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
				
			} else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
		}catch(Throwable e){
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println("销售退货凭证生成失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败：" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
		
	}
	
	/**
	* 打包发货费用登记 
		年-月-日付XXX供应商什么费用多少金额（例：2020-06-04付铜陵智远之星汽车服务有限公司物流费用5789.65）
		d	6601.05.02	销售费用-销售运费
		c	2241.02	其他应付款_供应商往来
	 */
	@Bizlet("打包发货费用登记 ")
	public static HashMap addPackExpense(Integer packType, Long packMainId, String serviceNo, String bookId, String date, 
			String year, String month, String day,
			String guestId, String guestName, Double amt) throws Exception {
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");

		String fnumber = "6601.05.02";
		String name = "销售出库运费生成凭证";
		String tempStr = "销售运费";
		if(packType == 2) {
			fnumber = "6601.05.01";
			name = "采购退货运费生成凭证";
			tempStr = "采购退货运费";
		}
		if(packType == 3) {
			fnumber = "6601.05.02";
			name = "移仓出库运费生成凭证";
		}
		if(packType == 4) {
			fnumber = "6601.05.02";
			name = "盘盈入库运费生成凭证";
		}
		if(packType == 5) {
			fnumber = "6601.05.01";
			name = "盘亏出库运费生成凭证";
		}
		if(packType == 6) {
			fnumber = "6601.05.02";
			name = "预销售运费生成凭证";
		}
		
		try{
			
			lp.add("part");
			lp.add(serviceNo);
			lp.add(name);
			lp.add("addPackExpense");
			lp.add(5);
			
			String preTitle = "";

			if(serviceNo != null && serviceNo != "") {
				preTitle = serviceNo + "-";
			}
		
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + guestName + tempStr + amt;
			
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			Double dsum = 0.0;
			Double csum = 0.0;
			Double sellExpSum = 0.0;//销售费用-采购运费 运费总和
			Double otherExpSum = 0.0; //其他应付款-捷捷物流 运费总和
			List<VoucherEntity> FEntity = new ArrayList();
			List<VoucherEntity> FEntity1 = new ArrayList();
			List<VoucherEntity> FEntity2 = new ArrayList();
			
			String nameSql = "com.hs.kinginterface.query.querySellPackAmt";
			if(packType == 3) {
				nameSql = "com.hs.kinginterface.query.queryShiftOutPackAmt";
			}
			if(packType == 5) {
				nameSql = "com.hs.kinginterface.query.queryOutPackAmt";
			}
			if(packType == 4) {
				nameSql = "com.hs.kinginterface.query.queryEnterPackAmt";
			}
			
			//查询库存商品
			HashMap pr = new HashMap();
	    	pr.put("packMainId",packMainId);
	    	pr.put("packType",packType);
	    	Object[] objr = DatabaseExt.queryByNamedSql("part",nameSql, pr);
	    	List<DataObject> pchsList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(pchsList, objr);
	    	
	    	HashMap pre = new HashMap();
			pre.put("orderServiceNo",serviceNo);
	    	Object[] objexp = DatabaseExt.queryByNamedSql("part","com.hs.kinginterface.query.queryPchsExpenseRecordAmt", pre);
	    	List<DataObject> expRecordList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(expRecordList, objexp);
	    	
	    	for(int i = 0; i<pchsList.size(); i++) {
	        	DataObject d = pchsList.get(i);
	        	
	        	String kingDeptCode = d.getString("kingDeptCode");
	        	Double expAmt = d.getDouble("expenseAmt"); //分配到厂牌的费用
	        	
	        	BigDecimal b = new BigDecimal(expAmt);
	        	expAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(i == pchsList.size() - 1) {
	        		BigDecimal p1 = new BigDecimal(Double.toString(amt));
	                BigDecimal p2 = new BigDecimal(Double.toString(dsum));
	                expAmt = p1.subtract(p2).doubleValue();
	        	}
	        	
	        	BigDecimal p1 = new BigDecimal(Double.toString(dsum));
	            BigDecimal p2 = new BigDecimal(Double.toString(expAmt));
	            dsum = p1.add(p2).doubleValue();
	            
	        	VoucherEntity ve = getVoucherEntity(serviceNo, fnumber, "D", fEXPLANATION, kingDeptCode, guestId, expAmt);
	        	FEntity1.add(ve);
	        	
	        	Double dispatchExpSum = 0.0;
	        	for(int j = 0; j < expRecordList.size(); j++) {
	        		DataObject exp = expRecordList.get(j);
	        		String logisticsGuestId = exp.getString("logisticsGuestId");
		        	Double expRecordAmt = exp.getDouble("expenseAmt");//物流公司登记的费用
		        	
	            	Double otherExpAmt = 0.0;//  （物流公司登记的费用 / 总费用） * 分配到厂牌的费用
		        	
		        	if(j == expRecordList.size() - 1) {
	            		BigDecimal s1 = new BigDecimal(Double.toString(expAmt));
	                    BigDecimal s2 = new BigDecimal(Double.toString(dispatchExpSum));
	            		otherExpAmt = s1.subtract(s2).doubleValue();
	            	}else {
	            		
	            		BigDecimal b1 = new BigDecimal(expRecordAmt.toString());
		                BigDecimal b2 = new BigDecimal(amt.toString());
		                expRecordAmt = new Double(b1.divide(b2, 10, BigDecimal.ROUND_HALF_UP)
		                        .doubleValue());
		                
		                b1 = new BigDecimal(expRecordAmt.toString());
		                b2 = new BigDecimal(expAmt.toString());
		            	
		            	otherExpAmt = new Double(b1.multiply(b2).doubleValue());//expRecordAmt / amt * expAmt;
	            	}
		        	
		        	BigDecimal s1 = new BigDecimal(Double.toString(dispatchExpSum));
	                BigDecimal s2 = new BigDecimal(Double.toString(otherExpAmt));
	                dispatchExpSum = s1.add(s2).doubleValue();
	                
	                VoucherEntity vt = getVoucherEntity(serviceNo, "2241.02", "C", fEXPLANATION, kingDeptCode, logisticsGuestId, otherExpAmt);
	            	FEntity2.add(vt);
	            	
	            	p1 = new BigDecimal(Double.toString(csum));
		            p2 = new BigDecimal(Double.toString(otherExpAmt));
	            	csum = p1.add(p2).doubleValue();
	        	}

	        	
	        }
	    	
	    	BigDecimal p1 = new BigDecimal(Double.toString(amt));
	        BigDecimal p2 = new BigDecimal(Double.toString(dsum));
	        BigDecimal p3 = new BigDecimal(Double.toString(csum));
	        Double ddiffsum = p1.subtract(p2).doubleValue();//借方存在差异
	        Double cdiffsum = p1.subtract(p3).doubleValue();//贷方存在差异
	        
	        if(ddiffsum != 0) {
	    		for(int j = FEntity1.size() - 1; j >= 0; j--) {
	    			VoucherEntity ve = FEntity1.get(j);
	    			Double c = ve.getFDEBIT();
	    			if(ve != null) {
	    				BigDecimal s1 = new BigDecimal(Double.toString(c));
		                BigDecimal s2 = new BigDecimal(Double.toString(ddiffsum));
		                c = s1.add(s2).doubleValue();
		                if(c != 0) {
		                	ve.setFDEBIT(c);
		                	ve.setFAMOUNTFOR(c);
		                	break;
		                }
	    			}
	    			 
	    		}
	    	}
	    	if(cdiffsum != 0) {
	    		for(int j = FEntity2.size() - 1; j >= 0; j--) {
	    			VoucherEntity ve = FEntity2.get(j);
	    			Double c = ve.getFCREDIT();
	    			if(ve != null) {
	    				BigDecimal s1 = new BigDecimal(Double.toString(c));
		                BigDecimal s2 = new BigDecimal(Double.toString(cdiffsum));
		                c = s1.add(s2).doubleValue();
		                if(c != 0) {
		                	ve.setFCREDIT(c);
		                	ve.setFAMOUNTFOR(c);
		                	break;
		                }
	    			}
	    			 
	    		}
	    	}
	    	
	
	    	FEntity.addAll(FEntity1);
	    	FEntity.addAll(FEntity2);
			vc.setFEntity(FEntity);
			
			lp.add(new SaveParam<Voucher>(vc).toJson());
	
			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> list = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = list.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
				
			} else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
		}catch(Throwable e){
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println("打包发货费用登记凭证生成失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败：" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
	}
	
	/**
	 *           年-月-日从XXX库移仓到XXX库多少金额（例：2020-10-31从杭州蓝都库移仓到南京库322721.31）单据的金额
	 *  d	1405	库存商品
		c	1405	库存商品 
	 */
	@Bizlet("移仓单生成凭证")
	public static HashMap addStockShift(Long outMainId, Long enterMainId, String serviceNo, String bookId, String date, 
			String year, String month, String day, Double orderAmt, String storeName, String receiveStoreName) throws Exception {
		
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");
		try{
			lp.add("part");
			lp.add(serviceNo);
			lp.add("移仓单生成凭证");
			lp.add("addStockShift");
			lp.add(24);
			
			String preTitle = "";

			if(serviceNo != null && serviceNo != "") {
				preTitle = serviceNo + "-";
			}
			
			//如果 amt 是不含税金额，怎么处理
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			BigDecimal bamt = new BigDecimal(orderAmt);
			orderAmt = bamt.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + "从" + storeName + "移仓到" + receiveStoreName + orderAmt;
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			Double dsum = 0.0;
			Double csum = 0.0;
			List<VoucherEntity> FEntity0 = new ArrayList();//移仓出-库存商品金额
			List<VoucherEntity> FEntity1 = new ArrayList();//移仓入-库存商品金额
			
			
			HashMap pr = new HashMap();
	    	
	    	//库存商品
	    	pr.put("outMainId",outMainId);
	    	Object[] objrt = DatabaseExt.queryByNamedSql("part","com.hs.kinginterface.query.querySellOutAmt", pr);
	    	List<DataObject> sellOutList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(sellOutList, objrt);
	    	
	    	for(int i = 0; i<sellOutList.size(); i++) {
	        	DataObject d = sellOutList.get(i);
	        	
	        	String kingDeptCode = d.getString("kingDeptCode");
	        	Double noTaxCostAmt = d.getDouble("noTaxCostAmt");
	        	
	        	
	        	BigDecimal b = new BigDecimal(noTaxCostAmt);
	        	noTaxCostAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(noTaxCostAmt>0) {
		        	VoucherEntity ve = getVoucherEntity(serviceNo, "1405", "C", fEXPLANATION, kingDeptCode, null, noTaxCostAmt);
		        	FEntity0.add(ve);
		        	
		        	BigDecimal p1 = new BigDecimal(Double.toString(csum));
		            BigDecimal p2 = new BigDecimal(Double.toString(noTaxCostAmt));
		            csum = p1.add(p2).doubleValue();
		    	}
	        }
	    	
	    	pr.put("pchsEnterMainId",enterMainId);
	    	Object[] objr = DatabaseExt.queryByNamedSql("part","com.hs.kinginterface.query.queryPchsAmt", pr);
	    	List<DataObject> pchsList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(pchsList, objr);
	    	
	    	
	    	for(int i = 0; i<pchsList.size(); i++) {
	        	DataObject d = pchsList.get(i);
	        	
	        	String kingDeptCode = d.getString("kingDeptCode");
	        	Double noTaxCostAmt = d.getDouble("noTaxCostAmt");
	        	
	        	BigDecimal b = new BigDecimal(noTaxCostAmt);
	        	noTaxCostAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(noTaxCostAmt>0) {
		        	VoucherEntity ve = getVoucherEntity(serviceNo, "1405", "D", fEXPLANATION, kingDeptCode, null, noTaxCostAmt);
		        	FEntity1.add(ve);
		        	
		        	BigDecimal p1 = new BigDecimal(Double.toString(dsum));
		            BigDecimal p2 = new BigDecimal(Double.toString(noTaxCostAmt));
		            dsum = p1.add(p2).doubleValue();
		    	}
	        	
	        }
	    	
	    	BigDecimal p1 = new BigDecimal(Double.toString(orderAmt));
	        BigDecimal p2 = new BigDecimal(Double.toString(dsum));
	        BigDecimal p3 = new BigDecimal(Double.toString(csum));
	        Double ddiffsum = p1.subtract(p2).doubleValue();//借方存在差异
	        Double cdiffsum = p1.subtract(p3).doubleValue();//贷方存在差异
	        
	        if(ddiffsum != 0) {
	    		for(int j = FEntity1.size() - 1; j >= 0; j--) {
	    			VoucherEntity ve = FEntity1.get(j);
	    			Double c = ve.getFDEBIT();
	    			if(ve != null) {
	    				BigDecimal s1 = new BigDecimal(Double.toString(c));
		                BigDecimal s2 = new BigDecimal(Double.toString(ddiffsum));
		                c = s1.add(s2).doubleValue();
		                if(c != 0) {
		                	ve.setFDEBIT(c);
		                	ve.setFAMOUNTFOR(c);
		                	break;
		                }
	    			}
	    			 
	    		}
	    	}
	    	if(cdiffsum != 0) {
	    		for(int j = FEntity0.size() - 1; j >= 0; j--) {
	    			VoucherEntity ve = FEntity0.get(j);
	    			Double c = ve.getFCREDIT();
	    			if(ve != null) {
	    				BigDecimal s1 = new BigDecimal(Double.toString(c));
		                BigDecimal s2 = new BigDecimal(Double.toString(cdiffsum));
		                c = s1.add(s2).doubleValue();
		                if(c != 0) {
		                	ve.setFCREDIT(c);
		                	ve.setFAMOUNTFOR(c);
		                	break;
		                }
	    			}
	    			 
	    		}
	    	}
	    	
	    	List<VoucherEntity> FEntity = new ArrayList();//主营业务成本
	    	FEntity.addAll(FEntity0);
	    	FEntity.addAll(FEntity1);
	
			vc.setFEntity(FEntity);
				
			lp.add(new SaveParam<Voucher>(vc).toJson());
			
			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> list = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = list.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
				
			} else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
		}catch(Throwable e) {
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println("移仓单凭证生成失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败：" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
		
	}
	
	/**
	 *           年-月-日XXX仓库盘盈多少金额（例：2020-10-31杭州蓝都库盘盈322721.31）单据的金额
	 *  d	1405	库存商品
		c	1901.02	待处理财产损溢_库存盘点
	 */
	@Bizlet("盘点单-盘盈生成凭证")
	public static HashMap addStockCheckProfit(Long enterMainId, String serviceNo, String bookId, String date, 
			String year, String month, String day, Double orderAmt, String storeName) throws Exception {
		
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");
		try{
			lp.add("part");
			lp.add(serviceNo);
			lp.add("盘点单-盘盈生成凭证");
			lp.add("addStockShift");
			lp.add(25);
			
			String preTitle = "";

			if(serviceNo != null && serviceNo != "") {
				preTitle = serviceNo + "-";
			}
			
			//如果 amt 是不含税金额，怎么处理
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			BigDecimal bamt = new BigDecimal(orderAmt);
			orderAmt = bamt.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + "从" + storeName + "仓库盘盈" + orderAmt;
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			Double dsum = 0.0;
			Double csum = 0.0;
			List<VoucherEntity> FEntity0 = new ArrayList();//移仓出-库存商品金额
			
			HashMap pr = new HashMap();
	    	pr.put("pchsEnterMainId",enterMainId);
	    	Object[] objr = DatabaseExt.queryByNamedSql("part","com.hs.kinginterface.query.queryPchsAmt", pr);
	    	List<DataObject> pchsList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(pchsList, objr);
	    	
	    	for(int i = 0; i<pchsList.size(); i++) {
	        	DataObject d = pchsList.get(i);
	        	
	        	String kingDeptCode = d.getString("kingDeptCode");
	        	Double noTaxCostAmt = d.getDouble("noTaxCostAmt");
	        	
	        	BigDecimal b = new BigDecimal(noTaxCostAmt);
	        	noTaxCostAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(noTaxCostAmt>0) {
		        	VoucherEntity ve = getVoucherEntity(serviceNo, "1405", "D", fEXPLANATION, kingDeptCode, null, noTaxCostAmt);
		        	FEntity0.add(ve);
		        	
		        	VoucherEntity vt = getVoucherEntity(serviceNo, "1901.02", "C", fEXPLANATION, kingDeptCode, null, noTaxCostAmt);
		        	FEntity0.add(vt);
		    	}
	        	
	        }
	    	
	    	
	    	List<VoucherEntity> FEntity = new ArrayList();//主营业务成本
	    	FEntity.addAll(FEntity0);
	
			vc.setFEntity(FEntity);
				
			lp.add(new SaveParam<Voucher>(vc).toJson());
			
			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> list = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = list.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
				
			} else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
		}catch(Throwable e) {
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println("盘点单-盘盈凭证生成失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败：" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
		
	}
	
	/**
	 *           年-月-日XXX仓库盘亏多少金额（例：2020-10-31杭州蓝都库盘亏322721.31）单据的金额
	 *  d	1405	库存商品
		c	1901.02	待处理财产损溢_库存盘点
	 */
	@Bizlet("盘点单-盘亏生成凭证")
	public static HashMap addStockCheckLoss(Long outMainId, String serviceNo, String bookId, String date, 
			String year, String month, String day, Double orderAmt, String storeName) throws Exception {
		
		List<Object> lp = new ArrayList<Object>();
		HashMap hm = new HashMap();
		hm.put("code", "E");
		try{
			lp.add("part");
			lp.add(serviceNo);
			lp.add("盘点单-盘盈生成凭证");
			lp.add("addStockShift");
			lp.add(26);
			
			String preTitle = "";

			if(serviceNo != null && serviceNo != "") {
				preTitle = serviceNo + "-";
			}
			
			//如果 amt 是不含税金额，怎么处理
			K3CloudApi api=new K3CloudApi();
			Voucher vc = new Voucher();
			
			BigDecimal bamt = new BigDecimal(orderAmt);
			orderAmt = bamt.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			
			String fEXPLANATION = preTitle + year + "-" + month + "-" + day + "从" + storeName + "仓库盘亏" + orderAmt;
			
			CommonFNumber FAccountBookID = new CommonFNumber();
			FAccountBookID.setFNumber(bookId);
			vc.setFAccountBookID(FAccountBookID);
			
			vc.setFDate(date);
			vc.setFBUSDATE(date);
			vc.setFYEAR(year);
			vc.setFPERIOD(month);
			vc.setFDocumentStatus("Z");
			vc.setFISADJUSTVOUCHER(false);
			
			CommonFNumber FVOUCHERGROUPID = new CommonFNumber();
			FVOUCHERGROUPID.setFNumber("PRE001");
			vc.setFVOUCHERGROUPID(FVOUCHERGROUPID);
			
			CommonFNumber FSourceBillKey = new CommonFNumber();
			FSourceBillKey.setFNumber("78050206-2fa6-40e3-b7c8-bd608146fa38");
			vc.setFSourceBillKey(FSourceBillKey);
			
			Double dsum = 0.0;
			Double csum = 0.0;
			List<VoucherEntity> FEntity0 = new ArrayList();//移仓出-库存商品金额
			
			HashMap pr = new HashMap();
	    	
	    	//库存商品
	    	pr.put("outMainId",outMainId);
	    	Object[] objrt = DatabaseExt.queryByNamedSql("part","com.hs.kinginterface.query.querySellOutAmt", pr);
	    	List<DataObject> sellOutList = new ArrayList<DataObject>();
	    	CollectionUtils.addAll(sellOutList, objrt);
	    	
	    	for(int i = 0; i<sellOutList.size(); i++) {
	        	DataObject d = sellOutList.get(i);
	        	
	        	String kingDeptCode = d.getString("kingDeptCode");
	        	Double noTaxCostAmt = d.getDouble("noTaxCostAmt");
	        	
	        	
	        	BigDecimal b = new BigDecimal(noTaxCostAmt);
	        	noTaxCostAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	        	
	        	if(noTaxCostAmt>0) {
		        	VoucherEntity ve = getVoucherEntity(serviceNo, "1901.02", "D", fEXPLANATION, kingDeptCode, null, noTaxCostAmt);
		        	FEntity0.add(ve);
		        	
		        	VoucherEntity vt = getVoucherEntity(serviceNo, "1405", "C", fEXPLANATION, kingDeptCode, null, noTaxCostAmt);
		        	FEntity0.add(vt);
		    	}
	        }
	    	
	    	
	    	List<VoucherEntity> FEntity = new ArrayList();//主营业务成本
	    	FEntity.addAll(FEntity0);
	
			vc.setFEntity(FEntity);
				
			lp.add(new SaveParam<Voucher>(vc).toJson());
			
			SaveResult sRet = api.save("GL_VOUCHER", new SaveParam<Voucher>(vc));
			if (sRet.isSuccessfully()) {
				hm.put("code", "S");
				Gson gson = new Gson();
				List<SuccessEntity> list = sRet.getResult().getResponseStatus().getSuccessEntitys();
				SuccessEntity successEntity = list.get(0);
				hm.put("id", successEntity.getId());
				hm.put("number", successEntity.getNumber());
				
				lp.add(successEntity.toString());
				lp.add(0);
				lp.add(1);
				lp.add("生成凭证成功");
				
			} else{
				List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
				String errMsg = "";
				for(int i=0; i<errs.size(); i++) {
					RepoError re = errs.get(i);
					errMsg = errMsg + re.getMessage() + ";";
				}
				
				lp.add(errMsg);
				lp.add(0);
				lp.add(0);
				lp.add("生成凭证失败");
			}
	
			return hm;
		}catch(Throwable e) {
			lp.add("");
			lp.add(0);
			lp.add(0);
			lp.add("生成凭证异常");
			System.out.println("盘点单-盘亏凭证生成失败：" + serviceNo);
			e.printStackTrace();
		}finally{
			try {
				Object[] resultRes = callLogicFlowMethd("com.hs.common.uitls", "saveVoucherRecord", lp.toArray(new Object[lp.size()]));
			} catch (Throwable e) {
				System.out.println("保存凭证生成记录失败：" + serviceNo);
				e.printStackTrace();
			}
		}
		
		return hm;
		
	}
	
	/*
	 * 重新生成凭证
	 * */
	@Bizlet("重新生成凭证")
	public static HashMap reloadVoucher(int type, String jsonStr) throws Exception {
		
		
		HashMap hm = new HashMap();
		hm.put("code", "E");
		
		K3CloudApi api=new K3CloudApi();
		
		SaveParam s = null;
		if(type == 22) {
			s = new Gson().fromJson(jsonStr,
					new TypeToken<SaveParam<Customer>>() {
					}.getType());
		} else if (type == 23) {
			s = new Gson().fromJson(jsonStr,
					new TypeToken<SaveParam<Supplier>>() {
					}.getType());
		} else {
			s = new Gson().fromJson(jsonStr,
					new TypeToken<SaveParam<Voucher>>() {
					}.getType());
		}
		
		//SaveParam sp = new Gson().fromJson(jsonStr,SaveParam.class);
		//JsonObject jsonObject = (JsonObject) new JsonParser().parse(jsonStr);
		//Voucher vc = new Gson().fromJson(jsonStr,new TypeToken<Voucher>(){}.getType());
		//Voucher vc = (Voucher)sp.getModel();
		//Voucher vc = JSONObject.parseObject(jsonStr, Voucher.class);
		/*SaveParam s = new Gson().fromJson(jsonStr,
				new TypeToken<SaveParam<Voucher>>() {
				}.getType());*/
		
		SaveResult sRet = api.save("GL_VOUCHER", s);
		System.out.println(jsonStr);
		if (sRet.isSuccessfully()) {
			hm.put("code", "S");
			Gson gson = new Gson();
			List<SuccessEntity> list = sRet.getResult().getResponseStatus().getSuccessEntitys();
			SuccessEntity successEntity = list.get(0);
			hm.put("id", successEntity.getId());
			hm.put("number", successEntity.getNumber());
			
		} else{
			List<RepoError> errs = sRet.getResult().getResponseStatus().getErrors();
			String errMsg = "";
			for(int i=0; i<errs.size(); i++) {
				RepoError re = errs.get(i);
				errMsg = errMsg + re.getMessage() + ";";
			}
			
			System.out.println(errMsg);
		}

		return hm;
	}
	
	/**
	 * 删除凭证
	 * */
	@Bizlet("删除凭证")
	public static boolean deleteVoucher(String id) throws Exception{
		K3CloudApi api=new K3CloudApi();
		
		OperateParam param = new OperateParam();
		param.setIds(id);

		OperatorResult sRet = api.delete("GL_VOUCHER", param);
		if (sRet.isSuccessfully()) {
			return true;
		} 
		
		return false;
	}
	
	/*
	 * 获取凭证明细 Double amt 商品金额, Double taxAmt 进项税额, Double payAmt 应付款
	 * dc  D借方，C贷方
	 */
	private static VoucherEntity getVoucherEntity(String serviceNo, String fnumber, String dc, String fEXPLANATION, 
			String departmentCode, String guestId, Double amt) {
		
		VoucherEntity f1 = new VoucherEntity();
		f1.setFBUSNO(serviceNo);
		
		f1.setFEXPLANATION(fEXPLANATION); //摘要
		CommonFNumber FACCOUNTID = new CommonFNumber();
		FACCOUNTID.setFNumber(fnumber); //科目
		f1.setFACCOUNTID(FACCOUNTID);
		
		CommonFDetailID FDetailID = new CommonFDetailID();
		if(fnumber.equals("1405")) {  //库存商品
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
			
		} else if(fnumber.equals("2221.01.01")) {//应交税费_应交增值税_进项税额
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		} else if(fnumber.equals("2202.02")) {//应付账款_明细应付款
			CommonFNumber FDETAILID__FFLEX4 = new CommonFNumber(); //供应商
			FDETAILID__FFLEX4.setFNumber(guestId);
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX4(FDETAILID__FFLEX4);
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		} else if(fnumber.equals("2241.02")) {//其他应付款_供应商往来
			CommonFNumber FDETAILID__FFLEX4 = new CommonFNumber(); //供应商
			FDETAILID__FFLEX4.setFNumber(guestId);
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX4(FDETAILID__FFLEX4);
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		} else if(fnumber.equals("6601.05.01")) {//销售费用_运费_采购运费
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		}  else if(fnumber.equals("1122")) {//应收账款
			CommonFNumber FDETAILID__FFLEX6 = new CommonFNumber(); //客户
			FDETAILID__FFLEX6.setFNumber(guestId);
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX6(FDETAILID__FFLEX6);
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		}  else if(fnumber.equals("6601.29.01")) {//销售费用_销售优惠_开单差异额
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		}  else if(fnumber.equals("6601.29.02")) {//销售费用_销售优惠_结算单位返点
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		}  else if(fnumber.equals("6601.29.03")) {//销售费用-销售优惠-销售类型返点
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		}  else if(fnumber.equals("6001.01")) {//主营业务收入_商品收入
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		}  else if(fnumber.equals("2221.01.02")) {//应交税费_应交增值税_销项税额
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		}  else if(fnumber.equals("2241.06.01")) {//其他应付款-销售优惠-开单差异额
			CommonFNumber FDETAILID__FFLEX6 = new CommonFNumber(); //客户
			FDETAILID__FFLEX6.setFNumber(guestId);
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX6(FDETAILID__FFLEX6);
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		}  else if(fnumber.equals("2241.06.02")) {//其他应付款-销售优惠-结算单位返点
			CommonFNumber FDETAILID__FFLEX6 = new CommonFNumber(); //客户
			FDETAILID__FFLEX6.setFNumber(guestId);
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX6(FDETAILID__FFLEX6);
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		}  else if(fnumber.equals("2241.06.03.01") || fnumber.equals("2241.06.03.02") || fnumber.equals("2241.06.03.03")
				|| fnumber.equals("2241.06.03.04") || fnumber.equals("2241.06.03.05") || fnumber.equals("2241.06.03.06")) {//其他应付款-销售优惠-销售类型返点-正常销售
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		}  else if(fnumber.equals("6401.01")) {//主营业务成本_商品成本
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		}else if(fnumber.equals("2203") || fnumber.equals("2241.01") || fnumber.equals("2241.03") 
				 || fnumber.equals("2241.06.01")|| fnumber.equals("2241.06.02")) {//预收账款 其他应收收款
			CommonFNumber FDETAILID__FFLEX6 = new CommonFNumber(); //客户
			FDETAILID__FFLEX6.setFNumber(guestId);
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX6(FDETAILID__FFLEX6);
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		}else if(fnumber.equals("1123") || fnumber.equals("2241.02") || fnumber.equals("2241.04") 
				|| fnumber.equals("2241.05")) {//预付账款 其他应收收款
			CommonFNumber FDETAILID__FFLEX4 = new CommonFNumber(); //供应商
			FDETAILID__FFLEX4.setFNumber(guestId);
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX4(FDETAILID__FFLEX4);
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		}else {//针对结算账户 
			CommonFNumber FDETAILID__FFLEX5 = new CommonFNumber(); //部门
			FDETAILID__FFLEX5.setFNumber(departmentCode);
			
			FDetailID.setFDETAILID__FFLEX5(FDETAILID__FFLEX5);
			
			f1.setFDetailID(FDetailID);
			
			f1.setFAMOUNTFOR(amt);
			if(("D").equals(dc)) {
				f1.setFDEBIT(amt);
			}else {
				f1.setFCREDIT(amt);
			}
		}
		
		
		CommonFNumber FCURRENCYID = new CommonFNumber();
		FCURRENCYID.setFNumber("PRE001");
		f1.setFCURRENCYID(FCURRENCYID);
		
		CommonFNumber FEXCHANGERATETYPE = new CommonFNumber();
		FEXCHANGERATETYPE.setFNumber("HLTX01_SYS");
		f1.setFEXCHANGERATETYPE(FEXCHANGERATETYPE);
		f1.setFEXCHANGERATE(1.0);
		
		return f1;
	}
	

	@Bizlet("方法调用API")
	public static Object[] callLogicFlowMethd(String componentName,
			String operationName, Object... params) throws Throwable {
		int len = params == null ? 0 : params.length;
		ILogicComponent logicComponent = LogicComponentFactory
				.create(componentName);
		Object[] ps = new Object[len];
		int idx = 0;
		for (Object o : params) {
			ps[idx] = o;
			idx++;
		}
		return logicComponent.invoke(operationName, ps);
	}
	
	public static void main(String[] args) {
		
		
		String serviceNo = "123";
		String preTitle = "";
		if(serviceNo != null && serviceNo != "") {
			preTitle = serviceNo + "-";
		}
		
		BigDecimal p1 = new BigDecimal(Double.toString(88.68*-1.0));
        BigDecimal p2 = new BigDecimal(Double.toString(-88.67));
        BigDecimal p3 = new BigDecimal(Double.toString(-88.68));
        Double ddiffsum = p1.subtract(p2).doubleValue();//借方存在差异
        Double cdiffsum = p1.subtract(p3).doubleValue();//贷方存在差异
    	
        if(ddiffsum > 0.0001 || ddiffsum < -0.0001) {
    		
			BigDecimal s1 = new BigDecimal(Double.toString(-80.14));
            BigDecimal s2 = new BigDecimal(Double.toString(ddiffsum));
            Double c = s1.add(s2).doubleValue();
            System.out.println("===========" + c);
    		
    	}
	}
	
}



/*System.out.println("===========上面是库存金额=========");
if(taxSign == 1) {
	//应交税费-应交增值税-进项税额-保时捷571.77
	for(int i = 0; i<pchsList.size(); i++) {
    	DataObject d = pchsList.get(i);
    	
    	String kingDeptCode = d.getString("kingDeptCode");
    	Double taxDiff = d.getDouble("taxDiff");
    	BigDecimal b = new BigDecimal(taxDiff);
    	taxDiff = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
    	
    	BigDecimal p1 = new BigDecimal(Double.toString(dsum));
        BigDecimal p2 = new BigDecimal(Double.toString(taxDiff));
        dsum = p1.add(p2).doubleValue();
        
    	System.out.println(taxDiff);
    	VoucherEntity vt = getVoucherEntity(serviceNo, "2221.01.01", "D", fEXPLANATION, kingDeptCode, supplierId, taxDiff);
    	FEntity.add(vt);
    }
}
System.out.println("===========上面是税费=========");

if(expenseAmt > 0 && orderType == 3) {
	//销售费用-采购运费-保时捷8
	for(int i = 0; i<pchsList.size(); i++) {
    	DataObject d = pchsList.get(i);
    	
    	String kingDeptCode = d.getString("kingDeptCode");
    	Double expAmt = d.getDouble("expenseAmt");
    	BigDecimal b = new BigDecimal(expAmt);
    	expAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
    	
    	BigDecimal p1 = new BigDecimal(Double.toString(dsum));
        BigDecimal p2 = new BigDecimal(Double.toString(expAmt));
        dsum = p1.add(p2).doubleValue();
        
    	System.out.println(expAmt);
    	VoucherEntity vt = getVoucherEntity(serviceNo, "6601.05.01", "D", fEXPLANATION, kingDeptCode, supplierId, expAmt);
    	FEntity.add(vt);
    }
}
System.out.println("===========上面是运费=========");

//应付账款- 广州市万德汽车配件有限公司-保时捷4970
for(int i = 0; i<pchsList.size(); i++) {
	DataObject d = pchsList.get(i);
	
	String kingDeptCode = d.getString("kingDeptCode");
	Double enterAmt = d.getDouble("enterAmt");
	BigDecimal b = new BigDecimal(enterAmt);
	enterAmt = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
	
	BigDecimal p1 = new BigDecimal(Double.toString(csum));
    BigDecimal p2 = new BigDecimal(Double.toString(enterAmt));
    csum = p1.add(p2).doubleValue();
    
	System.out.println(enterAmt);
	
	VoucherEntity vt = getVoucherEntity(serviceNo, "2202.02", "C", fEXPLANATION, kingDeptCode, supplierId, enterAmt);
	FEntity.add(vt);
}
System.out.println("===========上面是采购金额=========");*/
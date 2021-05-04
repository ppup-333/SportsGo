package com.sport.springboot.course_act.model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.stereotype.Component;


	@Table(name = "ECpayOrderAct")
	@Entity
	@Component
	public class EcpayOrderActBean {
		
		@Id
		private String MerchantTradeNo;
		private String MerchantTradeDate;
		private String itemName;
		private int totalAmount;
		private String TradeDesc;
		private String ReturnURL;
		private int ActivityOrderId;

		
		@ManyToOne(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
	    @JoinColumn(name="ActivityOrderId",insertable = false, updatable = false)
		private ActivityOrderBean activityOrderBean;

		public String getMerchantTradeNo() {
			return MerchantTradeNo;
		}
		public void setMerchantTradeNo(String merchantTradeNo) {
			MerchantTradeNo = merchantTradeNo;
		}
		public String getMerchantTradeDate() {
			return MerchantTradeDate;
		}
		public void setMerchantTradeDate(String merchantTradeDate) {
			MerchantTradeDate = merchantTradeDate;
		}
		public String getItemName() {
			return itemName;
		}
		public void setItemName(String itemName) {
			this.itemName = itemName;
		}
		public int getTotalAmount() {
			return totalAmount;
		}
		public void setTotalAmount(int totalAmount) {
			this.totalAmount = totalAmount;
		}
		public String getTradeDesc() {
			return TradeDesc;
		}
		public void setTradeDesc(String tradeDesc) {
			TradeDesc = tradeDesc;
		}
		public String getReturnURL() {
			return ReturnURL;
		}
		public void setReturnURL(String returnURL) {
			ReturnURL = returnURL;
		}
		public int getActivityOrderId() {
			return ActivityOrderId;
		}
		public void setActivityOrderId(int activityOrderId) {
			ActivityOrderId = activityOrderId;
		}
		public ActivityOrderBean getActivityOrderBean() {
			return activityOrderBean;
		}
		public void setActivityOrderBean(ActivityOrderBean activityOrderBean) {
			this.activityOrderBean = activityOrderBean;
		}
		
	
		
	}



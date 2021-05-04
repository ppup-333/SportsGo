package ecpay.payment.integration;

import ecpay.payment.integration.domain.AioCheckOutATM;

public class EcpayTry {

	public static void main(String[] args) {
	String properties="D:\\_SpringBoot\\workspace\\ECpayTest\\src\\main\\java\\ecpay\\payment\\integration\\properties\\log4j.properties";

	
	AllInOne ecpay=new AllInOne(properties);
	AioCheckOutATM atm=new AioCheckOutATM();
	
	}

}

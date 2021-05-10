package com.sport.springboot.shop.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.log4j.BasicConfigurator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;


import com.sport.springboot.shop.model.Product;
import com.sport.springboot.shop.model.ProductOrderDetail;
import com.sport.springboot.shop.model.ProductOrderList;
import com.sport.springboot.shop.repository.ProductOrderListRepository;
import com.sport.springboot.shop.service.ProductCategoryService;
import com.sport.springboot.shop.service.ProductOrderDetailService;
import com.sport.springboot.shop.service.ProductOrderListService;
import com.sport.springboot.shop.service.ProductService;
import com.sport.springboot.users.model.Users;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutALL;
import ecpay.payment.integration.domain.QueryTradeInfoObj;

@Controller
@RequestMapping("/shop/order")
public class ProductOrderController {

	@Autowired
	ProductService productService;

	@Autowired
	ProductCategoryService productCategoryService;
	
	@Autowired
	ProductOrderListService productOrderListService;
	
	@Autowired
	private ProductOrderListRepository productOrderListRepository;
	
	@Autowired
	ProductOrderDetailService productOrderDetailService;
	
	@Autowired
	ServletContext context;
	
	
	//用Session創建暫時訂單
	@RequestMapping(value = "/OrderTemp")
	@ResponseBody
	public String OrderTemp(@RequestBody Map<String, String> map, HttpSession httpSession) {
		
		String account = (String) httpSession.getAttribute("account");
		
		System.out.println("account ======================================================================================"+account);
		if (account == null) {
			return "login";
		}
		
		
		@SuppressWarnings("unchecked")
		Map<String,Integer> omap = (Map<String, Integer>) httpSession.getAttribute("orderTemp");	          
        omap = new HashMap<>(); 	
        httpSession.setAttribute("orderTemp", omap);
    	
    	for(Entry<String, String> prods : map.entrySet()){	
    		if ( Integer.parseInt(prods.getValue()) > productService.getByName1(prods.getKey()).getProduct_stock() ) { //判斷下定數量是否大於庫存
    			return ""+prods.getKey();
    		}
    		omap.put(prods.getKey(), Integer.parseInt(prods.getValue()));  
//    		System.out.println("get Key = "+prods.getKey()); //暫時訂單的商品名稱
//			System.out.println("get value = "+prods.getValue()); //暫時訂單的商品下訂數量
		}	
        System.out.println("omap = "+omap);
		return "success";			
	}

	//訂單確認頁01
	@GetMapping("/orderCheck1")
	public String orderCheck1() {
		//m.addAttribute("productList",productService.getAllProducts());
		return "shop/productsOrder/orderCheck1";
	}
	
	//訂單確認頁01，顯示暫定訂單Temp
	@GetMapping(value = "/getOrderTempJson")
	public @ResponseBody Map<String, Object> getOrderTemp(HttpSession httpSession) {
		Map<String, Object> map = new HashMap<>();
		List<Product> productList = new ArrayList<>();
		List<Integer> productNums = new ArrayList<>(); 
		
		@SuppressWarnings("unchecked")
		Map<String,Integer> checkmap = (Map<String, Integer>) httpSession.getAttribute("check");
		if (checkmap!=null) {
			checkmap.clear();
		}

		@SuppressWarnings("unchecked")
		Map<String,Integer> omap = (Map<String, Integer>) httpSession.getAttribute("orderTemp");
		Integer cartNum = 0;
		
        //獲取暫定訂單商品數量
		for(Entry<String, Integer> prods : omap.entrySet()){
			cartNum += prods.getValue();
			productNums.add(prods.getValue());
			productList.add(productService.getByName1(prods.getKey()));
		}		
        
		map.put("productList", productList);
		map.put("productNums", productNums);
		map.put("cartNum", cartNum);
		return map;
	}
	
	
	//創建訂單
	@RequestMapping(value = "/OrderCreate")
	@ResponseBody
	public String OrderCreate(@RequestBody Map<String, String> map, HttpSession httpSession) {
		
		@SuppressWarnings("unchecked")
		Map<String,Integer> omap = (Map<String, Integer>) httpSession.getAttribute("orderTemp");
		
		for(Entry<String, Integer> prods : omap.entrySet()){
    		if ( prods.getValue() > productService.getByName1(prods.getKey()).getProduct_stock() ) { //判斷下定數量是否大於庫存
    			return "failed"+prods.getKey();
    		}
		}	
		
		String account = (String) httpSession.getAttribute("account");
		
		System.out.println("account = "+account);
		String name = map.get("Name");
		String tel = map.get("Tel");
		String address = map.get("Address");
		Integer ship = Integer.parseInt(map.get("Ship"));
		Integer order_price = Integer.parseInt(map.get("OrderPrice"));
		
		ProductOrderList order = new ProductOrderList();

		order.setName(name);
		order.setTel(tel);
		order.setAddress(address);
		order.setShip(ship);
		order.setMember_id(account);
		order.setOrder_price(order_price);
		order.setOrder_status("未付款");
		if(ship == 100) {
			order.setShipway("宅配");
		} else order.setShipway("自取");
		
		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdFormat.format(new Date());
		order.setOrder_create_date(date);
		
		productOrderListService.save(order);
		
		@SuppressWarnings("unchecked")
		Map<String,Integer> cmap = (Map<String, Integer>) httpSession.getAttribute("cart");	
		
		
		for(Entry<String, Integer> prods : omap.entrySet()){
			ProductOrderDetail orderd = new ProductOrderDetail();
			Product product = productService.getByName1(prods.getKey());
			orderd.setOrder_list(order);
			orderd.setProduct(product);//key商品名稱
			orderd.setProduct_number(prods.getValue());//value商品數量
					
			product.setProduct_stock((product.getProduct_stock()-prods.getValue()));
			productOrderDetailService.save(orderd);
			cmap.remove(prods.getKey());
		}
		omap.clear();
		
		Integer id = order.getOrder_id();
		
		return ""+id;
	}
	
	
	
	//測試用
	@RequestMapping(value = "/OrderTest")
	@ResponseBody
	public String OrderTest(@RequestBody Map<String, String> map, HttpSession httpSession) {
		String name = map.get("Name");
		String address = map.get("Address");
		String tel = map.get("Tel");
		Integer ship = Integer.parseInt(map.get("Ship"));
		
		System.out.println("name = "+name);
		System.out.println("address = "+address);
		System.out.println("tel = "+tel);
		System.out.println("ship = "+ship);
		
		return "success";
	}
	
	
	//會員的訂單列表
	@GetMapping("/orderList")
	public String orderList() {
		//m.addAttribute("productList",productService.getAllProducts());
		return "shop/productsOrder/orderList";
	}
	
	//顯示用戶的訂單列表
	@GetMapping(value = "/getOrderListJson")
	public @ResponseBody Map<String, Object> getOrderList(HttpSession httpSession) {
		
		String account = (String) httpSession.getAttribute("account");
		
		System.out.println("account ======================================================================================"+account);
		if (account == null) {
			account="";
		}
		String MerchantTradeNo="";
		
		Map<String, Object> map = new HashMap<>();		
		List<ProductOrderList> orderList = productOrderListService.getByAccount(account);
		List<ProductOrderDetail> orderDetail = new ArrayList<>(); 
		List<Integer> orderNumber = new ArrayList<>();
		Integer num = 0;
		
		for(int i = 0; i<orderList.size(); i++) {
			orderDetail.addAll(productOrderDetailService.getAllById(orderList.get(i).getOrder_id()));
			System.out.println("orderDetail.size() = "+orderDetail.size());
			
			num = 0;
			for(int j = 0; j<orderDetail.size(); j++) {
				num += orderDetail.get(j).getProduct_number();
			}
			orderDetail.clear();
			orderNumber.add(num);
			
			
			orderList.get(i).getOrder_id();
			System.out.println("statue ==========================================================================="+orderList.get(i).getOrder_status() );
			
			if (orderList.get(i).getOrder_status().equals("未付款")) {
				System.out.println("進入迴圈111111111111111111111111111````````````wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
			ProductOrderList orderList2 = orderList.get(i);
			MerchantTradeNo=orderList2.getMerchantTradeNo();
			String status="";
			BasicConfigurator.configure();
			AllInOne ecpay=new AllInOne(properties);
			QueryTradeInfoObj trade=new QueryTradeInfoObj();
			trade.setMerchantTradeNo(MerchantTradeNo);
			status=ecpay.queryTradeInfo(trade);
			System.out.println(status);
			String[] statusSplit=status.split("&");				
			String Status=statusSplit[statusSplit.length-2];//交易狀態
			String TradeStatus=(Status.split("="))[1];
			System.out.println(TradeStatus);
				if(Integer.parseInt(TradeStatus)==1) {
					orderList2.setOrder_status("已付款");
					productOrderListService.update(orderList2);
				}
	
			}

		}	
		System.out.println("Size = "+orderList.size());	
		map.put("account", account);
		map.put("orderList", orderList);
		map.put("orderNumber", orderNumber);
		map.put("orderDetail", orderDetail);
		return map;
	}
	
	//會員的訂單詳細
	@GetMapping("/orderDetail/{order_Id}")
	public String orderDetail(@PathVariable("order_Id") Integer order_Id, Model m) {
		m.addAttribute("order_Id", order_Id);
		return "shop/productsOrder/orderDetail";
	}
	
	
	//顯示用戶的訂單詳細內容
	@GetMapping(value = "orderDetail/getOrderDetailJson/{order_Id}")
	public @ResponseBody Map<String, Object> getOrderDetail(@PathVariable("order_Id") Integer order_Id, HttpSession httpSession) {
		Map<String, Object> map = new HashMap<>();		
		
		List<ProductOrderDetail> orderDetail = productOrderDetailService.getAllById(order_Id);
		List<Product> productList = new ArrayList<>();
		ProductOrderList orderList = productOrderListService.get(order_Id);

		for(int i = 0; i<orderDetail.size(); i++) {
			productList.add(i, orderDetail.get(i).getProduct());
		}	

		System.out.println("orderList = "+orderList);
		System.out.println("orderDetail = "+orderDetail);
		System.out.println("productList = "+productList);
		map.put("orderList", orderList);
		map.put("orderDetail", orderDetail);
		map.put("productList", productList);
		return map;
	}
	
	

	
	private final String properties="D:\\git\\SportsGo\\sport\\src\\main\\java\\ecpay\\payment\\integration";
	
	//串接綠界處理付款
	@PostMapping("/productEcpay/{order_Id}")
	public String productEcpay(@PathVariable("order_Id") Integer order_Id, Model model) {
		
		ProductOrderList orderList = productOrderListService.get(order_Id);
		BasicConfigurator.configure();	
		String ReturnURL="http://localhost:8080/springEcpay/productEcpayReturn";
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
		Date date = new Date();
        String orderDate=dateFormat.format(date);
        String d=orderDate.split(" ")[0];
        String t=orderDate.split(" ")[1];
        String[] d1=d.split("/");
        String[] d2=t.split(":");
        String context="";
        for(int i=1;i<d1.length;i++) {
        	context+=d1[i];
        }
        for(int i=0;i<d2.length;i++) {
        	context+=d2[i];
        }
        String MerchantTradeNo = order_Id+context;
        String TradeDesc = "_courseApply";
        System.out.println("Product MerchantTradeNo  = "+MerchantTradeNo);
        orderList.setMerchantTradeNo(MerchantTradeNo);
        
        String totalAmount = Integer.toString(orderList.getOrder_price());
        
        productOrderListRepository.save(orderList);
        
        List<ProductOrderDetail> orderDetail = productOrderDetailService.getAllById(order_Id);
        String detail = "";
        for(int i = 0; i<orderDetail.size(); i++) {
        	detail += orderDetail.get(i).getProduct().getProduct_name() + "   單價 ";
        	detail += orderDetail.get(i).getProduct().getProduct_price() + " 元 x ";
        	detail += orderDetail.get(i).getProduct_number() + " # ";
		}	
        

        
        AioCheckOutALL atm=new AioCheckOutALL();
		atm.setTotalAmount(totalAmount);
		atm.setItemName(detail); //處理名稱
		atm.setMerchantTradeNo(MerchantTradeNo);
		atm.setMerchantTradeDate(orderDate);
		atm.setTradeDesc(TradeDesc);
		atm.setReturnURL(ReturnURL);
		
		
		AllInOne ecpay=new AllInOne(properties);	
		String htmlform=ecpay.aioCheckOut(atm, null);
		model.addAttribute("htmlform", htmlform);
		return "shop/productsOrder/productEcpay";
	}

	
	
	
	
	//後台管理訂單列表
	@GetMapping("/orderListManage")
	public String orderListManage() {
		//m.addAttribute("productList",productService.getAllProducts());
		return "shop/productsOrder/orderListManage";
	}
		
	//後台顯示所有訂單列表
	@GetMapping(value = "/getOrderListManageJson")
	public @ResponseBody Map<String, Object> getOrderListManage(HttpSession httpSession) {
		
//		String account = (String) httpSession.getAttribute("account");
//		
//		System.out.println("account ======================================================================================"+account);
//		if (account == null) {
//			account="";
//		}
		
		String MerchantTradeNo="";
		Map<String, Object> map = new HashMap<>();		
		List<ProductOrderList> orderList = productOrderListService.getAll();
		List<ProductOrderDetail> orderDetail = new ArrayList<>(); 
		List<Integer> orderNumber = new ArrayList<>();
		Integer num = 0;
		
		for(int i = 0; i<orderList.size(); i++) {
			orderDetail.addAll(productOrderDetailService.getAllById(orderList.get(i).getOrder_id()));
			System.out.println("orderDetail.size() = "+orderDetail.size());
			
			num = 0;
			for(int j = 0; j<orderDetail.size(); j++) {
				num += orderDetail.get(j).getProduct_number();
			}
			orderDetail.clear();
			orderNumber.add(num);
			
			//orderList.get(i).getOrder_id();
			
			if (orderList.get(i).getOrder_status().equals("未付款")) {
				ProductOrderList orderList2 = orderList.get(i);
				MerchantTradeNo=orderList2.getMerchantTradeNo();
				String status="";
				BasicConfigurator.configure();
				AllInOne ecpay=new AllInOne(properties);
				QueryTradeInfoObj trade=new QueryTradeInfoObj();
				trade.setMerchantTradeNo(MerchantTradeNo);
				status=ecpay.queryTradeInfo(trade);
				System.out.println(status);
				String[] statusSplit=status.split("&");				
				String Status=statusSplit[statusSplit.length-2];//交易狀態
				String TradeStatus=(Status.split("="))[1];
				System.out.println(TradeStatus);
					if(Integer.parseInt(TradeStatus)==1) {
						orderList2.setOrder_status("已付款");
						productOrderListService.update(orderList2);
					}	
			}
			
			
		}	
		
		System.out.println("Size = "+orderList.size());	
		
		
		map.put("orderList", orderList);
		map.put("orderNumber", orderNumber);
		map.put("orderDetail", orderDetail);
		return map;
	}
	
	
	
	//後台顯示會員訂單詳細
	@GetMapping("/orderDetailManage/{order_Id}")
	public String orderDetailManage(@PathVariable("order_Id") Integer order_Id, Model m) {
		m.addAttribute("order_Id", order_Id);
		return "shop/productsOrder/orderDetailManage";
	}
	
	
	//顯示用戶的訂單詳細內容
	@GetMapping(value = "orderDetailManage/getOrderDetailMJson/{order_Id}")
	public @ResponseBody Map<String, Object> getOrderDetailManage(@PathVariable("order_Id") Integer order_Id, HttpSession httpSession) {
		Map<String, Object> map = new HashMap<>();		
		
		List<ProductOrderDetail> orderDetail = productOrderDetailService.getAllById(order_Id);
		List<Product> productList = new ArrayList<>();
		ProductOrderList orderList = productOrderListService.get(order_Id);

		for(int i = 0; i<orderDetail.size(); i++) {
			productList.add(i, orderDetail.get(i).getProduct());
		}	

		System.out.println("orderList = "+orderList);
		System.out.println("orderDetail = "+orderDetail);
		System.out.println("productList = "+productList);
		map.put("orderList", orderList);
		map.put("orderDetail", orderDetail);
		map.put("productList", productList);
		return map;
	}
	
	
	
	
	//取消訂單
	@RequestMapping(value = "/cancelOrder")
	@ResponseBody
	public String cancelOrder(@RequestBody Map<String, String> map) {
		Integer oid = Integer.parseInt(map.get("cancelId"));
		ProductOrderList orderList = productOrderListService.get(oid);
		
		orderList.setOrder_status("已取消");
		productOrderListRepository.save(orderList);

				
		List<ProductOrderDetail> orderDetail = productOrderDetailService.getAllById(oid);
		Product product = null;
		Integer pnum = 0;
		Integer pid = 0;
		for(int i = 0; i<orderDetail.size(); i++) {
			pid = orderDetail.get(i).getProduct().getProduct_id();
			pnum = orderDetail.get(i).getProduct_number();
			product = productService.get(pid);
			product.setProduct_stock(product.getProduct_stock() + pnum);
			productService.save(product);
		}
		
		return "success";
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@ModelAttribute
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
	
	
	

}

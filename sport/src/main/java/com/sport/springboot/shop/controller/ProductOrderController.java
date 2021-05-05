package com.sport.springboot.shop.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sport.springboot.shop.model.Product;
import com.sport.springboot.shop.model.ProductOrderDetail;
import com.sport.springboot.shop.model.ProductOrderList;
import com.sport.springboot.shop.service.ProductCategoryService;
import com.sport.springboot.shop.service.ProductOrderDetailService;
import com.sport.springboot.shop.service.ProductOrderListService;
import com.sport.springboot.shop.service.ProductService;

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
	ProductOrderDetailService productOrderDetailService;
	
	@Autowired
	ServletContext context;
	
	
	//用Session創建暫時訂單
	@RequestMapping(value = "/OrderTemp")
	@ResponseBody
	public String OrderTemp(@RequestBody Map<String, String> map, HttpSession httpSession) {
		@SuppressWarnings("unchecked")
		Map<String,Integer> omap = (Map<String, Integer>) httpSession.getAttribute("orderTemp");	          
        omap = new HashMap<>(); 	
        httpSession.setAttribute("orderTemp", omap);
    	
    	for(Entry<String, String> prods : map.entrySet()){	
    		omap.put(prods.getKey(), Integer.parseInt(prods.getValue()));  
    		System.out.println("get Key = "+prods.getKey());
			System.out.println("get value = "+prods.getValue());
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
	
	
	//訂單
	@RequestMapping(value = "/OrderCreate")
	@ResponseBody
	public String OrderCreate(@RequestBody Map<String, String> map, HttpSession httpSession) {
		
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
		order.setMember_id("test1001");
		order.setOrder_price(order_price);
		if(ship == 100) {
			order.setShipway("宅配");
		} else order.setShipway("自取");
		
		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdFormat.format(new Date());
		order.setOrder_create_date(date);
		
		productOrderListService.save(order);
		
		@SuppressWarnings("unchecked")
		Map<String,Integer> cmap = (Map<String, Integer>) httpSession.getAttribute("cart");	
		
		@SuppressWarnings("unchecked")
		Map<String,Integer> omap = (Map<String, Integer>) httpSession.getAttribute("orderTemp");
		
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
		
		return "success";
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
		
		String account = "test1002";
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
		}	
		System.out.println("Size = "+orderList.size());	
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
	
	
	
	
	
	
	
	

}

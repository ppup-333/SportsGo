package com.sport.springboot.shop.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Blob;
import java.text.SimpleDateFormat;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sport.springboot.shop.model.Product;
import com.sport.springboot.shop.model.ProductCategory;
import com.sport.springboot.shop.model.ProductOrderDetail;
import com.sport.springboot.shop.model.ProductOrderList;
import com.sport.springboot.shop.service.ProductCategoryService;
import com.sport.springboot.shop.service.ProductService;
import com.sport.springboot.shop.validate.ProductValidator;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

@Controller
@RequestMapping("/shop")
public class ProductController {
	String noImage = "/images/NoImage.png";
	String imageRootDirectory = "d:\\Sport_Data\\Products";
	File imageFolder = null;

	public ProductController() {
		imageFolder = new File(imageRootDirectory, "images");
		if (!imageFolder.exists())
			imageFolder.mkdirs();
	}

	@Autowired
	ProductService productService;

	@Autowired
	ProductCategoryService productCategoryService;

	@Autowired
	ServletContext context;

	// 顯示所有商品資料
	@RequestMapping("/showAllProducts")
	public String prodList(String page, Model model, @RequestParam(required = false) String status,
			@RequestParam(required = false) String category) {

		int pageSize = 10; // 每頁顯示的商品數
		List<Product> products = new ArrayList<Product>();
		if (status != null && status != "") { // status為上下架狀態
			if (category != null && category != "") { // category為分類狀態
				products = this.productService.getProdByStatusByCategory(status, category); // 根據狀態決定尋找商品的方法
			} else
				products = this.productService.getProdByStatus(status);
		} else {
			if (category != null && category != "") {
				products = this.productService.getProdByCategory(category);
			} else
				products = this.productService.getAllProducts();
		}
		model.addAttribute("prodNum", products.size()); // prodNum為查到的總商品數量

		int pageTimes; // 分頁總頁數
		if (products.size() % pageSize == 0)
			pageTimes = products.size() / pageSize; // 如果能整除的話 總頁數即為商品數除10
		else
			pageTimes = products.size() / pageSize + 1; // 否則需要+1
		model.addAttribute("pageTimes", pageTimes);

		if (null == page)
			page = "1"; //初始的時候page沒有值故設為1
		int startRow = ((Integer.parseInt(page) - 1) * pageSize); //設置每頁是第幾行為初始
		pageSize = (Integer.parseInt(page) * pageSize) - 1; //設置每頁第幾行結束

		model.addAttribute("startRow", startRow);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", Integer.parseInt(page));
		model.addAttribute("category", category);
		model.addAttribute("status", status);
		model.addAttribute("products", products);
		return "shop/products/productsAll";
	}

	// 顯示搜尋出的商品資料
	@RequestMapping("/showSearchProducts")
	public ModelAndView prodBySearch(String keyword, String keyword2, String page, Model model,
			@RequestParam(required = false) String status, @RequestParam(required = false) String category) {

		int pageSize = 10; // 每頁顯示的商品數
		List<Product> products = new ArrayList<Product>();

		if (status != null && status != "") { // 根據狀態,分類和關鍵字決定尋找商品的方法
			if (category != null && category != "") {
				products = this.productService.getProdByStatusByNameByCategory(keyword, status, category);
			} else
				products = this.productService.getProdByStatusByName(keyword, status);
		} else {
			if (category != null && category != "") {
				products = this.productService.getProdByNameByCategory(keyword, category);
			} else
				products = this.productService.getByName(keyword);
		}
		model.addAttribute("keyword", keyword); //搜尋關鍵字
		model.addAttribute("keyword2", keyword2); //為了防止form表單多設的關鍵字
		model.addAttribute("prodNum", products.size()); //查到的總用戶數
		
		int pageTimes; //分頁總頁數
		if (products.size() % pageSize == 0)
			pageTimes = products.size() / pageSize; //如果能整除的話 總頁數即為商品數除10
		else
			pageTimes = products.size() / pageSize + 1; //否則需要+1
		model.addAttribute("pageTimes", pageTimes);

		if (null == page)
			page = "1"; //初始的時候page沒有值故設為1
		int startRow = ((Integer.parseInt(page) - 1) * pageSize); //設置每頁是第幾行為初始
		pageSize = (Integer.parseInt(page) * pageSize) - 1; //設置每頁第幾行結束

		model.addAttribute("startRow", startRow);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", Integer.parseInt(page));
		model.addAttribute("products", products);
		model.addAttribute("status", status);
		model.addAttribute("category", category);
		return new ModelAndView("shop/products/productsFind");
	}
	
	// 顯示商品描述
	@GetMapping("/showProductsRemark/{product_id}")
	public String pRemark(@PathVariable("product_id") Integer product_id, Model model) {
		Product product = productService.get(product_id);
		model.addAttribute("remark", product.getProduct_remark());
//			String str = product.getProduct_remark();
//			str = str.replaceAll("\r\n","<br/>");
//			product.setProduct_remark(str);
//			productService.save(product);
		return "shop/products/productRemark";
	}

	// 本方法於新增時，送出空白的表單讓使用者輸入資料
	@GetMapping(value = "/pro/{currentPage}")
	public String showEmptyForm(Model model, @PathVariable("currentPage") Integer currentPage,
			@RequestParam(required = false) String keyword, @RequestParam(required = false) String status,
			@RequestParam(required = false) String category) {
		Product product = new Product();
		System.out.println("show get keyword : " + keyword);
		model.addAttribute("keyword", keyword);
		model.addAttribute("status", status);
		model.addAttribute("category", category);
		// 下列敘述簡化測試時的資料輸入
		product.setProduct_name("測試用啞鈴");
		product.setProduct_price(100);
		product.setProduct_stock(50);
		product.setProduct_remark("TEST123");
		product.setProduct_status("0");
		model.addAttribute("product", product);
		return "shop/products/productsInsert";
	}

	// 當使用者填妥資料按下Submit按鈕後，本方法接收將瀏覽器送來的會員資料，新進行資料的檢查，
	// 若資料有誤，轉向寫入錯誤訊息的網頁，若資料無誤，則呼叫Service元件寫入資料庫
	@PostMapping(value = "/pro/{currentPage}")
	// BindingResult 參數必須與@ModelAttribute修飾的參數連續編寫，中間不能夾其他參數
	public String add(@ModelAttribute("product") /* @Valid */ Product product, BindingResult result, Model model,
			@PathVariable("currentPage") Integer currentPage, HttpServletRequest request,
			// HttpSession session,
			@RequestParam(required = false) String keyword, @RequestParam(required = false) String status,
			@RequestParam(required = false) String category) throws UnsupportedEncodingException {
		System.out.println("add get keyword : " + keyword);
		ProductValidator validator = new ProductValidator();
		validator.validate(product, result); //呼叫Validate進行資料檢查
		if (result.hasErrors()) {
			return "shop/products/productsInsert";
		}
		MultipartFile picture = product.getProductImage();
		String originalFilename = picture.getOriginalFilename();
		String extFilename = "";
		if (originalFilename.length() > 0 && originalFilename.lastIndexOf(".") > -1) {
			product.setFileName(originalFilename);
			extFilename = originalFilename.substring(originalFilename.lastIndexOf("."));
			System.out.println(extFilename);
		}

		// 建立Blob物件，交由 Hibernate 寫入資料庫
		if (picture != null && !picture.isEmpty()) {
			try {
				byte[] b = picture.getBytes();
				Blob blob = new SerialBlob(b);
				product.setImage(blob);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
			}
		}

		// 必須要找出對應的Category物件
		ProductCategory productcategory = productCategoryService
				.getProductCategory(product.getProductCategory().getId());
		product.setProductCategory(productcategory);

		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdFormat.format(new Date());
		product.setProduct_create_date(date);

		String str = product.getProduct_remark();
		str = str.replaceAll("\r\n", "<br/>");
		product.setProduct_remark(str);
		product.setProduct_status("0");
		productService.save(product);

		// 將上傳的檔案移到指定的資料夾, 取消下面的註解
		// rootDirectory: 儲存檔案的資料夾
		try {
			File file = new File(imageFolder, "ProductImage_" + product.getProduct_id() + extFilename);
			picture.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
		}

		if (keyword == null) {
			return "redirect:/shop/showAllProducts?page=" + currentPage + "&status=" + status + "&category=" + category;
		} else
			return "redirect:/shop/showSearchProducts?keyword=" + URLEncoder.encode(keyword, "UTF-8") + "&page="
					+ currentPage + "&status=" + status + "&category=" + category;
	}

	// 當使用者需要修改時，本方法送回含有會員資料的表單，讓使用者進行修改
	// 由這個方法送回修改記錄的表單...
	@GetMapping(value = "/pro/{currentPage}/{product_id}")
	public String showDataForm(@PathVariable("product_id") Integer product_id,
			@PathVariable("currentPage") Integer currentPage, Model model,
			@RequestParam(required = false) String keyword, @RequestParam(required = false) String status,
			@RequestParam(required = false) String category) {
		Product product = productService.get(product_id);
		model.addAttribute("keyword", keyword);
		model.addAttribute("category", category);
		model.addAttribute("status", status);

		String str = product.getProduct_remark();
		str = str.replaceAll("<br/>", "\r\n");
		product.setProduct_remark(str);
		model.addAttribute(product);
		return "shop/products/productsUpdate";
	}

	// 當將瀏覽器送來修改過的會員資料時，由本方法負責檢核，若無誤則寫入資料庫
	@PostMapping("/pro/{currentPage}/{product_id}")
	// BindingResult 參數必須與@ModelAttribute修飾的參數連續編寫，中間不能夾其他參數
	public String modify(@ModelAttribute("product") Product product, BindingResult result, Model model,
			@PathVariable Integer product_id, @PathVariable("currentPage") Integer currentPage,
			HttpServletRequest request, @RequestParam(required = false) String keyword,
			@RequestParam(required = false) String status, @RequestParam(required = false) String category)
			throws UnsupportedEncodingException {
		ProductValidator validator = new ProductValidator();
		Product productback = productService.get(product_id);
		
		validator.validate(product, result);
		if (result.hasErrors()) {
			System.out.println("result hasErrors(), product=" + product);
			List<ObjectError> list = result.getAllErrors();
			for (ObjectError error : list) {
				System.out.println("有錯誤：" + error);
			}
			return "shop/products/productsUpdate";
		}

		MultipartFile picture = product.getProductImage();

		if (picture.getSize() == 0) { // 表示使用者並未挑選圖片
			//System.out.println("進來了並未挑選圖片");
			product.setImage(productback.getImage());
			product.setFileName(productback.getFileName());
		} else {
			//System.out.println("進來了else");
			String originalFilename = picture.getOriginalFilename();
			if (originalFilename.length() > 0 && originalFilename.lastIndexOf(".") > -1) {
				product.setFileName(originalFilename);
			}

			// 建立Blob物件
			if (picture != null && !picture.isEmpty()) {
				//System.out.println("進來了if pic = null");
				try {
					byte[] b = picture.getBytes();
					Blob blob = new SerialBlob(b);
					product.setImage(blob);
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException("檔案上傳發生異常: " + e.getMessage());
				}
			}
		}

		product.setProduct_create_date(productback.getProduct_create_date());

		// 必須要找出對應的Category物件
		ProductCategory productcategory = productCategoryService
				.getProductCategory(product.getProductCategory().getId());
		product.setProductCategory(productcategory);

		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String udate = sdFormat.format(new Date());
		product.setProduct_update_date(udate);

		String str = product.getProduct_remark();
		str = str.replaceAll("\r\n", "<br/>");
		product.setProduct_remark(str);
		product.setProduct_status(productback.getProduct_status());

		productService.update(product);

		if (keyword == null) {
			return "redirect:/shop/showAllProducts?page=" + currentPage + "&status=" + status + "&category=" + category;
		} else
			return "redirect:/shop/showSearchProducts?keyword=" + URLEncoder.encode(keyword, "UTF-8") + "&page="
					+ currentPage + "&status=" + status + "&category=" + category;
	}

	// 顯示圖片
	@GetMapping("/picture/{product_id}")
	public ResponseEntity<byte[]> getPicture(@PathVariable("product_id") Integer product_id) {
		byte[] body = null;
		ResponseEntity<byte[]> re = null;
		MediaType mediaType = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setCacheControl(CacheControl.noCache().getHeaderValue());

		Product product = productService.get(product_id);
		if (product == null) {
			return new ResponseEntity<byte[]>(HttpStatus.NOT_FOUND);
		}
		String filename = product.getFileName();
		if (filename != null) {
			if (filename.toLowerCase().endsWith("jfif")) {
				mediaType = MediaType.valueOf(context.getMimeType("dummy.jpeg"));
			} else {
				mediaType = MediaType.valueOf(context.getMimeType(filename));
				headers.setContentType(mediaType);
			}
		}
		Blob blob = product.getImage();
		if (blob != null) {
			body = blobToByteArray(blob);
		} else {
			String path = null;
			path = noImage;
			;
			body = fileToByteArray(path);
		}
		re = new ResponseEntity<byte[]>(body, headers, HttpStatus.OK);
		return re;
	}

	// 刪除一筆商品資料
	@RequestMapping("/prod/{currentPage}/{product_id}")
	public String delete(@PathVariable("product_id") Integer product_id,
			@PathVariable("currentPage") Integer currentPage, @RequestParam(required = false) String keyword,
			@RequestParam(required = false) String status, @RequestParam(required = false) Integer prodNum,
			@RequestParam(required = false) String category) throws UnsupportedEncodingException {
		productService.delete(product_id);
		if (status == null) 
			status = "";

		if ((prodNum - 1) == (currentPage - 1) * 10) {
			currentPage = currentPage - 1; //如果刪除商品後此頁歸零的話跳轉回此頁的上一頁
			if (currentPage < 1) {
				currentPage = 1;
			}
		}
		if (keyword == null) {
			return "redirect:/shop/showAllProducts?page=" + currentPage + "&status=" + status + "&category=" + category;
		} else
			return "redirect:/shop/showSearchProducts?keyword=" + URLEncoder.encode(keyword, "UTF-8") + "&page="
					+ currentPage + "&status=" + status + "&category=" + category;
	}

	// 商品上架
	@RequestMapping("/prodUp/{currentPage}/{product_id}")
	public String ProdUp(@PathVariable("product_id") Integer product_id, Model model,
			@PathVariable("currentPage") Integer currentPage, @RequestParam(required = false) String keyword,
			@RequestParam(required = false) String status, @RequestParam(required = false) Integer prodNum,
			@RequestParam(required = false) String category) throws UnsupportedEncodingException {
		Product product = productService.get(product_id);
		product.setProduct_status("1"); // 設置資料表內商品狀態為1 代表上架
		productService.update(product);
		if (status == null)
			status = "";
		if (category == null)
			category = "";
		if ((prodNum - 1) == (currentPage - 1) * 10) {
			currentPage = currentPage - 1; //如果上架商品後此頁歸零的話跳轉回此頁的上一頁
			if (currentPage < 1) {
				currentPage = 1; //最小頁數為第一頁
			}
		}
		if (keyword == null) {
			return "redirect:/shop/showAllProducts?page=" + currentPage + "&status=" + status + "&category=" + category;
		} else {
			return "redirect:/shop/showSearchProducts?keyword=" + URLEncoder.encode(keyword, "UTF-8") + "&page="
					+ currentPage + "&status=" + status + "&category=" + category;
		}

	}

	// 商品下架
	@RequestMapping("/prodDown/{currentPage}/{product_id}")
	public String ProdDown(@PathVariable("product_id") Integer product_id, Model model,
			@PathVariable("currentPage") Integer currentPage, @RequestParam(required = false) String keyword,
			@RequestParam(required = false) String status, @RequestParam(required = false) Integer prodNum,
			@RequestParam(required = false) String category) throws UnsupportedEncodingException {
		Product product = productService.get(product_id);
		product.setProduct_status("0"); // 設置資料表內商品狀態為0 代表下架
		productService.update(product);
		if (status == null)
			status = "";
		if (category == null)
			category = "";
		if ((prodNum - 1) == (currentPage - 1) * 10) {
			currentPage = currentPage - 1; //如果上架商品後此頁歸零的話跳轉回此頁的上一頁
			if (currentPage < 1) {
				currentPage = 1; //最小頁數為第一頁
			}
		}
		if (keyword == null) {
			return "redirect:/shop/showAllProducts?page=" + currentPage + "&status=" + status + "&category=" + category;
		} else {
			return "redirect:/shop/showSearchProducts?keyword=" + URLEncoder.encode(keyword, "UTF-8") + "&page="
					+ currentPage + "&status=" + status + "&category=" + category;
		}

	}

	//轉成圖片方式1
	private byte[] fileToByteArray(String path) {
		byte[] result = null;
		try (InputStream is = context.getResourceAsStream(path);
				ByteArrayOutputStream baos = new ByteArrayOutputStream();) {
			byte[] b = new byte[819200];
			int len = 0;
			while ((len = is.read(b)) != -1) {
				baos.write(b, 0, len);
			}
			result = baos.toByteArray();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	//轉成圖片方式2
	public byte[] blobToByteArray(Blob blob) {
		byte[] result = null;
		try (InputStream is = blob.getBinaryStream(); ByteArrayOutputStream baos = new ByteArrayOutputStream();) {
			byte[] b = new byte[819200];
			int len = 0;
			while ((len = is.read(b)) != -1) {
				baos.write(b, 0, len);
			}
			result = baos.toByteArray();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	//處理分類
	@ModelAttribute
	public void commonData(Model model) {
		List<ProductCategory> productCategoryList = productCategoryService.getAllProductCategories();
		model.addAttribute("productCategoryList", productCategoryList);
		//System.out.println("@ModelAttribute productCategoryList = " + productCategoryList);
	}
	
	//商城首頁
	@GetMapping("/storeProductsAll")
	public String storeHomePage(Model m, Integer category, String keyword) {
		//m.addAttribute("productList",productService.getAllProducts());
		m.addAttribute("category",category);
		m.addAttribute("keyword",keyword);
		//m.addAttribute("productCategoryList",productCategoryList);	
		return "shop/products/storeProductsAll";
	}	
	
	
	//商城首頁，顯示商品
	@PostMapping(value = "/getProductsJson")
	public @ResponseBody Map<String, Object> getProductsAll(HttpSession httpSession, 
			@RequestParam("category") String category,
			@RequestParam("keyword") String keyword) {
//		System.out.println("CATEGORY================================================================================================ "+category);
//		System.out.println("KEYWORD================================================================================================ "+keyword);
		Map<String, Object> map = new HashMap<>();
		List<Product> productList = productService.getAllProducts();  //所有商品
		
		if (Integer.parseInt(category) == 0) {
			if(keyword=="") {
				productList = productService.getProdByStatus("1"); //所有上架中的商品	
			} else {
				productList = productService.getProdByStatusByName(keyword, "1");
			}
			
		} else {
			if(keyword=="") {
				productList = productService.getProdByStatusByCategory("1", category); //所有上架中的該分類產品
			} else {
				productList = productService.getProdByStatusByNameByCategory(keyword, "1", category);
			}
		}
		@SuppressWarnings("unchecked")
		Map<String,Integer> cmap = (Map<String, Integer>) httpSession.getAttribute("cart"); //獲取購物車session內容
		Integer cartNum = 0; //初始化購物車內商品數量
        if (cmap == null) {  //第一次購物，創建購物車
        	cartNum=0;
        }else {
            //購物車不為空，判斷購物車是否已經有該商品
            //獲取商品數量
    		for(Entry<String, Integer> prods : cmap.entrySet()){
    			cartNum+=prods.getValue();  //計算購物車數量
    		}		
        }
		map.put("productList", productList);
		map.put("cartNum", cartNum);
		
		@SuppressWarnings("unchecked")
		Map<String,Integer> checkmap = (Map<String, Integer>) httpSession.getAttribute("check"); //清除購物車的checkbox內容
		if (checkmap!=null) {
			checkmap.clear();
		}
		return map;
	}
	
	
	//商品詳細
	@GetMapping("/storeProduct/{product_id}")
	public String productDetail(@PathVariable("product_id") Integer product_id, Model m) {
		String product_name = productService.get(product_id).getProduct_name();
		m.addAttribute("product_id", product_id);
		m.addAttribute("product_name", product_name);
		return "shop/products/storeProductDetail";
	}
	
	
	//顯示商品詳細內容
	@GetMapping(value = "storeProduct/getProductDetailJson/{product_id}")
	public @ResponseBody Map<String, Object> getProductDetail(@PathVariable("product_id") Integer product_id, HttpSession httpSession) {
		Map<String, Object> map = new HashMap<>();		
		Product product = productService.get(product_id);
		
		@SuppressWarnings("unchecked")
		Map<String,Integer> cmap = (Map<String, Integer>) httpSession.getAttribute("cart"); //獲取購物車session內容
		Integer cartNum = 0; //初始化購物車內商品數量
		Integer count = null;  
        if (cmap == null) {  //第一次購物，創建購物車
        	cartNum=0;
        	
        }else {
            //購物車不為空，判斷購物車是否已經有該商品
            //獲取商品數量
    		for(Entry<String, Integer> prods : cmap.entrySet()){
    			cartNum+=prods.getValue();  //計算購物車數量
    		}
    		if (cmap.get(product.getProduct_name())!= null) {
    			count = cmap.get(product.getProduct_name());
    		} else count = 0;
        }
  
        
		@SuppressWarnings("unchecked")
		Map<String,Integer> checkmap = (Map<String, Integer>) httpSession.getAttribute("check"); //清除購物車的checkbox內容
		if (checkmap!=null) {
			checkmap.clear();
		}
		map.put("cartNum", cartNum);
		map.put("product", product);
		map.put("productNum", count);
		return map;
	}
		
	
	
	
	

	//將商品放入購物車
	@RequestMapping(value = "/addCart")
	@ResponseBody
	public String addProductToCart(@RequestBody Map<String, String> map, HttpSession httpSession) {
		 String addCartId  = map.get("addCartId").toString();
		 String addCartName = map.get("addCartName").toString();
		 String addCartNum = map.get("addCartNum");
		 
		 Product product = productService.get(Integer.parseInt(addCartId));
		 Integer pStock = product.getProduct_stock();
		 
		@SuppressWarnings("unchecked")
		Map<String,Integer> cmap = (Map<String, Integer>) httpSession.getAttribute("cart");
	
        Integer count = null;  
        if (cmap == null) {  //判斷購物車是否為空
        	cmap = new HashMap<>();  //第一次購物，創建購物車
        	httpSession.setAttribute("cart", cmap); //將購物車放入session中
        	if(addCartNum != null) { //如果加入複數商品
        		count = Integer.parseInt(addCartNum);
        	} else count = 1;  //加入單筆商品
        }else {
            //購物車不為空，判斷購物車是否已經有該商品
            //獲取商品數量
            count = cmap.get(addCartName);
            if(count == null) { //購物車沒有該商品
            	if(addCartNum != null) {
            		count = Integer.parseInt(addCartNum);
            	} else  count = 1;
            }else if(count >= pStock) {
            	System.out.println("超過庫存了GG");
            	return "OverStock";
            }
            else {
                //購物車具有該商品
            	if(addCartNum != null) {
            		if (count+Integer.parseInt(addCartNum) > pStock) {
                    	System.out.println("超過庫存了GG");
                    	return "OverStock";
            		} else count += Integer.parseInt(addCartNum);

            	} else count ++;
            }
        }
        //將商品放入購物車
        cmap.put(addCartName, count);  
        System.out.println("count = "+count);
        System.out.println("cmap = "+cmap);
		return "success";
	}
	
	@GetMapping("/myShoppingCart")
	public String cartPage() {
		//m.addAttribute("productList",productService.getAllProducts());
		return "shop/products/cart";
	}	
	
	//購物車首頁，顯示購物車內商品
	@GetMapping(value = "/getCartJson")
	public @ResponseBody Map<String, Object> getCart(HttpSession httpSession) {
		Map<String, Object> map = new HashMap<>();
		List<Product> productList = new ArrayList<>();
		List<Integer> productNums = new ArrayList<>(); 
		List<Integer> checks = new ArrayList<>(); 

		@SuppressWarnings("unchecked")
		Map<String,Integer> cmap = (Map<String, Integer>) httpSession.getAttribute("cart");
		Integer cartNum = 0;
        if (cmap == null) {  //第一次購物，創建購物車
        	cartNum=0;
        } else {
            //購物車不為空，判斷購物車是否已經有該商品
            //獲取商品數量
    		for(Entry<String, Integer> prods : cmap.entrySet()){
    			cartNum += prods.getValue();
    			productNums.add(prods.getValue());  //價錢
    			productList.add(productService.getByName1(prods.getKey())); //名字
    		}		
        }
		@SuppressWarnings("unchecked")
		Map<String,Integer> checkmap = (Map<String, Integer>) httpSession.getAttribute("check");
		if (checkmap!= null) {
			for(Entry<String, Integer> prods : checkmap.entrySet()){
    			checks.add(prods.getValue()); 
    		}			
		}
		System.out.println("checks : "+checks);
        map.put("checks", checks);
		map.put("productList", productList);
		map.put("productNums", productNums);
		return map;
	}
	
	
	
	//紀錄check
	@RequestMapping(value = "/CheckRecord")
	@ResponseBody
	public String CheckRecord(@RequestBody Map<String, Integer> map, HttpSession httpSession) {
		//String addCartId  = map.get("addCartId").toString();
		//String addCartName =map.get("addCartName").toString();	
		//String proCount = map.get("proCount").toString();
		//Integer check = map.get("check");
		System.out.println("map :" +map);
		
		@SuppressWarnings("unchecked")
		Map<String,Integer> checkmap = (Map<String, Integer>) httpSession.getAttribute("check");
		checkmap = new HashMap<>();  //將購物車放入session中
    	httpSession.setAttribute("check", checkmap);
    	
    	for(Entry<String, Integer> prods : map.entrySet()){
			checkmap.put(prods.getKey(), prods.getValue()); 
		}	
		
		return "success";		
	}
	
	//購物車內商品增加
	@RequestMapping(value = "/CartAdder")
	@ResponseBody
	public String CartAdder(@RequestBody Map<String, String> map, HttpSession httpSession) {
		String addCartId  = map.get("addCartId").toString();
		String addCartName =map.get("addCartName").toString();	
		String proCount = map.get("proCount").toString();
		Product product = productService.get(Integer.parseInt(addCartId));
		Integer pStock = product.getProduct_stock();
 
		@SuppressWarnings("unchecked")
		Map<String,Integer> cmap = (Map<String, Integer>) httpSession.getAttribute("cart");
		if (Integer.parseInt(proCount) <= pStock) {
			cmap.put(addCartName, (Integer.parseInt(proCount)) );  //更新購物車數量
		}
		else  {
        	return "OverStock";
		}	
		return "success";		
	}
		
	//購物車內商品減少
	@RequestMapping(value = "/CartMinus")
	@ResponseBody
	public String CartMinus(@RequestBody Map<String, String> map, HttpSession httpSession) {
		String minusCartName =map.get("minusCartName").toString();	
		String proCount = map.get("proCount").toString();
		@SuppressWarnings("unchecked")
		Map<String,Integer> cmap = (Map<String, Integer>) httpSession.getAttribute("cart");	
		cmap.put(minusCartName, (Integer.parseInt(proCount)) );  //更新購物車數量
		return "success";			
	}
		
	//刪除購物車內商品
	@RequestMapping(value = "/CartDel")
	@ResponseBody
	public String CartDel(@RequestBody Map<String, String> map, HttpSession httpSession) {
		@SuppressWarnings("unchecked")
		Map<String,Integer> cmap = (Map<String, Integer>) httpSession.getAttribute("cart");	

		for(Entry<String, String> prods : map.entrySet()){			
			System.out.println("get value"+prods.getValue());
			cmap.remove(prods.getValue());
		}		
		@SuppressWarnings("unchecked")
		Map<String,Integer> checkmap = (Map<String, Integer>) httpSession.getAttribute("check");
		if (checkmap!=null) {
			checkmap.clear();
		}
		return "success";			
	}
		
	//清空購物車內商品
	@RequestMapping(value = "/CartClear")
	@ResponseBody
	public String CartClear(@RequestBody Map<String, String> map, HttpSession httpSession) {
		@SuppressWarnings("unchecked")
		Map<String,Integer> cmap = (Map<String, Integer>) httpSession.getAttribute("cart");	
		cmap.clear(); //清空購物車
		
		@SuppressWarnings("unchecked")
		Map<String,Integer> checkmap = (Map<String, Integer>) httpSession.getAttribute("check");
		if (checkmap!=null) {
			checkmap.clear();
		}
		return "success";			
	}
		
	
		
	
	
	

}

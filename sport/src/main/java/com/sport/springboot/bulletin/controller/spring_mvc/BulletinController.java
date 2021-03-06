package com.sport.springboot.bulletin.controller.spring_mvc;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.sport.springboot.bulletin.model.Bulletin;
import com.sport.springboot.bulletin.model.BulletinClass;
import com.sport.springboot.bulletin.service.BulletinClassService;
import com.sport.springboot.bulletin.service.BulletinService;
import com.sport.springboot.users.model.Users;

@Controller
@RequestMapping("/Bulletin")
public class BulletinController {
	
	String noImage = "/images/noImage.jpg";
	
	@Autowired
	BulletinService bulletinService;
	
	@Autowired
	BulletinClassService bulletinClassService;
	
	@Autowired
	ServletContext context;
	
	//????????????????????????
	@GetMapping("/showAllBulletin")
	public String list(Model model) {
		model.addAttribute("bulletins", bulletinService.getAllBulletin());
		return "Bulletin/bulletinsPage";
	}
	//????????????
	@GetMapping("/bulletinPaging/{pageNum}")
	@ResponseBody
	public String pageable(@PathVariable("pageNum")Integer pageNum, Model model) {
		int pageSize = 4;
		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, Sort.Direction.DESC, "id"); 
		int id = 0; 
		Page<Bulletin> pageList = bulletinService.findByIdSort(id, pageable);
		List<Bulletin> dataList = pageList.getContent(); 
		Gson gson = new Gson();
		String jsonStr = gson.toJson(dataList);
//		for (Bulletin bulletin : pageList.getContent()) {
//			System.out.println(bulletin.toString()); 
//		 } 
//		model.addAttribute("totalPage", pageList.getTotalPages());
//		model.addAttribute("totalBulletin", pageList.getTotalElements());
		 return jsonStr; 
	}
	
	
	@GetMapping("/getPageInfo")
	public @ResponseBody Map<String, Integer> getPageInfo(@RequestParam("classId")Integer classId){
		Map<String, Integer> map = new HashMap<>();
		int pageSize = 4;
		Pageable pageable = PageRequest.of(0, pageSize, Sort.Direction.DESC, "id"); 
		int id = 0; 
		if(classId == 0) {
			Page<Bulletin> pageList = bulletinService.findByIdSort(id, pageable);
			map.put("totalPage", pageList.getTotalPages());
			map.put("totalBulletin", (int)(pageList.getTotalElements()));
		}else{
			Page<Bulletin> pageList = bulletinService.findByIdAndClassId(id, classId, pageable);
			map.put("totalPage", pageList.getTotalPages());
			map.put("totalBulletin", (int)(pageList.getTotalElements()));
		}
		return map;
	}
	
	//????????????
	@GetMapping("/bulletinPagingClass")
	@ResponseBody
	public String pageableAndClass(@RequestParam("nowPage")Integer pageNum,@RequestParam("classId")Integer classId, Model model) {
		int pageSize = 4;
		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, Sort.Direction.DESC, "id"); 
		int id = 0; 
		Page<Bulletin> pageList = bulletinService.findByIdAndClassId(id, classId, pageable);
		List<Bulletin> dataList = pageList.getContent(); 
		Gson gson = new Gson();
		String jsonStr = gson.toJson(dataList);

		 return jsonStr; 
	} 
	
	
	//???????????? ???????????????
		@GetMapping("/bulletinPagingCustomize")
		@ResponseBody
		public String pageableCustomize(@RequestParam("nowPage")Integer pageNum,@RequestParam("pageSize")Integer pageSize, Model model) {
//			int pageSize = 4;
			Pageable pageable = PageRequest.of(pageNum - 1, pageSize, Sort.Direction.DESC, "id"); 
			int id = 0; 
			Page<Bulletin> pageList = bulletinService.findByIdSort(id, pageable);
			List<Bulletin> dataList = pageList.getContent(); 
			Gson gson = new Gson();
			String jsonStr = gson.toJson(dataList);
//			for (Bulletin bulletin : pageList.getContent()) {
//				System.out.println(bulletin.toString()); 
//			 } 
//			model.addAttribute("totalPage", pageList.getTotalPages());
//			model.addAttribute("totalBulletin", pageList.getTotalElements());
			 return jsonStr; 
		}
	
	//???????????? ????????????????????????
		@GetMapping("/bulletinPagingClassCustomize")
		@ResponseBody
		public String pageableAndClassCustomize(@RequestParam("nowPage")Integer pageNum,@RequestParam("classId")Integer classId,@RequestParam("pageSize")Integer pageSize, Model model) {
//			int pageSize = 4;
			Pageable pageable = PageRequest.of(pageNum - 1, pageSize, Sort.Direction.DESC, "id"); 
			int id = 0; 
			Page<Bulletin> pageList = bulletinService.findByIdAndClassId(id, classId, pageable);
			List<Bulletin> dataList = pageList.getContent(); 
			Gson gson = new Gson();
			String jsonStr = gson.toJson(dataList);

			 return jsonStr; 
		} 
		//????????????????????????
		@GetMapping("/getPageInfoCustomize")
		public @ResponseBody Map<String, Integer> getPageInfoCustomize(@RequestParam("classId")Integer classId,@RequestParam("pageSize")Integer pageSize){
			Map<String, Integer> map = new HashMap<>();
//			int pageSize = 4;
			Pageable pageable = PageRequest.of(0, pageSize, Sort.Direction.DESC, "id"); 
			int id = 0; 
			if(classId == 0) {
				Page<Bulletin> pageList = bulletinService.findByIdSort(id, pageable);
				map.put("totalPage", pageList.getTotalPages());
				map.put("totalBulletin", (int)(pageList.getTotalElements()));
			}else{
				Page<Bulletin> pageList = bulletinService.findByIdAndClassId(id, classId, pageable);
				map.put("totalPage", pageList.getTotalPages());
				map.put("totalBulletin", (int)(pageList.getTotalElements()));
			}
			return map;
		}
	
	//??????????????????
	@GetMapping("/showBulletinContent/{id}")
	public String showBulletinContent(@PathVariable("id")Integer id,Model model) {
		Bulletin bulletin = bulletinService.get(id);
		model.addAttribute(bulletin);
//		Gson gson = new Gson();
//		String jsonStr = gson.toJson(bulletin);
		return "Bulletin/showBulletin";
//		return jsonStr;
	}
	
	@GetMapping("/getContent/{Id}")
	@ResponseBody
	public String getContent(@PathVariable("Id")Integer id,Model model) {
		Bulletin bulletin = bulletinService.get(id);
		Gson gson = new Gson();
		String jsonStr = gson.toJson(bulletin);
		return jsonStr;
	}
	
	//??????????????????????????????
	@GetMapping(value = "/add")
	public String showEmptyForm(Model model) {
		Bulletin bulletin = new Bulletin();
		//????????????
		
		
		model.addAttribute("bulletin",bulletin);
		return "Bulletin/addBulletin";
	}
	//??????submit????????? ??????????????????????????????????????????
	@PostMapping(value = "/add")
	public String add(@ModelAttribute("bulletin")Bulletin bulletin,
		 Model model, HttpServletRequest request) {
		MultipartFile picture = bulletin.getProductImage();
		String originalFilename = picture.getOriginalFilename();
		String extFilename = ""; 
		if (originalFilename.length() > 0 && originalFilename.lastIndexOf(".") > -1) {
			bulletin.setFileName(originalFilename);
			extFilename = originalFilename.substring(originalFilename.lastIndexOf("."));
			System.out.println(extFilename);
		}
		// ??????Blob??????????????? Hibernate ???????????????
		if (picture != null && !picture.isEmpty()) {
			try {
				byte[] b = picture.getBytes();
				Blob blob = new SerialBlob(b);
				bulletin.setImage(blob);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("????????????????????????: " + e.getMessage());
			}
		}
		//????????????????????????????????????????????????
//		String contents = bulletin.getContents();
//		if(contents != null) {
//			contents = contents.replaceAll("\n", "<br/>");
//			contents = contents.replaceAll(" ", "&nbsp;");
//			bulletin.setContents(contents);
//		}
//		
//		String subtitle = bulletin.getSubtitle();
//		if(subtitle != null) {
//			subtitle = subtitle.replaceAll("\n", "<br/>");
//			subtitle = subtitle.replaceAll(" ", "&nbsp;");
//			bulletin.setSubtitle(subtitle);
//		}
		//
		BulletinClass bulletinClass = bulletinClassService.getBulletinClass(bulletin.getClass_id().getId());
		bulletin.setClass_id(bulletinClass);
		
		Timestamp adminTime = new Timestamp(System.currentTimeMillis());
		bulletin.setDate(adminTime);
		bulletin.setUpdate_time(adminTime);
		try {
			bulletinService.save(bulletin);
		}catch (Exception e) {
			System.out.println("add error");
		}
		return "redirect:/Bulletin/showAllBulletin";
	}
	//????????????????????????????????????????????????????????????????????????
	@GetMapping(value = "/update/{id}")
	public String showDataForm(@PathVariable("id")Integer id, Model model) {
		Bulletin bulletin = bulletinService.get(id);
		String contents = bulletin.getContents();
		//?????????????????????
//		if(contents != null) {
//			contents = contents.replaceAll("<br/>", "\n");
//			contents = contents.replaceAll("&nbsp;", " ");
//			bulletin.setContents(contents);
//		}
//		String subtitle = bulletin.getSubtitle();
//		//?????????????????????
//		if(subtitle != null) {
//			subtitle = subtitle.replaceAll("<br/>", "\n");
//			subtitle = subtitle.replaceAll("&nbsp;", " ");
//			bulletin.setSubtitle(subtitle);
//		}
		System.out.println("==============" +  bulletin.getSubtitle());
//		if(bulletin.getSubtitle() == null) {
//			bulletin.setSubtitle("");
//			System.out.println("==============" +  bulletin.getSubtitle());
//		}
		
		
		model.addAttribute(bulletin);
		return "Bulletin/updateBulletin";
	}

	
	@PostMapping(value = "/update/{id}")
	public String modify(@ModelAttribute("bulletin")Bulletin bulletin, Model model,@PathVariable("id")Integer id , HttpServletRequest request) {
		
		
		
		Bulletin bulletin1 = bulletinService.get(bulletin.getId());
		
		BulletinClass bulletinClass = bulletinClassService.getBulletinClass(bulletin.getClass_id().getId());
		bulletin.setClass_id(bulletinClass);
		
		Timestamp adminTime = new Timestamp(System.currentTimeMillis());
		bulletin.setUpdate_time(adminTime);
		bulletin.setDate(bulletin1.getDate());
		
		//????????????????????????????????????????????????
		String contents = bulletin.getContents();
//		if(contents != null) {
//			contents = contents.replaceAll("\n", "<br/>");
//			contents = contents.replaceAll(" ", "&nbsp;");
//			bulletin.setContents(contents);
//		}
//				
//		String subtitle = bulletin.getSubtitle();
//		if(subtitle != null) {
//			subtitle = subtitle.replaceAll("\n", "<br/>");
//			subtitle = subtitle.replaceAll(" ", "&nbsp;");
//			bulletin.setSubtitle(subtitle);
//		}
				//
		
		
		
		
		MultipartFile picture = bulletin.getProductImage();
		
		if (picture.getSize() == 0) {
			bulletin.setFileName(bulletin1.getFileName());
			bulletin.setImage(bulletin1.getImage());
			
		} else {
			String originalFilename = picture.getOriginalFilename();
			if (originalFilename.length() > 0 && originalFilename.lastIndexOf(".") > -1) {
				bulletin.setFileName(originalFilename);
			}

			// ??????Blob??????
			if (picture != null && !picture.isEmpty()) {
				try {
					byte[] b = picture.getBytes();
					Blob blob = new SerialBlob(b);
					bulletin.setImage(blob);
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException("????????????????????????: " + e.getMessage());
				}
			}
		}
		System.out.println("----------------------------");
		System.out.println(picture.getSize() + "\n");
		System.out.println(bulletin.getImage() +"\n");
		System.out.println(bulletin.getFileName() + "\n");
		System.out.println("----------------------------");
		
		bulletinService.update(bulletin);
		return "redirect:/Bulletin/showAllBulletin";
	}
	
	@DeleteMapping(value = "/delete/{id}")
	@ResponseBody
	public void delete(@PathVariable("id")Integer id) {
		bulletinService.delete(id);
	}
	
	//??????id???????????????????????????????????????
	@GetMapping("/picture/{id}")
	public ResponseEntity<byte[]> getPicture(@PathVariable("id") Integer id) {
		byte[] body = null;
		ResponseEntity<byte[]> re = null;
		MediaType mediaType = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setCacheControl(CacheControl.noCache().getHeaderValue());

		Bulletin bulletin = bulletinService.get(id);
		if (bulletin == null) {
			return new ResponseEntity<byte[]>(HttpStatus.NOT_FOUND);
		}
		String filename = bulletin.getFileName();
		if (filename != null) {
			if (filename.toLowerCase().endsWith("jfif")) {
				mediaType = MediaType.valueOf(context.getMimeType("dummy.jpeg"));
			} else {
				mediaType = MediaType.valueOf(context.getMimeType(filename));
				headers.setContentType(mediaType);
			}
		}
		Blob blob = bulletin.getImage();
		if (blob != null) {
			body = blobToByteArray(blob);
		} else {
			String path = null;

			path = noImage;
			
			body = fileToByteArray(path);
		}
		re = new ResponseEntity<byte[]>(body, headers, HttpStatus.OK);

		return re;
	}
	
	//?????????ID???????????????????????????NULL????????????????????????reset
	@PostMapping("/resetPicture/{id}")
	@ResponseBody
	public void resetPicture (@PathVariable("id")Integer id) {
		bulletinService.resetPicture(id);
	}
	
	@ModelAttribute
	public void commonData(Model model) {
		List<BulletinClass> classList = bulletinClassService.getAllBulletinClass();
		model.addAttribute("classList", classList);
	}
	
	
//	@InitBinder
//	public void initBinder(WebDataBinder binder) {
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		sdf.setLenient(false);
//		binder.registerCustomEditor(Timestamp.class, new CustomDateEditor(sdf, true));
//	}
//	
	
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
	
	@ModelAttribute
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
	
}

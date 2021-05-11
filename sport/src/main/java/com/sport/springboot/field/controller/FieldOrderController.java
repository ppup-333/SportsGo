package com.sport.springboot.field.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sport.springboot.field.model.Field;
import com.sport.springboot.field.model.FieldActOrder;
import com.sport.springboot.field.model.FieldMemberOrder;
import com.sport.springboot.field.model.FieldOrderDetail;
import com.sport.springboot.field.model.FieldPeriod;
import com.sport.springboot.field.model.FieldType;
import com.sport.springboot.field.service.FieldActOrderService;
import com.sport.springboot.field.service.FieldMemberOrderService;
import com.sport.springboot.field.service.FieldOrderDetailService;
import com.sport.springboot.field.service.FieldPeriodService;
import com.sport.springboot.field.service.FieldService;
import com.sport.springboot.field.service.FieldTypeService;
import com.sport.springboot.users.model.Users;
import com.sport.springboot.users.service.UsersService;

@Controller
@RequestMapping("/fieldOrder")
public class FieldOrderController {
	
	@Autowired
	FieldTypeService fieldTypeService;
	@Autowired
	FieldService fieldService;
	@Autowired
	FieldPeriodService fieldPeriodService;
	@Autowired
	FieldMemberOrderService fieldMemberOrderService;
	@Autowired
	FieldActOrderService fieldActOrderService;
	@Autowired
	FieldOrderDetailService fieldOrderDetailService;
	@Autowired
	UsersService usersService;
	
	@GetMapping("/home")
	public String fieldOrderHome() {
		return "fieldOrder/order_Home";
	}
	
	@GetMapping("/searchPage")
	public String orderMemberSearchPage(Model m) {
		Date day1 = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String day1Str = dateFormat.format(day1);		
		System.out.println(day1Str);
		
		m.addAttribute("day1", day1Str);
		
		return "fieldOrder/order_SearchPage";
	}	
	
	@GetMapping("/searchForMemberPage")
	public String orderSearchForMemberPage() {
		return "fieldOrder/order_SearchPageForMember";
	}
	
	@GetMapping("/cancelForMemberPage")
	public String orderCancelForMemberPage() {
		return "fieldOrder/order_CancelPageForMember";
	}
	
	
	@GetMapping("/createPage")
	public String orderCreatePage(Model m, HttpSession session) {
		Date day1 = new Date();
		long ms = day1.getTime() + 86400000 * 7;
		Date day2 = new Date(ms);
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String day1Str = dateFormat.format(day1);
		String day2Str = dateFormat.format(day2);		
		System.out.println(day1Str);
		System.out.println(day2Str);
		
		List<FieldMemberOrder> memberOrderList = new ArrayList<>();
		List<FieldMemberOrder> memberPastOrderList = new ArrayList<>();
		if(session.getAttribute("account") != null) {
			String account = session.getAttribute("account").toString();
			memberOrderList = fieldMemberOrderService.getOrderByAccount(account);
			memberPastOrderList = fieldMemberOrderService.getPastOrdersByAccount(account);
		}
		
		boolean attendanceStatus = true;
		int count = 0;
		for(int i = 0; i < memberPastOrderList.size(); i++) {
			if(memberPastOrderList.get(i).getAttendance() == -1 ) {
				count++;
				if(count == 3) {
					attendanceStatus = false;
					break;
				}
			}
		}		
		
		m.addAttribute("day1", day1Str);
		m.addAttribute("day2", day2Str);
		m.addAttribute("memberOrderCount", memberOrderList.size());
		m.addAttribute("attendanceStatus", attendanceStatus);
		return "fieldOrder/order_CreatePage";
	}
	
	@PostMapping("/createMemberOrder")
	public String fieldOrderCreate(@RequestParam("periodId")Integer periodId,
			@RequestParam("date")String date, @RequestParam("hours")Integer hours,
			@RequestParam("fieldId")String fieldId, HttpSession session,
			RedirectAttributes attr) {
		
		String account = session.getAttribute("account").toString();
		Users user = usersService.get(account);
		FieldMemberOrder mOrder = new FieldMemberOrder();
		mOrder.setUsers(user);
		Date createDate = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateStr = dateFormat.format(createDate);
		mOrder.setCreateTime(dateStr);
		mOrder.setOrderStatus(1);
		mOrder.setRemark(null);
		
		fieldMemberOrderService.save(mOrder);
		
		attr.addAttribute("date", date);
		attr.addAttribute("periodId", periodId);
		attr.addAttribute("hours", hours);
		attr.addAttribute("fieldId", fieldId);
		attr.addAttribute("mOrder", mOrder);		
		
		return "redirect:orderDetailCreate";
	}
	
	//-------------------------------------------------------
	@PostMapping("/createActOrder")
	public String fieldOrdersCreate(@RequestParam("periodId")Integer periodId,
			@RequestParam("date")String date, @RequestParam("hours")Integer hours,
			@RequestParam("fieldId")String fieldId,
			RedirectAttributes attr) {
		FieldActOrder actOrder = new FieldActOrder();
		actOrder.setActId(123);
		Date createDate = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateStr = dateFormat.format(createDate);
		actOrder.setCreateTime(dateStr);
		actOrder.setOrderStatus(1);
		actOrder.setRemark(null);
		
		fieldActOrderService.save(actOrder);
		
		attr.addAttribute("date", date);
		attr.addAttribute("periodId", periodId);
		attr.addAttribute("hours", hours);
		attr.addAttribute("fieldId", fieldId);
		attr.addAttribute("actOrder", actOrder);		
		
		return "redirect:orderDetailCreate";
	}
	
	//-------------------------------------------------------
	
	@GetMapping("orderDetailCreate")
	public String fieldOrderDetailCreate(@RequestParam("periodId")Integer periodId,
			@RequestParam("date")String date, @RequestParam("hours")Integer hours,
			@RequestParam("fieldId")String fieldId,
			@RequestParam("mOrder")FieldMemberOrder mOrder) {
		
		//List<FieldOrderDetail> fieldOrderDetails = new ArrayList<>();
		for(int i = periodId; i < periodId + hours; i++) {
			FieldOrderDetail fieldOrderDetail = new FieldOrderDetail();
			fieldOrderDetail.setField(fieldService.get(fieldId));
			fieldOrderDetail.setFieldPeriod(fieldPeriodService.get(i));
			fieldOrderDetail.setFieldMemberOrder(mOrder);
			fieldOrderDetail.setDate(date);
			
			fieldOrderDetailService.save(fieldOrderDetail);
		}
		
		return "fieldOrder/order_Create";
		
	}	
	
	
	//-------------------- A j a x --------------------------
	@GetMapping(value = "/getAllMemberOrdersJsonByAccount/{account}")
	public @ResponseBody Map<String, Object> getAllMemberOrdersJsonByAccount(
			@PathVariable("account")String account){
		Map<String, Object> map = new HashMap<>();
		List<FieldMemberOrder> fieldMemberOrderList = fieldMemberOrderService.getAllByAccount(account);
		map.put("fieldMemberOrderList", fieldMemberOrderList);
		return map;
	}	
	
	@GetMapping(value = "/getMemberOrderJsonByAccount/{account}")
	public @ResponseBody Map<String, Object> getMemberOrderJsonByAccount(
			@PathVariable("account")String account){
		Map<String, Object> map = new HashMap<>();
		List<FieldMemberOrder> fieldMemberOrderList = fieldMemberOrderService.getOrderByAccount(account);
		map.put("fieldMemberOrderList", fieldMemberOrderList);
		return map;
	}
	
	@GetMapping(value = "/getPastMemberOrderJsonByAccount/{account}")
	public @ResponseBody Map<String, Object> getPastMemberOrderJsonByAccount(
			@PathVariable("account")String account){
		Map<String, Object> map = new HashMap<>();
		List<FieldMemberOrder> fieldMemberOrderList = fieldMemberOrderService.getPastOrdersByAccount(account);
		map.put("fieldMemberOrderList", fieldMemberOrderList);
		return map;
	}
	
	@GetMapping(value = "/getMemberOrderJson")
	public @ResponseBody Map<String, Object> getMemberOrderJson(HttpSession session){
		String account = session.getAttribute("account").toString();
		Map<String, Object> map = new HashMap<>();
		List<FieldMemberOrder> fieldMemberOrderList = fieldMemberOrderService.getOrderByAccount(account);
		map.put("fieldMemberOrderList", fieldMemberOrderList);
		return map;
	}
	
	@GetMapping(value = "/getPastMemberOrderJson")
	public @ResponseBody Map<String, Object> getPastMemberOrderJson(HttpSession session){
		String account = session.getAttribute("account").toString();
		Map<String, Object> map = new HashMap<>();
		List<FieldMemberOrder> fieldMemberOrderList = fieldMemberOrderService.getPastOrdersByAccount(account);
		map.put("fieldMemberOrderList", fieldMemberOrderList);
		return map;
	}
	
	@GetMapping(value = "/getJson/typeId={typeId}&date={date}&periodId={periodId}")
	public @ResponseBody Map<String, Object> getJsonByTypeAndPeriod(
			@PathVariable("typeId")Integer typeId, @PathVariable("date")String date,
			@PathVariable("periodId")Integer periodId){
		Map<String, Object> map = new HashMap<>();
		List<FieldMemberOrder> fieldMemberOrderList = fieldMemberOrderService.getOrderByDateAndPeriod(typeId, date, periodId);
//		System.out.println("---------------------------------------");
//		System.out.println(fieldMemberOrderList.get(0).getId());
//		System.out.println("---------------------------------------");
		map.put("fieldMemberOrderList", fieldMemberOrderList);
		return map;
	}
	
	@RequestMapping(value = "/updateAttendance")
	@ResponseBody
	public String updateAttendance(@RequestBody Map<String, Integer> map) {
		FieldMemberOrder fieldMemberOrder = fieldMemberOrderService.get(map.get("updateId"));
		fieldMemberOrder.setAttendance(1);
		fieldMemberOrderService.save(fieldMemberOrder);
		return "success";
	}
	
	@RequestMapping(value = "/updateAbsence")
	@ResponseBody
	public String updateAbsence(@RequestBody Map<String, Integer> map) {
		
		FieldMemberOrder fieldMemberOrder = fieldMemberOrderService.get(map.get("updateId"));
		fieldMemberOrder.setAttendance(-1);
		fieldMemberOrderService.save(fieldMemberOrder);
		return "success";
	}
	
	@RequestMapping(value = "/resetAttendance")
	@ResponseBody
	public String resetAttendance(@RequestBody Map<String, Integer> map) {
		FieldMemberOrder fieldMemberOrder = fieldMemberOrderService.get(map.get("updateId"));
		fieldMemberOrder.setAttendance(0);
		fieldMemberOrderService.save(fieldMemberOrder);
		return "success";
	}
	
	@RequestMapping(value = "/updateCancel")
	@ResponseBody
	public String updateCancel(@RequestBody Map<String, Integer> map) {
		FieldMemberOrder fieldMemberOrder = fieldMemberOrderService.get(map.get("updateId"));
		fieldMemberOrder.setOrderStatus(0);
		fieldMemberOrderService.save(fieldMemberOrder);
		return "success";
	}
	
	@RequestMapping(value = "/resetCancel")
	@ResponseBody
	public String resetCancel(@RequestBody Map<String, Integer> map) {
		FieldMemberOrder fieldMemberOrder = fieldMemberOrderService.get(map.get("updateId"));
		fieldMemberOrder.setOrderStatus(1);
		fieldMemberOrderService.save(fieldMemberOrder);
		return "success";
	}
	
	
	@GetMapping(value = "/getFieldsOrderJsonByTypeId/date={date}&typeId={typeId}")
	public @ResponseBody Map<String, Object> getJsonByTypeId(@PathVariable("date")String date,
			@PathVariable("typeId")Integer typeId) {
		Map<String, Object> map = new HashMap<>();
		List<FieldPeriod> fieldPeriodList = fieldPeriodService.getAll();
		List<FieldOrderDetail> fieldOrderDetailList = new ArrayList<FieldOrderDetail>();
		List<List<FieldOrderDetail>> orderDetailList = new ArrayList<>();
		List<Field> fieldList = fieldService.getByTypeId(typeId);
		for(int i = 0; i < fieldList.size(); i++) {
			fieldOrderDetailList = fieldOrderDetailService.getByDateAndField(date,fieldList.get(i));			
			
			List<FieldOrderDetail> temp = new ArrayList<>();
			for(int j = 0; j < fieldOrderDetailList.size(); j++) {
				if(fieldOrderDetailList.get(j).getFieldActOrder()!=null) {
					if(fieldOrderDetailList.get(j).getFieldActOrder().getOrderStatus() == 1) {
						temp.add(fieldOrderDetailList.get(j));
					}						
				}else {
					
					
					if(fieldOrderDetailList.get(j).getFieldMemberOrder()!=null) {
						
						if(fieldOrderDetailList.get(j).getFieldMemberOrder().getOrderStatus() == 1) {
						temp.add(fieldOrderDetailList.get(j));
						}
					}
					
				}
			}
			orderDetailList.add(temp);
			
		}
		System.out.println("====================================================================");
		System.out.println(orderDetailList.size());
		System.out.println("====================================================================");
		map.put("orderDetailList", orderDetailList);
		map.put("fieldList", fieldList);
		map.put("fieldPeriodList", fieldPeriodList);
		
		return map;
	}
	
	@ModelAttribute
	void commonData(Model m) {
		List<FieldType> fieldTypeList = fieldTypeService.getAll();
		List<FieldType> fieldTypeList1 = new ArrayList<>();
		for(int i = 1; i < fieldTypeList.size(); i++) {
			fieldTypeList1.add(fieldTypeList.get(i));
		}
		m.addAttribute("fieldTypeList", fieldTypeList1);
		m.addAttribute("periodList", fieldPeriodService.getAll());
		m.addAttribute("fieldList", fieldService.getAll());
	}
	
	@ModelAttribute
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
}

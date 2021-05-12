package com.sport.springboot.field.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sport.springboot.field.model.Field;
import com.sport.springboot.field.model.FieldType;
import com.sport.springboot.field.service.FieldService;
import com.sport.springboot.field.service.FieldTypeService;
import com.sport.springboot.field.validate.FieldValidator;
import com.sport.springboot.users.model.Users;

@Controller
public class FieldController {
	
	@Autowired
	FieldType fieldType;	
	@Autowired
	FieldService fieldService;	
	@Autowired
	FieldTypeService fieldTypeService;
	
	private Integer typeId = 0;
	private String startCode = "";

	@GetMapping("/field_HomePage")
	public String fieldHomePage() {
		return "field/field_HomePage";
	}	
	
	@GetMapping("/field_GetAllFields")
	public String findAllFields(Model m) {
		m.addAttribute("typeId", this.typeId);
		m.addAttribute("typeIdHide", this.typeId);
		m.addAttribute("startCode", this.startCode);
		this.startCode = "";
		return "field/field_GetAllFields";
	}
	
	@GetMapping("/field_CreatePage")
	public String createFieldPage(@RequestParam("typeId")Integer typeId, Model m) {
		m.addAttribute("typeId", typeId);
		return "field/field_Create";
	}	
	
	@PostMapping("/updateFieldPage")
	public String updateFieldPage(@RequestParam("updateId")String id,
			@RequestParam("typeId")Integer typeId, Model m) {
		Field field = fieldService.get(id);		
		m.addAttribute("field", field);
		m.addAttribute("typeId", typeId);
		return "field/field_Update";
	}
	
	@PostMapping("/updateField")
	public String updateField(@ModelAttribute("field")Field newField,
			@RequestParam("typeIdHide")Integer typeId, BindingResult result, Model m) {
		
		FieldValidator fieldValidator = new FieldValidator();
		
		fieldValidator.validate(newField, result);
		if(result.hasErrors()) {
			this.startCode = "createError";
			m.addAttribute("typeId", typeId);
			m.addAttribute("startCode", this.startCode);
			this.startCode = "";
			return "field/field_GetAllFields";
		}
		
		if(newField.getBuildDate()=="") {
			newField.setBuildDate("不明");
		}
		
		Date date = new Date();
		
		String id = newField.getId();		
		
		if(fieldService.findByFieldId(id).size() == 0) {
			
			System.out.println("-------- 執行新增 --------");
			
			newField.setCreateDate(date);
			
			fieldService.save(newField);
			
			System.out.println("-------- 新增成功！ --------");
			this.startCode = "createSuccess";
			
		}else {
			
			System.out.println("-------- 執行修改 --------");		
			
			Field field = fieldService.get(id);
			newField.setCreateDate(field.getCreateDate());
			newField.setUpdateDate(date);
			
			fieldService.update(newField);
			
			System.out.println("-------- 修改成功！ --------");	
			this.startCode = "updateSuccess";
		
		}
		this.typeId = typeId;
		return "redirect:/field_GetAllFields";
	}
	
	@PostMapping("/deleteField")
	public String deleteField(@RequestParam("deleteId")String id) {
		
		System.out.println("=================================");

		System.out.println("=================================");
		System.out.println(id);
		System.out.println("=================================");

		System.out.println("=================================");
		
		try {
			fieldService.delete(id);
		}catch(Exception e) {
			this.startCode = "deleteError";
			return "redirect:/field_GetAllFields";
		}
		
		
		this.startCode = "deleteSuccess";
		
		return "redirect:/field_GetAllFields";
	}

	
	//---------------- A j a x -------------------
	@GetMapping(value = "/getFieldsJsonByTypeId/{tid}")
	public @ResponseBody Map<String, Object> getJsonByTypeId(@PathVariable("tid")Integer typeId) {
		Map<String, Object> map = new HashMap<>();
		List<Field> fieldList = new ArrayList<>();
		
		if(typeId == 0) {
			fieldList = fieldService.getAll();
		}else {
			fieldList = fieldService.getByTypeId(typeId);
		}
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String[] fieldCreateDateStrList = new String[fieldList.size()];
		String[] fieldUpdateDateStrList = new String[fieldList.size()];
		for(int i = 0; i < fieldList.size(); i++) {
			fieldCreateDateStrList[i] = dateFormat.format(fieldList.get(i).getCreateDate());
			if(fieldList.get(i).getUpdateDate()!=null) {
				fieldUpdateDateStrList[i] = dateFormat.format(fieldList.get(i).getUpdateDate());
			}			
		}
		map.put("fieldList", fieldList);
		map.put("fieldCreateDateStrList", fieldCreateDateStrList);
		map.put("fieldUpdateDateStrList", fieldUpdateDateStrList);
		map.put("typeId", typeId);
		return map;
		
	}
	
	//---------------ModelAttribute----------------
	@ModelAttribute
	void commonData(Model m) {
		List<FieldType> fieldTypeList = fieldTypeService.getAll();
		List<FieldType> fieldTypeList1 = new ArrayList<>();
		for(int i = 1; i < fieldTypeList.size(); i++) {
			fieldTypeList1.add(fieldTypeList.get(i));
		}
		m.addAttribute("field", new Field());
		m.addAttribute("fieldTypeList", fieldTypeList1);
	}
	
	@ModelAttribute
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
}

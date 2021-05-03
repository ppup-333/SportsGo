package com.sport.springboot.bbs.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sport.springboot.bbs.model.Bbs;
import com.sport.springboot.bbs.model.BbsReply;
import com.sport.springboot.bbs.model.BbsType;
import com.sport.springboot.bbs.service.BbsReplyService;
import com.sport.springboot.bbs.service.BbsService;
import com.sport.springboot.bbs.service.BbsTypeService;

@Controller
public class BbsController_Member {

	@Autowired
	private BbsService bbsService;
	@Autowired
	private BbsTypeService bbsTypeService;
	@Autowired
	private BbsReplyService bbsReplyService;

	//所有類型分類，使用在select下拉式選單
	public void prepareList(Model m) {
		List<BbsType> gameList = bbsTypeService.getByTypeGroup("Game");
		m.addAttribute("gameList", gameList);
		List<BbsType> healthList = bbsTypeService.getByTypeGroup("Health");
		m.addAttribute("healthList", healthList);
		List<BbsType> sportList = bbsTypeService.getByTypeGroup("Sport");
		m.addAttribute("sportList", sportList);
	}
	
	@GetMapping("/bbs")
	public String bbsMemberHomePage(Model m) {
		List<Bbs> bbsList = bbsService.getAllBbs();
		m.addAttribute("bbsList", bbsList);
		prepareList(m);
		return "bbs/BbsMemberHomePage";
	}
	
	//select下拉式選單分類查詢
	@PostMapping("/bbs.selectSearch")
	public String selectType(@RequestParam Integer typeId, Model m) {
		prepareList(m);
		List<Bbs> bbsList = bbsService.getBbsByTypeId(typeId);	//orderBy bbsSetupTime
		m.addAttribute("bbsList", bbsList);
		m.addAttribute("typeId", typeId);
		return "bbs/BbsMemberHomePage";
	}

	//模糊查詢
	@GetMapping("/bbsdiscussion.r")
	public String bbsReadBySearch(@RequestParam("search") String search, Model m) {
		List<Bbs> searchList = bbsService.getBbsBySearch(search);
		m.addAttribute("searchList", searchList);
		prepareList(m);
		return "bbs/BbsReadDiscussion";
	}

	//
	@GetMapping("/bbsdiscussion.c")
	public String bbsCreateBbs(Model m) {
		prepareList(m);
		return "bbs/BbsCreateDiscussion";
	}
	
	@ModelAttribute
	public void modelAttribute(Model m) {
		m.addAttribute("bbs", new Bbs());
	}
	
	@PostMapping("/bbsdiscussion.c.success")
	public String bbsCreate(@ModelAttribute("bbs") Bbs bbs, Model m) {
		bbs.setBbsSetupTime(Timestamp.valueOf(LocalDateTime.now()));
		m.addAttribute("bbsSetupTime", bbs.getBbsSetupTime());
		bbsService.save(bbs);
		return "bbs/BbsCreateSuccess";
	}

	//跳轉到點選的留言
	@GetMapping("/bbsSelect")
	public String bbsSelectDicussionByBbsId(@RequestParam Integer bbsId, Model m) {
		Bbs bbs = bbsService.getBbsByBbsId(bbsId);
		m.addAttribute("bbs", bbs);
		return "bbs/BbsSelect";
	}
	
	//刪除發文
	@PostMapping("/bbsDelete")
	public String bbsDeleteSuccess(@RequestParam Integer bbsId) {
		bbsService.delete(bbsId);
		return "bbs/BbsDeleteSuccess";
	}
	
	//跳進編輯發文頁面
	@PostMapping("/bbsUpdate")
	public String bbsUpdate(@RequestParam Integer bbsId, Model m) {
		Bbs bbs = bbsService.getBbsByBbsId(bbsId);
		m.addAttribute("bbs", bbs);
		return "bbs/BbsUpdate";
	}
	
	//編輯發文
	@PostMapping("/bbsUpdateSuccess")
	public String bbsUpdateSuccess(@RequestParam Integer bbsId, @RequestParam String bbsTitle,
			@RequestParam String bbsMessage, @RequestParam Integer typeId, Model m) {
		Bbs bbs = bbsService.getBbsByBbsId(bbsId);//從資料庫拉物件進來，bbsId是從前端頁面傳過來的
		bbs.setBbsTitle(bbsTitle);
		bbs.setBbsMessage(bbsMessage);
		bbs.setBbsUpdateTime(Timestamp.valueOf(LocalDateTime.now()));
		BbsType bbsType = bbsTypeService.getBbsType(typeId);
		bbs.setBbsType(bbsType);
		bbsService.update(bbs);
		m.addAttribute("bbs", bbs);
		return "bbs/BbsUpdateSuccess";
	}
	
	//跳轉到回覆發文頁面
	@GetMapping("/bbsReply")
	public String bbsReply(@RequestParam Integer bbsId, @RequestParam Integer replyId, Model m) {
		Bbs bbs = bbsService.getBbsByBbsId(bbsId);
		m.addAttribute("bbs", bbs);
		BbsReply bbsReply = bbsReplyService.getBbsReply(replyId);
		m.addAttribute("bbsReply", bbsReply);
		return "bbs/BbsReply";
	}
	
	//回覆
	@PostMapping("/bbsReplySuccess")
	public String bbsReplySuccess(Model m) {
		List<BbsReply> replyList = bbsReplyService.getAllBbsReply();
		m.addAttribute("replyList", replyList);
		return "bbs/BbsReplySuccess";
	}
	
}

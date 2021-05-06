package com.sport.springboot.bbs.controller;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sport.springboot.bbs.model.Bbs;
import com.sport.springboot.bbs.model.BbsReply;
import com.sport.springboot.bbs.model.BbsType;
import com.sport.springboot.bbs.service.BbsReplyService;
import com.sport.springboot.bbs.service.BbsService;
import com.sport.springboot.bbs.service.BbsTypeService;
import com.sport.springboot.bbs.vo.BbsVo;

@Controller
public class BbsController_Manager {

	@Autowired
	private BbsService bbsService;
	@Autowired
	private BbsTypeService bbsTypeService;
	@Autowired
	private BbsReplyService bbsReplyService;

	// 所有類型分類，使用在select下拉式選單
	public void prepareList(Model m) {
		List<BbsType> gameList = bbsTypeService.getByTypeGroup("Game");
		m.addAttribute("gameList", gameList);
		List<BbsType> healthList = bbsTypeService.getByTypeGroup("Health");
		m.addAttribute("healthList", healthList);
		List<BbsType> sportList = bbsTypeService.getByTypeGroup("Sport");
		m.addAttribute("sportList", sportList);
	}

	// 首頁
	@GetMapping("/bbsM")
	public String bbsManagerHomePage(Model m) {
		prepareList(m);
		return "bbs/BbsManagerHomePage";
	}

	@GetMapping("/bbsM.selectSearch")
	public @ResponseBody List<BbsVo> bbsMselectType(@RequestParam("typeId") Integer typeId) {
		List<Bbs> bbsList = new ArrayList<>();
		if (typeId > 0) {
			bbsList = bbsService.getBbsByTypeId(typeId); // orderBy bbsSetupTime
		} else if (typeId == 0) {
			bbsList = bbsService.getAllBbs();
		} else {
			bbsList = bbsService.getBbsByTypeGroup(typeId);
		}
		return bbsList.stream().map(bbs -> {
			BbsVo bbsVo = new BbsVo();
			bbsVo.setBbsId(bbs.getBbsId());
			bbsVo.setAccount(bbs.getUsers().getAccount());
			bbsVo.setBbsTitle(bbs.getBbsTitle());
			bbsVo.setBbsMessage(bbs.getBbsMessage().length() >= 20 ? bbs.getBbsMessage().substring(0, 20) + "..." : bbs.getBbsMessage());
			bbsVo.setBbsSetupTime(bbs.getBbsSetupTime());
			bbsVo.setBbsUpdateTime(bbs.getBbsUpdateTime());
			bbsVo.setTypeName(bbs.getBbsType().getTypeName());
			bbsVo.setBbsDelete(bbs.getBbsDelete());
			BbsReply bbsReply = bbs.getReplyList().size() == 0 ? null : 
				bbs.getReplyList().stream().max(Comparator.comparing(BbsReply::getReplySetupTime)).get();
			bbsVo.setReplySetupTime(bbsReply != null ? bbsReply.getReplySetupTime() : null);
			bbsVo.setReplyAccount(bbsReply != null ? bbsReply.getUsers().getAccount() : null);
			return bbsVo;
		}).collect(Collectors.toList());

	}

	// 模糊查詢
	@GetMapping("/bbsM.discussion.r")
	public @ResponseBody List<BbsVo> bbsMReadBySearch(@RequestParam("search") String search, Model m) {
		List<Bbs> searchList = bbsService.getBbsBySearch(search);
		return searchList.stream().map(bbs -> {
			BbsVo bbsVo = new BbsVo();
			bbsVo.setBbsId(bbs.getBbsId());
			bbsVo.setAccount(bbs.getUsers().getAccount());
			bbsVo.setBbsTitle(bbs.getBbsTitle());
			bbsVo.setBbsMessage(bbs.getBbsMessage().length() >= 20 ? bbs.getBbsMessage().substring(0, 20) + "..." : bbs.getBbsMessage());
			bbsVo.setBbsSetupTime(bbs.getBbsSetupTime());
			bbsVo.setBbsUpdateTime(bbs.getBbsUpdateTime());
			bbsVo.setTypeName(bbs.getBbsType().getTypeName());
			bbsVo.setBbsDelete(bbs.getBbsDelete());
			BbsReply bbsReply = bbs.getReplyList().size() == 0 ? null : 
				bbs.getReplyList().stream().max(Comparator.comparing(BbsReply::getReplySetupTime)).get();
			bbsVo.setReplySetupTime(bbsReply != null ? bbsReply.getReplySetupTime() : null);
			bbsVo.setReplyAccount(bbsReply != null ? bbsReply.getUsers().getAccount() : null);
			return bbsVo;
		}).collect(Collectors.toList());
	}
	
	//dropdown-menu 選擇狀態
	@GetMapping("/bbsM.selectSearchByBbsDelete")
	public @ResponseBody List<BbsVo> bbsMselectDeleteType(@RequestParam Integer bbsDelete) {
		List<Bbs> bbsList = new ArrayList<>();
		if (bbsDelete == -1) {
			bbsList = bbsService.getAllBbs();
		} else {
			bbsList = bbsService.getBbsByBbsDelete(bbsDelete); // orderBy bbsSetupTime
		}
		return bbsList.stream().map(bbs -> {
			BbsVo bbsVo = new BbsVo();
			bbsVo.setBbsId(bbs.getBbsId());
			bbsVo.setAccount(bbs.getUsers().getAccount());
			bbsVo.setBbsTitle(bbs.getBbsTitle());
			bbsVo.setBbsMessage(bbs.getBbsMessage());
			bbsVo.setBbsSetupTime(bbs.getBbsSetupTime());
			bbsVo.setBbsUpdateTime(bbs.getBbsUpdateTime());
			bbsVo.setTypeName(bbs.getBbsType().getTypeName());
			bbsVo.setBbsDelete(bbs.getBbsDelete());
			BbsReply bbsReply = bbs.getReplyList().size() == 0 ? null : 
				bbs.getReplyList().stream().max(Comparator.comparing(BbsReply::getReplySetupTime)).get();
			bbsVo.setReplySetupTime(bbsReply != null ? bbsReply.getReplySetupTime() : null);
			bbsVo.setReplyAccount(bbsReply != null ? bbsReply.getUsers().getAccount() : null);
			return bbsVo;
		}).collect(Collectors.toList());

	}
	
	@ModelAttribute
	public void modelAttribute(Model m) {
		m.addAttribute("bbs", new Bbs());
		m.addAttribute("bbsReply", new BbsReply());
	}

	// 跳轉到點選的留言
	@GetMapping("/bbsM.Select")
	public String bbsMSelectDicussionByBbsId(@RequestParam Integer bbsId, Model m) {
		Bbs bbs = bbsService.getBbsByBbsId(bbsId);
		m.addAttribute("bbs", bbs);
		List<BbsReply> replyList = bbsReplyService.getBbsReplyByBbsId(bbsId);
		m.addAttribute("replyList", replyList);
		return "bbs/BbsManagerSelect";
	}
	
	// 管理員刪除發文
	@GetMapping("/bbsM.BbsDelete")
	public @ResponseBody String bbsMDeleteSuccess(@RequestParam Integer bbsId) {
		Bbs bbs = bbsService.getBbsByBbsId(bbsId);
		bbsService.deleteBbsByManager(bbs);
		return "OK";
	}
	
	//管理員復原刪除發文
	@GetMapping("/bbsM.BbsRecovery")
	public @ResponseBody String bbsMRecovery(@RequestParam Integer bbsId) {
		Bbs bbs = bbsService.getBbsByBbsId(bbsId);
		bbsService.recoveryBbsByManager(bbs);
		return "OK";
	}
	
	// 管理員刪除留言
	@GetMapping("/bbsM.ReplyDelete")
	public @ResponseBody String bbsMReplyDelete(@RequestParam Integer replyId) {
		BbsReply bbsReply = bbsReplyService.getReplyByReplyId(replyId);
		bbsReplyService.deleteReplyByManager(bbsReply);
		return "OK";
	}
	
	//管理員復原刪除留言
	@GetMapping("/bbsM.ReplyRecovery")
	public @ResponseBody String bbsMReplyRecovery(@RequestParam Integer replyId) {
		BbsReply bbsReply = bbsReplyService.getReplyByReplyId(replyId);
		bbsReplyService.recoveryReplyByManager(bbsReply);
		return "OK";
	}

}

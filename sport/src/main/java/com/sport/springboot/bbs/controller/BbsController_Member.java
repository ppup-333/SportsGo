package com.sport.springboot.bbs.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sport.springboot.bbs.model.Bbs;
import com.sport.springboot.bbs.model.BbsReply;
import com.sport.springboot.bbs.model.BbsType;
import com.sport.springboot.bbs.service.BbsReplyService;
import com.sport.springboot.bbs.service.BbsService;
import com.sport.springboot.bbs.service.BbsTypeService;
import com.sport.springboot.bbs.vo.BbsVo;
import com.sport.springboot.users.model.Users;
import com.sport.springboot.users.service.UsersService;

@Controller
public class BbsController_Member {

	@Autowired
	private BbsService bbsService;
	@Autowired
	private BbsTypeService bbsTypeService;
	@Autowired
	private BbsReplyService bbsReplyService;
	@Autowired
	UsersService usersService;

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
	@GetMapping("/bbs")
	public String bbsMemberHomePage(Model m) {
//		List<Bbs> bbsList = bbsService.getAllBbs();
//		m.addAttribute("bbsList", bbsList);
		prepareList(m);
		return "bbs/BbsMemberHomePage";
	}

	// select下拉式選單分類查詢
	@GetMapping("/bbs.selectSearch")
	public @ResponseBody List<BbsVo> selectType(@RequestParam("typeId") Integer typeId,
												@RequestParam Integer bbsDelete) {
		List<Bbs> bbsList = new ArrayList<>();
		if (typeId > 0) {
			bbsList = bbsService.getBbsByTypeId(typeId); // orderBy bbsSetupTime
		} else if (typeId == 0) {
			bbsList = bbsService.getAllBbs();
		} else {
			bbsList = bbsService.getBbsByTypeGroup(typeId);
		}
		return bbsList.stream().filter(bbs -> bbs.getBbsDelete() == bbsDelete || bbs.getBbsDelete() == 2)
				.map(bbs -> {
					BbsVo bbsVo = new BbsVo();
					bbsVo.setBbsId(bbs.getBbsId());
					bbsVo.setAccount(bbs.getUsers().getAccount());
					bbsVo.setBbsTitle(bbs.getBbsTitle());
					bbsVo.setBbsMessage(bbs.getBbsMessageByDetail().length() >= 20 ? bbs.getBbsMessageByDetail().substring(0, 20) + "..." : bbs.getBbsMessageByDetail());
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
	@GetMapping("/bbsdiscussion.r")
	public @ResponseBody List<BbsVo> bbsReadBySearch(@RequestParam("search") String search, Model m) {
		List<Bbs> searchList = bbsService.getBbsBySearch(search);
		return searchList.stream().map(bbs -> {
			BbsVo bbsVo = new BbsVo();
			bbsVo.setBbsId(bbs.getBbsId());
			bbsVo.setAccount(bbs.getUsers().getAccount());
			bbsVo.setBbsTitle(bbs.getBbsTitle());
			bbsVo.setBbsMessage(bbs.getBbsMessageByDetail().length() >= 20 ? bbs.getBbsMessageByDetail().substring(0, 20) + "..." : bbs.getBbsMessageByDetail());
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

	// 跳轉到新增發文頁面
	@GetMapping("/bbsdiscussion.c")
	public String bbsCreateBbs(Model m) {
		prepareList(m);
		return "bbs/BbsCreateDiscussion";
	}

	@ModelAttribute
	public void modelAttribute(Model m) {
		m.addAttribute("bbs", new Bbs());
		m.addAttribute("bbsReply", new BbsReply());
	}

	// 新增發文
	@PostMapping("/bbsCreateSuccess")
	public String bbsCreate(@ModelAttribute("bbs") Bbs bbs, HttpSession session, 
			RedirectAttributes attr) {
		String account = session.getAttribute("account").toString();
		Users users = usersService.get(account);
		users.setAccount(account);
		bbs.setUsers(users);
		bbs.setBbsSetupTime(Timestamp.valueOf(LocalDateTime.now()));
		Bbs newBbs = bbsService.save(bbs);
		attr.addAttribute("bbsId", newBbs.getBbsId());
		return "redirect:bbsSelect";
	}

	// 跳轉到點選的留言
	@GetMapping("/bbsSelect")
	public String bbsSelectDicussionByBbsId(@RequestParam Integer bbsId, Model m) {
		Bbs bbs = bbsService.getBbsByBbsId(bbsId);
		m.addAttribute("bbs", bbs);
		List<BbsReply> replyList = bbsReplyService.getBbsReplyByBbsId(bbsId);
		m.addAttribute("replyList", replyList);
		prepareList(m);
		return "bbs/BbsSelect";
	}

	// 刪除發文
	@PostMapping("/bbsDelete")
	public String bbsDeleteSuccess(@RequestParam Integer bbsId) {
		Bbs bbs = bbsService.getBbsByBbsId(bbsId);
		bbsService.delete(bbs);
		return "redirect:bbs";
	}

	// 編輯發文
	@PostMapping("/bbsUpdateSuccess")
	public String bbsUpdateSuccess(@RequestParam Integer bbsId, @RequestParam String bbsTitle,
			@RequestParam String bbsMessage, @RequestParam Integer typeId, RedirectAttributes attr,
			Model m) {
		Bbs bbs = bbsService.getBbsByBbsId(bbsId);// 從資料庫拉物件進來，bbsId是從前端頁面傳過來的
		bbs.setBbsTitle(bbsTitle);
		bbs.setBbsMessage(bbsMessage);
		bbs.setBbsUpdateTime(Timestamp.valueOf(LocalDateTime.now()));
		BbsType bbsType = bbsTypeService.getBbsType(typeId);
		bbs.setBbsType(bbsType);
		bbsService.update(bbs);
		bbsTypeService.update(bbsType);
		attr.addAttribute("bbsId", bbsId);
		return "redirect:bbsSelect";
	}

	// 回覆發文
	@PostMapping("/bbsReplySuccess")
	public String bbsReplySuccess(@ModelAttribute("bbsReply") BbsReply bbsReply, @RequestParam Integer bbsId,
			RedirectAttributes attr, HttpSession session, Model m) {
		String account = session.getAttribute("account").toString();
		Users users = usersService.get(account);
		users.setAccount(account);
		bbsReply.setUsers(users);	
		bbsReply.setReplySetupTime(Timestamp.valueOf(LocalDateTime.now()));
		Bbs bbs = bbsService.getBbsByBbsId(bbsId);
		bbsReply.setBbs(bbs);
		bbsReplyService.save(bbsReply);
		attr.addAttribute("bbsId", bbsId);
		return "redirect:bbsSelect";
	}

	// 刪除回覆
	@PostMapping("/bbsReplyDelete")
	public String bbsReplyDelete(@RequestParam Integer replyId, @RequestParam Integer bbsId, 
			RedirectAttributes attr) {
		bbsReplyService.delete(replyId);
		attr.addAttribute("bbsId", bbsId);
		return "redirect:bbsSelect";
	}

	// 編輯回覆
	@PostMapping("/bbsReplyUpdate")
	public String bbsReplyUpdate(@RequestParam Integer replyId, @RequestParam String reply, @RequestParam Integer bbsId, 
			RedirectAttributes attr) {
		BbsReply bbsReply = bbsReplyService.getReplyByReplyId(replyId);
		bbsReply.setReply(reply);
		bbsReply.setReplyUpdateTime(Timestamp.valueOf(LocalDateTime.now()));
		bbsReplyService.update(bbsReply);
		Bbs bbs = bbsService.getBbsByBbsId(bbsId);
		attr.addAttribute("bbsId", bbs);
		return "redirect:bbsSelect";
	}
	
	//接我的發文跟我的留言
	@GetMapping("/bbsMemberPrivate")
	public String bbsMemberPrivate(HttpSession session) {
		return "bbs/BbsMemberPrivate";
	}
	
	//我的發文
	@GetMapping("/bbs.selectSearchPrivateBbs")
	public @ResponseBody List<BbsVo> selectPrivateBbs(@RequestParam("typeId") Integer typeId,
			@RequestParam Integer bbsDelete, HttpSession session) {
		String account = session.getAttribute("account").toString();
		List<Bbs> bbsList = bbsService.getBbsByUsersAccount(account);
		List<BbsReply> replyList = bbsReplyService.getReplyByUsersAccount(account);
		replyList.stream().forEach(bbsReply -> {
			if(!bbsList.contains(bbsReply.getBbs())) {
				bbsList.add(bbsReply.getBbs());
			}
		});
		return bbsList.stream().filter(bbs -> bbs.getBbsDelete() == bbsDelete || bbs.getBbsDelete() == 2)
				.sorted()
				.map(bbs -> {
					BbsVo bbsVo = new BbsVo();
					bbsVo.setBbsId(bbs.getBbsId());
					bbsVo.setAccount(bbs.getUsers().getAccount());
					bbsVo.setBbsTitle(bbs.getBbsTitle());
					bbsVo.setBbsMessage(bbs.getBbsMessageByDetail().length() >= 20 ? bbs.getBbsMessageByDetail().substring(0, 20) + "..." : bbs.getBbsMessageByDetail());
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
	public void headerModel(Model m) {
		Users users = new Users();
		m.addAttribute("loginPage", users);
	}
}

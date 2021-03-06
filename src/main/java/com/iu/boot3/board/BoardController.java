package com.iu.boot3.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.iu.boot3.util.Pager;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@ModelAttribute("board")
	public String getBoard() {
		return "board";
	}
	
	@GetMapping("list")
	public String getList(Model model, Pager pager) throws Exception {
		List<BoardVO> ar = boardService.getList(pager);
		model.addAttribute("list", ar);
		model.addAttribute("pager", pager);
		
		return "board/list";
	}
	
	@GetMapping("add")
	public String setAdd() throws Exception {
		
		return "board/add";
	}
	
	@PostMapping("add")
	public String setAdd(BoardVO boardVO, MultipartFile[] files) throws Exception {
		
//		for(MultipartFile f: files) {
//			System.out.println(f.getOriginalFilename());
//		}
		
		// 업로드시 파일명을 출력
		int result = boardService.setAdd(boardVO, files);

		return "redirect:./list";
	}
	
	@GetMapping("detail")
	public String getDetail(Model model, BoardVO boardVO) throws Exception {
		boardVO = boardService.getDetail(boardVO);
		model.addAttribute("vo", boardVO);
		
		return "board/detail";
	}
	
	@GetMapping("update")
	public String setUpdate(Model model, BoardVO boardVO) throws Exception {
		boardVO = boardService.getDetail(boardVO);
		model.addAttribute("vo", boardVO);
		
		return "board/update";
	}
	
	@PostMapping("update")
	public String setUpdate(BoardVO boardVO) throws Exception {
		int result = boardService.setUpdate(boardVO);
		
		return "redirect:./list";
	}
	
	@GetMapping("delete")
	public String setDelete(BoardVO boardVO) throws Exception {
		int result = boardService.setDelete(boardVO);
		
		return "redirect:./list";
	}
	
	@GetMapping("fileDown")
	public ModelAndView getFileDown(BoardFilesVO boardFilesVO) throws Exception {
		ModelAndView mv = new ModelAndView();
		boardFilesVO = boardService.getFileDetail(boardFilesVO);
		
		// 속성명은 fileDown 클래스에서 사용하는 이름과 동일하게
		mv.addObject("fileVO", boardFilesVO);
		// Bean(class)이름과 동일하게
		mv.setViewName("fileDown");
		
		return mv;
	}
	
	// 게시판 이미지파일 추가
	@PostMapping("summerFileUpload")
	public String setSummerFileUpload(Model model, MultipartFile files) throws Exception {
		
		String fileName = boardService.setSummerFileUpload(files);
		System.out.println(fileName);
		model.addAttribute("result", fileName);
		
		return "common/result";
	}
	
	// 게시판 이미지파일 삭제
	@GetMapping("summerFileDelete")
	public String setsummerFileDelete(Model model, String fileName) throws Exception {
		
		System.out.println("summernote 게시판 파일이름 확인 : " + fileName);
		
		boolean result = boardService.setSummerFileDelete(fileName);
		model.addAttribute("result", result);
		
		return "common/result";
	}
}

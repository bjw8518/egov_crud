package egovframework.example.sample.board.web;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import egovframework.example.sample.board.service.BoardService;
import egovframework.example.sample.board.service.BoardVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardController {
	
	@Resource(name="boardService")
	private BoardService boardService;
	
	@Resource(name="propertiesService")
	protected EgovPropertyService propertiesService;
	
	// 메인 페이지
	@RequestMapping(value="/index.do")
	public String index(ModelMap model) throws Exception {
		return "/main/index";
	}

	// 게시글 목록 페이지
	@RequestMapping(value="/mainList.do")
	public String list(@ModelAttribute("boardVO") BoardVO boardVO, 
						ModelMap model) throws Exception {
		
		boardVO.setPageUnit(propertiesService.getInt("pageUnit"));
		boardVO.setPageSize(propertiesService.getInt("pageSize"));
		
		// 페이지 설정
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
		
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 게시글 목록 조회
		List<?> list = boardService.selectBoardList(boardVO);
		model.addAttribute("resultList",list);
		int totCnt = boardService.selectBoardListTotCnt(boardVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo",paginationInfo);
		return "/board/mainList";
	}
	
	// 글 작성 페이지
	@RequestMapping(value="/mgmg.do", method=RequestMethod.GET)
	public String mgmg(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model, HttpServletRequest request) throws Exception {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	    Calendar c1 = Calendar.getInstance();
	    String strToday = sdf.format(c1.getTime());
	    System.out.println("Today"+strToday);
	    
	    // 서버에서 가져오기
	    boardVO=boardService.selectBoard(boardVO);
	    
	    boardVO.setIndate(strToday);
	    boardVO.setWriter(request.getSession().getAttribute("userId").toString());
	    boardVO.setWriterNm(request.getSession().getAttribute("userName").toString());
	    
	    model.addAttribute("boardVO",boardVO);
	    
	    return "/board/mgmg";
	}

	// 글 작성 또는 수정 또는 삭제
	@RequestMapping(value="/mgmg.do" , method=RequestMethod.POST)
	public String mgmg2(@ModelAttribute("boardVO") BoardVO boardVO,
	                    @RequestParam("mode") String mode,
	                    ModelMap model) throws Exception {
	    if( "add".equals(mode)) {
	        boardService.insertBoard(boardVO);
	        boardService.insertVoteBoard(boardVO);
	    }else if("modify".equals(mode)) {
	        boardService.updateBoard(boardVO);
	    }else if("del".equals(mode)) {
	        boardService.deleteBoard(boardVO);
	    }
	    return "redirect:/mainList.do";
	}

	
	// 글 상세보기 페이지
	@RequestMapping(value="/view.do")
	public String view(@ModelAttribute("boardVO") BoardVO boardVO,
					   @ModelAttribute("voteVO") BoardVO voteVO,
						ModelMap model) throws Exception{
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
		System.out.println("Today: "+strToday); 
		
		// 조회수 증가 설정
		boardService.updateBoardCount(boardVO);
		
		// 게시글 조회
		boardVO = boardService.selectBoard(boardVO);
		voteVO = boardService.selectVoteBoard(boardVO);
		
		model.addAttribute("boardVO",boardVO);
		model.addAttribute("voteVO",voteVO);
		
		
		// 댓글 목록 조회
		List<?> list = boardService.selectReplyList(boardVO);
		model.addAttribute("strToday",strToday);
		model.addAttribute("resultList",list);
		return "/board/view";
	}
	
	// 결과 상세보기 페이지
		@RequestMapping(value="/result.do")
		public String result(@ModelAttribute("boardVO") BoardVO boardVO,
						   @ModelAttribute("voteVO") BoardVO voteVO,
							ModelMap model) throws Exception{
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
			Calendar c1 = Calendar.getInstance();
			String strToday = sdf.format(c1.getTime());
			System.out.println("Today: "+strToday); 

			
			// 게시글 조회
			boardVO = boardService.selectBoard(boardVO);
			voteVO = boardService.selectVoteBoard(boardVO);
			/*voteVO = boardService.selectVoteresult(boardVO);*/
			
			model.addAttribute("boardVO",boardVO);
			model.addAttribute("voteVO",voteVO);


			return "/board/result";
		}
	
	// 로그인 처리
	@RequestMapping(value="/login.do")
	public String login(@RequestParam("user_id") String user_id,
						@RequestParam("password") String password,
						ModelMap model,
						HttpServletRequest request) throws Exception{
		System.out.println("userid:"+user_id);
		System.out.println("password:"+password);
		
		BoardVO boardVO = new BoardVO();
		boardVO.setUserId(user_id);
		boardVO.setPassword(password);
		
		String user_name = boardService.selectLoginCheck(boardVO);
		
		if(user_name !=null && !"".equals(user_name)) {
			request.getSession().setAttribute("userId", user_id);
			request.getSession().setAttribute("userName", user_name);
		}else {
			request.getSession().setAttribute("userId", "");
			request.getSession().setAttribute("userName", "");
			model.addAttribute("msg","사용자 정보가 올바르지 않습니다.");
		}
		return "redirect:/mainList.do";
		
	}
	
	// 로그아웃 처리
	@RequestMapping(value="/logout.do")
	public String logout(ModelMap model , HttpServletRequest request) throws Exception{
		request.getSession().invalidate();
		return "redirect:/index.do";
	}
	
	// 댓글 작성
	@RequestMapping(value="/reply.do" ,method= RequestMethod.POST)
	public String reply(@ModelAttribute("boardVO") BoardVO boardVO,
						ModelMap model ) throws Exception{

		boardService.insertReply(boardVO);
		
		return "redirect:/view.do?idx="+boardVO.getIdx();
	}
	

	// 댓글 삭제
	@RequestMapping(value = "/deleteReply.do", method = RequestMethod.POST)
	public String deleteReply(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model) throws Exception {
	    boardService.deleteReply(boardVO);
	    return "redirect:/view.do?idx=" + boardVO.getIdx();
	}
	
	//투표
	
	// 투표 처리
	@RequestMapping(value="/vote.do", method=RequestMethod.POST)
	public String vote(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model) throws Exception {
	    // 선택한 항목을 DB에 저장
		System.out.println(boardVO);
	    boardService.insertAddChoice(boardVO);
	    



	    return "redirect:/view.do?idx=" + boardVO.getIdx();
	}

	
	
}
package com.panda.used;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.omg.PortableInterceptor.USER_EXCEPTION;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import dao.UsedDAO;
import util.Common;
import util.Paging;
import vo.BoardVO;
import vo.T_CommentsVO;
import vo.UsedVO;
import vo.UserVO;

@Controller
public class UsedController {

	@Autowired // 자동주입 : 스프링에서 제공하는 클래스에 대해 자동으로 객체를 만들어주는 기능
	HttpServletRequest request; // Autowired를 통해 자동으로 객체생성이 된다

	@Autowired
	ServletContext application; // 현재 프로젝트의 정보를 가지고 있는 클래스

	public static final String WEB_PATH = "/WEB-INF/views/main/";

	UsedDAO used_dao;

	public void setUsed_dao(UsedDAO used_dao) {
		this.used_dao = used_dao;
		System.out.println("used_dao 컨트롤러");
	}

	// 메인페이지
	@RequestMapping(value = { "/", "used_list.do" })
	public String used(Model model) {

		List<UsedVO> list = used_dao.selectList();

		model.addAttribute("list", list);

		return WEB_PATH + "used_main.jsp";
	}

	// 메인페이지 - 판매상품리스트
	@RequestMapping("used_list1.do")
	public String used1(Model model) {

		List<UsedVO> list = used_dao.selectList();

		model.addAttribute("list", list);

		return "redirect:used_list.do";
	}

	// 로그인 페이지
	@RequestMapping("loginpage.do")
	public String loginpage(Model model) {

		return WEB_PATH + "loginpage.jsp";
	}

	// 회원가입 페이지
	@RequestMapping("join.do")
	public String join(Model model) {

		return WEB_PATH + "join.jsp";
	}

	// 거래글 작성 페이지
	@RequestMapping("trade.do")
	public String tran() {

		return WEB_PATH + "trade.jsp";
	}

	// 아이디 중복체크
	@RequestMapping("id_check.do")
	@ResponseBody
	public String id_check(String id) {

		UserVO vo = used_dao.id_selectOne(id);

		String id_res = "no";

		if (vo == null) {
			id_res = "yes";
		}

		return id_res;
	}

	// 닉네임중복체크
	@RequestMapping("nick_check.do")
	@ResponseBody
	public String nick_check(String nickname) {

		UserVO vo = used_dao.nick_selectOne(nickname);

		String nick_res = "no";

		if (vo == null) {
			nick_res = "yes";
		}

		return nick_res;
	}

	// 이메일중복체크
	@RequestMapping("email_check.do")
	@ResponseBody
	public String email_check(String email) {

		UserVO vo = used_dao.email_selectOne(email);

		String email_res = "no";

		if (vo == null) {
			email_res = "yes";
		}

		return email_res;
	}

	// 회원가입
	@RequestMapping("insert.do")
	public String insert(UserVO vo) {

		System.out.println(vo);

		int res = used_dao.insert(vo);

		return WEB_PATH + "loginpage.jsp";
	}

	// 로그인 가능 체크
	@RequestMapping("login_check.do")
	@ResponseBody
	public String login_check(UserVO vo) {

		System.out.println("바보");

		UserVO vo1 = used_dao.login_select(vo);

		System.out.println(vo1);
		String login_res = "no";

		if (vo1 != null) {
			login_res = "yes";
		}

		return login_res;
	}

	// 로그인
	@RequestMapping("login.do")
	public String login(HttpServletRequest request, UserVO vo, Model model) {

		String id = vo.getId();
		UserVO vo1 = used_dao.id_selectOne(id);

		System.out.println(vo1);
		HttpSession session = request.getSession();
		session.setAttribute("vo", vo1);
		session.setMaxInactiveInterval(120 * 120); // 세션유지시간 1시간

		return "redirect:used_list1.do";
	}

	// 로그아웃
	@RequestMapping("logout.do")
	public String logout(HttpServletRequest request) {

		HttpSession session = request.getSession();
		session.invalidate();

		return "redirect:used_list.do";
	}

	// 상품 올리기
	@RequestMapping("product_insert.do")
	public String product_insert(UsedVO vo, Model model) {

		// 파일을 저장할 경로를 생성
		String webPath = "/resources/upload/";
		String savePath = application.getRealPath(webPath);
		System.out.println(savePath);

		// 파라미터로 넘어온 파일의 정보
		MultipartFile img = vo.getImg();

		String filename = "no_file";

		// 수신된 이미지가 존재한다면(비어있지 않다면)
		if (!img.isEmpty()) {
			filename = img.getOriginalFilename();

			// 파일을 저장할 경로를 생성
			File saveFile = new File(savePath, filename);

			if (!saveFile.exists()) {
				saveFile.mkdirs(); // 없는 경로(upluad/파일명)생성
			} else {
				// 업로드 시도시, 동일한 이름의 파일이 존재할 경우 업로드 시간을 붙여서 중복을 방지

				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(savePath, filename);
			}

			try {
				img.transferTo(saveFile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		vo.setFilename(filename);
		used_dao.product_insert(vo);

		return "redirect:product_list.do";
	}

	// 인기상품페이지
	@RequestMapping("product_list.do")
	public String product(Model model) {

		List<UsedVO> list = used_dao.selectList();

		model.addAttribute("list", list);

		return WEB_PATH + "product_list.jsp";
	}

	// 게시판
	@RequestMapping("board.do")
	public String board(Model model, String page) {
		
		// board.do <----- null
		// board.do?page= <----- empty
		
		int nowPage = 1; //기본 페이지 1
		
		if( page != null && !page.isEmpty() ) {
			nowPage = Integer.parseInt(page);
		}
		
		// 한 페이지에 보여줄 게시물의 시작변화 끝 번호를 계산
		// 1page는 1 ~ 20 기시물까지 보여줘야 하고
		// 2page는 21 ~ 40번 게시물까지 보여줄수 있도록 공식을 만든다
		
		int start = ( nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;
		
		//페이지별 목록 가져오기
		List<BoardVO> list = used_dao.b_selectList(start, end);
		
		//전체 게시물 수 구하기
		int row_total = used_dao.rowTotal();
		
		//하단부에 추가될 페이지 메뉴 생성
		String pageMenu = Paging.getPaging("board.do",
										   nowPage,
										   row_total,
										   Common.Board.BLOCKLIST,
										   Common.Board.BLOCKPAGE);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return WEB_PATH + "board.jsp";
	}

	// 게시판 상세보기
	@RequestMapping("board_view.do")
	public String board_view(Model model, BoardVO vo) {

		BoardVO vo1 = used_dao.b_selectOne(vo.getB_idx());

		model.addAttribute("b_view", vo1);

		return WEB_PATH + "board_view.jsp";
	}

	// 게시글작성
	@RequestMapping("board_insert.do")
	public String board_insert() {

		return WEB_PATH + "board_insert.jsp";
	}

	// 게시글 등록
	@RequestMapping("b_insert.do")
	public String b_insert(BoardVO vo) {

		used_dao.b_insert(vo);

		return "redirect:board.do";
	}

	// 게시판 글 삭제
	@RequestMapping("delete.do")
	public String delete(BoardVO vo) {

		used_dao.b_delete(vo.getB_idx());

		return "redirect:board.do";
	}

	// 거래글 삭제
	@RequestMapping("trade_delete.do")
	public String trade_delete(UsedVO vo) {

		used_dao.trade_delete(vo.getIdx());

		return "redirect:product_list.do";
	}

	// 거래글 댓글 등록
	@RequestMapping("t_insert.do")
	public String t_insert(T_CommentsVO vo, Model model) {

		int res = used_dao.t_insert(vo);

		if (res == 1) {
			used_dao.comments_plus(vo.getT_ref());
		}
		
		List<T_CommentsVO> list = used_dao.trade_view_comments( vo.getT_ref() );
		UsedVO used = used_dao.idx_selectOne(vo.getT_ref());
		
		model.addAttribute("list", list);
		model.addAttribute("used", used);

		return WEB_PATH + "trade_view.jsp";
	}

	// 상품 상세보기페이지
	@RequestMapping("trade_view.do")
	public String trade_view(Model model, UsedVO vo) {

		UsedVO used = used_dao.idx_selectOne(vo.getIdx());
		List<T_CommentsVO> list = used_dao.trade_view_comments( vo.getIdx() );
		
		model.addAttribute("list", list);
		model.addAttribute("used", used);
		

		return WEB_PATH + "trade_view.jsp";
	}
	
	// 거래글 댓글 삭제 비밀번호체크
	@RequestMapping( "comments_check.do" )
	@ResponseBody
	public String comments_check( T_CommentsVO vo ) {
		
		T_CommentsVO vo1 = used_dao.comments_check( vo);
		
		String check_res = "no";
		
		if( vo1 != null ) {
			check_res = "yes";
		}
		
		return check_res;
	}
	
	//거래글 댓글삭제
	@RequestMapping( "comments_delete.do" )
	public String comments_delete(T_CommentsVO vo, Model model) {
		
		int res = used_dao.comments_delete( vo.getT_idx() );
		
		if (res == 1) {
			used_dao.comments_minus(vo.getT_ref());
		}
		
		UsedVO used = used_dao.idx_selectOne(vo.getT_ref());
		List<T_CommentsVO> list = used_dao.trade_view_comments( vo.getT_ref() );
		
		model.addAttribute("list", list);
		model.addAttribute("used", used);
		

		return WEB_PATH + "trade_view.jsp";

	}
	
	//관리자 답변추가
	@RequestMapping( "mgr_insert.do" )
	public String mgr_insert(BoardVO vo, Model model) {
		
		used_dao.mgr_insert( vo );
		BoardVO vo1 = used_dao.b_selectOne(vo.getB_idx());

		model.addAttribute("b_view", vo1);

		return WEB_PATH + "board_view.jsp";
	}

}





























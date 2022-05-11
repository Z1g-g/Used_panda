package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.BoardVO;
import vo.T_CommentsVO;
import vo.UsedVO;
import vo.UserVO;

public class UsedDAO {

	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		System.out.println("sqlSession의 셋터");
	}
	
	//인기상품 불러오기
	public List<UsedVO> selectList(){
		
		List<UsedVO> list = sqlSession.selectList("used.product_list");
		
		return list;
	}
	
	//아이디 중복체크
	public UserVO id_selectOne( String id ) {
		
		UserVO vo = sqlSession.selectOne("user.selectOne_id", id);
		
		return vo;
	}
	
	//닉네임 중복체크
	public UserVO nick_selectOne( String nickname ) {
		
		UserVO vo = sqlSession.selectOne("user.selectOne_nick", nickname);
		
		return vo;
	}
	
	//이메일 중복체크
		public UserVO email_selectOne( String email ) {
			
			UserVO vo = sqlSession.selectOne("user.selectOne_email", email);
			
			return vo;
		}
	
	//회원가입
	public int insert( UserVO vo ) {
		
		int res = sqlSession.insert("user.insert", vo);
		
		System.out.println(res);
		return res;
	}
	
	//로그인 체크
	public UserVO login_select( UserVO vo) {
		
		System.out.println(vo.getId());
		System.out.println(vo.getPwd());
		UserVO vo1 = sqlSession.selectOne("user.login_select", vo);
		System.out.println(vo1);
		
		return vo1;
	}
	
	//상품 db에 저장하기
	public int product_insert( UsedVO vo ) {
		
		System.out.println("여기까지 도착");
		int res = sqlSession.insert("used.product_insert",vo);
		
		return res;
	}
	
	//상세보기 클릭
	public UsedVO idx_selectOne( int idx ) {
		
		UsedVO vo = sqlSession.selectOne("used.idx_selectOne", idx);
		
		return vo;
	}
	
	//게시판 글쓰기
	public int b_insert( BoardVO vo ) {
		
		System.out.println("게시글 등록");
		int res = sqlSession.insert("board.b_insert", vo);
		
		return res;
	}
	
	//전체게시물 수 구하기
	public int rowTotal() {
		
		int count = sqlSession.selectOne("board.b_count");
		
		return count;
	}
	
	//게시판 list불러오기
	public List<BoardVO> b_selectList(int start, int end){
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("s", start);
		map.put("e", end);
		
		List<BoardVO> list = sqlSession.selectList("board.b_selectList", map);
		
		return list;
	}
	
	//게시판 글 클릭시 상세보기
	public BoardVO b_selectOne( int idx ) {
		
		BoardVO vo = sqlSession.selectOne("board.idx_selectOne", idx);
		
		return vo;
	}
	
	//게시판 관리자답변추가
	public int mgr_insert( BoardVO vo ) {
		
		int res = sqlSession.update("board.mgr_content", vo);
		
		return res;
	}
	
	//글 삭제
	public int b_delete( int idx ) {
		
		int res = sqlSession.delete("board.b_delete", idx);
		
		return res;
	}
	
	//거래 글 삭제
	public int trade_delete( int idx ) {
		
		int res = sqlSession.delete("used.trade_delete", idx);
		
		return res;
	}
	
	//댓글 추가
	public int t_insert( T_CommentsVO vo) {
		
		int res = sqlSession.insert("used.t_insert", vo);
		
		return res;
	}
	
	//댓글수 증가
	public int comments_plus(int idx) {
		
		int res = sqlSession.update("used.comments_plus", idx);
		
		return res;
	}
	
	//댓글수 감소
	public int comments_minus(int idx) {
		
		int res = sqlSession.update("used.comments_minus", idx);
		
		return res;
	}
	
	//댓글목록 뽑아오기
	public List<T_CommentsVO> trade_view_comments(int t_ref){
		
		System.out.println("dao:" + t_ref);
		List<T_CommentsVO> list = sqlSession.selectList("used.trade_view_comments", t_ref);
				
		return list;
	}
	
	//댓글삭제 체크
	public T_CommentsVO comments_check( T_CommentsVO vo ) {

		T_CommentsVO vo1 = sqlSession.selectOne("used.comments_check", vo);
		
		return vo1;
	}
	
	//댓글삭제
	public int comments_delete( int t_idx ) {
		
		int res = sqlSession.delete("used.comments_delete", t_idx);
		
		return res;
	}
	
	
	
}



























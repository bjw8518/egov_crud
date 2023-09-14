package egovframework.example.sample.board.service.impl;

import java.util.List;

import egovframework.example.sample.board.service.BoardVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardMapper")
public interface BoardMapper {

	/**
	 * 글을 등록한다.
	 * @param vo - 등록할 정보가 담긴 BoardVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	void insertBoard(BoardVO vo) throws Exception;
	
	void insertVoteBoard(BoardVO vo) throws Exception;

	/**
	 * 글을 수정한다.
	 * @param vo - 수정할 정보가 담긴 BoardVO
	 * @return void형
	 * @exception Exception
	 */
	void updateBoard(BoardVO vo) throws Exception;

	/**
	 * 글을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 BoardVO
	 * @return void형
	 * @exception Exception
	 */
	void deleteBoard(BoardVO vo) throws Exception;

	/**
	 * 글을 조회한다.
	 * @param vo - 조회할 정보가 담긴 BoardVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	BoardVO selectBoard(BoardVO vo) throws Exception;
	
	
	//투표
	BoardVO selectVoteBoard(BoardVO vo) throws Exception;
	
	/*//투표결과
	BoardVO selectVoteresult(BoardVO vo) throws Exception;*/
	
	

	/**
	 * 글 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	List<?> selectBoardList(BoardVO searchVO) throws Exception;

	/**
	 * 글 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
	int selectBoardListTotCnt(BoardVO searchVO);
	
	String selectLoginCheck(BoardVO searchVO);
	
	void insertReply(BoardVO vo) throws Exception;
	
	void deleteReply(BoardVO boardVO) throws Exception;

	
	List<?> selectReplyList(BoardVO searchVO) throws Exception;
	
	void updateBoardCount(BoardVO vo) throws Exception;
	
	
	//투표
    
	// 투표 결과를 저장하는 메서드
	void updateVoteResult(BoardVO boardVO) throws Exception;


	void insertAddChoice(BoardVO boardVO);

}

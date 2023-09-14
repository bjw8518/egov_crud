package egovframework.example.sample.board.service.impl;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.sample.board.service.BoardService;
import egovframework.example.sample.board.service.BoardVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("boardService")
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService {

    private static final Logger LOGGER = LoggerFactory.getLogger(BoardServiceImpl.class);

    /** BoardDAO */
    // TODO ibatis 사용
    //@Resource(name = "boardDAO")
    //private BoardDAO boardDAO;
    // TODO mybatis 사용
    @Resource(name = "boardMapper")
    private BoardMapper boardDAO;

    /** ID Generation */
    @Resource(name = "egovIdGnrService")
    private EgovIdGnrService egovIdGnrService;

    /**
     * 글을 등록한다.
     * @param vo - 등록할 정보가 담긴 BoardVO
     * @return 등록 결과
     * @exception Exception
     */

    public String insertBoard(BoardVO vo) throws Exception {
        LOGGER.debug(vo.toString());

        boardDAO.insertBoard(vo);
        return boardDAO.toString();

    }
    
    public String insertVoteBoard(BoardVO vo) throws Exception {
        LOGGER.debug(vo.toString());

        boardDAO.insertVoteBoard(vo);
        return boardDAO.toString();

    }

    /**
     * 글을 수정한다.
     * @param vo - 수정할 정보가 담긴 BoardVO
     * @return
     * @return void형
     * @exception Exception
     */

    public String updateBoard(BoardVO vo) throws Exception {
        LOGGER.debug(vo.toString());
        boardDAO.updateBoard(vo);
        return vo.getIdx();
    }

    /**
     * 글을 삭제한다.
     * @param vo - 삭제할 정보가 담긴 BoardVO
     * @return void형
     * @exception Exception
     */

    public String deleteBoard(BoardVO vo) throws Exception {
        boardDAO.deleteBoard(vo);
        return vo.getIdx();
    }

    /**
     * 글을 조회한다.
     * @param vo - 조회할 정보가 담긴 BoardVO
     * @return 조회한 글
     * @exception Exception
     */

    public BoardVO selectBoard(BoardVO vo) throws Exception {
        BoardVO resultVO = boardDAO.selectBoard(vo);
        if (resultVO == null) {
            resultVO = new BoardVO();
        }
        //throw processException("info.nodata.msg")
        return resultVO;
    }
    
    public BoardVO selectVoteBoard(BoardVO vo) throws Exception {
        BoardVO resultVO = boardDAO.selectVoteBoard(vo);
        if (resultVO == null) {
            resultVO = new BoardVO();
        }
        //throw processException("info.nodata.msg")
        return resultVO;
    }
    
    
    
    /*//투표결과
    public BoardVO selectVoteresult(BoardVO vo) throws Exception {
        BoardVO resultVO = boardDAO.selectVoteresult(vo);
        if (resultVO == null) {
            resultVO = new BoardVO();
        }
        //throw processException("info.nodata.msg")
        return resultVO;
    }*/

    /**
     * 글 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 VO
     * @return 글 목록
     * @exception Exception
     */

    public List<?> selectBoardList(BoardVO searchVO) throws Exception {
        return boardDAO.selectBoardList(searchVO);
    }

    /**
     * 글 총 갯수를 조회한다.
     * @param searchVO - 조회할 정보가 담긴 VO
     * @return 글 총 갯수
     * @exception
     */

    public int selectBoardListTotCnt(BoardVO searchVO) {
        return boardDAO.selectBoardListTotCnt(searchVO);
    }

    public String selectLoginCheck(BoardVO searchVO) {
        return boardDAO.selectLoginCheck(searchVO);
    }

    public void insertReply(BoardVO vo) throws Exception {
        LOGGER.debug(vo.toString());

        boardDAO.insertReply(vo);
    }
    
	
	public void deleteReply(BoardVO boardVO) throws Exception {
	    boardDAO.deleteReply(boardVO);
	}

    public List<?> selectReplyList(BoardVO searchVO) throws Exception {
        return boardDAO.selectReplyList(searchVO);
    }

    public void updateBoardCount(BoardVO vo) throws Exception {
        boardDAO.updateBoardCount(vo);
    }

    //투표
    
    public void updateVoteResult(BoardVO boardVO) throws Exception {
	    boardDAO.updateVoteResult(boardVO);
	}
    

	public void insertAddChoice(BoardVO boardVO) throws Exception {
		boardDAO.insertAddChoice(boardVO);
		
	}
    
}

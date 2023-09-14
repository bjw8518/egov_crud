package egovframework.example.sample.board.service;

import java.util.Date;
import java.util.List;

import egovframework.example.sample.service.SampleDefaultVO;

/**
 * @Class Name : SampleVO.java
 * @Description : SampleVO Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */
public class BoardVO extends SampleDefaultVO {

    private String idx;
    private String category;
	private String category_no;
    private String title;
    private String contents;
    private String count;
    private String writer;
    private String writerNm;
    private String indate;
    private String seq;
    private String reply;
    private String filename;

    private String userId;
    private String password;
    
    private String votetitle;
    private String item;
    
    public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getItem2() {
		return item2;
	}
	public void setItem2(String item2) {
		this.item2 = item2;
	}
	public String getItem3() {
		return item3;
	}
	public void setItem3(String item3) {
		this.item3 = item3;
	}
	private String item2;
    private String item3;
    private String endday;
    

    
    
    
    
    private String selectedOption; // 선택된 투표 항목
    private String voteResult; // 투표 결과
    
    public String getSelectedOption() {
		return selectedOption;
	}
	public void setSelectedOption(String selectedOption) {
		this.selectedOption = selectedOption;
	}
	public String getVoteResult() {
		return voteResult;
	}
	public void setVoteResult(String voteResult) {
		this.voteResult = voteResult;
	}
	
    
    
    public String getVotetitle() {
		return votetitle;
	}
	public void setVotetitle(String votetitle) {
		this.votetitle = votetitle;
	}
	public String getItem1() {
		return item;
	}
	public void setItem1(String item1) {
		this.item = item1;
	}

	public String getEndday() {
		return endday;
	}
	public void setEndday(String endday) {
		this.endday = endday;
	}
	

    public String getIdx() {
        return idx;
    }
    public void setIdx(String idx) {
        this.idx = idx;
    }
    
    public String getCategory() {
		return category;
	}
    
	public void setCategory(String category) {
		this.category = category;
	}

	public String getCategory_no() {
		return category_no;
	}

	public void setCategory_no(String category_no) {
		this.category_no = category_no;
	}

    

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getWriterNm() {
        return writerNm;
    }

    public void setWriterNm(String writerNm) {
        this.writerNm = writerNm;
    }

    public String getIndate() {
        return indate;
    }

    public void setIndate(String indate) {
        this.indate = indate;
    }

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
	public void setVote1(String vote1) {
		// TODO Auto-generated method stub
		
	}
	public void setVote2(String vote2) {
		// TODO Auto-generated method stub
		
	}
	public void setVote3(String vote3) {
		// TODO Auto-generated method stub
		
	}
	public void setEndDate(Date endDate) {
		// TODO Auto-generated method stub
		
	}
    
    

}

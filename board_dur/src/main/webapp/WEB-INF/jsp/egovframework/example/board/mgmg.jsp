<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
    <title>등록 및 수정</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/style.css">
<script src="${pageContext.request.contextPath}/resources/common/js/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/css/bootstrap/js/bootstrap.min.js "></script>
<script src="https://cdn.ckeditor.com/ckeditor5/38.0.1/classic/ckeditor.js"></script>
    <script type="text/javaScript" language="javaScript" defer="defer">
$(document).ready(function () {
$("#idx").attr("readonly", true);
$("#writeNm").attr("readonly", true);
$("#indate").attr("readonly", true);

// 카테고리 변경 시 해당하는 div 보여주기
$("#category_sel").on("change", function () {
var selectedCategory = $(this).val();
$(".boardform").hide();
$("#" + selectedCategory).show();

// 카테고리에 따라서 hidden input의 값을 설정
if (selectedCategory === "nomal_board") {
$("#category").val("일반게시판");
} else if (selectedCategory === "vote_board") {
$("#category").val("투표게시판");
} else if (selectedCategory === "free_board") {
$("#category").val("자유게시판");
}
});
});

function cancel() {
	location.href = "<c:url value='/mainList.do' />";
}

function add() {
	if ($("#title").val() == '') {
	alert("제목을 입력하세요");
	$("#title").focus();
	return;
	}
	
	//카테고리
	if ($("#category").val() == '') {
	alert("카테고리를 선택하세요");
	$("#category").focus();
	return;
	}
	
	
	if ($("#contents").val() == '') {
	alert("내용을 입력하세요");
	$("#contents").focus();
	return;
	}
	
	if( $("#endday").val()=='' ){
		alert("투표 마감일을 입력하세요");
		$("#endday").focus;
		return;
	}
	
	if (!confirm("등록하시겠습니까?")) {
	return;
	}

document.boardRegForm.action = "<c:url value='mgmg.do' />?mode=add";
document.boardRegForm.submit();
}

	function modify() {
	if ($("#title").val() == '') {
	alert("제목을 입력하세요");
	$("#title").focus();
	return;
	}
	
	//카테고리
	if ($("#category").val() == '') {
	alert("카테고리를 선택하세요");
	$("#category").focus();
	return;
	}
	
	//카테고리
	if ($("#contents").val() == '') {
	alert("내용을 입력하세요");
	$("#contents").focus();
	return;
	}
	
	if( $("#endday").val()=='' ){
		alert("투표 마감일을 입력하세요");
		$("#endday").focus;
		return;
	}
	
	
	if (!confirm("수정하시겠습니까?")) {
	return;
	}

document.boardRegForm.action = "<c:url value='mgmg.do' />?mode=modify";
document.boardRegForm.submit();


}
</script>
    <style>
        .boardform {
            display: none;
        }
    </style>
</head>

<div class="container">
    <h1>등록 및 수정</h1>
    <div class="panel panel-default">
        <div class="panel-heading">
            <label for="">등록 및 수정</label>
        </div>
        
        <div class="panel-body">
            <form class="form-horizontal" id="boardRegForm" name="boardRegForm" method="post" action="/">

                <div class="form-group">
                    <label class="control-label col-sm-2" for="idx">게시물아이디:</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="idx" name="idx" placeholder="자동발번"
                            value="${boardVO.idx}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2" for="pwd">제목:</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="title" name="title"
                            placeholder="제목을 입력하세요" maxLength="100" value="${boardVO.title}">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" for=" pwd">등록자|등록일:</label>
                    <div class="col-sm-10">
                        <input type="hidden" class="form-control" id="writer" name="writer"
                            placeholder="등록자를 입력하세요" maxLength="15" style="float:left; width:40%"
                            value="${boardVO.writer}">
                        <input type="text" class="form-control" id="writerNm" name="writerNm"
                            placeholder="등록자를 입력하세요" maxLength="15" style="float:left; width:40%"
                            value="${boardVO.writerNm}">
                        <input type="text" class="form-control" id="indate" name="indate"
                            placeholder="등록일을 입력하세요" maxLength="10" style="float:left; width:40%"
                            value="${fn:substring(boardVO.indate,0, fn:length(boardVO.indate))}">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" for="category_sel">카테고리:</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="category_sel" name="category_sel">
                            <option value="">카테고리 선택</option>
                            <option value="nomal_board">일반게시판</option>
                            <option value="vote_board">투표게시판</option>
                            <!-- <option value="free_board">자유게시판</option> 추가된 항목 -->
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" for="pwd">내용:</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" rows="5" id="content" name="contents"
                            maxLength="1000">${boardVO.contents}</textarea>
                    </div>
                </div>
                
                
                <input type="hidden" id="category" name="category" value="">



            <%-- <c:if test="${boardVO.category=='투표게시판' }"> --%>
				<div id="vote_board" class="boardform">
				<!-- 제목votetitle -->
				
				<div class="form-group">
							<label class="control-label col-sm-2 for="" style="text-align: left;">투표제목</label>
							<div class="col-sm-10">
								<input type="text" name="votetitle"  value="${voteVO.votetitle}">
							</div>
					</div>
				
					<div class="form-group">
							<label class="control-label col-sm-2 for="pwd" style="text-align: left;">투표마감일</label>
							<div class="col-sm-10">
								<input type="datetime-local" name="endday" id="yyyyMmDdThhss" />	
							</div>
					</div>
					<!-- 투표항목 -->
					<div class="form-group">
							<label class="control-label col-sm-2 for="pwd" style="text-align: left;">투표항목</label>
							<div class="col-sm-10">
			    				<input type="text" id="item1" name="item1" placeholder="투표내용 작성" /><br>
			    				<input type="text" id="item2" name="item2" placeholder="투표내용 작성" />
			    				<input type="text" id="item3" name="item3" placeholder="투표내용 작성" />
							</div>
					</div>
					
				</div>
            <%-- </c:if> --%>
            <!-- 투표창 -->

        </form>
        </div>
        <div class="panel-footer">
            <c:if test="${!empty sessionScope.userId }"> <!-- 로그인시에만 등록/수정 가능 -->
                <button type="button" class="btn btn-default" onclick="add();">등록</button>
                <button type="button" class="btn btn-default" onclick="modify();">수정</button>
            </c:if>
            <button type="button" class="btn btn-default" onclick="cancel();">취소</button>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/common/js/ckeditor.js"></script>

</html>
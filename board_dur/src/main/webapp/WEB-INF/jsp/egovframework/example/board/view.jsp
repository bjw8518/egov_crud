<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    pageContext.setAttribute("crcr", "\r\n"); //space, enter
    pageContext.setAttribute("br", "<br/>"); //br태그
%>

<!DOCTYPE html>
<html>
<head>
<title>상세화면 페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/style.css">
<script src="${pageContext.request.contextPath}/resources/common/js/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/css/bootstrap/js/bootstrap.min.js "></script>
<script src="https://cdn.ckeditor.com/ckeditor5/38.0.1/classic/ckeditor.js"></script>
    <script type="text/javaScript" language="javaScript" defer="defer">
    $(document).ready(function() {
        $("#indate").attr("readonly", true);
    });

    function cancel() {
        location.href="<c:url value='/mainList.do'/>";
    }

    function list() {
        location.href="<c:url value='/mainList.do'/>";
    }

    function add() {
        if ($("#writer").val() == '') {
            alert("작성자를 입력하세요");
            $("#writer").focus();
            return;
        }
        if ($("#reply").val() == '') {
            alert("댓글을 입력하세요");
            $("#reply").focus();
            return;
        }
        if (!confirm("댓글을 작성하시겠습니까?")) {
            return;
        }
        document.form2.action = "<c:url value='reply.do'/>?idx=${boardVO.idx}";
        document.form2.submit();
    }

    function modify() {
        location.href="<c:url value='/mgmg.do'/>?mode=modify&idx=${boardVO.idx}";
    }

    function del() {
        var cnt = ${fn:length(resultList)};
        if (cnt > 0) {
            alert("댓글이 있는 게시물은 삭제할 수 없습니다.");
        }
        if (!confirm("삭제하시겠습니까?")) {
            return;
        }
        document.form1.action="<c:url value='/mgmg.do'/>?mode=del&idx=${boardVO.idx}";
        document.form1.submit();
    }
    function vote() {
    	  var radioButton = document.querySelector('input[name="item"]:checked');
    	  console.log(radioButton);
    	  if (!radioButton) {
    	    alert("투표지를 선택해주세요.");
    	    return;
    	  }

    	  var selectedValue = radioButton.value;
    	  alert("선택된 값: " + selectedValue);

    	  if (!confirm("투표하시겠습니까?")) {
    	    return;
    	  }

    	  // boardVO의 item 값 설정
    	  document.getElementById("item").value = selectedValue;

    	  

    	  document.form1.action="<c:url value='/vote.do'/>?idx=${boardVO.idx}";
    	  document.form1.submit();
    	  
    	  alert("투표가 완료되었습니다.");
    	  
    	  location.href="<c:url value='/result.do'/>?idx=${boardVO.idx}";
    	}

    function deleteReply(seq) {
        if (!confirm("댓글을 삭제하시겠습니까?")) {
            return;
        }

        $.ajax({
            url: '/deleteReply.do',
            type: 'POST',
            data: { seq: seq },
            success: function(result) {
                alert("댓글이 삭제되었습니다.");
                location.reload();
            },
            error: function(xhr, status, error) {
                alert("댓글 삭제 중 오류가 발생했습니다.");
            }
        });
    }
</script>
</head>
<div class="container">
<h1>상세화면</h1>
<div class="panel panel-default">
    <div class="panel-heading">
        <label for="">${sessionScope.userName} 님이 로그인 하셨습니다.</label>
    </div>
    
    <div class="panel-body">
        <form class="form-horizontal" id="form1" name="form1" method="post" action="/">
        
            <div class="form-group">
                <label class="control-label col-sm-2" for="idx">게시물아이디:</label>
                <div class="col-sm-10 control-lable" style="text-align: left;">
                    <c:out value="${boardVO.idx}" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="pwd">제목:</label>
                <div class="col-sm-10 control-label" style="text-align: left;">
                    <c:out value="${boardVO.title}" />
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
            
            
            <!-- 카테고리 -->
            <div class="form-group">
                <label class="control-label col-sm-2" for="pwd">카테고리:</label>
                <div class="col-sm-10 control-label" style="text-align: left;">
                    <c:out value="${boardVO.category}" />
                </div>
            </div>
            <!-- 카테고리 -->
            
            <div class="form-group">
                <label class="control-label col-sm-2" for="pwd">내용:</label>
                <div class="col-sm-10 control-label" style="text-align: left;">
                    <c:out value="${fn:replace(boardVO.contents, crcn, br)}" escapeXml="false" />
                </div>
            </div>
            
            <!-- 투표창 -->
            <c:if test="${boardVO.category=='투표게시판' }">
				<div id="vote_board" class="boardform">
				
				
					<div class="form-group">
							<label class="control-label col-sm-2 for="pwd">투표마감일</label>
							<div class="col-sm-10">
								<c:out value="${voteVO.endday}" />	
							</div>
					</div>
					<!-- 투표항목 -->
					<div class="form-group">
					    <label class="control-label col-sm-2">투표:</label>
					    <div class="col-sm-10">
					        <label><input type="radio" id="item" name="item" value="item1">${boardVO.item1}</label>
					        <label><input type="radio" id="item" name="item" value="item2">${boardVO.item2}</label>
					        <label><input type="radio" id="item" name="item" value="item3">${boardVO.item3}</label>
					    </div>
					</div>
					<!-- 투표항목 -->
					<div class="form-group">
					    <div class="col-sm-offset-2 col-sm-10">
					        <button type="button" class="btn btn-primary" onclick="vote()">투표하기</button>
					    </div>
					</div>
					
					<!-- 투표항목 -->
				</div>
            </c:if>
            <!-- 투표창 -->
            <input type="hidden" id="userId" name="userId" value="${sessionScope.userId}">
        </form>


    </div>
    <div class="panel-footer">
        <!--로그인 한 경우 & 게시물작성자와 세션정보가 같은경우만 수정/삭제 가능  -->
        <c:if test="${!empty sessionScope.userId && sessionScope.userId==boardVO.writer}">
            <button type="button" class="btn btn-default" onclick="modify();">수정</button>
            <button type="button" class="btn btn-default" onclick="del();">삭제</button>
        </c:if>
        <button type="button" class="btn btn-default" onclick="list();">목록</button>
    </div>
</div>
<!--댓글등록-->
<div class="well well-sm">작성자|작성일</div>
<div class="well well-lg">
    <form class="form-horizontal" method="post" id="form2" name="form2" action="">
        <div class="form-group">
            <label class="control-label col-sm-2" for="pwd" style="text-align: left;">작성자/작성일</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="writer" name="writer" value="${sessionScope.userId}" readonly>
                <input type="text" class="form-control" id="indate" name="indate" value="<c:out value="${date}"/>" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="reply">댓글:</label>
            <div class="col-sm-10">
                <textarea class="form-control" rows="3" id="reply" name="reply"></textarea>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="button" class="btn btn-default" onclick="add();">등록</button>
                <button type="button" class="btn btn-default" onclick="cancel();">취소</button>
            </div>
        </div>
        
    </form>
</div>
<!--댓글-->
<c:forEach var="result" items="${resultList}" varStatus="status">
    <div class="well well-sm">
        <c:out value="${result.writer}"/> | <c:out value="${result.indate}"/>
        <c:if test="${!empty sessionScope.userId && sessionScope.userId==result.writer}">
            <button type="button" class="btn btn-default" onclick="deleteReply('<c:out value="${result.seq}"/>');">삭제</button>
        </c:if>
    </div>
    <div class="well well-lg">
        <c:out value="${fn:replace(result.reply, crcn, br)}" escapeXml="false"/>
    </div>
</c:forEach>
</div>
</body>
</html>

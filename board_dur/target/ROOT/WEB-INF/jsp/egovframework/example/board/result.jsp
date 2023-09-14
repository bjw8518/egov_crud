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
				</div>
            </c:if>
            <!-- 투표창 -->
            <input type="hidden" id="userId" name="userId" value="${sessionScope.userId}">
        </form>

        

    </div>
    <div class="panel-footer">
        <button type="button" class="btn btn-default" onclick="list();">목록</button>
    </div>
</div>
</div>
</html>
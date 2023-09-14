<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 날짜 포맷 사용을 위해 씀! -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<!DOCTYPE html>
<html>
<head>
<title>메인페이지</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/common/css/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/style.css">
    <script src="${pageContext.request.contextPath}/resources/common/js/jquery-3.5.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/common/js/bootstrap.min.js "></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/38.0.1/classic/ckeditor.js"></script>
    <script type="text/javaScript" language="javaScript" defer="defer">
$(document).ready(function() {
	<c:if test="${!empty msg}">
		alert("${msg}");
	</c:if>
});

function add() {
	location.href="<c:url value='/mgmg.do'/>";
}

function view() {
	location.href="<c:url value='/view.do'/>";
}

function check() {
	if ($("#user_id").val() == "") {
		alert("아이디를 입력하세요");
		return false;
	}
	if ($("#password").val() == "") {
		alert("비밀번호를 입력하세요");
		return false;
	}
	return true;
}

function out() {
	location.href="<c:url value='/logout.do'/>";
}

function view(idx) {
	location.href="<c:url value='/view.do'/>?idx=" + idx;
}

function page(pageNo) {
	location.href="<c:url value='mainList.do'/>?pageIndex=" + pageNo;
}

// 검색




// 검색
</script>
<style>
.forms {
	display: none;
}
</style>
</head>
<div class="container">
	<h1>일반게시판</h1>

	<div class="panel panel-default">
		<div class="panel-heading">
			<c:if test="${empty sessionScope.userId}">
				<form class="form-inline" method="post" action="/login.do">
					<div class="form-group">
						<label for="id">아이디:</label>
							<!-- 아이디 입력 -->
						<input type="text" class="form-control" id="user_id" name="user_id">
					</div>
					<div class="form-group">
						<label for="pwd">비밀번호:</label>
							<!-- 비밀번호 입력 -->
						<input type="password" class="form-control" id="password" name="password">
					</div>
					<button type="submit" class="btn btn-default" onclick="return check();">로그인</button>
				</form>
			</c:if>
			<c:if test="${!empty sessionScope.userId}">
				<!-- 로그인 된 사용자 환영 메시지와 로그아웃 버튼 -->
				${sessionScope.userName }님 환영합니다
				<button type="button" class="btn btn-default" onclick="out();">로그아웃</button>
			</c:if>
			<!-- 게시판 메뉴 버튼 -->
			<a type="button" class="btn btn-primary" href="/mainList.do">일반게시판</a>
			<!-- <a type="button" class="btn btn-warning" href="/TopicList.do">투표게시판</a> -->
		</div>
		<!-- 테이블 부분 -->
		<div class="panel-body">
			<!-- 검색 폼 -->
			<form class="form-inline" method="post" action="/mainList.do">
				<div class="form-group">
					<label for="searchKeyword">검색 조건:</label>
					<!-- 검색 조건 선택 -->
					<select id="search_select" name="searchType">
						<option value="">선택하세요</option>
						<option value="title">제목</option>
						<option value="writer">등록자</option>
					</select>
				</div>
				<div class="form-group">
					<!-- 검색 키워드 입력 -->
					<input type="text" class="form-control" id="searchKeyword" name="searchKeyword">
				</div>
				<button type="button" class="btn btn-default" onclick="submitForm();">검색</button>
			</form>
			<!-- 게시물 목록 테이블 -->
			<div class="table-responsive">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>게시물번호</th>
							<th>카테고리</th>
							<th>제목</th>
							<th>조회수</th>
							<th>댓글수</th>
							<th>등록자</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody>
						<!-- 게시물 목록 반복문 -->
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td>
									<!-- 게시물 상세 페이지 링크 -->
									<a href="javascript:view('${result.idx}');"><c:out value="${result.idx}"/></a>
								</td>
								<!-- 카테고리 추가예정 -->
								<td>
									<a href="javascript:view('${result.category}');">${result.category}</a>
								</td>
								<!-- 카테고리 추가예정 -->
								
								<td>
									<!-- 게시물 상세 페이지 링크 -->
									<a href="javascript:view('${result.idx}');"><c:out value="${result.title}"/></a>
								</td>
								
								<td><c:out value="${result.count}"/></td>
								<td><c:out value="${result.reply}"/></td>
								<td><c:out value="${result.writerNm}"/></td>
								<td>${result.indate}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- 페이징 처리 -->
			<div class="paging">
				<!-- 페이징 컴포넌트 -->
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="page" />
				<!-- <form:hidden path="pageIndex" /> -->
			</div>
		</div>
		<!-- 하위부분 -->
		<div class="panel-footer">
			<c:if test="${!empty sessionScope.userId}">
				<!-- 등록 버튼 -->
				<button type="button" class="btn btn-default" onclick="add();">등록</button>
			</c:if>
		</div>
	</div>
</div>
</html>

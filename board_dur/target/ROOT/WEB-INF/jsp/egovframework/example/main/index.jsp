<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt"	   uri="http://java.sun.com/jsp/jstl/fmt" %>   <!--날짜포멧사용위해 씀! -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	
$( document).ready( function(){
	<c:if test="${!empty msg}">
	alert("${msg}");
	</c:if>
})

function check(){
	if( $("#user_id").val() =="" ){
		alert("아이디를 입력하세요");
		return false;
	}
	if( $("#password").val() ==""){
		alert("비밀번호를 입력하세요");
		return false;
	}
	return true;
}
function out(){
	location.href="<c:url value='/logout.do'/>";
}
function list(){
	location.href="<c:url value='/mainList.do'/>"
}
</script>

</head>
<div class="container">
	<h1>로그인</h1>
	<!--로그인 부분  -->
	<div class="panel panel-default"> 
		<div class="panel-heading">
		<c:if test = "${sessionScope.userId ==null || sessionScope.userId =='' }">
			<form class="form-inline" method ="post" action="/login.do">
				<div class="form-group">
					<label for="id">아이디:</label>
					
					<input type="text" class="form-control" id="user_id" name="user_id">
				</div>
				<div class="form-group">
					<label for="pwd">Password:</label>
					<input type="password" class="form-control" id="password" name="password">
				</div>
				<button type="submit" class="btn btn-default" onclick="return check();">로그인</button> <!--return: false인 경우 로그인폼의 action이 실행안되게함-->
			</form>
			</c:if>
			<c:if test = "${sessionScope.userId !=null && sessionScope.userId !='' }">
			${sessionScope.userName }님 환영합니다
			<button type="button" class="btn btn-default" onclick="out();">로그아웃</button> <!--return: false인 경우 로그인폼의 action이 실행안되게함-->
			<button type="button" class="btn btn-default" onclick="list();">게시판</button>
			</c:if>
		</div>
	
	
	<!--하위부분-->
</div>
</div>
</html>
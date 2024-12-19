<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sooljura</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/textHeader.jsp"/>
	<main>
		<h2>주소지 관리</h2>
		<br><hr><br>
		
	</main>
	<footer>
		<button onclick="addAddr()">주소지 추가</button>
	</footer>
<script>
	function addAddr(){
		window.opener.location.href="/user/addAddrFrm.do";
	}
</script>
</body>
</html>
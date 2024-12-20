<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sooljura</title>
<style>
*{
	margin: 0;
	padding : 0;
}
h2 {
	color: gray;
}

.addrWrap{
	width:100%;
	
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/textHeader.jsp"/>
	<main>
		<h2>주소지 관리</h2>
		<br><hr><br>
<%--
		<form>
			<input type="hidden" name="userKey" value="${loginUser.userKey}">
			<input type="hidden" name="addrKey" value="${addr.addrKey}">
		</form>
--%>		
		<ul>
			<c:forEach var="addr" items="${addrList}">
				<li>
					<div class="addrWrap">
						<span>
							${addr.rcptNm} (${addr.addrNm != null ? addr.addrNm : ''})
							<c:if test="${defaultYn eq 1}" >
								<p>기본배송지</p>
							</c:if>
						</span>
						<div class="btnWrap">
							<button onclick="delAddr()">삭제</button>
							<button onclick="updAddr()">수정</button>
						</div>
					</div>
					<div class="addrWrap">
						<span>${addr.rcptPhone}</span>
					</div>
					<div class="addrWrap">
						<span>${addr.addr}(${addrCd})</span><br>
					</div>
				</li>
			</c:forEach>
		</ul>
	</main>
	<footer>
		<button onclick="addAddr()">주소지 추가</button>
	</footer>
<script>
	function addAddr(){
		window.opener.location.href="/user/addAddrFrm.do";
	}
	
	function delAddr(){
		swal({
			title : "알림",
			text : "주소를 삭제하시겠습니까?",
			icon : "success",
			buttons : {
				cancel : {
					text : "취소",
					value : false,
					visible : true,
					closeModal true: 
				},
				confirm : {
					text : "삭제",
					value : true,
					visible : true,
					closeModal : true
				}
			}
		}).then(function(isConfirm){
			if(isConfirm){
				$.ajax({
					url : "/user/delAddr.do",
					type : "GET",
					data : {
						addrKey : ${addrList.addrKey}
					},
					success : function(res){
						if(res == "1"){
							msg('알림', '삭제가 완료되었습니다', 'success', 'window.self.close();window.opener.location.href = "/user/addrListFrm.do";')
						}else{
							msg('알림', '삭제중 오류가 발생했습니다', 'error', 'window.self.close();window.opener.location.href = "/user/addrListFrm.do";')						
						}
					},
					error : function(){
						console.log('ajax 오류');
					}
				});
			}
		});
	}
	
	function updAddr(){
		window.opener.location.href="/user/updAddrFrm.do";
	}
</script>
</body>
</html>
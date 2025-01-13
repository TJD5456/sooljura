<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>술주라</title>
    <link rel="icon" href="/resources/icons/logo-circle-woText-16px-favicon.png">
<style>
h2 {
    color: gray;
}

.addrWrap {
    width: 100%;

}

li {
    font-weight: none;
}

.btnWrap > button {
    width: 70px;
    height: 30px;
    border-radius: 10px;
    border: 1px solid #fc8173;
    background-color: #fc8173;
    color: #efece5;
    box-shadow: 1px 1px 1px 1px #d2210d;
}
input[type=button] {
/* Disable text selection inside the button */
/* Standard, FireFox, Safari & Chrome */
user-select: none;
-moz-user-select: none;
-webkit-user-select: none;

border: none;
border-radius: 15px;
color: #efece5;
background-color: #fc8173;
box-shadow: 1px 1px 1px 1px #d2210d;
width: 30%;
height: 50px;
display: block;
position: fixed;
bottom: 20px;
left: 35%;
}
	.myPageChoices {
        width: 700px;
        margin: 0 auto;
        display: flex;
        justify-content: center;
    }
	.myPageChoiceBtn {
	        width: 500px;
	        height: 50px;
	        margin: 15px;
	        font-size: 20px;
	        font-weight: bold;
	    }
input[type=button]:hover {
    background-color: #f5afa5;
    box-shadow: 1px 1px 1px 1px #fc8173;
}

button:hover {
    background-color: #f5afa5;
    box-shadow: 1px 1px 1px 1px #fc8173;
}   
main {
   width: 50%;
   display: block;
   justify-content: center;
   align-items: center;
   height: 100%;
   margin: 0 auto;
   background-color: #F9F9F9;
}
.addrMngList{
	
	
}
</style>
</head>
<body style="background-color: #F9F9F9;">
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
	<div class="title">
		<h1>마이 페이지</h1>
	</div>

	<div class="myPageChoices">
		<button class="myPageChoiceBtn" value="1" id="myPageBtns">회원 정보</button>
		<button class="myPageChoiceBtn" value="2" id="myPageBtns">구매 내역</button>
		<button class="myPageChoiceBtn" value="3" id="myPageBtns">내글 보기</button>
		<button class="myPageChoiceBtn" value="4" id="myPageBtns">찜한상품</button>
		<button class="myPageChoiceBtn" value="5" id="myPageBtns">주소 관리</button>
	</div>
    <br>
	<h2>주소지 관리</h2>
    <br>
    <hr>
	<div class="addrMngList">
        <c:choose>
            <c:when test="${not empty addrList}">
                <c:forEach var="addr" items="${addrList}">
                        <div class="addrWrap">
                            <input type="hidden" class="addrKey" name="addrKey" value="${addr.addrKey}">
                            <span style="display: flex; font-size: 20px;">
	                                ${addr.rcptNm}
	                                <c:if test="${not empty addr.addrNm}">
                                        (${addr.addrNm})
                                    </c:if>
	                                <c:if test="${addr.defaultYn == 1}">
                                        <span style="font-weight: lighter; color: #fc8173; border: 1px solid #fc8173; font-size: 15px; margin-left: 10px; border-radius: 5px;">
                                        	기본배송지
                                        </span>
                                    </c:if>
	                            </span>
                        </div>
                        <div class="btnWrap">
                            <button onclick="delAddr(this)">삭제</button>
                            <button onclick="updAddr(this)">수정</button>
                        </div>
                        <div class="addrWrap">
                            <span>${addr.rcptPhone}</span>
                        </div>
                        <div class="addrWrap">
                            <span>${addr.addr} (${addr.addrCd})</span>
                        </div>
                    <br>
                    <hr>
                    <br>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>등록된 주소지가 없습니다.</p>
            </c:otherwise>
        </c:choose>
		</div>
    <input type="button" onclick="addAddr()" value="주소지 추가">
</main>
<script>
	$('.myPageChoiceBtn').on('click', function(){
			let i = parseInt($(this).val(), 10);
			
			// 현재 페이지 URL 가져오기
			const url = window.location.href;// URL 객체 생성
			const urlParams = new URLSearchParams(new URL(url).search);// 특정 파라미터 값 가져오기 (예: 'id' 파라미터)
			const paramValue = urlParams.get('pg');
			
			switch (i) {
			case 1:
				location.href="/userMyPage/userInfo.do";
				break;
			case 2:
				location.href="/product/buyList.do?reqPage=1&userKey=${loginUser.userKey}";
				break;
			case 3:
				    const form = document.createElement('form');
				    form.method = 'POST';
				    form.action = '/post/readMyPost.do';

				    const input = document.createElement('input');
				    input.type = 'hidden';
				    input.name = 'userKey';
				    input.value = '${loginUser.userKey}';
				    form.appendChild(input);

				    document.body.appendChild(form);
				    form.submit(); // 서버로 POST 요청 전송 및 페이지 이동
				
				break;
			case 4:
				location.href="/userMyPage/likedProdList.do";
				break;
			case 5:
				location.href="/userMyPage/userMyPageFrm.do";
				break;
			default:
				break;
			}
			
		})
    function addAddr() {
        location.href = "/user/addAddrFrm.do";
    }

    function delAddr(button) {
        const addrKey = $(button).closest('li').find('.addrKey').val();
        swal({
            title: "알림",
            text: "주소를 삭제하시겠습니까?",
            icon: "success",
            buttons: {
                cancel: {
                    text: "취소",
                    value: false,
                    visible: true,
                    closeModal: true
                },
                confirm: {
                    text: "삭제",
                    value: true,
                    visible: true,
                    closeModal: true
                }
            }
        }).then(function (isConfirm) {
            if (isConfirm) {
                $.ajax({
                    url: "/user/delAddr.do",
                    type: "GET",
                    data: {
                        addrKey: addrKey
                    },
                    success: function (res) {
                        if (res === "1") {
                            msg('알림', '삭제가 완료되었습니다', 'success', "location.href = '/user/addrListFrm.do';");
                        } else {
                            msg('알림', '삭제중 오류가 발생했습니다', 'error');
                        }
                    },
                    error: function () {
                        console.log('ajax 오류');
                    }
                });
            }
        });
    }

    function updAddr(button) {
        const addrKey = $('.addrKey').val();
        console.log(addrKey);

        location.href = "/user/updAddrFrm.do?addrKey=" + addrKey;

        <%--
        if (!addrKey) {
            alert("주소 키 값을 찾을 수 없습니다.");
            return;
        }
        location.href = `/user/updAddrFrm.do?addrKey=${addrKey}`;
        --%>
    }
</script>
</body>
</html>
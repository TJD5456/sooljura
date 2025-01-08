<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sooljura</title>
<style>
* {
    margin: 0;
    padding: 0;
}

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
</style>
</head>
<body>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/textHeader.jsp"/>
<main>
    <br>
    <h2>주소지 관리</h2>
    <br>
    <hr>
    <br>
    <ul>
	    <li style="list-style-type: none;"><input type="hidden" id="userKey" value="${loginUser.userKey}"></li>
	    <c:forEach var="addr" items="${addrList}">
	        <li style="list-style-type: none;">
	            <div class="addrWrap">
	                <input type="hidden" class="addrKey" name="addrKey" value="${addr.addrKey}">
	                <span style="display: flex; font-size: 20px;">
	                     ${addr.rcptNm}
	                     <c:if test="${not empty addr.addrNm}">
	                            (${addr.addrNm})
	                        </c:if>
	                     <c:if test="${addr.defaultYn == 1}">
	                            <span style="font-weight: lighter; color: #fc8173; border: 1px solid #fc8173; font-size: 15px; margin-left: 10px;">기본배송지</span>
	                        </c:if>
	                 </span>
	            </div>
	            <div class="btnWrap">
	                <button onclick="selAddr(this)">선택</button>
	                <button onclick="delAddr(this)">삭제</button>
	                <button onclick="updAddr(this)">수정</button>
	            </div>
	            <div class="addrWrap">
	                <span>${addr.rcptPhone}</span>
	            </div>
	            <div class="addrWrap">
	                <span>${addr.addr} (${addr.addrCd})</span>
	            </div>
	        </li>
	        <br>
	        <hr>
	        <br>
	    </c:forEach>
    </ul>
    <input type="button" onclick="addAddr(this)" style="width:100%" value="주소지 추가">
<script>
<%-- 주소지 삭제 --%>
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

<%-- 주소지 수정 --%>
function updAddr(button) {
    const addrKey = $(button).closest('li').find('.addrKey').val();
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

<%-- 주소지 선택 --%>
function selAddr(button){
	const addrKey = $(button).closest('li').find('.addrKey').val();
	
	$.ajax({
		url : "/product/selAddr.do",
		type: "POST",
		data : {
			addrKey : addrKey
		},
		success : function(res){
			window.opener.chgAddrChild(res);
			window.close();
		},
		error : function(){
			console.log('주소지 선택 ajax 오류');
		}
	})
}

<%-- 주소지 추가 --%>
function addAddr(button){
	location.href = "/product/addBuyPageAddrFrm.do";
}

</script>
</main>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sooljura</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/textHeader.jsp"/>
	<main>
		<h1>주소지 수정</h1>
		<hr>
		<input type="hidden" name="addrKey" id="addrKey" value="${addrInfo.addrKey}">
		<input type="hidden" name="userKey" id="userKey" value="${addrInfo.userKey}">
		<div>
			<span>배송지 명</span><br>
			<input type="text" name="addrNm" id="addrNm" value="${addrInfo.addrNm}"><br>
		</div>
		<div>
			<span>주소</span><br>
			<input type="text" name="addrCd" id="addrCd" value="${addrInfo.addrCd}" readonly><button onclick="srchAddr()">주소 검색</button><br>
			<input type="text" name="addr" id="addr" value="${addrInfo.addr}" readonly><br>
			<input type="text" name="addrDetail" id="addrDetail" value="${addrInfo.addrDetail}"><br>
			<input type="text" name="addrRef" id="addrRef" value="${addrInfo.addrRef}" readonly>		
		</div>
		<div>
			<span>수령인</span><br>
			<input type="text" name="rcptNm" id="rcptNm" value="${addrInfo.rcptNm}">
		</div>
		<div>
			<span>연락처</span><br>
			<input type="text" name="rcptPhone" id="rcptPhone" value="${addrInfo.rcptPhone}">
		</div>
		<c:if test="${addrInfo.defaultYn eq 0}">
			<input type="checkbox" name="defaultYn" id="defaultYn" value=1>기본 배송지로 설정
		</c:if>
		<div>
			<button id="cancelBtn" onclick="cancelBtn()">취소</button>
			<button id="saveBtn" onclick="saveBtn()">저장</button>
		</div>
	</main>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		//주소찾기 버튼
		function srchAddr() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("addrRef").value = extraAddr;
                
                } else {
                    document.getElementById("addrRef").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('addrCd').value = data.zonecode;
                document.getElementById("addr").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addrDetail").focus();
	            }
	        }).open();
	    }
		
		function cancelBtn(){
			window.self.close();window.opener.location.href = "/user/addrListFrm.do";
		}
		
		function saveBtn(){
			swal({
				title : "알림",
				text : "주소를 수정하시겠습니까?",
				icon : "success",
				buttons : {
					cancel : {
						text : "취소",
						value : false,
						visible : true,
						closeModal true: 
					},
					confirm : {
						text : "수정",
						value : true,
						visible : true,
						closeModal : true
					}
				}
			}).then(function(isConfirm){
				if(isConfirm){
					$.ajax({
						url : "/user/updAddr.do",
						type : "POST",
						data : {
							addrKey : $('#addrKey'),
							userKey : $('#userKey'),
							addrNm : $('#addrNm'),
							addrCd : $('#addrCd'),
							addr : $('#addr'),
							addrDetail : $('#addrDetail'),
							addrRef : $('#addrRef'),
							rcptNm : $('#rcptNm'),
							rcptPhone : $('#rcptPhone'),
							defaultYn : $('#defaultYn')
						},
						success : function(res){
							if(res == "1" || res == "2"){
								msg('알림', '수정이 완료되었습니다', 'success', 'window.self.close();window.opener.location.href = "/user/addrListFrm.do";');
							}else{
								msg('알림', '수정 중 오류가 발생했습니다', 'error');
							}
						},
						error : function(){
							console.log('ajax 오류');
						}
					})
				}
			})
		}
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>술주라</title>
<link rel="icon" href="/resources/icons/logo-circle-woText-16px-favicon.png">
</head>
<style>
	.wrapper{
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	.myPageChoices{
		display: flex;
		justify-content:center;
		
		width: 700px;
	}
	.myPageInfoView{
		height: 800px;
		
	}
	.myPageChoiceBtn{
		width: 500px;
		height: 50px;
		margin: 15px;
		
		font-size: 20px;
		font-weight: bold;
	}
	.myPageInfoView{
		display:none;
	}
	.userInfoInptBtn{
		margin: 20px;
		display: flex;
		justify-content: center;
	}
	.userInfoBtn{
		width: 50%;
		height: 20px;
		padding: 1px;

		display: flex;
		justify-content: center;
		align-items: center;
	}
	.userInfoUpdContent{
		display: flex;
		justify-content: center;
		text-align: center;
		min-width: 600px;
	}
	.tblUserInfo{
		min-width: 600px;
		height: 550px;
		border-top: 1px solid black;
		border-bottom: 1px solid gray;
	}
	.tblUserInfo>tbody>tr>th{
		text-align: left;
	}
	.tblUserInfo>tbody>tr>td>input{
		width: 100%;
		height: 50px;
		border: 1px solid gray;
		border-radius: 15px;
		padding-left: 15px;
		box-sizing:border-box;
	}
	.pwChgBtns{
		display: flex;
	}
	.pwChgBtns .userInfoBtn{
		width: 225px;
	}
	
	.pwChgBtns>*{
		margin-left: 5px;
		margin-right: 5px;		
	}
	.userInptAddrBtn{
		display: flex;
		justify-content: center;
	}
	#userPwChg{
		display: none;
	}
	#userPwChg>table>tbody>tr>th{
		text-align: left;
	}
	#userPwChg>table>tbody>tr>td>input{
		width: 275px;
		height: 30px;
		border: 1px solid gray;
		border-radius: 10px;
		padding-left: 15px;
		box-sizing:border-box;
	}
	#newPwUnMatchSpan{
		font-size:10px;
		display: none;	
	}
	#oldPwUnMatchSpan{
		font-size:10px;
		display: none;	
	}
	#newPwIrreg{
		font-size:10px;
		display: none;
	}
	#userPwMod{
		display: none;
		font-size:10px;
		background-color: white;
	}
	
	#userPwMod>ul{
		list-style-type: none;
	}
	#userPwMod>ul>li{
		list-style-type: none;
	}
</style>
<body>
	<%--개인정보 수정 페이지 --%>
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
	<main>
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="wrapper">
		<h1 style="margin: 15px;">마이 페이지</h1>
		<div style="margin: 15px;"><span>필요하신 메뉴 버튼을 클릭하여 주세요!</span></div> 
		<div class="myPageChoices">
			<button class="myPageChoiceBtn" id="userInfo" onclick="toggleView(this)">회원 정보</button>
			<button class="myPageChoiceBtn" id="shoppingInfo" onclick="toggleView(this)">쇼핑 정보</button>
			<button class="myPageChoiceBtn" id="readMyPost" onclick="toggleView(this)">내글 보기</button>
			<button class="myPageChoiceBtn" id="likedMerc" onclick="toggleView(this)">찜한상품 보기</button>
		</div>
		<div class="myPageInfoView"></div>
	<jsp:include page="/WEB-INF/views/common/remote.jsp"/>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	</main>
<script>
		function toggleView(button){
			/*값 불러올 수 있도록 펑션 설계*/
			/*해당 값에 맞는 페이지로 location.href 써서 보내줄것임*/
			/*불필요하다 생각되면 말해주세요 --엄*/
			const endPoints = {
				userInfo: "/userMyPage/userInfo.do",
		        shoppingInfo: "/userMyPage/shoppingInfo.do",
		        readMyPost: "/userMyPage/readMyPost.do",
		        likedMerc: "/userMyPage/likedMerc.do"
			};
			const selected = $(button).attr('id');
			const url = endPoints[selected];
			
			if (!url) {
	            console.error("Invalid selection:", selected);
	            return;
	        };
			 $('.myPageInfoView').hide(); // 기존 뷰 숨기기
		        console.log("버튼 클릭됨");
		     
			 $.ajax({
		            url: url,
		            type: "get",
		            success: function(res) {
		                $('.myPageInfoView').html(res).show();
		            },
		            error: function() {
		                console.error('AJAX 오류 발생.');
		                $('.myPageInfoView').html('<p>정보를 가져오는 데 실패했습니다.</p>').show();
		            }
		        });
		    }
			
		
		//
		$(document).ready(function(){
			
			$('.myPageInfoView').on('click', '#pwChgBtn', function(){
				console.log("button clicked");
				$('#userPwChg').toggle();
			});
			
			$('.myPageInfoView').on('click', '#pwChgMod', function(){
				$('#userPwMod').toggle();
			});
			
			$('.myPageInfoView').on('click', '#userInfoUpd', function(){
				console.log("Tlqkf anjrk answpdi");
				$.ajax({
					url : "/userMyPage/userInfoUpd",
					type : "post",
					data: {
						string : "123123123"
					},
					dataType:"text",
					success : function(res){
						alert("회원정보 변경 완료");
					},
					error : function(){
						console.log('ajax 오류');
						}
					});
				});
		});
		
</script>
</body>
</html>
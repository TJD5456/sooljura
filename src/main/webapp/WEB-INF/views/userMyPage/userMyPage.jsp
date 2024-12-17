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
	.myPageChoices{
		display: flex;
	}
	.myPageInfoView{
		height: 800px;
		border: 1px solid red;
	}
	.myPageChoiceBtn{
		-webkit-user-select: none;
 		-moz-user-select: none;
 		-ms-use-select: none;
 		user-select: none;

	
		width: 350px;
		height: 100px;
		border-radius: 15px;
		background-color: #FC8173;
		margin: 15px;
		
		display: flex;
		justify-content: center;
		align-items: center;
		
		font-size: 24px;
		font-weight: bold;
		
		box-shadow: 1px 1px 1px 1px #d2210d;
	}
	.myPageChoiceBtn:hover{
		background-color: #F5AFA5;
		box-shadow: 1px 1px 1px 1px #FC8173;
	}
	.myPageChoiceBtn:focus{
		box-shadow: none;
		background-color: #F5AFA5;
	}
	.myPageInfoView{
		display:none;
	}
	
</style>
<body>
	<%--개인정보 수정 페이지 --%>
	<body>
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
	<div class="rWrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="mainDiv">
		<h1>my page</h1>
		<div class="myPageChoices">
			
			<button class="myPageChoiceBtn" id="userInfo" onclick="toggleView(this)">회원 정보</button>
			<button class="myPageChoiceBtn" id="shoppingInfo" onclick="toggleView(this)">쇼핑 정보</button>
			<button class="myPageChoiceBtn" id="readMyPost" onclick="toggleView(this)">내글 보기</button>
			<button class="myPageChoiceBtn" id="likedMerc" onclick="toggleView(this)">찜한상품 보기</button>
		</div>
		<div class="myPageInfoView">
			
		</div>
	<jsp:include page="/WEB-INF/views/common/remoteController.jsp"/>
	</div>
	<div style="height: 500px;"></div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	</div>
<script>
		function toggleView(div){
			/*값 불러올 수 있도록 펑션 설계*/
			/*해당 값에 맞는 페이지로 location.href 써서 보내줄것임*/
			/*불필요하다 생각되면 말해주세요 --엄*/
			let selected = $(div).attr('id');
			
			switch (selected) {
			case 'userInfo':
				console.log("1");
				$.ajax({
					url : "/userMyPage/userInfo.do",
					type : "GET",
					datatype:"html",
					success : function(res){
						console.log("success");
						$('.myPageInfoView').html(res);
					},
					error : function(){
						console.log('ajax 오류');
					}
				});
				$('.myPageInfoView').show();
				break;
			case 'shoppingInfo':
				console.log("2");
				$.ajax({
					url : "/userMyPage/shoppingInfo.do",
					type : "GET",
					datatype:"html",
					success : function(res){
						$('.myPageInfoView').html(res);
					},
					error : function(){
						console.log('ajax 오류');
					}
				});
				$('.myPageInfoView').show();
				break;
			case 'readMyPost':
				console.log("3");
				$.ajax({
					url : "/userMyPage/readMyPost.do",
					type : "GET",
					datatype:"html",
					success : function(res){
						$('.myPageInfoView').html(res);
					},
					error : function(){
						console.log('ajax 오류');
					}
				});
				$('.myPageInfoView').show();
				break;
			case 'likedMerc':
				console.log("4");
				$.ajax({
					url : "/userMyPage/likedMerc.do",
					type : "GET",
					datatype:"html",
					success : function(res){
						$('.myPageInfoView').html(res);
					},
					error : function(){
						console.log('ajax 오류');
					}
				});
				$('.myPageInfoView').show();
				break;
			default:
				break;
			}
			/*
			$.ajax({
				url : "",
				type : "POST",
				data : {
						
						},
				success : function(res){
					
				},
				error : function(){
					console.log('ajax 오류');
				}
			});
			*/
			
		}
		
</script>
</body>
</html>
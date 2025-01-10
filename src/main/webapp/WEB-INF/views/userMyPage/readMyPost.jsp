<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>술주라</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<style>
.myPageChoices {
	width: 700px;
	margin: 0 auto;
	display: flex;
	justify-content: center;
}

.myPageInfoView {
	height: 800px;
}

.myPageChoiceBtn {
	width: 500px;
	height: 50px;
	margin: 15px;
	font-size: 20px;
	font-weight: bold;
}

.myPageInfoView {
	display: none;
}

.tblUserInfo>tbody>tr>th {
	text-align: left;
}

.tblUserInfo>tbody>tr>td>input {
	width: 100%;
	height: 50px;
	border: 1px solid gray;
	border-radius: 15px;
	padding-left: 15px;
	box-sizing: border-box;
}

.pwChgBtn>* {
	margin-left: 5px;
	margin-right: 5px;
}

#userPwChg>table>tbody>tr>th {
	text-align: left;
}

#userPwChg>table>tbody>tr>td>input {
	width: 275px;
	height: 30px;
	border: 1px solid gray;
	border-radius: 10px;
	padding-left: 15px;
	box-sizing: border-box;
}

#userPwMod>ul {
	list-style-type: none;
}

#userPwMod>ul>li {
	list-style-type: none;
}
</style>
<body>
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	<main>
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<div class="wrapper">
			<div class="content">
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
				<div>
					<div class="post-section">
						<h1>내 작성 글 보기</h1>

						<!-- 공지사항 -->
						<c:if test="${loginUser != null && loginUser.userCd == 0}">
							<h2>공지사항</h2>
							<table>
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작성일</th>
										<th>조회수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="post" items="${noticeList}" varStatus="status">
										<tr>
											<td>${status.index + 1}</td>
											<td><a href="/post/noticeDetail.do?postKey=${post.postKey}">${post.postTitle}</a></td>
											<td>${post.postDate}</td>
											<td>${post.postViews}</td>
										</tr>
									</c:forEach>
									<c:if test="${empty noticeList}">
										<tr>
											<td colspan="4">작성된 공지사항이 없습니다.</td>
										</tr>
									</c:if>
									<c:if test="${not empty noticeList}">
										<tr>
											<td colspan="4">
												<div>${noticePageNavi}</div>
											</td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</c:if>

						<!-- 자유게시판 -->
						<h2>자유게시판</h2>
						<table>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>작성일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="post" items="${freePostList}" varStatus="status">
									<tr>
										<td>${status.index + 1}</td>
										<td><a
											href="/post/freePostDetail.do?postKey=${post.postKey}">${post.postTitle}</a></td>
										<td>${post.postDate}</td>
										<td>${post.postViews}</td>
									</tr>
								</c:forEach>
								<c:if test="${empty freePostList}">
									<tr>
										<td colspan="4">작성된 자유게시글이 없습니다.</td>
									</tr>
								</c:if>
								<c:if test="${not empty freePostList}">
									<tr>
										<td colspan="4">
											<div>${freePageNavi}</div>
										</td>
									</tr>
								</c:if>
							</tbody>
						</table>

						<!-- 후기 게시판 -->
						<h2>후기 게시판</h2>
						<table>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>작성일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="post" items="${reviewPostList}"
									varStatus="status">
									<tr>
										<td>${status.index + 1}</td>
										<td><a
											href="/post/freePostDetail.do?postKey=${post.postKey}">${post.postTitle}</a></td>
										<td>${post.postDate}</td>
										<td>${post.postViews}</td>
									</tr>
								</c:forEach>
								<c:if test="${empty reviewPostList}">
									<tr>
										<td colspan="4">작성된 후기게시글이 없습니다.</td>
									</tr>
								</c:if>
								<c:if test="${not empty reviewPostList}">
									<tr>
										<td colspan="4">
											<div>${reviewPageNavi}</div>
										</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<jsp:include page="/WEB-INF/views/common/remote.jsp" />
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</main>

	<script>
		$('.myPageChoiceBtn').on('click', function() {
							let i = parseInt($(this).val(), 10);

							// 현재 페이지 URL 가져오기
							const url = window.location.href;// URL 객체 생성
							const urlParams = new URLSearchParams(
									new URL(url).search);// 특정 파라미터 값 가져오기 (예: 'id' 파라미터)
							const paramValue = urlParams.get('pg');

							switch (i) {
							case 1:
								location.href = "/userMyPage/userInfo.do"
								break;
							case 2:
								location.href = "/product/buyList.do?reqPage=1&userKey=${loginUser.userKey}";
								break;
							case 3:
								location.href = "/userMyPage/userMyPageFrm.do";
								break;
							case 4:
								location.href = "/userMyPage/likedProdList.do";//?
								break;
							case 5:
								location.href = "/user/addrListFrm.do";
								break;
							default:
								break;
							}

						})

		//=========================================================================================================
		function goToEditPage(postCd, postKey) {
			let editPage;
			switch (postCd) {
			case 1: // 공지사항
				editPage = "noticePostEdit.do";
				break;
			case 2: // 자유게시판
				editPage = "freePostEdit.do";
				break;
			case 3: // 후기 게시판
				editPage = "reviewPostEdit.do";
				break;
			default: // 기본값: 자유게시판
				editPage = "freePostEdit.do";
			}
			window.location.href = `/post/${editPage}?postKey=${postKey}`;
		}
	</script>
</body>
</html>

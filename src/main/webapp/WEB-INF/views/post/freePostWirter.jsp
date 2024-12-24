<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자유게시판 글쓰기</title>
<style>
/* 전체 레이아웃 */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

/* 사이드바 스타일 */
.leftSideBar {
	width: 250px;
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	padding: 20px;
	box-sizing: border-box;
	overflow-y: auto;
}

.main-container {
	margin-left: 250px; /* 사이드바 너비 */
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

.header, .footer {
	background-color: #fff;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

.footer {
	margin-top: auto; /* 푸터를 하단에 고정 */
	border-top: 1px solid #ddd;
	 box-shadow: none;
	
}

/* 폼 스타일 */
.form-group {
	display: flex;
	margin-bottom: 15px;
	align-items: center;
}

.form-group label {
	width: 120px;
	font-weight: bold;
	margin-right: 10px;
}

.form-group input[type="text"], .form-group select, textarea {
	flex: 1;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
}


.button-group {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 20px;
}

.button-group button {
	padding: 10px 30px;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

/* 콘텐츠 영역 */
.content {
    flex: 1;
    padding: 20px;
    box-sizing: border-box;
    background-color: #fff;
    margin: 20px;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

/* Summernote 스타일 */
.note-editor {
    max-width: 100%; /* 에디터가 화면을 넘어가지 않도록 설정 */
    box-sizing: border-box;
}

#postContent {
    display: block;
    width: 100%; /* 에디터 크기 */
    height: 400px; /* 기본 높이 */
    box-sizing: border-box;
    border: 1px solid #ddd;
    border-radius: 4px;
    resize: none;
}
.note-toolbar button{
	box-shadow: unset;
}

</style>
</head>
<body>
	
	
	<!--  사이드바 -->
   <div class="leftSideBar">
        <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
    </div>

    <div class="main-container">
    	<!-- 헤더 -->
        <div class="header">
            <jsp:include page="/WEB-INF/views/common/header.jsp" />
        </div>

        <div class="content">
            <h1>자유 게시판 글쓰기</h1>
            <!-- Form 태그 추가 -->
            <form action="/post/freewrite.do" method="post">
                <!-- 말머리 -->
                <div class="form-group">
                    <label for="category">말머리</label>
                    <select id="category" name="category">
                        <option value="1">일상</option>
                        <option value="2">질문</option>
                        <option value="3">정보 나눔</option>
                        <option value="4">공지사항</option>
                    </select>
                </div>

                <!-- 글쓴이 -->
                <div class="form-group">
                    <label for="author">글쓴이</label>
                    <input type="text" id="author" name="author" value="<%= session.getAttribute("userNm") %>" readonly>
                </div>

                <!-- 제목 -->
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required>
                </div>

                <!-- 본문 -->
                <div class="form-group">
                    <label for="postContent">본문</label>
                    <textarea id="postContent" name="postContent" placeholder="내용을 입력하세요..." required></textarea>
                </div>

                <!-- 버튼 -->
                <div class="button-group">
                    <button type="button" onclick="history.back();">이전</button>
                    <button type="submit">등록</button>
                </div>
            </form>
        </div>

        <div class="footer">
            <jsp:include page="/WEB-INF/views/common/footer.jsp" />
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#postContent').summernote({
                height: 400,
                lang: 'ko-KR',
                toolbar: [
                    ['style', ['style']],
                    ['font', ['bold', 'italic', 'underline', 'clear']],
                    ['fontname', ['fontname']],
                    ['fontsize', ['fontsize']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['insert', ['picture', 'link', 'video']],
                    ['view', ['fullscreen', 'codeview', 'help']],
                ],
                placeholder: "내용을 입력하세요...",
            });
        });
    </script>
</body>
</html>
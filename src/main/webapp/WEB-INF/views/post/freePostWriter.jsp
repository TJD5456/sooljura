<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.khedu.sooljura.user.model.vo.User" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유 게시판 글쓰기</title>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <style>
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
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .button-group button:hover {
            background-color: #0056b3;
        }

        /* Summernote 스타일 */
        .note-editor {
            max-width: 80%;
            box-sizing: border-box;
            margin: 0 auto;
        }

        .note-frame {
            width: 1000px;
        }

        #postContent {
            display: block;
            width: 100%;
            height: 400px; /* Summernote 기본 높이 */
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: none;
        }

        .note-toolbar button {
            box-shadow: unset;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <div class="title">
                <h1>자유 게시판 글쓰기</h1>
            </div>

            <div class="note-editor">
                <form action="/post/freeWrite.do" method="post">
                    <div class="form-group">
                        <label for="postCategory">게시판 종류 </label>
                        <input type="text" value="자유게시판" id="postCategory" readonly>
                    </div>

                    <div class="form-group">
                        <label for="author">글쓴이</label>
                        <input type="text" id="author" name="author"
                               value="<%= ((User)session.getAttribute("loginUser")).getUserNm() %>" readonly>
                    </div>

                    <div class="form-group">
                        <label for="title">제목</label>
                        <input type="text" id="title" name="postTitle" placeholder="제목을 입력하세요" required>
                    </div>

                    <div class="form-group">
                        <label for="postContent">본문</label>
                        <textarea id="postContent" name="postContent" required></textarea>
                    </div>

                    <div class="button-group">
                        <button type="button" onclick="history.back();">이전</button>
                        <button type="submit">등록</button>
                    </div>
                </form>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>

<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<script>
    $(function () {
        $('#postContent').summernote({
            height: 400,   // 에디터 높이 설정
            lang: 'ko-KR',
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'italic', 'underline', 'clear']],
                ['fontname', ['fontname']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['view', ['fullscreen', 'codeview', 'help']],
            ],
            placeholder: "내용을 입력하세요...",
        });
    });
</script>
</body>
</html>

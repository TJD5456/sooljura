<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판 - 게시글 상세보기</title>
    <link rel="icon" href="/resources/icons/logo-circle-woText-16px-favicon.png">
    <link rel="stylesheet" href="/resources/css/freePost.css"/>
    <style>
        .comment-form button {
            width: 100px;
            padding: 10px 20px;
            border-radius: 5px;
            color: #FFF;
            background-color: #007BFF;
            cursor: pointer;
        }
        .comment-form button:hover {
            background-color: #0056b3;
        }
        .back-button {
            background-color: #555;
            color: white;
        }
        .back-button:hover {
            background-color: #333;
        }
        .edit-buttons {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
            gap: 10px;
        }
        .edit-buttons a, .edit-buttons form button {
            padding: 8px 16px;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
        }
        .edit-button {
            background-color: #007BFF;
            color: white;
        }
        .delete-button {
            background-color: #FF4D4D;
            color: white;
        }
        .delete-button:hover, .edit-button:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <!-- 게시글 정보 -->
            <div class="title">
                <h1>자유게시판</h1>
            </div>
            <div class="container">
                <div class="post-title">${post.postTitle}</div>
                <div class="post-info">
                    작성자: ${post.userNickNm} | 작성일:${post.postDate} | 조회수:
                    ${post.postViews}

                    <!-- 게시글 수정/삭제 버튼 (작성자 본인만 확인 가능) -->
                    <c:if
                            test="${not empty loginUser && post.userKey == loginUser.userKey}">
                        <div class="edit-buttons">
                            <!-- 게시글 수정 버튼 -->
                            <a class="edit-button"
                               href="/post/freePostEdit.do?postKey=${post.postKey}" style="background-color: #FC8173; text-decoration: none;">수정</a>
                            <!-- 게시글 삭제 버튼 -->
                            <form action="/post/deletePost.do" method="post"
                                  onsubmit="return confirm('정말 삭제하시겠습니까?')">
                                <input type="hidden" name="postKey" value="${post.postKey}">
                                <button type="submit" style="background-color: #FC8173;" class="delete-button">삭제</button>
                            </form>
                        </div>
                    </c:if>
                </div>
                <div class="post-content">${post.postContent}</div>

                <!-- 댓글 섹션 -->
                <div class="comments">
                    <h4>댓글</h4> <br>
                    <c:forEach var="comment" items="${comments}">
                        <div class="comment" id="comment-${comment.commentKey}">
                            <!-- 댓글 작성자 -->
                            <div>
                                <span class="author">${comment.userNickNm}</span>
                                <c:if
                                        test="${not empty loginUser && comment.userKey == loginUser.userKey}">
                                    <!-- 삭제 버튼 -->
                                    <form action="/post/deleteComment.do" method="post"
                                          onsubmit="return confirm('정말 삭제하시겠습니까?');"
                                          style="display: inline;">
                                        <input type="hidden" name="commentKey"
                                               value="${comment.commentKey}"/>
                                        <button type="submit">삭제</button>
                                    </form>
                                </c:if>
                            </div>
                            <!-- 댓글 작성 날짜 -->
                            <div class="date">${comment.commentDate}</div>
                            <!-- 댓글 내용 -->
                            <div class="content" id="comment-content-${comment.commentKey}">
                                    ${fn:escapeXml(comment.commentContent)}</div>
                        </div>
                    </c:forEach>
                </div>
                <!-- 댓글 작성 폼 -->
                <div class="comment-form">
                    <form action="/post/addComment.do" method="post" id="commentForm"
                            <c:if test="${empty loginUser}">
                                hidden
                            </c:if>>
							<textarea name="commentContent" placeholder="댓글 내용을 입력하세요"
                                      required></textarea>
                        <input type="hidden" name="postKey" value="${post.postKey}"/>
                    </form>
                    <button class="back-button" style="background-color: #FC8173;" onclick="history.back();">뒤로가기</button>
                    <c:choose>
                        <c:when test="${empty loginUser}">
                            <button onclick="toLogin()" style="background-color: #FC8173;" class="to-login-btn">로그인</button>
                        </c:when>
                        <c:otherwise>
                            <button type="submit" style="background-color: #FC8173;" form="commentForm">댓글 등록</button>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${loginUser.userCd == 0}">
                        <button class="adminDeletePost" style="background-color: #FC8173;" type="button">삭제</button>
                    </c:if>
                </div>

            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>

<script>
    // 현재 수정 중인 댓글의 key 를 추적
    let currentEditingKey = null;

    // 댓글 수정 함수
    window.editComment = function (commentKey, commentContent) {
        console.log("EditComment Called:", commentKey, commentContent);

        // 이미 다른 댓글을 수정 중일 경우 확인 메시지
        if (currentEditingKey && currentEditingKey !== commentKey) {
            if (!confirm("현재 수정 중인 댓글이 있습니다. 다른 댓글을 수정하시겠습니까?")) {
                return;
            }
            cancelEdit(currentEditingKey); // 기존 수정 취소
        }

        // 수정 중인 key 업데이트
        currentEditingKey = commentKey;

        const parentDiv = document.getElementById(`comment-${commentKey}`);
        const contentDiv = document.getElementById(`comment-content-${commentKey}`);

        if (!parentDiv || !contentDiv) {
            console.error(`Element not found for commentKey: ${commentKey}`);
            return;
        }

        // 이미 수정 폼이 생성된 경우 추가 생성 방지
        if (document.getElementById(`edit-form-container-${commentKey}`)) {
            console.warn("Edit form already exists for this comment.");
            return;
        }

        // 댓글 내용을 숨김
        contentDiv.style.display = 'none';

        // 수정 폼 생성
        const formContainer = document.createElement('div');
        formContainer.id = `edit-form-container-${commentKey}`;
        formContainer.style.marginTop = '10px';

        const form = document.createElement('form');
        form.action = '/post/editComment.do';
        form.method = 'post';

        const textArea = document.createElement('textarea');
        textArea.name = 'commentContent';
        textArea.value = commentContent;
        textArea.style.width = '100%';
        textArea.style.marginBottom = '10px';
        form.appendChild(textArea);

        const hiddenInput = document.createElement('input');
        hiddenInput.type = 'hidden';
        hiddenInput.name = 'commentKey';
        hiddenInput.value = commentKey;
        form.appendChild(hiddenInput);

        const saveButton = document.createElement('button');
        saveButton.type = 'submit';
        saveButton.textContent = '저장';
        saveButton.style.marginRight = '10px';
        form.appendChild(saveButton);

        const cancelButton = document.createElement('button');
        cancelButton.type = 'button';
        cancelButton.textContent = '취소';
        cancelButton.onclick = function () {
            cancelEdit(commentKey);
        };
        form.appendChild(cancelButton);

        formContainer.appendChild(form);

        // 댓글 내용 바로 아래에 수정 폼 삽입
        contentDiv.insertAdjacentElement('afterend', formContainer);
    };

    // 댓글 수정 취소 함수
    window.cancelEdit = function (commentKey) {
        console.log("CancelEdit Called:", commentKey);

        const formContainer = document.getElementById(`edit-form-container-${commentKey}`);
        const contentDiv = document.getElementById(`comment-content-${commentKey}`);

        if (formContainer) {
            formContainer.remove();
        }
        if (contentDiv) {
            contentDiv.style.display = 'block';
        }

        // 수정 상태 초기화
        currentEditingKey = null;
    };

    function confirmEditPage(url) {
        if (confirm("수정 페이지로 이동하시겠습니까?")) {
            window.location.href = url;
        }
    }

    function toLogin() {
        window.location.href = '/user/loginFrm.do';
    }

    $(".adminDeletePost").click(function () {
        window.location.href = "/post/adminDeletePost.do?postKey=${post.postKey}";
    })

    $(function () {
        if ("${post.confirmYn == 0}" && "${userCd == 0}") {
            $.ajax({
                url: '/post/confirmYn.do',
                type: 'get',
                data: {
                    postKey: "${post.postKey}",
                }
            })
        }
    })
</script>
</body>
</html>

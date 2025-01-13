<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품 후기 - 게시글 상세보기</title>
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
                <h1>제품 후기 게시판</h1>
            </div>
            <div class="container">
                <div class="post-title">${post.postTitle}</div>
                <div class="post-info">
                    작성자: ${post.userNickNm} |
                    작성일: ${post.postDate} |
                    조회수: ${post.postViews}

                    <!-- 게시글 수정/삭제 버튼 (작성자 본인만 확인 가능) -->
                    <c:if test="${not empty loginUser && post.userKey == loginUser.userKey}">
                        <div class="edit-buttons">
                            <!-- 게시글 수정 버튼 -->
                            <a class="edit-button" href="/post/reviewPostEdit.do?postKey=${post.postKey}"  style="background-color: #FC8173; text-decoration: none;">수정</a>
                            <!-- 게시글 삭제 버튼 -->
                            <form action="/post/deletePost.do" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?')">
                                <input type="hidden" name="postKey" value="${post.postKey}">
                                <button type="submit" style="background-color: #FC8173;" class="delete-button">삭제</button>
                            </form>
                        </div>
                    </c:if>
                </div>
                <div class="post-content">${post.postContent}</div>

                <!-- 댓글 섹션 -->
                <div class="comments">
                    <h4>댓글</h4><br>
                    <c:forEach var="comment" items="${comments}">
                        <div class="comment" id="comment-${comment.commentKey}">
                            <div>
                                <span class="author">${comment.userNickNm}</span>
                                <c:if test="${not empty loginUser && comment.userKey == loginUser.userKey}">
                                    <form action="/post/deleteComment.do" method="post"
                                          onsubmit="return confirm('정말 삭제하시겠습니까?');"
                                          style="display: inline;">
                                        <input type="hidden" name="commentKey"
                                               value="${comment.commentKey}"/>
                                        <button type="submit"
                                                style="border: none; background: none; color: red; cursor: pointer;">
                                            삭제
                                        </button>                                      	
                                    </form>
                                </c:if>
								<%--<c:if test="${userCd == 0}">
                                	<form action="/post/deleteComment.do" method="post"
                                          onsubmit="return confirm('정말 삭제하시겠습니까?');"
                                          style="display: inline;">
                                        <input type="hidden" name="commentKey"
                                               value="${comment.commentKey}"/>
                                        <button type="submit"
                                                style="border: none; background: none; color: red; cursor: pointer;">
                                            삭제
                                        </button>
                                    </form>
                               </c:if>	--%>
                            </div>
                            <div class="date">${comment.commentDate}</div>
                            <div class="content" id="comment-content-${comment.commentKey}">
                                ${fn:escapeXml(comment.commentContent)}
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- 댓글 작성 폼 -->
                <div class="comment-form">
                    <form action="/post/addComment.do" method="post" id="commentForm"
                          <c:if test="${empty loginUser}">
                              hidden
                          </c:if>>
                        <textarea name="commentContent" placeholder="댓글 내용을 입력하세요" required></textarea>
                        <input type="hidden" name="postKey" value="${post.postKey}"/>
                    </form>
                    <button class="back-button" style="background-color: #FC8173;" onclick="history.back();">뒤로가기</button>
                    <c:choose>
                        <c:when test="${empty loginUser}">
                            <button onclick="toLogin()" class="to-login-btn">로그인</button>
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
    function toLogin() {
        window.location.href = '/user/loginFrm.do';
    }
    
    $(".adminDeletePost").click(function () {
        window.location.href = "/post/adminDeletePost.do?postKey=${post.postKey}";
    })
</script>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 글 보기</title>
    <script src="/resources/jquery/jquery-3.7.1.min.js"></script>
</head>
<body>
    <div class="post-section">
        <h1>내 작성 글 보기</h1>

        <!-- 공지사항 -->
        <c:if test="${loginUser != null && loginUser.userCd == 0}">
            <h2>공지사항</h2>
            <table>
                <thead>
                    <tr>
                        <th>제목</th>
                        <th>작성일</th>
                        <th>조회수</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="post" items="${noticePosts}">
                        <tr>
                            <td>${post.postTitle}</td>
                            <td>${post.postDate}</td>
                            <td>${post.postViews}</td>
                            <td>
                                <a href="#" onclick="goToEditPage(${post.postCd}, '${post.postKey}')">수정</a>
                                <form action="/post/deletePost.do" method="post" style="display: inline;">
                                    <input type="hidden" name="postKey" value="${post.postKey}">
                                    <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty noticePosts}">
                        <tr>
                            <td colspan="4">작성된 공지사항이 없습니다.</td>
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
                    <th>제목</th>
                    <th>작성일</th>
                    <th>조회수</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="post" items="${freePosts}">
                    <tr>
                        <td>${post.postTitle}</td>
                        <td>${post.postDate}</td>
                        <td>${post.postViews}</td>
                        <td>
                            <a href="#" onclick="goToEditPage(${post.postCd}, '${post.postKey}')">수정</a>
                            <form action="/post/deletePost.do" method="post" style="display: inline;">
                                <input type="hidden" name="postKey" value="${post.postKey}">
                                <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty freePosts}">
                    <tr>
                        <td colspan="4">작성된 자유게시글이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <!-- 후기 게시판 -->
        <h2>후기 게시판</h2>
        <table>
            <thead>
                <tr>
                    <th>제목</th>
                    <th>작성일</th>
                    <th>조회수</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="post" items="${reviewPosts}">
                    <tr>
                        <td>${post.postTitle}</td>
                        <td>${post.postDate}</td>
                        <td>${post.postViews}</td>
                        <td>
                            <a href="#" onclick="goToEditPage(${post.postCd}, '${post.postKey}')">수정</a>
                            <form action="/post/deletePost.do" method="post" style="display: inline;">
                                <input type="hidden" name="postKey" value="${post.postKey}">
                                <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty reviewPosts}">
                    <tr>
                        <td colspan="4">작성된 후기가 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <script>
        function goToEditPage(postCd, postKey) {
            let editPage;
            switch (postCd) {
                case 1:  // 공지사항
                    editPage = "noticePostEdit.do";
                    break;
                case 2:  // 자유게시판
                    editPage = "freePostEdit.do";
                    break;
                case 3:  // 후기 게시판
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

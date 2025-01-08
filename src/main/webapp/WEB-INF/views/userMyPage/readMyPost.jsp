<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    .post-section {
        margin-bottom: 50px;
    }

    .post-section table {
        width: 100%; /* 화면 전체 너비 사용 */
        max-width: 1200px; /* 최대 너비 제한 */
        border-collapse: collapse;
        margin: 0 auto;
    }

    .post-section th, .post-section td {
        padding: 15px 20px; /* 칸 간격 */
        text-align: center;
        border: 1px solid #ddd;
    }

    .post-section th {
        background-color: #f2f2f2;
        font-weight: bold;
    }

    .post-section td {
        font-size: 16px;
    }

    .post-section tr:hover {
        background-color: #f9f9f9;
    }

    .post-section .post-title {
        text-align: left;
        padding-left: 10px;
    }

    .post-section .post-title a {
        color: #007bff;
        text-decoration: none;
    }

    .post-section .post-title a:hover {
        text-decoration: underline;
    }

    .post-section .action-buttons {
        display: flex;
        gap: 10px;
        justify-content: center;
    }

    .post-section .action-buttons a,
    .post-section .action-buttons button {
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 8px 16px;
        cursor: pointer;
    }

    .post-section .action-buttons button {
        background-color: #dc3545;
    }

    .post-section .action-buttons a:hover,
    .post-section .action-buttons button:hover {
        opacity: 0.9;
    }
</style>
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
                        <td class="post-title">${post.postTitle}</td>
                        <td>${post.postDate}</td>
                        <td>${post.postViews}</td>
                        <td class="action-buttons">
                            <a href="/post/noticePostEdit.do?postKey=${post.postKey}">수정</a>
                            <form action="/post/deletePost.do" method="post" style="display: inline;">
                                <input type="hidden" name="postKey" value="${post.postKey}" />
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
                    <td class="post-title">${post.postTitle}</td>
                    <td>${post.postDate}</td>
                    <td>${post.postViews}</td>
                    <td class="action-buttons">
                        <a href="/post/freePostEdit.do?postKey=${post.postKey}">수정</a>
                        <form action="/post/deletePost.do" method="post" style="display: inline;">
                            <input type="hidden" name="postKey" value="${post.postKey}" />
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
                    <td class="post-title">${post.postTitle}</td>
                    <td>${post.postDate}</td>
                    <td>${post.postViews}</td>
                    <td class="action-buttons">
                        <a href="/post/reviewPostEdit.do?postKey=${post.postKey}">수정</a>
                        <form action="/post/deletePost.do" method="post" style="display: inline;">
                            <input type="hidden" name="postKey" value="${post.postKey}" />
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



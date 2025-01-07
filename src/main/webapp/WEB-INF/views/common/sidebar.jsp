<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside>
    <a href="/"> <img id="logoImg" src="/resources/icons/logo.png" alt="술주라 로고"> </a>
    <div>
        <%--
        와인/샴페인
            프랑스, 이태리, 칠레, 미국, 호주
        위스키
            아메리칸, 스카치, 아이리쉬, 캐나다, 일본
        브랜디/꼬냑
            브랜디, 꼬냑, 알마냑
        리큐르/보드카
            리큐르, 진, 럼, 보드카, 테낄라
        전통주/민속주
        기타주류(중국술/대만술)
        카테고리
        --%>
        <span>카테고리</span>
        <ul class="ul">
            <li><a href="/">와인/샴페인</a></li>
            <li><a href="/">위스키</a></li>
            <li><a href="/">브랜디/꼬냑</a></li>
            <li><a href="/">리큐르/보드카</a></li>
            <li><a href="/">전통주/민속주</a></li>
            <li><a href="/">기타주류</a></li>
        </ul>
        <span>공지사항</span>
        <ul class="ul">
            <li><a href="/post/noticeList.do?reqPage=1">공지사항</a></li>
            <li><a href="/">Q&#38;A</a></li>
        </ul>
    </div>
    <span>커뮤니티</span>
    <ul class="ul">
        <li><a href="/post/freePostList.do?reqPage=1">자유게시판</a></li>
        <li><a href="/post/reviewListPost.do?reqPage=1">제품 후기 게시판</a></li>
        <li><a href="/post/webPageInfo.do">사이트 소개</a></li>
    </ul>

    <form action="/user/createTestAccount.do" method="post">
        <input type="radio" name="testAccount" value="0" id="0"><label for="0">관리자 계정 생성</label> <br>
        <input type="radio" name="testAccount" value="1" id="1"><label for="1">레벨 1</label> <br>
        <input type="radio" name="testAccount" value="-1" id="minus"><label for="minus">레벨 -1</label> <br>
        <input type="submit" value="생성">
    </form>

</aside>

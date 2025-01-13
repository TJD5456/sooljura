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
            <li><a href="/product/productList.do?categoryKey=c0001&sort=0">와인/샴페인</a></li>
            <li><a href="/product/productList.do?categoryKey=c0002&sort=0">위스키</a></li>
            <li><a href="/product/productList.do?categoryKey=c0003&sort=0">브랜디/꼬냑</a></li>
            <li><a href="/product/productList.do?categoryKey=c0004&sort=0">리큐르/보드카</a></li>
            <li><a href="/product/productList.do?categoryKey=c0005&sort=0">전통주/민속주</a></li>
            <li><a href="/product/productList.do?categoryKey=c0006&sort=0">기타주류</a></li>
        </ul>
    </div>
    <div style="margin-top:20px; border-top:1px solid #FF6851;">
        <br>
        <span>공지사항</span>
        <ul class="ul">
            <li><a href="/post/noticeList.do?reqPage=1">공지사항</a></li>
        </ul>
    </div>
    <div style="margin-top:20px; border-top:1px solid #FF6851;">
    <br>
    <span>커뮤니티</span>
	    <ul class="ul">
	        <li><a href="/post/freePostList.do?reqPage=1">자유게시판</a></li>
	        <li><a href="/post/reviewListPost.do?reqPage=1">제품 후기 게시판</a></li>
	        <li><a href="/common/webPageInfo.do">사이트 소개</a></li>
	    </ul>
	</div>
	<div style="margin-top:20px; padding-top:20px; border-top:1px solid #FF6851;">
	    <form action="/user/createTestAccount.do" method="post">
	        <input type="radio" name="testAccount" value="0" id="0"><label for="0">관리자 계정 생성</label> <br>
	        <input type="radio" name="testAccount" value="1" id="1"><label for="1">레벨 1</label> <br>
	        <input type="radio" name="testAccount" value="-1" id="minus"><label for="minus">레벨 -1</label> <br>
	        <input type="submit" value="생성">
	    </form>
	</div>
</aside>

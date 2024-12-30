<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="remote">
    <ul>
        <li><a href="#top"><img src="/resources/icons/arrow_화살표상_7411287_45px.png" alt="화살표상"></a></li>
        <li><a href="/"><img src="/resources/icons/home_홈_1946488_45px.png" alt="홈"></a></li>
        <li><a href="/"><img src="/resources/icons/bags_쇼핑백_1413928_45px.png" alt="쇼핑백"></a></li>
        <li><a href="/"><img src="/resources/icons/heart_찜하기_5303390_45px.png" alt="찜하기"></a></li>
        <c:if test="${not empty loginUser}">
            <li><a href="javascript:void(0);"><img src="/resources/icons/message-icon.png" onclick="fn.createRoom();"
                                                   style="width: 45px" alt="chat"></a></li>
        </c:if>
        <li><a href="#bottom"><img src="/resources/icons/arrow_화살표하_7411288_45px.png" alt="화살표하"></a></li>
    </ul>
</div>
<script>
    let fn = {
        createRoom: function () {
            let top = (window.innerHeight - 300) / 2 + window.screenY;
            let left = (window.innerWidth - 200) / 2 + window.screenX;
            window.open("/chat/chatList.do", "creatRoom", "width=" + 450 + ", height=" + 700 + ", top=" + top + ", left=" + left);
        }
    };
</script>

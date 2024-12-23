<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>manageYoutube.jsp</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <div class="title">
                <h1>유튜브관리 페이지</h1>
            </div>
            <form action="/admin/uploadYoutube.do" method="get">
                <table border="1">
                    <tr>
                        <th><label for="urlInput">유튜브 URL</label></th>
                        <td><input type="text" name="youtubeUrl" id="urlInput"></td>
                    </tr>
                    <tr>
                        <th><label for="contentInput">제품 설명</label></th>
                        <td><input type="text" name="content" id="contentInput"></td>
                    </tr>
                    <tr class="prodKeyInput">
                        <th><label for="prodKeyInput1">제품 등록</label></th>
                        <td><input type="text" name="prodKey1" id="prodKeyInput1"></td>
                    </tr>
                    <tr>
                        <th colspan="2"><input type="submit" value="YouTube 등록"></th>
                    </tr>
                </table>
            </form>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>
<script>
    <%-- 제품을 하나 등록하면 다음 제품도 등록할 수 있도록 테이블 행을 추가 총 3개 까지 --%>
    $(".prodKeyInput").on("change", function () {
        console.log("foobar");
    });
</script>
</body>
</html>

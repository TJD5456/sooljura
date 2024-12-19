<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>manageCategory.jsp</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <form action="/admin/manageCategory.do" method="get">
                <table border="1">
                    <tr>
                        <th><label for="categoryLevelInput">카테고리 레벨</label></th>
                        <td><input type="text" id="categoryLevelInput" name="categoryLevel"></td>
                    </tr>
                    <tr>
                        <th><label for="categoryNmInput">카테고리 이름</label></th>
                        <td><input type="text" id="categoryNmInput" name="categoryNm"></td>
                    </tr>
                    <tr>
                        <th><label for="higherCategoryInput">상위 카테고리 코드</label></th>
                        <td><input type="text" id="higherCategoryInput" name="higherCategory"></td>
                    </tr>
                    <tr>
                        <th colspan="2"><input type="submit" value="등록하기"></th>
                    </tr>
                </table>
            </form>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>
</body>
</html>

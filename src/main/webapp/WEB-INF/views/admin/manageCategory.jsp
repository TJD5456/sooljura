<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>manageCategory.jsp</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<h1>카테고리 관리 페이지</h1>

<main>
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
                <th><label for="higherCategoryInput">상위 카테고리 레벨</label></th>
                <td><input type="text" id="higherCategoryInput" name="higherCategory"></td>
            </tr>
            <tr>
                <input type="submit" value="등록하기">
            </tr>
        </table>
    </form>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>

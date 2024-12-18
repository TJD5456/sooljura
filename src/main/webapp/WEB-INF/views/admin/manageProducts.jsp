<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>manageProducts.jsp</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
    <div class="title">
        <span>상품 관리 페이지</span>
    </div>
    <form action="/admin/uploadProduct.do" method="post" enctype="multipart/form-data" id="uploadForm">
        <table border="1">
            <tr>
                <th><label for="nameInput">상품명</label></th>
                <td><input type="text" id="nameInput" name="prodName"></td>
            </tr>
            <tr>
                <th>사진</th>
                <td><input type="file" id="photoInput" name="prodImages"></td>
            </tr>
            <tr>
                <th><label for="priceInput">가격</label></th>
                <td><input type="text" id="priceInput" name="prodPrice"></td>
            </tr>
            <tr>
                <th><label for="makerInput">제조사</label></th>
                <td><input type="text" id="makerInput" name="prodMaker"></td>
            </tr>
            <tr>
                <th><label for="originInput">원산지</label></th>
                <td><input type="text" id="originInput" name="prodOrigin"></td>
            </tr>
            <tr>
                <th><label for="introInput">소개</label></th>
                <td><input type="text" id="introInput" name="prodIntro"></td>
            </tr>
            <tr>
                <th><label for="categoryInput">카테고리</label></th>
                <td><input type="text" id="categoryInput" name="categoryLevel"></td>
            </tr>
            <tr>
                <th><label for="cntInput">수량</label></th>
                <td><input type="text" id="cntInput" name="prodCnt"></td>
            </tr>
            <tr>
                <th colspan="2">
                    <input type="submit" value="제품 등록">
                    <input type="button" value="카테고리 관리" onclick="manageCategoryFrm()">
                </th>
            </tr>
        </table>
    </form>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<script>
    function manageCategoryFrm() {
        window.location.href = '/admin/manageCategoryFrm.do';
    }
</script>
</body>
</html>

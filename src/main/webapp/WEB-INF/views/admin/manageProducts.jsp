<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>manageProducts.jsp</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<div class="title">
    <span>상품 관리 페이지</span>
</div>

<form action="/admin/uploadProduct.do" method="post" enctype="multipart/form-data">
    <table border="1">
        <tr>
            <th><label for="nameInput">상품명</label></th>
            <td><input type="text" id="nameInput" name="prodName"></td>
        </tr>
        <tr>
            <th>사진</th>
            <td><input type="file" id="photoInput" name="prodPhoto"></td>
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
            <th><label for="cntInput">수량</label></th>
            <td><input type="text" id="cntInput" name="prodCnt"></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="제품 등록"></td>
        </tr>
    </table>
</form>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<script>

</script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>manageProducts.jsp</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <div class="title">
                <h1>상품 관리 페이지</h1>
            </div>
            <form action="/admin/uploadProduct.do" method="post" enctype="multipart/form-data" id="uploadForm">
                <table border="1">
                    <tr>
                        <th><label for="nameInput">상품명</label></th>
                        <td><input type="text" id="nameInput" name="prodName"></td>
                    </tr>
                    <tr>
                        <th>사진</th>
                        <td><input type="file" name="prodImages" multiple></td>
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
                        <th>카테고리</th>
                        <td>
                            <c:forEach var="category" items="${categoryList}">
                                <input type="radio" value="${category.categoryKey}"
                                       id="categoryInput${category.categoryNm}"
                                       name="categoryKey">
                                <label for="categoryInput${category.categoryNm}"> ${category.categoryNm} </label>
                                <br>
                            </c:forEach>
                        </td>
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

            <div class="product-header">
                <span>제품키</span>
                <span>카테고리</span>
                <span>이름</span>
                <span>가격</span>
                <span>원산지</span>
                <span>제조사</span>
                <span>사진</span>
                <span>수량</span>
            </div>

            <div class="show-products">
                <c:forEach var="product" items="${products}">
                    <div class="each-product">
                            <%-- 제품을 클릭하면 제품 상세 페이지로 이동하도록 할것 --%>
                        <span>${product.prodKey}</span>
                        <span>${product.productCategory.categoryNm}</span>
                        <span>${product.prodName}</span>
                        <span>${product.prodPrice}</span>
                        <span>${product.prodOrigin}</span>
                        <span>${product.prodMaker}</span>
                        <span><img src="/resources/upload/product_images/${product.productImages[0].imgPath}"
                                   alt="${product.productImages[0].imgNm}"></span>
                        <span>${product.prodCnt}</span>
                    </div>
                </c:forEach>
            </div>

        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>
<script>
    $(function () {
        let uploadProductResult = "${uploadProductResult}";
        let manageCategoryResult = "${manageCategoryResult}";

        if (uploadProductResult === "0") {
            window.alert("상품 등록 중 오류가 발생하였습니다");
        }

        if (manageCategoryResult === "1") {
            window.alert("카테고리 등록 성공");
        } else if (manageCategoryResult === "0") {
            window.alert("카테고리 등록 중 오류가 발생하였습니다");
        }
    });

    function manageCategoryFrm() {
        window.location.href = '/admin/manageCategoryFrm.do';
    }
</script>
</body>
</html>

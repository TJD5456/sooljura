<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>manageProducts.jsp</title>
    <style>
        .categoryLevel2, .categoryLevel3 {
            border-top: var(--table-border) 1px solid;
        }

        .second-table {
            margin-top: 50px;
        }

        span {
            display: inline-block;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <div class="title">
                <h1>상품 관리</h1>
            </div>
            <form action="${pageContext.request.contextPath}/admin/uploadProduct.do" method="post"
                  enctype="multipart/form-data" id="uploadForm">
                <table>
                    <tr>
                        <th><label for="nameInput">상품명</label></th>
                        <td><input type="text" id="nameInput" name="prodName" autofocus required></td>
                    </tr>
                    <tr>
                        <th>사진</th>
                        <td><input type="file" name="prodImages" multiple required></td>
                    </tr>
                    <tr>
                        <th><label for="priceInput">가격</label></th>
                        <td><input type="text" id="priceInput" name="prodPrice" required></td>
                    </tr>
                    <tr>
                        <th><label for="makerInput">제조사</label></th>
                        <td><input type="text" id="makerInput" name="prodMaker" required></td>
                    </tr>
                    <tr>
                        <th><label for="originInput">원산지</label></th>
                        <td><input type="text" id="originInput" name="prodOrigin" required></td>
                    </tr>
                    <tr>
                        <th><label for="introInput">소개</label></th>
                        <td>
                            <textarea id="introInput" name="prodIntro" rows="6" cols="50" placeholder="제품 소개 작성 ..."
                                      maxlength="4000" wrap="hard" style="resize: none" required></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="volInput">용량</label></th>
                        <td><input type="text" id="volInput" name="prodVol" required></td>
                    </tr>
                    <tr>
                        <th><label for="proofInput">도수</label></th>
                        <td><input type="text" id="proofInput" name="prodProof" required></td>
                    </tr>
                    <tr>
                        <th><label for="tradeYnInput">거래여부</label></th>
                        <td><input type="text" id="tradeYnInput" name="tradingYn"></td>
                    </tr>
                    <tr class="categoryRow">
                        <th>카테고리</th>
                        <td>
                            <div class="categoryLevel1">
                                <c:forEach var="category" items="${categoryList}">
                                    <c:if test="${category.categoryLevel == 1}">
                                        <span>
                                            <input type="radio" value="${category.categoryKey}"
                                                   id="${category.categoryNm}" name="categoryLevel1" required>
                                            <label for="${category.categoryNm}">${category.categoryNm}</label>
                                        </span>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </td>
                    <tr>
                        <th><label for="cntInput">수량</label></th>
                        <td><input type="text" id="cntInput" name="prodCnt" required></td>
                    </tr>
                    <tr>
                        <th colspan="2">
                            <input type="submit" value="제품 등록">
                            <input type="button" value="카테고리 관리" onclick="manageCategoryFrm()">
                        </th>
                    </tr>
                </table>
            </form>

            <table class="second-table">
                <thead>
                <tr>
                    <th>제품키</th>
                    <th>카테고리</th>
                    <th>이름</th>
                    <th>가격</th>
                    <th>사진</th>
                    <th>수량</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="product" items="${products}">
                    <tr class="product-each">
                            <%-- TODO: 제품을 클릭하면 제품 상세 페이지로 이동하도록 할것 --%>
                        <td>${product.prodKey}</td>
                        <td>${product.productCategory.categoryNm}</td>
                        <td>${product.prodName}</td>
                        <td>${product.prodPrice}</td>
                        <td><img src="/resources/upload/product_images/${product.productImages[0].imgPath}"
                                 alt="${product.productImages[0].imgNm}" style="height: 100px"></td>
                        <td>${product.prodCnt}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>

<script>
    function manageCategoryFrm() {
        window.location.href = '/admin/manageCategoryFrm.do';
    }

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

    $('.categoryLevel1 input[type="radio"]').on('change', function () {
        if ($(this).is(':checked')) {

            let higherCategoryKey = $(this).val();

            $.ajax({
                url: '/admin/selectLowerCategoryLevel.do',
                type: 'get',
                data: {
                    "higherCategoryKey": higherCategoryKey
                },
                success: function (result) {
                    const categoryLevel1Div = $(".categoryLevel1");

                    const existingCategoryLevel2Div = $(".categoryLevel2");
                    if (existingCategoryLevel2Div) {
                        existingCategoryLevel2Div.remove();
                    }

                    const divEl = document.createElement("div");
                    divEl.classList.add("categoryLevel2");

                    for (let i = 0; i < result.length; i++) {
                        let categoryKey = result[i].categoryKey;
                        let categoryNm = result[i].categoryNm;

                        const spanEl = document.createElement("span");

                        const inputEl = document.createElement("input");
                        inputEl.setAttribute("type", "radio");
                        inputEl.setAttribute("value", categoryKey);
                        inputEl.setAttribute("id", categoryNm);
                        inputEl.setAttribute("name", "categoryLevel2");
                        inputEl.setAttribute("required", "");

                        const labelEl = document.createElement("label");
                        labelEl.setAttribute("for", categoryNm);
                        labelEl.innerText = categoryNm;

                        spanEl.appendChild(inputEl);
                        spanEl.appendChild(labelEl);

                        divEl.appendChild(spanEl);
                    }

                    categoryLevel1Div.after(divEl);
                },
                error: function () {
                    console.log("ajax error");
                }
            })
        }
    });

    // Use "document" or another static parent for event delegation
    $(document).on('change', '.categoryLevel2 input[type="radio"]', function () {
        if ($(this).is(':checked')) {
            let higherCategoryKey = $(this).val();

            $.ajax({
                url: '/admin/selectLowerCategoryLevel.do',
                type: 'get',
                data: { "higherCategoryKey": higherCategoryKey },
                success: function (result) {
                    const categoryLevel2Div = $(".categoryLevel2");

                    const existingCategoryLevel3Div = $(".categoryLevel3");
                    if (existingCategoryLevel3Div) {
                        existingCategoryLevel3Div.remove();
                    }

                    const divEl = document.createElement("div");
                    divEl.classList.add("categoryLevel3");

                    for (let i = 0; i < result.length; i++) {
                        let categoryKey = result[i].categoryKey;
                        let categoryNm = result[i].categoryNm;

                        const spanEl = document.createElement("span");

                        const inputEl = document.createElement("input");
                        inputEl.setAttribute("type", "radio");
                        inputEl.setAttribute("value", categoryKey);
                        inputEl.setAttribute("id", categoryNm);
                        inputEl.setAttribute("name", "categoryKey");
                        inputEl.setAttribute("required", "");

                        const labelEl = document.createElement("label");
                        labelEl.setAttribute("for", categoryNm);
                        labelEl.innerText = categoryNm;

                        spanEl.appendChild(inputEl);
                        spanEl.appendChild(labelEl);
                        divEl.appendChild(spanEl);
                    }

                    categoryLevel2Div.after(divEl);
                },
                error: function () {
                    console.log("ajax error");
                }
            });
        }
    });
</script>
</body>
</html>

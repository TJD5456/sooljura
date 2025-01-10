<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>editProd.jsp</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <div class="title">
                <h1>제품 수정</h1>

                <form action="/admin/editProd.do" method="post" enctype="multipart/form-data" id="uploadForm">
                    <input type="hidden" value="${prodKey}" name="prodKey">
                    <table>
                        <tr>
                            <th><label for="nameInput">상품명</label></th>
                            <td><input type="text" id="nameInput" name="prodNm" value="${prod.prodNm}" autofocus
                                       required></td>
                        </tr>
                        <tr>
                            <th>사진</th>
                            <td>
                                <c:forEach var="img" items="${img}">
                                    <img src="/resources/upload/productImages/${img.imgPath}"
                                         alt="${img.imgNm}" style="height: 100px">
                                </c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="priceInput">가격</label></th>
                            <td><input type="text" id="priceInput" name="prodPrice" value="${prod.prodPrice}" required>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="makerInput">제조사</label></th>
                            <td><input type="text" id="makerInput" name="prodMaker" value="${prod.prodMaker}" required>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="originInput">원산지</label></th>
                            <td><input type="text" id="originInput" name="prodOrigin" value="${prod.prodOrigin}"
                                       required></td>
                        </tr>
                        <tr>
                            <th><label for="introInput">소개</label></th>
                            <td>
                            <textarea id="introInput" name="prodIntro" rows="6" cols="50" placeholder="제품 소개 작성 ..."
                                      maxlength="4000" wrap="hard" style="resize: none"
                                      required>${prod.prodIntro}</textarea>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="volInput">용량</label></th>
                            <td><input type="text" id="volInput" name="prodVol" value="${prod.prodVol}" required></td>
                        </tr>
                        <tr>
                            <th><label for="proofInput">도수</label></th>
                            <td><input type="text" id="proofInput" name="prodProof" value="${prod.prodProof}" required>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="tradeYnInput">거래여부</label></th>
                            <td><input type="text" id="tradeYnInput" name="tradingYn" value="${prod.tradingYn}"></td>
                        </tr>
                        <tr class="categoryRow">
                            <th>카테고리</th>
                            <td>
                                <input value="${catNm}" name="oriCat" disabled>
                                <input type="hidden" value="${prod.categoryKey}" name="categoryKey">
                                <div class="categoryLevel1">
                                    <c:forEach var="category" items="${catList}">
                                        <c:if test="${category.categoryLevel == 1}">
                                        <span class="category-span">
                                            <input type="radio" value="${category.categoryKey}"
                                                   id="${category.categoryNm}" name="categoryLevel1">
                                            <label for="${category.categoryNm}">${category.categoryNm}</label>
                                        </span>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </td>
                        <tr>
                            <th><label for="cntInput">수량</label></th>
                            <td><input type="text" id="cntInput" name="prodCnt" value="${prod.prodCnt}" required></td>
                        </tr>
                        <tr>
                            <th colspan="2">
                                <input type="submit" value="제품 수정">
                                <input type="button" value="카테고리 관리" onclick="manageCategoryFrm()">
                            </th>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>

<script>
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
                        spanEl.setAttribute("class", "category-span");

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
                data: {"higherCategoryKey": higherCategoryKey},
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
                        spanEl.setAttribute("class", "category-span");

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

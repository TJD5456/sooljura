<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>manageYoutube.jsp</title>
    <style>
        .currentYoutube {
            display: block;
        }

        [type="button"] {
            display: block;
            margin: 3px auto;
            width: 28%;
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
                <h1>유튜브관리 페이지</h1>
            </div>
            <form action="${pageContext.request.contextPath}/admin/uploadYoutube.do" method="get">
                <table>
                    <tr>
                        <th><label for="urlInput">유튜브 URL</label></th>
                        <td><input type="text" name="youtubeUrl" id="urlInput"></td>
                    </tr>
                    <tr>
                        <th><label for="contentInput">제품 설명</label></th>
                        <td>
                            <textarea id="contentInput" name="content" rows="6" cols="50" placeholder="유튜브 소개 작성 ..."
                                      maxlength="4000" wrap="hard" style="resize: none" required></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="prodKey1">제품 1 등록</label></th>
                        <td>
                            <input type="text" class="searchProductName" id="prodKey1">
                            <input type="hidden" name="prodKey1">
                        </td>
                    </tr>
                    <tr>
                        <th><label for="prodKey2">제품 2 등록</label></th>
                        <td>
                            <input type="text" class="searchProductName" id="prodKey2">
                            <input type="hidden" name="prodKey2">
                        </td>
                    </tr>
                    <tr>
                        <th><label for="prodKey3">제품 3 등록</label></th>
                        <td>
                            <input type="text" class="searchProductName" id="prodKey3">
                            <input type="hidden" name="prodKey3">
                        </td>
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

    <script>
        $(".searchProductName").on("keyup", function () {
            const $thisInput = $(this);
            const $thisInputId = $thisInput.attr("id");

            if ($thisInput.val() !== "") {
                let currentInputValue = $thisInput.val();

                $.ajax({
                    url: "/admin/searchProductName.do",
                    type: "get",
                    data: {
                        "currentInputValue": currentInputValue
                    },
                    success: function (result) {
                        let existingDiv = $thisInput.parent().find(".search-result-div");
                        if (existingDiv.length > 0) {
                            existingDiv.remove();
                        }

                        if (result.length > 0) {
                            const divEl = document.createElement("div");
                            divEl.classList.add("search-result-div");

                            for (let i = 0; i < result.length; i++) {
                                let prodNm = result[i].prodNm;
                                let prodKey = result[i].prodKey;

                                const inputEl = document.createElement("input");
                                inputEl.setAttribute("type", "button");
                                inputEl.setAttribute("name", prodKey);
                                inputEl.setAttribute("value", prodNm);
                                inputEl.setAttribute("onclick", "insertKeyToInput(this, '" + $thisInputId + "')");
                                inputEl.setAttribute("readonly", "readonly");

                                divEl.appendChild(inputEl);
                            }

                            $thisInput.after(divEl);

                        } else {
                            console.log("일치하는 상품이 없습니다");
                        }
                    },
                    error: function () {
                        console.log("ajax error");
                    },
                });
            } else {
                let existingDiv = $thisInput.parent().find(".search-result-div");
                if (existingDiv.length > 0) {
                    existingDiv.remove();
                }
            }
        });

        function insertKeyToInput(obj, inputId) {
            // obj.name  : prodKey
            // obj.value : prodNm
            let prodKey = obj.name;
            let prodName = obj.value;

            console.log("product key: " + prodKey);
            console.log("product name: " + prodName);

            // 1) 검색창(텍스트 필드)에 prodNm(상품명) 표시
            document.getElementById(inputId).value = prodName;

            // 2) 폼 전송용 숨긴 필드(또는 별도의 input)에 prodKey(상품키) 세팅
            //    name 속성이 inputId와 같은 요소가 존재한다고 가정
            document.getElementsByName(inputId)[0].value = prodKey;
        }
    </script>
</main>
</html>

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

        input, textarea {
            padding: 4px;
        }

        input {
            margin-right: 4px;
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
                <h1>유튜브 관리 페이지</h1>
            </div>
            <form action="/admin/updateYoutube.do" method="get">
                <table>
                    <tr>
                        <th><label for="iframeInput">유튜브 URL</label></th>
                        <td>
                            <textarea id="iframeInput" rows="8" cols="50"
                                      placeholder="YouTube -> Share -> Embed 에서 값을 가져오시오" required></textarea>
                            <input type="hidden" name="youtubeUrl" id="youtubeUrl">
                        </td>
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
                        <th colspan="2">
                            <input type="submit" onclick="extractIframeSrc()" value="YouTube 등록">
                            <input type="button" class="youtubeDelBtn" value="YouTube 삭제">
                        </th>
                    </tr>
                </table>
            </form>
            <jsp:include page="/WEB-INF/views/common/youtube.jsp"/>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

    <script>
        $('.youtubeDelBtn').on('click', function () {
            $.ajax({
                    url: '/admin/delYt.do',
                    type: 'get',
                    success() {
                        window.alert("유튜브가 삭제 되었습니다");
                    },
                    error(res) {
                        window.alert("error: " + res);
                    }
                }
            )
        })

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
            let prodKey = obj.name;
            let prodName = obj.value;

            $('#' + inputId).val(prodName);
            $('input[name="' + inputId + '"]').val(prodKey);
        }

        function extractIframeSrc() {
            const iframeCode = document.getElementById('iframeInput').value;
            const pattern = /src="([^"]+)"/;
            const match = iframeCode.match(pattern);

            if (match) {
                const extractedSrc = match[1];
                console.log("Extracted src:", extractedSrc);

                $("#youtubeUrl").val(extractedSrc);

                const resultEl = document.getElementById('result');
                if (resultEl) {
                    resultEl.textContent = extractedSrc;
                }
            } else {
                console.log("No src found.");

                const resultEl = $('#result');
                if (resultEl) {
                    resultEl.textContent = 'No src found.';
                }
            }
        }
    </script>
</main>
</html>

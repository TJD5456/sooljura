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
                        <th><label for="prodKeyInput1">제품 1 등록</label></th>
                        <td><input type="text" name="prodKey1" class="searchProductName" id="prodKeyInput1"></td>
                    </tr>
                    <tr>
                        <th><label for="prodKeyInput2">제품 2 등록</label></th>
                        <td><input type="text" name="prodKey2" class="searchProductName" id="prodKeyInput2"></td>
                    </tr>
                    <tr>
                        <th><label for="prodKeyInput3">제품 3 등록</label></th>
                        <td><input type="text" name="prodKey3" class="searchProductName" id="prodKeyInput3"></td>
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
            let currentInputValue = $(this).val();

            $.ajax({
                url: "/admin/searchProductName.do",
                type: "get",
                data: {
                    "currentInputValue": currentInputValue
                },
                success: function (result) {
                    if (result.length > 0) {
                        let prodNm = result[0].prodNm;
                        let prodKey = result[0].prodKey;

                        

                    } else if (result.length === "0") {
                        let searchResult = "일치하는 상품이 없습니다"
                    }
                },
                error: function () {
                    console.log("ajax error");
                },
            })

            console.log(currentInputValue);
        })
    </script>
</main>
</html>

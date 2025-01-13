<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>manageCategory.jsp</title>
    <style>
        input {
            padding: 4px;
        }

        .catSelRes {
            margin-top: 4px;
            padding: 4px;
            border: 1px solid var(--table-border);
            border-radius: 4px;
            background-color: var(--table-th-background);
        }

        #higherCategoryInput {
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
            <form action="/admin/manageCategory.do" method="get">
                <table>
                    <tr>
                        <th><label for="categoryNmInput">카테고리 이름</label></th>
                        <td><input type="text" name="categoryNm" id="categoryNmInput"></td>
                    </tr>
                    <tr>
                        <th><label for="higherCategoryInput">상위 카테고리</label></th>
                        <td class="higherCat"><input type="text" id="higherCategoryInput" placeholder="상위 카테고리 검색">
                            <input type="hidden" id="higherCategoryKey" name="higherCategory">
                        </td>
                    </tr>
                    <tr>
                        <th><label for="categoryLevelInput">카테고리 레벨</label></th>
                        <td><input type="text" value="1" name="categoryLevel" id="categoryLevelInput" disabled></td>
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

<script>
    $('#higherCategoryInput').on("keyup", function () {
        const catNm = $("#higherCategoryInput").val();

        $.ajax({
            url: "/admin/selHigherCat.do",
            data: {
                "catNm": catNm
            },
            success(res) {
                addQueryResultEl(res);
            },
            error() {
                console.log("failed to retrieve higher category");
            }
        })
    })

    function addQueryResultEl(res) {
        const prevRes = $('.catSelRes');
        if (prevRes.length) {
            prevRes.remove();
        }

        const higherCat = $('.higherCat');

        for (let i = 0; i < res.length; i++) {
            let catKey = res[i].categoryKey;
            let catNm = res[i].categoryNm;
            let catLevel = res[i].categoryLevel;

            let catDiv = $("<div>")
                .addClass("catSelRes")
                .attr("id", catKey)
                .attr("onclick", "handleClick(this)")
                .attr("data-catNm", catNm)
                .attr("data-catLevel", catLevel)
                .text(catNm);

            higherCat.append(catDiv);
        }
    }

    function handleClick(obj) {
        let catNm = obj.getAttribute("data-catNm");
        let catKey = obj.getAttribute("id");
        let catLevel = obj.getAttribute("data-catLevel");

        $("#higherCategoryInput").val(catNm);
        $("#higherCategoryKey").val(catKey);
        $("#categoryLevelInput").val(+catLevel + 1);
    }
</script>
</body>
</html>

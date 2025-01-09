<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Web scraper</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        button {
            margin-top: 20px;
            padding: 10px;
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
                <h1>DB 저장용 scraper</h1>
            </div>

            <p>
                웹 스크래퍼 구동 중 server 모듈 auto reloading 끌것.<br>
                스크래퍼 구동중 서버 재시작 되면 에러나고 종료되어,<br>
                DB 에있던 정보 삭제하고 재실행 해야함<br>

                만약 에러난 경우<br>
                seq_product<br>
                seq_product_image<br>
                두 시퀀스 초기화하고 사용<br>

                스크랩 및 db insert 가 모두 끝났다면, 추가된 행은 모두 378개, <br>
                마지막 제품명 대만 마오타이(마우타이) (VAT 별도) 임 <br>
                server 모듈 auto reloading 다시 켜줄것<br>
            </p>

            <button id="webScraper">스크래퍼 실행</button>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>

<script>
    $('#webScraper').on('click', function () {
        $.ajax({
            url: "/webScraping/scrapingTest.do",
            error: function () {
                console.log(
                    "code:" + request.status + "\n" +
                    "message:" + request.responseText + "\n" +
                    "error:" + error);
            }
        });
    });
</script>
</body>
</html>

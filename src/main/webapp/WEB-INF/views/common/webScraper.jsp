<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>db저장용 webscraper</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<h1>db저장용 webscraper</h1>
<hr>
<h3>
    웹 스크래퍼 구동 중 server 모듈 auto reloading 끌것. 스크래퍼 구동중 서버 재시작 되면 에러나고 종료되어,
    db있던 정보 삭제하고 재실행 해야함;

    만약 에러난 경우..
</h3>
<pre>
		--sql 구문

		drop sequence seq_product;
		drop sequence seq_product_image;

		create sequence seq_product maxvalue 9999 cycle;
		create sequence seq_product_image maxvalue 9999 cycle;

		commit;	
	</pre>
<h3>
    시퀀스 초기화를 위해 사용할 것
</h3>
<hr>
<h3>
    추가 : <br>
    db에 저장될 경로 는 /resources/productImage/categoryKey_fileName_fileSize.jpg 와 같음<br>
    resource 하위 productImage폴더 필요!!! <br>
    웹스크래퍼가 폴더를 만들어 주지 않으니 꼭 폴더 생성해 줄것.<br>
    WebScraperService 내 //TODO로 작성한 주석 밑 localSave 값 변경으로 <br>
    제품 사진들이 저장될 하위 경로 지정 필요!!!<br>
    <br>
    String localSave = "C:/이 공간/sooljura/src/main/webapp/resources/productImage/";<br>
    이 공간 을 본인의 sooljura 폴더 상위폴더 명으로 대체할것<br>
</h3>
<button id="webscraper">스크래퍼 작동</button>

<h4>
    스크래핑 및 db insert가 모두 끝났다면, 추가된 행은 모두 378개, 마지막 제품명 대만 마오타이(마우타이) (VAT별도) 임


    server 모듈 auto reloading 다시 켜줄것.
</h4>

<script>
    $('#webscraper').on('click', function () {
        $.ajax({
            url: "/webScraping/scrapingTest.do",
            success: function () {
            },
            error: function () {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });
    });
</script>
</body>
</html>
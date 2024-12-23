<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<button id="webscraper">더보기1</button>
	<script>
	$('#webscraper').on('click', function(){
		$.ajax({
			url : "/webScraping/scrapingTest.do",
			success : function(){
			},
			error : function(){
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       
			}
		});
	});
	</script>
</body>
</html>
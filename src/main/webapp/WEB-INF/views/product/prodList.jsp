<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품페이지</title>
<link rel="icon" href="/resources/icons/logo-circle-woText-16px-favicon.png">
<style>
.prodList{
	margin-left: 100px;
}

.prodUlList{
	display: flex;
	flex-wrap: wrap;
}

.prodLi {
	list-style: none;
	margin-right: 30px;
	margin-top: 30px;
	width: 300px;
	height: 314px;
}

table{
	background-color: white;
}

td {
    width: 200px;       /* td 요소에 명시적으로 크기를 제한 */
    text-align: center; /* 가운데 정렬 옵션 */
}

.prodName {
	width: 100%;             /* 부모 요소의 크기 설정 */
   	white-space: nowrap;     /* 텍스트를 한 줄로 표시 */
   	overflow: hidden;        /* 넘치는 텍스트를 숨김 */
  	text-overflow: ellipsis; /* 숨겨진 부분에 "..." 표시 */
    display: inline-block;   /* 텍스트가 차지할 수 있는 공간 유지 */
    max-width: 200px;        /* 텍스트 길이에 제한 설정 */
}

.select-order {
    /*제일 오른쪽 아이템의 오른쪽 모서리에 select 태그의 오른쪽 모서리가 정렬되도록*/
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	<main>
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<div class="wrapper">
			<div class="content">
                <div class="title">
                    <h1>${listTitle}</h1>
                </div>
                <div class="prodList">
					<div class="select-order">
						<select name="sorting" class="sorting">
							<option value="0">선택</option>
							<option value="1">가나다순</option>
							<option value="2">가격순</option>
						</select>
					</div>
					<ul class="prodUlList">
						<c:forEach var="prod" items="${prodlist}">
							<li class="prodLi">
								<table>
									<tr>
										<td><a href="/product/prodDetail.do?prodKey=${prod.prodKey}"><img alt="${prod.prodNm}" width="150px" height="200px" src="/resources/upload/productImages/${prod.imgPath}"></a></td>
									</tr>
									<tr>
										<td><div class="prodName"> ${prod.prodNm} </div></td>
									</tr>
									<tr>
										<td><fmt:formatNumber value="${prod.prodPrice}" type="number" pattern="#,###"/>원</td>
									</tr>
								</table>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<jsp:include page="/WEB-INF/views/common/remote.jsp" />
		</div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	</main>

	<script>
		$('.sorting').on('change', function(){
			const sort = $('.sorting').val();	
			console.log(sort);
			location.href="/product/productList.do?categoryKey="+`${prodCate}`+"&sort="+sort;
		});
		
		$(function() {
			// 현재 URL 의 파라미터에서 `sort` 값을 가져옴
			const urlParams = new URLSearchParams(window.location.search);
			const currentSort = urlParams.get('sort');
			if (currentSort) {
				$('.sorting').val(currentSort);
			}
		});
	</script>
</body>
</html>
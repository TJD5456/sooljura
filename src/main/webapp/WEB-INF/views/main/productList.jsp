<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
.list-wrap {
	margin-left: 150px;
	margin-right: 150px;
}

.prodUlList {
	display: flex;
	flex-wrap: wrap;
	margin-bottom: 30px;
}
.prodList{
	margin-top: 15px;
	margin-bottom: 15px;
}
.prodLi {
	list-style: none;
	width: 200px;
	margin-right: 50px;
}

table {
	background-color: white;
}

.prodLi>table>tr td {
	width: 200px;
	text-align: center;
}

.prodName {
	width: 200px;
	white-space: nowrap; /* 텍스트를 한 줄로 표시 */
	overflow: hidden; /* 넘치는 텍스트를 숨김 */
	text-overflow: ellipsis; /* 숨겨진 부분에 "..." 표시 */
	display: inline-block; /* 텍스트가 차지할 수 있는 공간 유지 */
}
</style>
<div class="bannerDiv1">
	<img alt="" src="/resources/sooljura-banner/mainPageBanner_01.webp">
</div>		
<c:if test="${chkYt != 'empty'}">
    <jsp:include page="/WEB-INF/views/common/youtube.jsp" />
</c:if>
<div class="list-wrap">
	<div class="prodList wineList">
	<span>추천 와인</span>
	<a href="/product/productList.do?categoryKey=c0001&sort=0"> <img alt="" src="/resources/icons/plus_더보기_169.png" width="15px"> </a>
		<ul class="prodUlList">
			<c:forEach var="prod" items="${wineProdList}">
				<li class="prodLi">
					<table>
						<tr>
							<td><a href="/product/prodDetail.do?categoryKey=c0001&prodKey=${prod.prodKey}"><img
									alt="" width="150px" height="200px"
									src="/resources/upload/productImages/${prod.imgPath}"></a></td>
						</tr>
						<tr>
							<td><div class="prodName">${prod.prodNm}</div></td>
						</tr>
						<tr>
							<td><fmt:formatNumber value="${prod.prodPrice}"
									type="number" pattern="#,###" />원</td>
						</tr>
					</table>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div class="prodList brandyList">
	<span>추천 브랜디</span>
	<a href="/product/productList.do?categoryKey=c0003&sort=0"><img alt="" src="/resources/icons/plus_더보기_169.png" width="15px"></a>
		<ul class="prodUlList">
			<c:forEach var="prod" items="${brandyProdList}">
				<li class="prodLi">
					<table>
						<tr>
							<td><a href="/product/prodDetail.do?categoryKey=c0003&prodKey=${prod.prodKey}"><img
									alt="" width="150px" height="200px"
									src="/resources/upload/productImages/${prod.imgPath}"></a></td>
						</tr>
						<tr>
							<td><div class="prodName">${prod.prodNm}</div></td>
						</tr>
						<tr>
							<td><fmt:formatNumber value="${prod.prodPrice}"
									type="number" pattern="#,###" />원</td>
						</tr>
					</table>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div class="prodList whiskeyList">
	<span>추천 위스키</span>
	<a href="/product/productList.do?categoryKey=c0002&sort=0"><img alt="" src="/resources/icons/plus_더보기_169.png" width="15px"></a>
		<ul class="prodUlList">
			<c:forEach var="prod" items="${whiskeyProdList}">
				<li class="prodLi">
					<table>
						<tr>
							<td><a href="/product/prodDetail.do?categoryKey=c0002&prodKey=${prod.prodKey}"><img
									alt="" width="150px" height="200px"
									src="/resources/upload/productImages/${prod.imgPath}"></a></td>
						</tr>
						<tr>
							<td><div class="prodName">${prod.prodNm}</div></td>
						</tr>
						<tr>
							<td><fmt:formatNumber value="${prod.prodPrice}"
									type="number" pattern="#,###" />원</td>
						</tr>
					</table>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div class="prodList liqueurList">
	<span>추천 리큐르</span>
	<a href="/product/productList.do?categoryKey=c0004&sort=0"><img alt="" src="/resources/icons/plus_더보기_169.png" width="15px"></a>
		<ul class="prodUlList">
			<c:forEach var="prod" items="${liqueurProdList}">
				<li class="prodLi">
					<table>
						<tr>
							<td><a href="/product/prodDetail.do?categoryKey=c0004&prodKey=${prod.prodKey}"><img
									alt="" width="150px" height="200px"
									src="/resources/upload/productImages/${prod.imgPath}"></a></td>
						</tr>
						<tr>
							<td><div class="prodName">${prod.prodNm}</div></td>
						</tr>
						<tr>
							<td><fmt:formatNumber value="${prod.prodPrice}"
									type="number" pattern="#,###" />원</td>
						</tr>
					</table>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div class="prodList sojuList">
	<span>추천 전통주</span>
	<a href="/product/productList.do?categoryKey=c0005&sort=0"><img alt="" src="/resources/icons/plus_더보기_169.png" width="15px"></a>
		<ul class="prodUlList">
			<c:forEach var="prod" items="${sojuProdList}">
				<li class="prodLi">
					<table>
						<tr>
							<td><a href="/product/prodDetail.do?categoryKey=c0005&prodKey=${prod.prodKey}"><img
									alt="" width="150px" height="200px"
									src="/resources/upload/productImages/${prod.imgPath}"></a></td>
						</tr>
						<tr>
							<td><div class="prodName">${prod.prodNm}</div></td>
						</tr>
						<tr>
							<td><fmt:formatNumber value="${prod.prodPrice}"
									type="number" pattern="#,###" />원</td>
						</tr>
					</table>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div class="prodList etcList">
	<span>추천 기타주류</span>
	<a href="/product/productList.do?categoryKey=c0006&sort=0"><img alt="" src="/resources/icons/plus_더보기_169.png" width="15px"></a>
		<ul class="prodUlList">
			<c:forEach var="prod" items="${etcProdList}">
				<li class="prodLi">
					<table>
						<tr>
							<td><a href="/product/prodDetail.do?categoryKey=c0006&prodKey=${prod.prodKey}"><img
									alt="" width="150px" height="200px"
									src="/resources/upload/productImages/${prod.imgPath}"></a></td>
						</tr>
						<tr>
							<td><div class="prodName">${prod.prodNm}</div></td>
						</tr>
						<tr>
							<td><fmt:formatNumber value="${prod.prodPrice}"
									type="number" pattern="#,###" />원</td>
						</tr>
					</table>
				</li>
			</c:forEach>
		</ul>
	</div>
	<%--
		<c:forEach var="prod" items="${list}">
			<li class="prodLi">
				<table>
					<tr>
						<td><a href="/product/prodDetail.do?prodKey=${prod.prodKey}"><img alt="" width="150px" height="200px" src="/resources/upload/productImages/${prod.imgPath}"></a></td>
					</tr>
					<tr>
						<td><div class="prodName">${prod.prodNm}</div></td>
					</tr>
					<tr>
						<td><fmt:formatNumber value="${prod.prodPrice}" type="number"
								pattern="#,###" />원</td>
					</tr>
				</table>
			</li>
		</c:forEach>
		 --%>

</div>
<script>
	$('.sorting').on('change', function() {
		const sort = $('.sorting').val();
		console.log(sort);
	});

	$(document).ready(function() {
		// 현재 URL의 파라미터에서 `sort` 값을 가져옴
		/*
		const urlParams = new URLSearchParams(window.location.search);
		const currentSort = urlParams.get('sort');
		if (currentSort) {
			$('.sorting').val(currentSort);
		}
		 */
	});
</script>
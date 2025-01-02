<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.content{	
	display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
.goodsBox {
	display: flex;
}
.goodsImg>img{
	border: 1px solid black;
}
.tbl {
	width: 800px;
	margin-left: 15px;
}
.btns{
	display: flex;
	justify-content: center;
    margin-left: 15px;
}
button{
	height: 70px;
	width: 370px;
	margin: 15px;
}
.prodIntro{
	width: 1177px;
	
}
.prodIntro>table{
	margin: 0;
	width: 100%;
	max-width: 100%;
	border: none;
   
}
.prodIntro>table tr:first-of-type td:first-of-type, tr:first-of-type td:nth-of-type(3) {
	background-color: #ff6650 !important;
	
}
.prodIntro>table tr:first-of-type td:nth-of-type(2) {
	background-color: #fc8173;
	width: 70m0px;
}

.prodIntro>table{
	background-color: rgb(227, 227, 227);
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	<main>
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<div class="wrapper">
			<div class="content">
				<div class="goodsBox">
					<!-- 상품이미지 미리보기 시작 { -->
					<div class="goodsLeft">
						<div class="goodsImg">
							<img src="${prodImg.imgPath}" width="360" height="480"alt="" title="">
						</div>
					</div>
					<!-- } 상품이미지 미리보기 끝 -->
					<!-- 상품 요약정보 및 구매 시작 { -->
					<section class="goods_detail">
						<div>
							<table class="tbl">
								<colgroup>
									<col style="width: 100px" />
									<col style="width: 100px;" />
									<col style="width: 100px" />
									<col style="width: 100px;" />
								</colgroup>
								<tbody>
									<tr>
										<th colspan="4">
											<span class="good_tit1">${prod.prodNm}</span>
										</th>
									</tr>
									<tr>
										<th><span>원산지</span></th>
										<td><span>${prod.prodOrigin}</span></td>
										<th><span>제조사</span></th>
										<td><span>${prod.prodMaker}</span></td>
									</tr>
									<tr>
										<th><span>용량</span></th>
										<td><span>${prod.prodVol}</span></td>
										<th><span>알콜도수</span></th>
										<td><span>${prod.prodProof}</span></td>
									</tr>
									<tr>
										<th align="left">수량</th>
										<td colspan="3"><input type="number" min="1" max="${prod.prodCnt}" value="" id="prodCnt" inputmode="numeric" onkeydown="return false;"></td>
									</tr>
									<tr>
										<th>소비자가격</th>
										<td colspan="3"><span>${priceWithComma}원</span></td>
									</tr>

									<tr>
										<th>할인가</th>
										<td colspan="3"><span>...원</span></td>
									</tr>
									<tr>
										<th>결제가</th>
										<td colspan="3"><span>...원</span></td>
									</tr>
									<tr>
										<th><font size="4"><strong>금액</strong></font></th>
										<td colspan="3"><font size="5" color="red">188,000원<strong></strong></font>
										</td>
									</tr>
								</tbody>
							</table>
					<div class="btns">
						<div>
							<button>찜하기</button>
						</div>
						<div>
							<button>장바구니</button>
						</div>
					</div>
						</div>
					</section>
				</div>
					<div class="prodIntro">
						<table>
							<tr> 
								<td></td>
								<td>
									<span>상품 설명</span>
								</td>
								<td></td>
							</tr>
							<tr> 
								<td></td>
								<td>
									<span>${prod.prodIntro}</span>
								</td>
								<td></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<jsp:include page="/WEB-INF/views/common/remote.jsp" />
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</main>
	<script>
		$('#prodCnt').on('click', function(){
			const prodCntVal = $('#prodCnt').val();
			console.log(prodCntVal);
			
		});
	</script>
</body>
</html>
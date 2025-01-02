<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${prod.prodNm}</title>
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
#prodCnt{
	width: 100px;
	text-align: center;
	font-size: 18px;
	background-color: #F9F9F9;
	border: none;
}
#prodCnt:focus{
	outline: none;
}
button{
	height: 70px;
	width: 370px;
	margin: 15px;
}
.cntBtn{
	margin: 0;
	height: 20px;
	width: 20px;
	margin-bottom: 2px;
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
	width: 700px;
}

.prodIntro>table{
	background-color: rgb(227, 227, 227);
}
.finalPrice span{
	font-size: 24px;
	color: red;
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
											<input type="hidden" id="prodKey" value="${prod.prodKey}">
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
										<td colspan="3">
											<%--<button class="cntBtn" id="cntBtnDown">-</button> --%>
											<input type="number" value="1" min="1" max="${prod.prodCnt}" id="prodCnt" inputmode="numeric" onkeydown="return false;">
											<%--<button class="cntBtn" id="cntBtnUp">+</button> --%>
										</td>
									</tr>
									<tr>
										<th>소비자가격</th>
										<td colspan="3"><span>${priceWithComma}원</span></td>
									</tr>

									<tr>
										<th>할인가/율</th>
										<c:if test="${pOrA eq 1}">
											<td colspan="3"><span>${dcPrice}&#37;</span></td>
										</c:if>
										<c:if test="${pOrA eq 0}">
											<td colspan="3"><span>${dcPrice}&#37;</span></td>
										</c:if>
									</tr>
									<tr>
										<th>결제가</th>
										<td colspan="3" class="payPrice">
										<c:if test="${pOrA eq 1}">
											<span>${payPrice}원</span>
										</c:if>
										<c:if test="${pOrA eq 0}">
											<span>${payPrice}원</span>
										</c:if>
									</tr>
									<tr>
										<th>
											<font size="4">
												<strong>금액</strong>
											</font>
										</th>
										<td colspan="3"  class="payPrice finalPrice">
											<c:if test="${pOrA eq 1}">
												<span>${payPrice}원</span>
											</c:if>
											<c:if test="${pOrA eq 0}">
												<span>${payPrice}원</span>
											</c:if>
										</td>
									</tr>
								</tbody>
							</table>
					<div class="btns">
						<div>
							<button id="likedProd">찜하기</button>
						</div>
						<div>
							<button id="prodBasket">장바구니</button>
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
		$('#cntBtnUp').on('click', function(){
			var currentValue = parseInt($('#prodCnt').val()) || 0;
		    $('#prodCnt').val(currentValue + 1);
		});
		$('#cntBtnDown').on('click', function(){
			var currentValue = parseInt($('#prodCnt').val()) || 0;
		    $('#prodCnt').val(currentValue - 1);
		});
		$('#prodCnt').on('change', function(){
			const prodCntVal = $(this).val();
			const prodKey = $('#prodKey').val();
			console.log(prodCntVal);
			$.ajax({
                url: '/product/productDcCnt',
                type: 'post',
                data: {
                	"prodCntVal": prodCntVal,
                	"prodKey": prodKey,
                },
                dataType: "text",
                success: function (res) {
                    const totalPrice = "<span>"+res+"원</span>";
                	$('.payPrice').empty();
                	$('.payPrice').html(totalPrice);
                	
                },
                error: function () {
					console.log("ajax오류");                	
                }
            });
		});
		
		$('#likedProd').on('click', function(){
			const prodCntVal = $('#prodCnt').val();
			const totalPrice = $('.payPrice').find('span').html();	
			
			console.log("찜하기 prodCount : " + prodCntVal + "| totalPrice : " + totalPrice)
		});
		
		$('#prodBasket').on('click', function(){
			const prodCntVal = $('#prodCnt').val();
			const totalPrice = $('.payPrice').find('span').html();	
			
			console.log("장바구니 prodCount : " + prodCntVal + "| totalPrice : " + totalPrice)
		});
	</script>
</body>
</html>
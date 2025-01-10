<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>술주라</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<style>
	.userInfo{
		display: none;
	}
    .myPageChoices {
        width: 700px;
        margin: 0 auto;
        display: flex;
        justify-content: center;
    }

    .myPageInfoView {
        height: 800px;
    }

    .myPageChoiceBtn {
        width: 500px;
        height: 50px;
        margin: 15px;
        font-size: 20px;
        font-weight: bold;
    }

    .myPageInfoView {
        display: none;
    }

    .tblUserInfo > tbody > tr > th {
        text-align: left;
    }

    .tblUserInfo > tbody > tr > td > input {
        width: 100%;
        height: 50px;
        border: 1px solid gray;
        border-radius: 15px;
        padding-left: 15px;
        box-sizing: border-box;
    }

    .pwChgBtn > * {
        margin-left: 5px;
        margin-right: 5px;
    }

    #userPwChg > table > tbody > tr > th {
        text-align: left;
    }

    #userPwChg > table > tbody > tr > td > input {
        width: 275px;
        height: 30px;
        border: 1px solid gray;
        border-radius: 10px;
        padding-left: 15px;
        box-sizing: border-box;
    }

    #userPwMod > ul {
        list-style-type: none;
    }

    #userPwMod > ul > li {
        list-style-type: none;
    }
</style>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <div class="title">
                <h1>마이 페이지</h1>
            </div>

            <div class="myPageChoices">
					<button class="myPageChoiceBtn" value="1" id="userInfo">회원 정보</button>
					<button class="myPageChoiceBtn" value="2" id="shoppingInfo">구매 내역</button>
					<button class="myPageChoiceBtn" value="3" id="readMyPost">내글 보기</button>
					<button class="myPageChoiceBtn" value="4" id="likedItems">찜한상품</button>
					<button class="myPageChoiceBtn" value="5" id="addrMng">주소 관리</button>
				</div>
            <div class="myPageInfoView">
            </div>
            <div class="userInfo">
            	<jsp:include page="/userMyPage/userInfo.do"></jsp:include>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>

<script>
$('.myPageChoiceBtn').on('click', function(){
	let i = parseInt($(this).val(), 10);
	
	// 현재 페이지 URL 가져오기
	const url = window.location.href;// URL 객체 생성
	const urlParams = new URLSearchParams(new URL(url).search);// 특정 파라미터 값 가져오기 (예: 'id' 파라미터)
	const paramValue = urlParams.get('pg');
	
	switch (i) {
	case 1:
		location.href="userInfo.do";
		break;
	case 2:
		location.href="/product/buyList.do?reqPage=1&userKey=${loginUser.userKey}";
		break;
	case 3:
		    const form = document.createElement('form');
		    form.method = 'POST';
		    form.action = '/post/readMyPost.do';

		    const input = document.createElement('input');
		    input.type = 'hidden';
		    input.name = 'userKey';
		    input.value = '${loginUser.userKey}';
		    form.appendChild(input);

		    document.body.appendChild(form);
		    form.submit(); // 서버로 POST 요청 전송 및 페이지 이동
		
		break;
	case 4:
		location.href="/userMyPage/likedProdList.do";//?
		break;
	case 5:
		location.href="/user/addrListFrm.do";
		break;
	default:
		break;
	}
	
})
/*
    function toggleView(button) {
        // 값 불러올 수 있도록 펑션 설계
        // 해당 값에 맞는 페이지로 location.href 써서 보내줄것임
        // 불필요하다 생각되면 말해주세요
        const endPoints = {
            userInfo: "/userMyPage/userInfo.do",
            shoppingInfo: "/userMyPage/shoppingInfo.do",
            readMyPost: "/userMyPage/readMyPost.do",
            likedMerc: "/userMyPage/likedMerc.do"
        };
        const selected = $(button).attr('id');
        const url = endPoints[selected];

        if (!url) {
            console.error("Invalid selection:", selected);
            return;
        }

        $('.myPageInfoView').hide(); // 기존 뷰 숨기기

        console.log("버튼 클릭됨");

        $.ajax({
            url: url,
            type: "get",
            success: function (res) {
                $('.myPageInfoView').html(res).show();
            },
            error: function () {
                console.error('AJAX 오류 발생.');
                $('.myPageInfoView').html('<p>정보를 가져오는 데 실패했습니다.</p>').show();
            }
        });
    }
    */
    // ========== userInfo.jsp 의 function ==========
    function pwChk() {
        $('#myPageInfoView').on('input', '#userPw', function () {
            const regExp = /^[a-zA-Z0-9!@#$%^&*]{8,16}$/;
            const userPwVal = $('#userPw').val();

            if (userPw != regExp) {

            }
        });
    }

    function pwChk() {
        //비밀번호체크
        let newUserPw = $('#userUpdPw').val();
        console.log(newUserPw);
        let newUserPwChk = $('#userUpdPwChk').val();
        console.log(newUserPwChk);
        if (newUserPw != newUserPwChk) {
            console.log("pw-chk-error");
            $('#pwUnMatchSpan').html('비밀번호가 일치하지 않습니다.').css('color', 'red');
        } else {
            $('#pwUnMatchSpan').html('비밀번호가 일치합니다.').css('color', 'green');
        }
    }

    $(function () {
    	
        $('.myPageInfoView').on('click', '#pwChgBtn', function () {
            console.log("button clicked");
            $('#userPwChg').toggle();
        });

        $('.myPageInfoView').on('click', '#pwChgMod', function () {
            $('#userPwMod').toggle();
        });

        $('.myPageInfoView').on('click', '#userInfoUpd', function () {

            console.log("foobar");

            $.ajax({
                url: "/userMyPage/userInfoUpd",
                type: "post",
                data: {
                    string: "123123123"
                },
                dataType: "text",
                success: function (res) {
                    alert("회원정보 변경 완료");
                },
                error: function () {
                    console.log('ajax 오류');
                }
            });
        });
    });

    function addrInfo() {
        location.href = "/user/addrListFrm.do";
    }
</script>
</body>
</html>

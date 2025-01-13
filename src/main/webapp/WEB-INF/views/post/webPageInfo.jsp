<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>술주라</title>
    <link rel="icon" href="/resources/icons/logo-circle-woText-16px-favicon.png">
    <style>
        .close-content {
            display: flex;
            justify-content: center; /* 가로 중앙 정렬 */
            align-items: center; /* 세로 중앙 정렬 */
            padding: 20px;
        }

        .close-message {
            font-weight: bold;
            text-align: center;
            font-size: 20px;
            line-height: 1.6;
            white-space: pre-line; /* 줄바꿈을 위해 pre-line 사용 */
        }

        /* 이미지를 가운데 정렬하는 스타일 */
        .center-image {
            display: block;
            margin: 20px auto;
            max-width: 100%; /* 이미지가 컨테이너 너비를 넘지 않도록 제한 */
            height: auto;
        }

        /* 가운데 정렬 적용 */
        .middle-content {
            display: flex; /* 컨텐츠를 유연하게 정렬 */
            flex-direction: column; /* 세로 방향으로 요소 배치 */
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 20px;
            box-sizing: border-box;
        }

        .middle-content h1 {
            margin-bottom: 30px;
        }

        .middle-content h3 {
            text-align: center;
            line-height: 1.6;
            margin-top: 30px;
        }

        .title {
            border-bottom: var(--table-border) 3px solid;
            padding-bottom: 30px;
        }

        img {
            margin-bottom: 7px;
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
                <h1>웹사이트 소개</h1>
            </div>

            <section class="middle-content">
                <h1>안녕하세요 술주라입니다!</h1>
                <img src="/resources/Introducing/술 마켓.basic.png" alt="">
                <img src="/resources/Introducing/술마켓.young.png" alt="">
                <h3>
                    저희 술주라는 술을 다양한 분야의 술들을 소개하고 저희 제품들을 보고 <br>
                    가볍게 한잔 부터 같이 즐겁게 마시는 것까지 <br>
                    다양한 주종과 설명을 통해 내가 좋아할만한 술을 찾아보는 재미가 있는 페이지 입니다.
                </h3>

                <h3>술주라는 예전에 마시기 싫어도 마셔야 하거나 <br>
                    강제하는 마셔야지라는 말과는 반대로 내가 마시고 싶을 때<br>
                    못마시는 사람이던 잘마시는 사람이던 한잔 마시고싶을 때를 생각하여 만들었습니다!!</h3>
            </section>

            <img src="/resources/Introducing/img_ligo_cro.png" alt="" class="center-image">

            <section class="close-content">
                <div class="close-message">
                    "마시기 싫어도 마셔야 했던 시대는 끝!<br>
                    이제는 '마시고 싶을 때, 딱 한잔!' 술주라에서 당신의 취향 저격 술을 찾아보세요!"
                </div>
            </section>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>
<jsp:include page="/WEB-INF/views/common/remote.jsp"/>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이용약관</title>
    <style>
        .title h1 {
            text-align: center;
            color: #0078D4;
            font-size: 1.8em;
            margin-bottom: 20px;
        }

        .textEl {
            margin: 0 auto;
            padding: 20px;
            max-width: 800px;
        }

        .textEl p {
            margin: 15px 0;
            line-height: 1.6;
        }

        .textEl h4 {
            color: #0078D4;
            font-size: 1.2em;
            margin-top: 25px;
            margin-bottom: 10px;
            border-left: 4px solid #0078D4;
            padding-left: 10px;
        }

        .textEl ul {
            margin: 15px 0 15px 20px;
            list-style: disc;
        }

        .textEl ul li {
            margin-bottom: 10px;
        }
    </style>
</head>

<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main class="main-container">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <div class="title">
                <h1>이용약관</h1>
            </div>

            <div class="textEl">
                <p>제1조(목적) 이 약관은 "술주라"(이하 "몰")에서 제공하는 인터넷 관련 서비스(이하 "서비스")를 이용함에
                    있어 "몰"과 이용자의 권리와 의무를 규정함을 목적으로 합니다.</p>

                <h4>제2조(정의)</h4>
                <p>1. "몰"이란 "술주라" 운영사가 제공하는 음주 게임 및 커뮤니티 서비스를 말합니다.</p>
                <p>2. "이용자"란 "몰"에 접속하여 서비스를 이용하는 모든 사람을 말합니다.</p>
                <p>3. "회원"이란 "몰"에 회원가입을 완료하고 지속적으로 서비스를 이용하는 자를 말합니다.</p>
                <p>4. "비회원"이란 회원가입 없이 서비스를 이용하는 자를 말합니다.</p>

                <h4>제3조(약관의 효력 및 변경)</h4>
                <p>1. "몰"은 이 약관을 "몰" 초기 화면에 게시하거나 연결 화면을 통해 공지합니다.</p>
                <p>2. "몰"은 필요한 경우 관련 법령을 위배하지 않는 범위에서 약관을 변경할 수 있습니다. 변경된 약관은 공지된
                    날로부터 7일 이후 효력이 발생합니다.</p>
                <p>3. 변경된 약관에 동의하지 않을 경우, 이용자는 회원탈퇴를 요청할 수 있습니다.</p>

                <h4>제4조(서비스의 제공)</h4>
                <p>1. "몰"은 다음과 같은 서비스를 제공합니다: 음주 게임 및 커뮤니티 콘텐츠 제공, 회원 간 소통 및 정보
                    공유</p>
                <p>2. "몰"은 서비스의 품질을 유지하기 위해 지속적으로 노력합니다.</p>

                <h4>제5조(회원가입 및 탈퇴)</h4>
                <p>1. 이용자는 회원가입 절차를 통해 "몰"의 회원으로 등록할 수 있습니다.</p>
                <p>2. 회원은 언제든지 회원탈퇴를 요청할 수 있으며, "몰"은 이를 즉시 처리합니다.</p>

                <h4>제6조(개인정보보호)</h4>
                <p>1. "몰"은 서비스 제공을 위해 최소한의 개인정보를 수집합니다.</p>
                <p>2. 개인정보는 이용자의 동의 없이 제3자에게 제공되지 않으며, "몰"은 이를 안전하게 관리할 책임이 있습니다.</p>

                <h4>제7조(책임과 의무)</h4>
                <p>1. "몰"은 서비스 운영과 관련하여 법령을 준수하며, 안정적인 서비스를 제공하기 위해 노력합니다.</p>
                <p>2. 이용자는 "몰"에서 제공하는 서비스를 불법적으로 사용하거나 타인의 권리를 침해하지 않아야 합니다.</p>

                <h4>제8조(분쟁해결 및 관할법원)</h4>
                <p>1. "몰"과 이용자 간에 발생한 분쟁은 성실히 협의하여 해결합니다.</p>
                <p>2. 협의가 어려운 경우, 관할 법원은 "몰"의 본사 소재지를 기준으로 합니다.</p>

                <h4>부칙</h4>
                <p>1. 이 약관은 2024년 12월 20일부터 적용됩니다.</p>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>
</body>
</html>

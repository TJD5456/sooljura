<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>술주라</title>
    <link rel="icon"
          href="/resources/icons/logo-circle-woText-16px-favicon.png">
    <style>
        .wrapper {
            justify-content: center;
            align-items: center !important;
        }

        .idPwFind {
            border: 1px solid black;
            width: 550px;
            height: 550px;
            display: flex;
            flex-direction: column;
        }

        .idPwHeader {
            width: 550px;
            height: 200px;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <c:if test="${idOrPW eq 1}">
            <div class="idPwFind">
                <div>
                    <h1>아이디 찾기</h1>
                </div>
                <div class="idPwHeader">
                    <form action="/user/idFind.do" method="post"
                          style="display: flex;">
                        <div style="display: flex; flex-direction: column; width: 60%;">
                            <input type="text" id="nameInpt" name="name" placeholder="이름"
                                   style="height: 50px; font-size: 30px;"> <input
                                type="text" id="phoneInpt" name="phone" placeholder="가입휴대폰번호"
                                style="height: 50px; font-size: 30px;">
                        </div>
                        <div style="width: 40%; height: 108px;">
                            <input type="submit" name="idFindBtn" value="아이디 찾기"
                                   style="width: 100%; height: 100%; font-size: 30px;">
                        </div>
                    </form>
                </div>
                <div></div>
            </div>
        </c:if>
        <%--
        <c:if test="${idOrPW eq 2}">
            <div class="idPwFind">
                <div>
                    <h1>비밀번호 찾기</h1>
                </div>
                <div class="idPwHeader">
                    <form action="">
                        <input type="text" name="id"> <input type="text" name="">
                    </form>
                </div>
                <div></div>
            </div>
        </c:if>
         --%>
        <c:if test="${res eq 3}">
            <div class="idPwFind">
                <div>
                    <h1>아이디 찾기</h1>
                </div>
                <div class="idPwHeader">
                    <h1>your id is ${idFind}</h1>
                </div>
                <div></div>
            </div>
        </c:if>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>
<script>


</script>
</body>
</html>

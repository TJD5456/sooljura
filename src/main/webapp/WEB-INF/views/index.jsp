<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>술주라</title>
    <link rel="icon" href="/resources/icons/logo-circle-woText-16px-favicon.png">
    <style>
        .content {
            display: inline-block;
            justify-items: center;
        }

        .bannerDiv1 {
            width: 1400px;
        }

        .bannerDiv1 img {
            display: block;
            width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <jsp:include page="/WEB-INF/views/common/productList.jsp"/>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>
</body>
</html>

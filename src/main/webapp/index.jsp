<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>술주라</title>
    <link rel="icon" href="/resources/icons/logo-circle-woText-16px-favicon.png">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<h1>메인페이지</h1>
<div class="mainDiv">
</div>
<jsp:include page="/WEB-INF/views/common/remoteController.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>

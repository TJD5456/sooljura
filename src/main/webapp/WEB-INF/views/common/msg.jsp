<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>With Trip</title>
    <link rel="apple-touch-icon"
          href="/resources/images/withTrip_favicon.png"/>
    <link rel="icon" href="/resources/images/withTrip_favicon.png"/>
    <script src="/resources/js/sweetalert.min.js"></script>
</head>
<body>
<script>
    const title = '${title}';	//메세지 제목(request.setAttribut로 등록한 속성의 키값)
    const msg = '${msg}';	//메세지 본문
    const icon = '${icon}';	//alert 아이콘 종류(success, error, warning)
    const loc = '${loc}';	//이동할 서블릿의 URL
    const callback = '${callback}';	//메시지를 띄어주고, 실행할 함수

    swal({
        title: title,
        text: msg,
        icon: icon
    }).then(function () {
        //alert의 확인 버튼 누른 이후 동작

        if (callback != '' && callback != null) {
            //전달된 callback 내부 문자열을, Javascript 코드로 해석하고 실행할 수 있게 해주는 함수 : eval
            eval(callback);
        }
        if (loc != '' && loc != null) {
            location.href = loc;	//서블릿에서 등록한, 이동할 URL로 이동!
        }
    });
</script>
</body>
</html>
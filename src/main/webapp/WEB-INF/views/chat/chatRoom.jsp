<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>chat.jsp</title>
    <script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.7.1.min.js"></script>
</head>
<body>

<%-- 기존 메시지 출력 --%>
<div id="msgArea" style="border : 1px solid black; height : 500px; overflow : scroll;">
    <c:forEach var="chat" items="${chatList}">
        <h4>${chat.senderKey}: ${chat.msg}[${chat.sentDate}]</h4>
    </c:forEach>
</div>

<label for="chatMsg">메시지 : </label><input type="text" id="chatMsg">
<button onclick="fn.sendValidate()">보내기</button>
<button onclick="fn.deleteChat()">나가기</button>
<button onclick="fn.returnList()">목록</button>

<script>
    let ws;
    let userKey = '${userKey}';
    let roomKey = '${roomKey}';
    let userCd = '${userCd}';

    let fn = {
        init: function () {

            ws = new WebSocket("ws://localhost/chat/doChat.do");

            // 연결 시, 이벤트 핸들러
            ws.onopen = function () {
                let msg = {
                    type: "connect",
                    roomKey: roomKey,
                    userKey: userKey
                };
                ws.send(JSON.stringify(msg));
            };

            // 메시지 수신 시, 이벤트 핸들러
            ws.onmessage = function (e) {
                let msg = e.data;
                let chat = $('#msgArea').html() + "\n <h4>" + msg + "</h4>";
                $("#msgArea").html(chat);
            };

            // 소켓 연결 종료 이벤트 핸들러
            ws.onclose = function () {
                console.log("연결종료");
            };
        },
        sendValidate: function () {
            let obj = {};
            fn.sendChat(obj);
        },
        sendChat: function (sendObj) {
            sendObj.type = "chat";
            sendObj.roomKey = roomKey;
            sendObj.userKey = userKey;
            sendObj.userCd = userCd;
            sendObj.msg = $("#chatMsg").val();

            ws.send(JSON.stringify(sendObj));

            // 기존 입력값 초기화
            $('#chatMsg').val("");
        },
        deleteChat: function () {
            // 방 나가기 == 삭제
            let sendObj = {};
            sendObj.type = "delete";
            sendObj.roomKey = roomKey;
            sendObj.userKey = userKey;

            ws.send(JSON.stringify(sendObj));
        },
        returnList: function () {
            location.href = "/chat/chatFrm.do";
        }
    };

    //소켓 연결
    $(function () {
        fn.init();
    });
</script>
</body>
</html>

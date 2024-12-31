<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>chatRoom.jsp</title>
    <script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.7.1.min.js"></script>
</head>
<body>
<%-- 기존 메시지 출력 --%>
<div id="msgArea" style="border : 1px solid black; height : 500px; overflow : scroll;">
    <c:forEach var="chat" items="${chatList}">
        <h4>${chat.memberId} :
            <c:if test="${chat.msgGb eq 1}">
                <a href="javascript:void(0)"
                   onclick="fn.chatFileDown('${chat.fileName}', '${chat.filePath}')">${chat.fileName}</a>
            </c:if>
                ${chat.msg}
            [${chat.msgDate}]
        </h4>
    </c:forEach>
</div>

<label for="chatMsg">메시지 : </label><input type="text" id="chatMsg">
<button onclick="fn.sendValidate()">전송</button>
<input type="file" name="uploadFile"> <br>
<button onclick="fn.deleteChat()">방 나가기</button>
<button onclick="fn.returnList()">목록으로</button>

</body>
<script>
    let ws;
    let memberId = '${sessionScope.loginMember.memberId}';
    let roomId = '${roomId}';

    let fn = {
        init: function () {

            ws = new WebSocket("ws://localhost/chat/doChat.do");

            // 연결 시, 이벤트 핸들러
            ws.onopen = function () {
                let msg = {
                    type: "connect",
                    roomId: roomId,
                    memberId: memberId
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
            // 파일 서버 업로드 -> 메시지 전송
            let file = $('input[type=file]')[0].files;

            if (file.length > 0) {
                file = file[0];

                const formData = new FormData();
                formData.append("file", file);
                formData.append("memberId", memberId);

                // 서버 파일 업로드 처리
                $.ajax({
                    url: "/chat/fileUpload.do",
                    type: "post",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (obj) {
                        fn.sendChat(obj); // DB에 등록하기 위한 값 (fileName, filePath)
                    },
                    error: function () {
                        alert("파일 업로드 실패: " + error);
                    }
                });
            } else {
                let obj = {};
                fn.sendChat(obj);
            }
        },
        sendChat: function (sendObj) {

            sendObj.type = "chat";
            sendObj.roomId = roomId;
            sendObj.memberId = memberId;
            sendObj.msg = $("#chatMsg").val();

            ws.send(JSON.stringify(sendObj));

            // 기존 입력값 초기화
            $("#chatMsg").val("");
            $('input[type=file]').val("");

        },
        deleteChat: function () {
            // 방 나가기 == 삭제
            let sendObj = {};
            sendObj.type = "delete";
            sendObj.roomId = roomId;
            sendObj.memberId = memberId;

            ws.send(JSON.stringify(sendObj));
        },
        returnList: function () {
            location.href = "/chat/getRoomList.do";

        },
        chatFileDown: function (fileName, filePath) {
            fileName = encodeURIComponent(fileName);
            filePath = encodeURIComponent(filePath);

            location.href = "/chat/fileDown.do?fileName=" + fileName + "&filePath=" + filePath;
        }
    };

    //소켓 연결
    $(function () {
        fn.init();
    });
</script>
</html>

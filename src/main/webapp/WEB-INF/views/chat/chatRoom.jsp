<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>chat.jsp</title>
    <link rel="stylesheet" href="/resources/css/common.css"/>
    <script src="/resources/jquery/jquery-3.7.1.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            height: 100%;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .chat-wrapper {
            width: 90%;
            max-width: 600px;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 6px;
            display: flex;
            flex-direction: column; /* stack messages and input vertically */
            min-height: 70vh;
        }

        .chat-title {
            font-size: 20px;
            margin-bottom: 16px;
            text-align: center;
        }

        #msgArea {
            flex: 1; /* fill remaining space */
            border: 1px solid #ccc;
            padding: 10px;
            overflow-y: auto; /* vertical scroll if messages overflow */
            margin-bottom: 16px;
            background-color: #fafafa;
        }

        #msgArea h4 {
            font-size: 14px;
            margin-bottom: 8px;
            line-height: 1.4;
            word-wrap: break-word; /* wrap long text */
        }

        .chat-input-area {
            display: flex;
            gap: 8px;
            flex-wrap: wrap; /* wrap to next line if not enough space */
            margin-bottom: 8px;
        }

        #chatMsg {
            flex: 1; /* grow to fill available space */
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .button {
            padding: 8px 12px;
            font-size: 14px;
            color: var(--sidebar-background);
            background-color: var(--button-background);
            box-shadow: 1px 1px 1px 1px var(--button-shadow);
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .button:hover {
            background-color: var(--button-background-hover);
            box-shadow: 1px 1px 1px 1px var(--button-background);
        }

        .myMsgContainer {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 8px;
        }

        .adminMsgContainer {
            display: flex;
            justify-content: flex-start;
            margin-bottom: 8px;
        }

        .bubble {
            max-width: 60%;
            padding: 10px 15px;
            border-radius: 15px;
            word-wrap: break-word;
            position: relative;
            font-size: 14px;
            line-height: 1.4;
        }

        .myMsgBubble {
            background-color: var(--button-background);
            color: #333;
            border-top-right-radius: 0;
        }

        .adminMsgBubble {
            background-color: #fff;
            color: #333;
            border-top-left-radius: 0;
        }
    </style>
</head>
<body>
<div class="chat-wrapper">
    <div class="chat-title">실시간 채팅</div>

    <c:set var="senderLabel" value="${userCd == 0 ? userNickNm : '관리자'}" />
    <div id="msgArea">
        <c:forEach var="chat" items="${chatList}">
            <c:choose>
                <c:when test="${chat.senderKey == userKey}">
                    <div class="myMsgContainer">
                        <div class="bubble myMsgBubble">
                                ${chat.msg}
                        </div>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="adminMsgContainer">
                        <div class="bubble adminMsgBubble">
                                ${senderLabel}: ${chat.msg}
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>

    <div class="chat-input-area">
        <button class="button" onclick="fn.deleteChat()">나가기</button>
        <button class="button" onclick="fn.returnList()">목록</button>

        <label for="chatMsg" style="display: none;">메시지</label>
        <input type="text" id="chatMsg" placeholder="메시지를 입력하세요">

        <button class="button" onclick="fn.sendValidate()">보내기</button>
    </div>
</div>

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
            ws.onmessage = function () {
                location.reload();
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
            let sendObj = {};
            sendObj.type = "delete";
            sendObj.roomKey = roomKey;
            sendObj.userKey = userKey;
            ws.send(JSON.stringify(sendObj));

            window.location = "/chat/toChatList.do";
        },
        returnList: function () {
            window.location = "/chat/toChatList.do";
        }
    };

    //소켓 연결
    $(function () {
        fn.init();
    });
</script>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <link rel="icon" href="/resources/icons/logo-circle-woText-16px-favicon.png">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding-top: 100px;
        }

        .container {
            width: 70%;
            margin: 0 auto;
        }

        h1 {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            vertical-align: top;
        }

        th {
            width: 20%;
            background-color: #f9f9f9;
            text-align: left;
        }

        .editor {
            height: 200px;
            resize: vertical;
        }

        .captcha-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .buttons {
            text-align: center;
            margin-top: 20px;
        }

        .buttons button {
            padding: 10px 20px;
            font-size: 16px;
            margin: 0 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .buttons button:hover {
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>수다게시판</h1>
    <form>
        <table>
            <tr>
                <th>분류</th>
                <td><select>
                    <option>일상</option>
                    <option>질문</option>
                    <option>정보</option>
                    <option>수다</option>
                    <!--  관리자일 경우 가능   <option>공지</option>-->
                </select></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>호날두(닉네임)<br>작성한 글은 닉네임으로 노출됩니다
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" style="width: 50%; padding: 5px;"></td>
            </tr>
            <tr>
                <th>본문</th>
                <td><textarea class="editor" style="width: 100%;"></textarea>
                    <p>아래 영역을 드래그하여 입력창 크기를 조절할 수 있습니다.</p></td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td><input type="file"></td>
            </tr>

        </table>
        <div class="buttons">
            <button type="button">취소</button>
            <button type="submit">저장</button>
        </div>
    </form>
</div>
</body>
</html>
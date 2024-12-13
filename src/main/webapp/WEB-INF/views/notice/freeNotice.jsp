<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>공지사항</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }
    th {
      background-color: #f4f4f4;
    }
    tr:hover {
      background-color: #f9f9f9;
    }
    .notice {
      font-weight: bold;
      color: #ff5722;
    }
   .board-navi {
    list-style: none;
    padding: 0;
    margin: 0;
    display: flex;
    gap: 10px;
  }

  .board-navi li {
    padding: 10px 15px;
    border: 1px solid #ddd;
    border-radius: 5px;
    cursor: pointer;
    text-align: center;
    background-color: white;
    font-weight: normal;
    transition: all 0.3s ease;
  }

  .board-navi li.active {
    font-weight: bold;
    color: white;
    background-color: black;
    border-color: black;
  }

  .board-navi li:hover {
    background-color: #f4f4f4;
  }

  .board-navi li.writer {
    margin-left: auto; /* 오른쪽으로 정렬 */
  }
  </style>
</head>
<body>
  <h1>자유 게시판</h1> <hr><br>

  

  <table>

<ul class="board-navi">
    <li class="active">전체</li>
    <li>일상</li> 
    <li>질문</li>
    <li>정보</li>
    <li>공지사항</li>
    <li class="writer">작성하기</li>
</ul>

    <thead>
      <tr>
        <th>번호</th>
        <th>분류</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>조회수</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="notice">공지</td>
        <td class="notice">공지</td>
        <td class="notice">충사모 앱 다운로드 즉시 3000pt 적립 지급!</td>
        <td>관리자</td>
        <td>2024-10-04</td>
        <td>159</td>
      </tr>
      <tr>
        <td class="notice">공지</td>
        <td class="notice">공지</td>
        <td class="notice">수리금액 및 유의사항</td>
        <td>관리자</td>
        <td>2017-07-05</td>
        <td>3247</td>
      </tr>
      <tr>
        <td>193</td>
        <td>일상</td>
        <td>오늘은 훈련 하기 싫은 날이네!~!</td>
        <td>메시</td>
        <td>2024-12-02</td>
        <td>18</td>
      </tr>
      <tr>
        <td>192</td>
        <td>정보</td>
        <td>※ 2024년 11월 무이자할부!</td>
        <td>관리자</td>
        <td>2024-11-01</td>
        <td>73</td>
      </tr>
      <tr>
        <td>191</td>
        <td>질문</td>
        <td>독일까지 배달이 가능한가요??</td>
        <td>김민재</td>
        <td>2024-09-30</td>
        <td>133</td>
      </tr>

      <tr>
        <td>190</td>
        <td>질문</td>
        <td>사케 종류에서 회랑 먹을만한 술이 뭐가있을까요?!</td>
        <td>충사모</td>
        <td>2024-09-30</td>
        <td>133</td>
      </tr>
    </tbody>
  </table>
</body>
</html>
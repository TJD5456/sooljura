<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>manageLevel.jsp</title>
    <style>
        .levelChangeSubmitButton {
            text-align: right;
            margin-bottom: 20px;
            margin-right: 14%;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <div class="title">
                <h1>회원 레벨 관리 페이지</h1>
            </div>

            <div class="levelChangeSubmitButton">
                <input type="button" value="회원 정보 수정" onclick="changeUserLevel(this)">
            </div>

            <table>
                <thead>
                <tr>
                    <th>체크</th>
                    <th>회원번호</th>
                    <th>이름</th>
                    <th>닉네임</th>
                    <th>이메일</th>
                    <th>게시글 수</th>
                    <th>포인트</th>
                    <th>성인인증</th>
                    <th>가입일</th>
                    <th>레벨 변경</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${userList}">
                    <tr>
                        <td>
                            <div>
                                <label>
                                    <input type="checkbox" class="chk" disabled>
                                </label>
                            </div>
                        </td>
                        <td class="userKey">${user.userKey}</td>
                        <td>${user.userNm}</td>
                        <td>${user.userNickNm}</td>
                        <td>${user.userEmail}</td>
                        <td>${user.postCnt}</td>
                        <td>${user.userPoint}</td>
                        <td>
                            <c:choose>
                                <c:when test="${user.adultChk == 0}">
                                    인증 X
                                </c:when>
                                <c:otherwise>
                                    인증 O
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${user.enrollDate}</td>
                        <td>
                            <label>
                                <select onchange="checkCheckBox(this)">
                                    <option value="1" <c:if test="${user.userCd == 1}">selected</c:if>>신규가입</option>
                                    <option value="2" <c:if test="${user.userCd == 2}">selected</c:if>>일반회원</option>
                                    <option value="3" <c:if test="${user.userCd == 3}">selected</c:if>>열심회원</option>
                                    <option value="4" <c:if test="${user.userCd == 4}">selected</c:if>>단골회원</option>
                                    <option value="-1" <c:if test="${user.userCd == -1}">selected</c:if>>관리대상
                                    </option>
                                </select>
                            </label>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>

<script>
    function refresh() {
        window.location.href = "/admin/manageLevel.do";
    }

    function checkCheckBox(obj) {
        $(obj).closest("tr").find(".chk").prop("checked", true).prop("disabled", "");
    }

    function changeUserLevel() {
        let checkedCheckBoxes = $(".chk:checked");

        let userKeyArr = [];
        let userCdArr = [];

        $.each(checkedCheckBoxes, function (index, item) {
            userKeyArr.push($(item).parents("tr").find(".userKey").html());
            userCdArr.push($(item).parents("tr").find("select option:selected").val());
        });

        $.ajax({
            url: '/admin/changeUserLevel.do',
            type: 'get',
            data: {
                "userKeyString": userKeyArr.join(","),
                "userCdString": userCdArr.join(",")
            },
            success: function (res) {
                if (res > 0) {
                    window.alert("레벨이 변경 되었습니다")
                } else {
                    window.alert("레벨 변경 중 오류 발생")
                }
            },
            error: function () {
                console.log('ajax error');
            }
        })
    }
</script>
</body>
</html>

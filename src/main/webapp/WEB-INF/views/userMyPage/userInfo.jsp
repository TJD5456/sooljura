<%@page contentType="text/html; charset=UTF-8"%>

<div class="userInfoUpdContent">
		<div>
		<h1>회원 정보 수정</h1>
		<%--<form id="form" method="post" onSubmit="return false;"> --%>
		<input type="hidden" value="{user.userNo}">
		<table class="tbl tblUserInfo">
			<colgroup>
				<col style="width: 20%;">
				<col style="width: 80%;">
			</colgroup>
			<tr>
				<th>아이디</th>
				<td> <input type="text" value="{user.userId}" readonly> </td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<div class="pwChgBtns">
						<div><button type="button" class="userInfoBtn" id="pwChgBtn">비밀번호 변경</button></div>
						<div><button type="button" class="userInfoBtn" id="pwChgMod">비밀번호 양식</button></div>
					</div>
				</td>
			</tr>
			<tr>
				<th></th>
				<td style="display: flex; flex-direction: row-reverse;">
					<div id="userPwMod">
						<ul>
							<li>영어,숫자,특수기호(!@#$%^&#38;*)를 포함한</li>
							<li>8~16글자의 비밀번호를 작성하여 주세요</li>
						</ul>
					</div>
				</td>
			</tr>
			<tr>
				<th></th>
				<td>	
					<div id="userPwChg">
						<table>
							<colgroup>
								<col style="width: 40%;">
								<col style="width: 60%;">
							</colgroup>
							<tr>
								<th>현재 비밀번호</th>
								<td><input  id="userPw" type="password"> <img alt="" src=""> </td>
							</tr>
							<tr>
								<td colspan="2"><div id="oldPwUnMatchSpan"><span>비밀번호가 일치하지 않습니다</span></div></td>
							</tr>
							<tr>
								<th>새 비밀번호</th>
								<td><input id="userUpdPw" oninput="pwChk()" type="password"></td>
							</tr>
							<tr>
								<td colspan="2"><div id="newPwIrreg"><span>사용불가! 영어,숫자,특수기호(!@#$%^&#38;*)를 포함한 8~16글자의 비밀번호를 작성하여 주세요</span></div></td>
							</tr>
							<tr>
								<th>새 비밀번호 확인</th>
								<td><input id="userUpdPwChk" oninput="pwChk()" type="password">  </td>
							</tr>
							<tr>
								<td colspan="2"><div id="pwUnMatchSpan"></div></td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" value="{user.userEmail}"></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" value="{user.userName}" readonly></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" value="{user.userPhone}"></td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td><input type="text" value="{user.userNickname}" readonly></td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<div class="userInptAddrBtn">
						<button class="userInfoBtn" type="button">주소지 관리</button>
						<%-- 팝업창 뜨도록/ 별개의 창에서 관리 --%>
					</div>
				</td>
			</tr>
			<tr>
				<th>가입일</th>
				<td><input type="text" value="{user.enrollDate}" readonly></td>
			</tr>
		</table>
			<%-- onclick="userInfoUpdBtn(this)"--%>
			<div class="userInfoInptBtn">
				<button class="userInfoBtn" type="submit" id="userInfoUpd">변경</button>
			</div>
		<%-- </form> --%>
		</div>
	</div>


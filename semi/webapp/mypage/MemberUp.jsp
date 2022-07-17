<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="semi.manager.*" %>
<jsp:useBean id="mdao" class="semi.manager.ManagerDAO"></jsp:useBean>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<style>
h2 {
	text-align: center;
	color: white;
	font-family: "Comic Sans MS";
}
body{
	background-color: black;
}
table th{
	font-size: 25px;
	color: white;
	font-family: "Comic Sans MS";
	text-align: right;
}
table td{
	font-size: 15px;
	color: white;
	font-family: "Comic Sans MS";
}
table{
	text-align: center;
}
#bir{
	font-size: 9px;
	color: gray;
}
#addr{
	font-size: 9px;
	color: gray;
}
.button{
	font-size: 15px;
	text-align: center;
}	
</style>
</head>
<body>
	<%
	String userid=(String)session.getAttribute("sid");
	ManagerDTO mdto = mdao.managerUpdateList(userid);
	if(mdto==null){
		%>
		<h3>등록되지 않은 계정입니다</h3>
		<%
	}
	%>
	<h2>정보 수정</h2>
	<form name="update" action="/myweb/mypage/MemberUp_ok.jsp">
		<hr width="700px">
			<table style="margin-left: auto; margin-right: auto;">
				<tr>
					<th>아이디: </th>
					<td><input type="text" name="id" size="15" value="<%=mdto.getName() %>"  readonly required></td>
				</tr>
				<tr>
					<th>비밀번호: </th>
					<td><input type="password" name="pwd" size="15" value="<%=mdto.getPwd() %>" required></td>
				</tr>
				<tr>
					<th>이름: </th>
					<td><input type="text" name="name" size="15"  value="<%=mdto.getId() %>" required ></td>
				</tr>
				<tr>
					<th>성별: </th>
					<%
					if(mdto.getSe().equals("male")){
						%>
						<td><input type="radio" name="se" value="male" checked>남
							<input type="radio" name="se" value="female">여
						</td>
						<%						
					}else{
						%>						
						<td><input type="radio" name="se" value="male">남
							<input type="radio" name="se" value="female" checked>여							
						</td>
						<%	
					}
					%>
				</tr>
				<tr>
					<th>생년월일: </th>
					<td><input type="text" name="birth" size="15" value="<%=mdto.getBirth() %>" required readonly></td>
				</tr>
				<tr>				
					<th>&nbsp;</th>
					<td id="bir">생년월일 앞 6자리</td>
				</tr>
				<tr>
					<th>전화번호: </th>
					<td>
					<input type="text" name="tel_1" value="010" size="1" value="<%=mdto.getTel_1() %>" required> - 
					<input type="text" name="tel_2" size="6" value="<%=mdto.getTel_2() %>" required>
					</td>
				</tr>
				<tr>
					<th>EMAIL:</th>
					<td><input type="text" name="email_1" size="3" value="<%=mdto.getEmail_1() %>" required> @ 
					<select name="email_2" style="font-size: 10px; width: 60px;" required><option value="naver.com"><%=mdto.getEmail_2() %></option>
							<option value="daum.net">daum.net</option>
							<option value="nate.com">nate.com</option>
							<option value="직접입력">직접입력</option>
					</select>
					</td>
				</tr>
				<tr>
					<th>주소: </th>
					<td id="addr"><input type="text" name="addr_1" size="6" value="<%=mdto.getAddr_1() %>" required> 주소전체입력
					</td>
				<tr>
					<th>&nbsp;</th>
					<td><input type="text" name="addr_2" size="15" value="<%=mdto.getAddr_2() %>" required></td>
				</tr>
				<tr>
					<th>&nbsp;</th>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" class="button" value="수정하기">
						 &nbsp;
						<input type="reset" class="button" value="취소하기" onclick="self.close()">
					</td>
				</tr>
			</table>		
	</form>
</body>
</html>v
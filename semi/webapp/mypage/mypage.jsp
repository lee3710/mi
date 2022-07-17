<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="semi.QA.*" %>
 	<%@ page import="semi.review.*" %>
 	<%@ page import = "java.util.*" %>
    <jsp:useBean id="rdao" class="semi.review.ReDAO" scope="session"></jsp:useBean>
    <jsp:useBean id="qdao" class="semi.QA.QaDAO" scope="session"></jsp:useBean>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#boardtitle{
	font-size: 30px;
	
}
#boardtable{
	text-align: center;
	height: 150px;
}

.line{
border-bottom: 1px solid gray;
}

#trhead{
	background-color: lightgray;
}

table{
	border: 1px solid #aaaaaa;
	border-collapse: collapse;
	align: center;
	height:130px;
	padding:10px;
}

</style>
<link rel="stylesheet" type="text/css" href="/myweb/css/bodyLayout.css">

</head>
<%@include file="/header2.jsp" %>
<body id="boardbody">
<h1>마이페이지</h1>
내 정보를 확인할 수 있습니다.
<hr><br>

<h3>주문 처리 현황</h3>
<table style="text-align: center; font-size:30px; background-color: lightgray">
<tr><th>배송준비중  >  배송중  >  배송완료<th></tr>
<tr><th>0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0</th></tr>
</table>

<h3>주문 상품 정보</h3>
<table id="mqna" border="1" style="text-align: center;">
	<tr id="trhead">
		<th>주문번호</th>
		<th>이미지</th>
		<th>상품정보</th>
		<th>수량</th>
		<th>상품구매금액</th>
		<th>주문처리상태</th>
	</tr>

	<tr>
		<td>1</td>
		<td><img src="img/img6.jpg" width="150px" style="padding:10px"></td>
		<td>데일리 미니 복조리 버킷백 <br><br>옵션: 블랙</td>
		<td>1</td>
		<td>16,800원</td>
		<td>배송준비중</td>
	</tr>

</table>

<h3>내 Q&A</h3>
<table id="mqna" border="1" style="text-align: center;">
	<tr id="trhead">
		<th>번호</th>
		<th>제목</th>
		<th>작성일</th>
		<th>수정/삭제</th>
	</tr>
<%
ArrayList<QaDTO> qarr=qdao.myQa("치즈");

	if(qarr==null||qarr.size()==0){
%>
			<tr>
				<td colspan="4"> 등록된 글이 없습니다.</td>
			</tr>
			
	<%} else {
		for(int i=0;i<qarr.size();i++){
		%>
			<tr>
				<td><%=i+1 %></td>
				<td align="left"><a href="javascript:window.open('Mypage_content.jsp?idx=<%=qarr.get(i).getQa_idx() %>','myqa','width=1000,height=600')">
				
				<%if(qarr.get(i).getQ_lev()==1){	%> &nbsp;&nbsp;▶<%} %>
					<%=qarr.get(i).getQ_subject() %></a><br>
						</td>
				<td><%=qarr.get(i).getQ_date() %></td>
		
				<td>
					<%if(!(qarr.get(i).getQ_lev()==1)){	%>
					<input type="button" value="수정" onclick="window.open('QAUpdate.jsp?qa_idx=<%=qarr.get(i).getQa_idx()%>','qaup','width=1000,height=600');">
					<input type="button" value="삭제"  onclick="window.open('QADelete.jsp?qa_idx=<%=qarr.get(i).getQa_idx()%>');"></td>
				<% } %>
			</tr>
		<% 
		}
	}
	%>

</table>

<h3>내 리뷰</h3>
<table id="mreview" border="1" style="text-align: center;">
	<tr id="trhead" align="center">
		<th>번호</th>
		<th>상품명</th>
		<th>제목</th>
		<th>별점</th>
		<th>작성일</th>
		<th>삭제</th>
	</tr>

<%
ArrayList<ReDTO> redto=rdao.myReview("치즈");

if(redto==null||redto.size()==0){
%>
	<tr>
		<td colspan="4">등록된 리뷰가 없습니다.</td>
	</tr>

<%} else{
	for(int i=0;i<redto.size();i++){
		%>
		<tr>
			<td><%=i+1 %></td>
			<td><%= redto.get(i).getP_name()%></td>
			<td align="left"><%=redto.get(i).getRe_subject() %><br>
				<%=redto.get(i).getRe_content().replaceAll("\n", "<br>") %></td>
			<td><%=redto.get(i).getRe_star() %></td>
			<td>	<%=redto.get(i).getRe_date() %></td>
			<td><input type="button" value="수정" onclick="window.open('ReviewUpdate.jsp?re_idx=<%=redto.get(i).getRe_idx() %>','reup','width=1000,height=600')">
			<input type="button" value="삭제" onclick="window.open('ReviewDelete.jsp?re_idx=<%=redto.get(i).getRe_idx() %>')"></td>
		<tr>

<% }} %>


</table>
</body>

<br><br>
<%@include file="/footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import ="com.oreilly.servlet.*" %>    
<%@ page import = "semi.review.*" %>
<jsp:useBean id="rdao" class="semi.review.ReDAO" scope="session"></jsp:useBean>

<%
String idx=request.getParameter("re_idx");
if(idx==null||idx.equals("")){
	idx="0";
}

int re_idx=Integer.parseInt(idx);

ReDTO dto=rdao.reContent(re_idx);
%>    
   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/myweb/css/managerLayout.css" >

<script>
function manager_Reviewopen(){
	location.href='manager_Review.jsp'
}

</script>
</head>
<body>
<section class="center">
<article class="ma1">
<h2>Review 글 확인</h2>
</article>
<form name="Review">
<article class="ma2">

<table>
	<tr>
		<th width="100px">제품 목록<input type="hidden" name="re_idx" value="<%=dto.getRe_idx() %>"></th>
	
		<td><%=dto.getP_name() %></td>
	</tr>
	
	<tr>
		<th>별점</th>
		<td><%=dto.getRe_good() %></td>
	</tr>

	<tr>
		<th>작성자</th>
		<td><%=dto.getid() %></td>
	</tr>
	
	<tr>
		<th>제목</th>
		<td><%=dto.getRe_subject() %></td>
	</tr>

	<tr>
		<th>내용</th>
		<td><%=dto.getRe_content().replaceAll("\n", "<br>") %></td>
	</tr>

</table>
</article>
<article class="ma3">
<div align="right">
	<input type="button" value="삭제하기" class="button" onclick="location.href='ReviewDelete.jsp?re_idx=<%=dto.getRe_idx()%>'">
</div>


</article>
</form>
</section>
</body>
</html>
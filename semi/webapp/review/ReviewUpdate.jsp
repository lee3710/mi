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
<link rel="stylesheet" type="text/css" href="/myweb/css/qareview.css">

<script>
function reviewopen(){
	location.href='review.jsp'
}


</script>
</head>
<body>
<h2>Review 글 수정</h2>
<section>
<article>
<form name="Review" action="ReviewUpdate_ok.jsp">

<table>
	<tr>
		<th>제품 목록<input type="hidden" name="re_idx" value="<%=dto.getRe_idx() %>"></th>
	
		<td>
		<select name="p_name">
				<%
				ArrayList<String> pname=rdao.rePro();
						
						for(int i=0;i<pname.size();i++){
							
							if(pname.get(i).equals(dto.getP_name())){
				%>
					<option value='<%=pname.get(i) %>' selected><%=pname.get(i) %></option>	
					<%
					} else{ %>
					<option value='<%= pname.get(i) %>'><%= pname.get(i) %></option>
				<% 	}} %>
			</select>
		</td>
	</tr>
	
	<tr>
		<th>별점</th>
		<td><select name="re_star">
		<% 
			for(int i=0;i<=4;i++){
				if((i+1)==dto.getRe_star()){
					%>
					<option value='<%=i+1%>' selected><%=i+1%></option>		
					<% 
				} else{
					%>
					<option value='<%=i+1%>'> <%=i+1%></option>
					<% }}%>

		</select></td>
	</tr>

	<tr>
		<th>작성자</th>
		<td><input type="text" name="id" class="text" value="<%=dto.getid() %>" required></td>
	</tr>
	
	<tr>
		<th>제목</th>
		<td><input type="text" name="re_subject" size="100" class="text" value="<%=dto.getRe_subject() %>" required></td>
	</tr>

	<tr>
		<th>내용</th>
		<td><textarea name="re_content" rows="20" cols="100" required><%=dto.getRe_content() %></textarea></td>
	</tr>

</table>

<div align="right"><input type="submit" value="글쓰기" class="button"></div>

</form>
</article>
</section>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import ="com.oreilly.servlet.*" %>    
    <jsp:useBean id="rdao" class="semi.review.ReDAO" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/myweb/css/qareview.css">

<script>
function reviewopen(){
	location.href='Review.jsp'
}


</script>
</head>
<body>
<%@ include file="//header2.jsp" %>
<h2>Review 글 작성</h2>
<section>
<article>
<form name="Review" action="ReviewWrite_ok.jsp" >

<table class="table">
	<tr>
			<th>제품 목록</th>
		<td><select name="p_name">
	<%
	ArrayList<String> pname=rdao.rePro();
			
			for(int i=0;i<pname.size();i++){
	%>
					<option value='<%= pname.get(i) %>'><%= pname.get(i) %></option>
		<%		} %>

			</select>
		</td>
	</tr>
	<tr>
		<th>별점</th>
		<td><select name="re_star">
				<option value="5">5</option>
				<option value="4">4</option>
				<option value="3">3</option>
				<option value="2">2</option>
				<option value="1">1</option>
		</select></td>
	</tr>

	<tr>
		<th>작성자</th>
		<td><input type="text" name="id" class="text" required></td>
	</tr>
	
	<tr>
		<th>제목</th>
		<td><input type="text" name="re_subject" size="100" class="text" required></td>
	</tr>

	<tr>
		<th>내용</th>
		<td><textarea name="re_content" rows="20" cols="100" required></textarea></td>
	</tr>

</table>

<table>
<tr>
	<td><input type="button" value="목록가기" class="button" onclick='reviewopen();'></td>
	<td align="right"><input type="submit" value="글쓰기" class="button">
		<input type="reset" value="초기화" class="button"></td>
</tr>
</table>

</form>
</article>
</section>

<%@ include file="//footer.jsp" %>
</body>
</html>
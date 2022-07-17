<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/myweb/css/qareview.css">

<script>
function QAopen(){
	location.href='Q&A.jsp';
}

</script>
</head>
<body>
<%@ include file="//header2.jsp" %>
<h2>Q&A 글 작성</h2>
<section>
<article>
<form name="QAW" action="QAWrite_ok.jsp">
<table class="table">
	<tr>
		<th>작성자</th>
		<td><input type="text" name="id" class="text" required></td>
	</tr>
	
	<tr>
		<th>제목</th>
		<td><input type="text" name="q_subject" size="80" class="text" required></td>
	</tr>

	<tr>
		<th>내용</th>
		<td><textarea name="q_content" rows="20" cols="90" required></textarea></td>
	</tr>
</table>

<table>
<tr>
	<td><input type="button" value="목록가기" class="button" onclick='QAopen();'></td>
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
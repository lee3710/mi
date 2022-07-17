<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="semi.QA.*" %>    
<jsp:useBean id="qdao" class="semi.QA.QaDAO" scope="session"></jsp:useBean>    
 
<%
     

          String q_idx=request.getParameter("idx");
          if(q_idx==null||q_idx.equals("")){
          	q_idx="0";
          }

          int qa_idx=Integer.parseInt(q_idx);
          QaDTO dto=qdao.qaContent(qa_idx);
     %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/myweb/css/managerLayout.css">

<script>
function QAReply(){
	location.href='QAReply.jsp?q_ref=<%=dto.getQ_ref()%>'};
	
function QADel(){
	var result=	window.confirm('삭제하시겠습니까?');
	
	if(result){
		window.open('QADelete_ok.jsp?qa_idx=<%=qa_idx%>','qadel_ok',);
	
	} else{
		window.alert('삭제가 취소되었습니다.');

	}
}

	

</script>
</head>


<body>
<section class="center">
<article class="ma1">
<h2>Q&A 글 확인</h2></article>
<form name="QAC">
<article class="ma2">
<table class="table">
	<tr>
		<th>작성자</th>
		<td><%=dto.getid() %></td>
	</tr>
	
	<tr>
		<th>제목</th>
		<td><%=dto.getQ_subject() %></td>
	</tr>

	<tr>
		<th>내용</th>
		<td><%=dto.getQ_content().replaceAll("\n", "<br>") %></td>
	</tr>
</table>
</article>
<article class="ma3">
<div align="right">
		<input type="button" value="삭제" class="button" onclick="QADel();">
		<input type="button" value="답글" class="button" onclick="QAReply();"></div>

</article>
</form>
</section>

</body>
</html>
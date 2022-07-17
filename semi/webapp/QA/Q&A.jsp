<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="semi.QA.*" %>
<%@ page import="java.util.*"%>
<jsp:useBean id="qdao" class="semi.QA.QaDAO" scope="session"></jsp:useBean>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/myweb/css/qareview.css">

<script>
function QAOpen(){
	location.href="QAWrite.jsp";
}

</script>
</head>
<%
int totalCnt=qdao.qaTotalCnt();
int listSize=5;
int pageSize=5;
String s_cp=request.getParameter("cp");
if(s_cp==null||s_cp.equals("")){
	s_cp="1";
}
int cp=Integer.parseInt(s_cp);
int totalPage=(totalCnt/listSize)+1;
if(totalCnt%listSize==0)totalPage--;

int userGroup=cp/pageSize;
if(cp%pageSize==0)userGroup--;
%>
<body>
<%@ include file="//header2.jsp" %>

<section>
<article>
<h2> Q&A </h2>
</article>
<article>
<form>
	<table class="table">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		
		
		<tbody align="center">
			<%
					ArrayList<QaDTO> dto=qdao.qaList(cp,listSize);
					
					if(dto==null||dto.size()==0){
			%>
				<tr>
					<td colspan="4">등록된 Q&A가 없습니다.</td>
				</tr>
				
				<% 
			} else{
			
				for(int i=0;i<dto.size();i++){
					%>
					<tr>
						<td><%=dto.get(i).getQa_idx() %></td>
						<td align="left"><a href="QAContent.jsp?idx=<%=dto.get(i).getQa_idx() %>">
						<%if(dto.get(i).getQ_lev()==1){	%>&nbsp;&nbsp;▶<% } %>
						<%=dto.get(i).getQ_subject() %></a></td>
						<td><%=dto.get(i).getid() %></td>
						<td><%=dto.get(i).getQ_date() %></td>
					</tr>
					<%
				}
			}

			%>
	
		</tbody>
	</table>


		<div align="right"><input type="button" value="글쓰기" class="button" onclick='QAOpen();'></div>
		<div id="page">
			<%
			if(userGroup!=0){%>
				<a href="Q&A.jsp?cp=<%=(userGroup-1)*pageSize+pageSize %>">
				&lt;&lt;</a><% }
			
			for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
				%> &nbsp;&nbsp;<a href="Q&A.jsp?cp=<%=i%>"><%=i %></a>
				&nbsp;&nbsp;<%
				if(i==totalPage)break;
			}
			
			if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){%>
				<a href="Q&A.jsp?cp=<%=(userGroup+1)*pageSize+pageSize%>">
				&gt;&gt;</a><%} %>
	
</div>

</form>
</article>
</section>
<%@ include file="//footer.jsp" %>
</body>
</html>
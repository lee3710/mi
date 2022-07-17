<%@page import="java.lang.reflect.Array"%>
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
<link rel="stylesheet" type="text/css" href="/myweb/css/managerLayout.css" >

<script>
function QAOpen(){
	location.href="QAWrite.jsp";
}

</script>
</head>
<%
int totalCnt=qdao.qaTotalCnt();
String recheck=request.getParameter("recheck");

if(recheck==null||recheck.equals("")){
	recheck="10";
} else{
	totalCnt=qdao.qaSunCnt();
}


int q_recheck=Integer.parseInt(recheck);

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
<%@ include file="manager_header.jsp" %>
<%@ include file="manager_menu.jsp" %>

<section class="center">
<article class="ma1">
<h2> Q&A </h2>
</article>
<form>

<article class="ma2">
<input type="button" value="답글필요" onclick="location.href='manager_QA.jsp?recheck=0'">


	<table id="QAtable">
		<thead align="center">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		
		
		<tbody>
			<%
			ArrayList<QaDTO> dto=q_recheck==0?qdao.qaList2(q_recheck, cp,listSize):qdao.qaList(cp,listSize);
						
						
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
						<td align="left"><a href="javascript:window.open('manager_QAContent.jsp?idx=<%=dto.get(i).getQa_idx() %>','maqa','width=1000,height=600')">
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
	</article>
	
	<article class="ma3">
	
	<% 
	if(q_recheck==0){%>
		<div id="page">
		<%
		if(userGroup!=0){%>
			<a href="manager_QA.jsp?cp=<%=(userGroup-1)*pageSize+pageSize %>&recheck=0">
			&lt;&lt;</a><% }
		
		for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
			%> &nbsp;&nbsp;<a href="manager_QA.jsp?cp=<%=i%>&recheck=0"><%=i %></a>
			&nbsp;&nbsp;<%
			if(i==totalPage)break;
		}
		
		if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){%>
			<a href="manager_QA.jsp?cp=<%=(userGroup+1)*pageSize+pageSize%>&recheck=0">
			&gt;&gt;</a><%} %>
		</div>

	
	<% } else{%>
	
			<div id="page">
		<%
		if(userGroup!=0){%>
			<a href="manager_QA.jsp?cp=<%=(userGroup-1)*pageSize+pageSize %>">
			&lt;&lt;</a><% }
		
		for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
			%> &nbsp;&nbsp;<a href="manager_QA.jsp?cp=<%=i%>"><%=i %></a>
			&nbsp;&nbsp;<%
			if(i==totalPage)break;
		}
		
		if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){%>
			<a href="manager_QA.jsp?cp=<%=(userGroup+1)*pageSize+pageSize%>">
			&gt;&gt;</a><%} %>
		</div>
	<%	} %>

</article>
</form>
</section>
<%@ include file="manager_footer.jsp"%>
</body>
</html>
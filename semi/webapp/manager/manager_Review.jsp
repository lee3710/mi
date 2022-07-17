<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="semi.review.*" %>
<jsp:useBean id="rdao" class="semi.review.ReDAO" scope="session"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/myweb/css/managerLayout.css" >

</head>
<%
String p_name=request.getParameter("p_name");

int totalCnt=(p_name==null||p_name=="")?rdao.reTotalCnt():rdao.reSearCnt(p_name);
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
	<h2>Review</h2>

	</article>		
	
	<article class="ma2">
	<form name="maresearch" action="manager_Review.jsp">
		<select name="p_name" >
				
				<%
				
								ArrayList<String> pname=rdao.rePro();
										
										for(int i=0;i<pname.size();i++){
											
											if(pname.get(i).equals(p_name)){
								%>
					<option value='<%=pname.get(i) %>' selected><%=pname.get(i) %></option>	
					<%
					} else{ %>
					<option value='<%= pname.get(i) %>'><%= pname.get(i) %></option>
				<% 	}
				} %>
			</select>
			<input type="submit" value="상품 검색" class="darkbutton">
	</form>
	<table>
	<%
	ArrayList<ReDTO> dto=(p_name==""||p_name==null)?rdao.reList(cp,listSize):rdao.reSearch(p_name, cp, listSize);
		
		
		if(dto==null||dto.size()==0){
	%>
			<tr>
				<td align="center">등록된 리뷰가 없습니다.</td>
			</tr>
		<%
	} else{
	
	for(int i=0;i<dto.size();i++){
		%>

		<tr>
			<td><%=dto.get(i).getP_name() %> / 별점 
				<%= dto.get(i).getRe_star() %></td>
			<td align="right">작성자 : <%=dto.get(i).getid()%>
				 / <%=dto.get(i).getRe_date() %></td>
		</tr>
		<tr>
			<td><strong>
			
			<a href="javascript:window.open('ReviewContent.jsp?re_idx=<%=dto.get(i).getRe_idx()%>','marecon','width=1000,height=600')"><%=dto.get(i).getRe_subject() %></a></strong></td>
			
			
			<td align="right"> 추천수 : <%=dto.get(i).getRe_good() %>
				<input type="button" value="삭제하기" class="button" onclick="window.open('ReviewDelete.jsp?re_idx=<%=dto.get(i).getRe_idx()%>','redel',);">
			</td>
		</tr>
<%	
	}}
	%>
	
	</table>
	</article>
	<article class="ma3">

	<%
	if(p_name==null){
		
		%><div id="page"><% 
		if(userGroup!=0){%>
		
		<a href="manager_Review.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>">
		&lt;&lt;</a><%}
		
	for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
		%> &nbsp;&nbsp;<a href="manager_Review.jsp?cp=<%=i %>"><%=i %></a>
		&nbsp;&nbsp;<%
		if(i==totalPage)break;}
	
	if(userGroup!=totalPage/pageSize-(totalPage%pageSize==0?1:0)){%>
		<a href="manager_Review.jsp?cp=<%=(userGroup+1)*pageSize+pageSize %>">
		&gt;&gt;</a><%} %>
			</div>
			
	<% } else { 
				%><div id="page"><% 
				
				if(userGroup!=0){%>
					<a href="manager_Review.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>&p_name=<%=p_name%>">
					&lt;&lt;</a><%}
					
				for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
					%> &nbsp;&nbsp;<a href="manager_Review.jsp?cp=<%=i %>&p_name=<%=p_name%>"><%=i %></a>
					&nbsp;&nbsp;<%
					if(i==totalPage)break;}
				
				if(userGroup!=totalPage/pageSize-(totalPage%pageSize==0?1:0)){%>
					<a href="manager_Review.jsp?cp=<%=(userGroup+1)*pageSize+pageSize %>&p_name=<%=p_name%>">
					&gt;&gt;</a><%} %>
						</div>
	
		<% } %>
	</article>
</section>
<%@ include file="manager_footer.jsp"%>
</body>
</html>
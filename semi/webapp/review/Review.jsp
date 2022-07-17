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
<link rel="stylesheet" type="text/css" href="/myweb/css/qaReview.css">
<style>
.good{height:20px; width:20px;}

</style>

<script>
function rwrite(){
	location.href="ReviewWrite.jsp"
}

</script>
</head>
<%
String p_name=request.getParameter("p_name");

int totalCnt=(p_name==null||p_name=="")?rdao.reTotalCnt():rdao.reSearCnt(p_name);

rdao.reTotalCnt();
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
<%@ include file="/header2.jsp" %>
<section>
<article>
	<h2>Review</h2>

	<hr>
	<form name="ser" action="Review.jsp">
	<table>
		<tr>
			<td> 상품 검색 
			<select name="p_name">
				
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
			</td>
		<td align="right"><input type="button" value="글쓰기" class="darkbutton" onclick="rwrite();"></td>
		</tr>
	</table>
	
	
	<table class="table">
	
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
			<td><strong><%=dto.get(i).getRe_subject() %></strong></td>
		</tr>
		<tr>
			<td colspan="2" width="800"><%=dto.get(i).getRe_content().replaceAll("\n", "<br>") %>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
			 추천수 : <%=dto.get(i).getRe_good() %>
			<img src="/myweb/img/good.png" class="good" alt="추천이미지" onclick="window.open('ReviewGood.jsp?re_idx=<%=dto.get(i).getRe_idx()%>');">
			</td>
		</tr>

<%	
	}}
	%>
	
	</table>
	
	</form>
	<%
	if(p_name==null){
		%><div id="page"><% 
		if(userGroup!=0){%>
				
				<a href="Review.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>">
				&lt;&lt;</a><%}
				
				for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
					%> &nbsp;&nbsp;<a href="Review.jsp?cp=<%=i %>"><%=i %></a>
					&nbsp;&nbsp;<%
					if(i==totalPage)break;}
				
				if(userGroup!=totalPage/pageSize-(totalPage%pageSize==0?1:0)){%>
					<a href="Review.jsp?cp=<%=(userGroup+1)*pageSize+pageSize %>">
					&gt;&gt;</a><%} %>
						</div>

	<% } else { 
				%><div id="page"><% 
				
				if(userGroup!=0){%>
					<a href="Review.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>&p_name=<%=p_name%>">
					&lt;&lt;</a><%}
					
				for(int i=(userGroup*pageSize+1);i<=(userGroup*pageSize+pageSize);i++){
					%> &nbsp;&nbsp;<a href="Review.jsp?cp=<%=i %>&p_name=<%=p_name%>"><%=i %></a>
					&nbsp;&nbsp;<%
					if(i==totalPage)break;}
				
				if(userGroup!=totalPage/pageSize-(totalPage%pageSize==0?1:0)){%>
					<a href="Review.jsp?cp=<%=(userGroup+1)*pageSize+pageSize %>&p_name=<%=p_name%>">
					&gt;&gt;</a><%} %>
						</div>
	
		<% } %>

	</article>
</section>
<%@ include file="/footer.jsp" %>
</body>
</html>
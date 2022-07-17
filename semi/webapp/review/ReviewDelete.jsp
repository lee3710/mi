<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String idx=request.getParameter("re_idx");
if(idx==null||idx.equals("")){
	idx="0";
}

int re_idx=Integer.parseInt(idx);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
function ReDel(){
	var result=	window.confirm('삭제하시겠습니까?');
	
	if(result){
		location.href='ReviewDelete_ok.jsp?re_idx=<%=re_idx%>';
	
	} else{
		window.alert('삭제가 취소되었습니다.');
		window.self.close();
	}
}
</script>
</head>
<body onload="ReDel();">

</body>
</html>
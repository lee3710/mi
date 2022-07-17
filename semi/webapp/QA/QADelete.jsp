<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String q_idx=request.getParameter("qa_idx");
if(q_idx==null||q_idx.equals("")){
	q_idx="0";
}

int qa_idx=Integer.parseInt(q_idx);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
function QADel(){
	var result=	window.confirm('삭제하시겠습니까?');
	
	if(result){
		location.href='QADelete_ok.jsp?qa_idx=<%=qa_idx%>';
	
	} else{
		window.alert('삭제가 취소되었습니다.');
		window.self.close();

	}
}
</script>
</head>
<body onload="QADel();">

</body>
</html>
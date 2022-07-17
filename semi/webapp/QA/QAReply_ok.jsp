<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="qdto" class="semi.QA.QaDTO"></jsp:useBean>
<jsp:setProperty property="*" name="qdto"/>
<jsp:useBean id="qdao" class="semi.QA.QaDAO" scope="session"></jsp:useBean>

<%
int count=qdao.qaReply(qdto);

String msg="";
if(count>0){
	qdao.qaUpCheck(qdto.getQ_ref());
	msg="답글 완료되었습니다.";
	
} else{
	msg="답글 불가합니다.";
}
%>
<script>
	window.alert('<%=msg%>');
	window.self.close();
	opener.location.reload();	

</script>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<script>
if(${!empty msg}){
	window.alert('${msg}');
}
	window.location=document.referrer;

</script>
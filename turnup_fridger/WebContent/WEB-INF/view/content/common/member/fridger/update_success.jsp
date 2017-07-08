<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<script type="text/javascript">
$(document).ready(function(){
	console.log(window.opener.location);	
	window.opener.location.reload;
	self.close();
});
</script>

<h2>업뎃 성공했다</h2>
냉장고 ID : ${ requestScope.fridger.fridgerId }<br>
사진 : 
<img src="${ initParam.rootParam }/images/${requestScope.fridger.fridgerImg}">
<br>
냉장고 이름 : ${ requestScope.fridger.fridgerName }<br>
냉장고 주인 : ${ requestScope.fridger.memberId }<br>

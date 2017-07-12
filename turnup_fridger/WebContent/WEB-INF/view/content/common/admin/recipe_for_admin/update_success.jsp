<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script type="text/javascript" src="${ initParam.rootPath }/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){	
	window.opener.location.href="${initParam.rootPath}/recipe/show/detail.do?recipeId=${requestScope.recipeId}";
	self.close();
});
</script>


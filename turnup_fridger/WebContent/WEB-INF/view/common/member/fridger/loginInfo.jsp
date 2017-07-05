<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<div id="loginInfo">
<sec:authentication property="principal.memberId" var="memberId"/>
현재 로그인한 회원 ID : ${ memberId }<br>
내 냉장고 조회 <span><input type="hidden" name="memberId" id="memberId" value="${ memberId }">
	    <button type="button" class="btn btn-default" id="searchByOwnerBtn">
      	<span class="glyphicon glyphicon-search"></span> 
    	</button>
    	</span>
</div><hr>
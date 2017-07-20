<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.turnup_fridger.service.ShareRecipeIrdntService"%>
<%@page import="kr.co.turnup_fridger.vo.ShareRecipeIrdnt"%>
<%@page import="kr.co.turnup_fridger.service.IrdntManageService"%>
<%@page import="kr.co.turnup_fridger.vo.BoardShareRecipe"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
   //줄 바꿈
   pageContext.setAttribute("br", "<br/>");
   pageContext.setAttribute("cn", "\n");

%>
<!DOCTYPE html>
<html>
<head>
<!-- cardList.css -->
<link href="${initParam.rootPath }/css/cardList2.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Latest compiled and minified CSS 아이콘 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- 버튼, table css -->
<script src="http://code.jquery.com/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script type="text/javascript">
////작성자의 수정 권한
function update_event(){
	var writer = $('input[name=writer]').val();
	var memberId = $('input[name=memberId]').val();
	
	if(writer != memberId)
	{
		alert("권한이 없습니다.");
		return false;
	}

	
	return location.href="/turnup_fridger/boardRecipe/boardRecipe_list.do";
	
};
//작성자의 삭제 권한
function delete_event(){
	var writer = $('input[name=writer]').val();
	var memberId = $('input[name=memberId]').val();
	if(writer != memberId)
	{
		alert("권한이 없습니다.");
		return false;
	}
	if(confirm("확실하게 삭제 하시겠습니까?")==true){
		alert('삭제되었습니다.')
		location.href="/turnup_fridger/boardRecipe/boardRecipe_list.do";
		
	}else{
		return false;
	}
};
//관리자의 삭제 권한
function adminDelete_event(){
	var writer = $('input[name=writer]').val();
	var adminId = $('input[name=adminId]').val();
	if(writer != adminId)
	{
		alert("권한이 없습니다.");
		return false;
	}
	if(confirm("확실하게 삭제 하시겠습니까?")==true){
		alert('삭제되었습니다.');
		location.href="/turnup_fridger/boardRecipe/boardRecipe_list.do";
		
	}else{
		return false;
	}

}

//목록 버튼
function back(){
	
	return location.href="/turnup_fridger/boardRecipe/boardRecipeList.do";
}
</script>

<style type="text/css">
form{display:inline}

div.align{
text-align:right;
}
div.pattern{
text-align:center;
}


</style>
<title>Insert title here</title>
<%

Cookie hits = new Cookie("hits", request.getParameter("hits"));
hits.setMaxAge(60*60*24);
response.addCookie(hits);


%>
</head>
<body>
<div class="container">
 <div id="table" style="width:50%; text-align:center; margin-left: auto; margin-right: auto;">

	<button type="button" class="btn btn-default btn-lg" style="border:0;outline:0;" onClick="return back();" >
			<span class="glyphicon glyphicon-list" aria-hidden="true">목록</span>
	</button>
<hr>
<h1 >View > ${boardShareRecipe.memberId}님의 게시물</h1>
<!-- 회원만 수정/삭제 가능 (자기자신이 올린 게시물만 가능) -->
<br><br>
<div class="align">
<sec:authorize access="hasRole('ROLE_MEMBER')"> <!-- 회원만 볼 수 있게 -->
<form action="${initParam.rootPath }/common/boardReipce/boardRecipeUpdate.do" method="post">

	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="hidden" name="recipeId" 				value="${boardShareRecipe.recipeId}">	
	<input type="hidden" name="writer" 					value="${boardShareRecipe.memberId}">
 	<input type="hidden" name="memberId" 				value="<sec:authentication property="principal.memberId"/>">
	<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;" onclick="return update_event();">
	<span class="glyphicon glyphicon-pencil" aria-hidden="true">수정</span>
	</button>
</form>
</sec:authorize>


<sec:authorize access="hasRole('ROLE_MEMBER')">
<form action="${initParam.rootPath }/common/boardRecipe/boardRecipeDelete.do" method="post">
	<input type="hidden" name="${_csrf.parameterName }" 	value="${_csrf.token }">
	<input type="hidden" name="recipeId"					value="${boardShareRecipe.recipeId }">
	<input type="hidden" name="memberId" 					value="<sec:authentication property="principal.memberId"/>">
	<input type="hidden" name="writer" 						value="${boardShareRecipe.memberId }">
	<input type="hidden" name="adminId" 					value="">
	<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;" onClick="return delete_event();"><!-- onclick="this.parentNode.submit();" --> 
	<span class="glyphicon glyphicon-trash" aria-hidden="true">삭제</span>
	</button>
</form>
</sec:authorize>
</div>
<div class="align">
<!-- 관리자 권한 폼 -->
<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
<form action="${initParam.rootPath}/common/boardRecipe/boardRecipeDelete.do" method="post">
<input type="hidden" name="${_csrf.parameterName }" 		value="${_csrf.token }">
	<input type="hidden" name="recipeId" 					value="${boardShareRecipe.recipeId }">
	<input type="hidden" name="writer" 						value="${boardShareRecipe.memberId}">
	<input type="hidden" name="adminId" 					value="<sec:authentication property="principal.adminId"/>">
	<input type="hidden" name="memberId" 					value="">
	<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;" onclick="return adminDelete_event()"><!-- this.parentNode.submit(); -->
	<span class="glyphicon glyphicon-trash" aria-hidden="true">삭제</span>
	</button>
</form>
</sec:authorize>
</div>
<hr>

<div id="pattern" class="pattern" >
	<ul >
        <li class="list3 img-list3">
            <div class="inner3">	
            	<div class="li-text3">
            		<p class="li-sub3">
            		<i class="glyphicon glyphicon-calendar" style="font-size:20px">
            		<fmt:formatDate value="${boardShareRecipe.date}" pattern="yyyy년 MM월 dd일"/></i></p>
            	</div>
            	<hr>
                <div class="li-img3">
                    <img src="${initParam.rootPath }/img/${boardShareRecipe.original}" alt="${boardShareRecipe.original }" />
                    <!-- ${top.upImage}-->
                </div>
                <hr>
                <div class="li-text3">
            		<p class="li-head3" style="font-size: 40px; font-weight: bold;">${boardShareRecipe.title } </p>
            	</div>
            	<hr>
                <div class="li-text3">
                    <h5 class="li-head3"><i class="glyphicon glyphicon-user" style="font-size:30px"> ${boardShareRecipe.memberId }</i>&emsp;
                    <i class="glyphicon glyphicon-eye-open" style="font-size:30px">  ${boardShareRecipe.hits }</i>&emsp;
                    
                    <form method="post" action="${initParam.rootPath }/common/boardRecipe/increaseRecommand.do">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
						<input type="hidden" name="recipeId" value="${top.recipeId }">
						<input type="hidden" name="memberId" value="${top.memberId }">
					
					<a href="#" onClick="this.parentNode.submit()" id="recommand-btn"><i class="glyphicon glyphicon-thumbs-up" style="font-size:30px">&emsp;${boardShareRecipe.recommand }</i></a>
					</form></h5>
                    <%-- <i class="glyphicon glyphicon-thumbs-up" style="font-size:30px"> ${boardShareRecipe.recommand }</i> --%>
                </div>
                <hr>
                <div class="li-text3">
                	<div class="li-sub3">
	                	<h2>재료 Ingredients </h2>
	                	<hr>
	                	<%-- <c:forEach items="${share}" var="row">
	                		${row.irdntId}
						</c:forEach> --%>
				
						<li>${irdntList }</li>
						
                	</div>
                </div>
                <hr>
                <div class="li-text3">
                	<h2>내용 Contents</h2>
                	<hr>
                	<!-- 띄어쓰기, 엔터  -->
                	<p class="li-sub3">${fn:replace(boardShareRecipe.txt, cn, br)} </p>
                </div>
                <hr>
                <div class="li-head3">
                	<h2>기타재료 Other materials</h2>
                	<hr>
                	<p class="li-sub3">${boardShareRecipe.etc }</p>
                </div>
                <hr>
            </div>    
            
        </li>
   
    </ul>
</div>
</div>
 </div>



</body>
</html>
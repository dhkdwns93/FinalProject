<%@page import="kr.co.turnup_fridger.vo.BoardShareRecipe"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<!-- cardList.css -->
<link href="${initParam.rootPath }/css/cardList.css" rel="stylesheet" type="text/css">
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

	
	return location.href="/turnup_fridger/boardRecipe/boardRecipe_view";
	
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
	return location.href="/turnup_fridger/boardRecipe/boardRecipe_view";
}

</script>

<style type="text/css">
#rcorners2{
	boarder-radius:25px;
	border: 2px solid #73AD21;
    padding: 20px; 
    width: 200px;
    height: 150px; 
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
<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do">목록</a>
<hr>
<h2>게시물 보기(상세페이지)</h2>

<%-- <div id="pattern" class="pattern">
    <ul class="list3 img-list3">
         <li>
            	<div class="li-text3">
            		<p class="li-sub3">${boardShareRecipe.recipeId }</p>
            		<p class="li-sub3">
            		<i class="glyphicon glyphicon-calendar" style="font-size:13px">
            		<fmt:formatDate value="${boardShareRecipe.date}" pattern="yyyy년 MM월 dd일"/>
            		</i></p>
            	</div>
         
                <div class="li-img3">
                    <img src="${initParam.rootPath }/img/1.jpg" alt="${boardShareRecipe.original }" />
                    <!-- ${top.upImage}-->
                </div>
         
                <div class="li-text3">
            		<p class="li-head3"> ${boardShareRecipe.title} </p>
            	</div>
       
                <div class="li-text3">
                    <h5 class="li-head3"><i class="glyphicon glyphicon-user" style="font-size:20px"> ${boardShareRecipe.memberId }</i>
                    <i class="glyphicon glyphicon-eye-open" style="font-size:20px">  ${boardShareRecipe.hits }</i> 
                    <i class="glyphicon glyphicon-thumbs-up" style="font-size:20px"> ${boardShareRecipe.recommand }</i></h5>
                </div>
        </li>
   
    </ul>
</div> --%>
<div id="pattern" class="pattern">
	<ul class="list3 img-list3">
	
        <li>
          <%-- <a href="${initParam.rootPath }/boardRecipe/boardRecipeView.do?recipeId=${boardShareRecipe.recipeId}" class="inner3"> --%>
            <div class="inner3">	
            	<div class="li-text3">
            		<p class="li-sub3">
            		<i class="glyphicon glyphicon-calendar" style="font-size:20px">
            		<fmt:formatDate value="${boardShareRecipe.date}" pattern="yyyy년 MM월 dd일"/></i></p>
            	</div>
            	<hr>
                <div class="li-img3">
                    <img src="${initParam.rootPath }/img/1.jpg" alt="${boardShareRecipe.original }" />
                    <!-- ${top.upImage}-->
                </div>
                <hr>
                <div class="li-text3">
            		<p class="li-head3">${boardShareRecipe.recipeId } 제목 : ${boardShareRecipe.title } </p>
            	</div>
            	<hr>
                <div class="li-text3">
                    <h5 class="li-head3"><i class="glyphicon glyphicon-user" style="font-size:20px"> ${boardShareRecipe.memberId }</i>
                    <i class="glyphicon glyphicon-eye-open" style="font-size:20px">  ${boardShareRecipe.hits }</i>
                    <i class="glyphicon glyphicon-thumbs-up" style="font-size:20px"> ${boardShareRecipe.recommand }</i></h5>
                </div>
                <hr>
                <div class="li-text3">
                	<div class="li-sub3">
	                	<p>재료 Ingredients </p>
	                	<c:forEach items="${list}" var="row">
							<c:forEach items="${irdntId }" var="list">
							${list.irdntName}
							</c:forEach>
						</c:forEach>
                	</div>
                </div>
                <hr>
                <div class="li-text3">
                	<p>내용</p>
                	<p class="li-sub3">${boardShareRecipe.txt } </p>
                </div>
                <hr>
                <div class="li-head3">
                	<p>기타재료 Other materials</p>
                	<p class="li-sub3">${boardShareRecipe.etc }</p>
                </div>
                <hr>
            </div>    
            <!-- </a> -->
        </li>
   
    </ul>
</div>






	<%-- <table border="1" width="500px" class="table table-bordered">
		<c:forEach items="${requestScope.list }" var="view">
		<tr>
			<th>번호</th>
			<td>${boardShareRecipe.recipeId }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${boardShareRecipe.title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${boardShareRecipe.memberId }</td>
		</tr>
		<tr>	
			<th>작성일</th>
			<td><fmt:formatDate value="${boardShareRecipe.date}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
		</tr>
		<tr>
			<th>재료</th>
			<td>
			<c:forEach items="${list}" var="row">
				<c:forEach items="${irdntId }" var="list">
				${list.irdntName}
				</c:forEach>
			</c:forEach>

			</td> 
		</tr>
		<tr>
			<th>내용</th>
			<td>${boardShareRecipe.txt}</td>
		</tr>
		<tr>	
			<th>추천수</th>
			<td>${boardShareRecipe.recommand}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${boardShareRecipe.hits }</td>
		</tr>
		
		</c:forEach>
	</table> --%>
<!-- 회원만 수정/삭제 가능 (자기자신이 올린 게시물만 가능) -->
<sec:authorize access="hasRole('ROLE_MEMBER')"> <!-- 회원만 볼 수 있게 -->
<form action="${initParam.rootPath }/common/boardReipce/boardRecipeUpdate.do" method="post">

	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="hidden" name="recipeId" 				value="${boardShareRecipe.recipeId}">	
	<input type="hidden" name="writer" 					value="${boardShareRecipe.memberId}">
 	<input type="hidden" name="memberId" 				value="<sec:authentication property="principal.memberId"/>">
	<input type="submit" value="수정" onclick="return update_event();" class="btn">

</form>
<form action="${initParam.rootPath }/common/boardRecipe/boardRecipeDelete.do" method="post">
	<input type="hidden" name="${_csrf.parameterName }" 	value="${_csrf.token }">
	<input type="hidden" name="recipeId"					value="${boardShareRecipe.recipeId }">
	<input type="hidden" name="memberId" 					value="<sec:authentication property="principal.memberId"/>">
	<input type="hidden" name="writer" 						value="${boardShareRecipe.memberId }">

	<input type="submit" value="삭제" onclick="return delete_event();" class="btn">

</form>
</sec:authorize>


<!-- 관리자 권한 폼 -->
<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
<form action="${initParam.rootPath}/common/member/boardRecipe/boardRecipeDelete.do" method="post">
<input type="hidden" name="${_csrf.parameterName }" 		value="${_csrf.token }">
	<input type="hidden" name="recipeId" 					value="${boardShareRecipe.recipeId }">
	<input type="hidden" name="writer" 						value="${boardShareRecipe.memberId}">
	<input type="hidden" name="adminId" 					value="<sec:authentication property="principal.adminId"/>">
	<input type="hidden" name="memberId" 					value="">
	<input type="submit" value="삭제하기" class="btn">
</form>
</sec:authorize>
</body>
</html>
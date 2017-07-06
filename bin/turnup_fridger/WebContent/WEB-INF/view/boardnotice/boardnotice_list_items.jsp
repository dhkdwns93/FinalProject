<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger2/scripts/jquery.js"></script>
<script type="text/javascript">
/* $(document).ready(function(){
	$("#items").on("change",function(){
		$.ajax
		({
			"url":"/turnup_fridger2/boardnotice/boardNoticeByItems.do",
			"type":"POST",
			"data":{"items":$("#items").val()},
			"dataType":"json",
			"success":function(obj)
			{
				$("#tbody").empty();
				var txt = "";
				$.each(obj, function()
				{
					txt = txt+"<tr><td>"+this.id+"</td><td>"+this.items+"</td><td><a href=/turnup_fridger2/boardnotice/boardNoticeView.do?id="+this.id+">"+this.title+"</td><td>"+this.date+"</td><td>관리자</td>";
					$("#tbody").html(txt);
				});
			}
		});
		
	});
}); */
</script>
<style type="text/css">
a:link{
	/*방문하지 않은 링크 설정.*/
	text-decoration:none; /*밑줄 안나오도록 처리.*/
	color:black;
}
a:visited{
	/*방문한 링크 설정*/
	text-decoration: none;
	color:black;
}
a:hover{
	/*마우스 포인터가 올라간 시점의 설정.*/
	text-decoration: underline;
	color:red;
}
</style>
</head>
<body>

<form action="${initParam.rootPath}/boardnotice/boardNoticeByItems.do" method="post">
<select name="items" id="items" value="${requestScope.items}">
	 <!-- 검색조건을 검색처리후 결과화면에 보여주기위해  c:out 출력태그 사용, 삼항연산자 -->
	<option value="전체보기">전체보기</option>
	<option value="공지사항">공지사항</option>
	<option value="뉴스">뉴스</option>
	<input type="submit" value="검색"/>
</select>
<sec:csrfInput/>
</form>
<table border="1" width="600px">
<thead id="thead">
    <tr>
        <th>번호</th>
        <th>말머리</th>
        <th>제목</th>
        <th>작성일</th>
        <th>작성자</th>
    </tr>
 </thead>
 
<tbody id="tbody">
<c:forEach var="row" items="${list}">
    <tr>
        <td>${row.id}</td>
        <td>${row.items}</td>
        <td><a href="${initParam.rootPath}/boardnotice/boardNoticeView.do?id=${row.id}">${row.title}</td>
        <td>
            <fmt:formatDate value="${row.date}" pattern="yyyy-MM-dd"/>
        </td>
        <td>관리자</td>
    </tr>    
</c:forEach>
 </tbody>
</table>






<p>
	<%-- ######################################################
														페이징 처리
			###################################################### --%>
	<!-- 첫페이지로 이동 -->
	<a href="${initParam.rootPath}/boardnotice/boardNoticeByItems.do?page=1&items=${requestScope.items}">첫페이지</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup}">
			<%-- 이전페이지 그룹이 있디면 : previousPageGroup()--%>
			<a href="${initParam.rootPath }/boardnotice/boardNoticeByItems.do?page=${requestScope.pageBean.beginPage - 1}&items=${requestScope.items}">☜</a>
		</c:when>
		<c:otherwise>
				☜	
		</c:otherwise>
	</c:choose>
	
	<!-- 
		현재 page가 속한 page 그룹내의 페이지들 링크.
		현재 pageGroup의 시작page ~ 끝 page
	 -->
	 <!-- 만약에 page가 현재페이지면 링크처리를 하지 않고 page가 현재페이지가 아니라면 링크처리. -->
		<c:forEach begin="${requestScope.pageBean.beginPage}" end="${requestScope.pageBean.endPage}" var="page">
			<c:choose>
				<c:when test="${requestScope.pageBean.page != page}"> <%-- 현재패이지가 아니라면 --%>
					<a href="${initParam.rootPath}/boardnotice/boardNoticeByItems.do?page=${page}&items=${requestScope.items}">&nbsp;${page}&nbsp;</a>
				</c:when>
				<c:otherwise>
					&nbsp;[${page}]&nbsp;
				</c:otherwise>
			</c:choose>
		</c:forEach>
	

	
	
	<!-- 
		다음페이지 그룹으로 이동
		만약에 다음페이지 그룹이 있으면 링크 처리 없으면 화살표만 나오도록 처리
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.nextPageGroup}">
			<%-- 다음페이지 그룹이 있디면 : nextPageGroup()--%>
			<a href="${initParam.rootPath }/boardnotice/boardNoticeByItems.do?page=${requestScope.pageBean.endPage + 1}&items=${requestScope.items}">☞</a>
		</c:when>
		<c:otherwise>
				☞		
		</c:otherwise>
	</c:choose>			
	
	
	
	
	
	
	
	<!-- 마지막 페이지로 이동 -->
	<a href="${initParam.rootPath}/boardnotice/boardNoticeByItems.do?page=${requestScope.pageBean.totalPage}&items=${requestScope.items}">마지막페이지</a>





</p>
<a href="${initParam.rootPath}/boardnotice/boardnotice_form.do"><button>등록</button></a>
</body>
</html>
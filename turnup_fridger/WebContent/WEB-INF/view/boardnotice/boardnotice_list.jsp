<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger2/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#items").on("change",function(){
		$. ajax
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
					txt = txt+"<tr><td>"+this.id+"</td><td>"+this.items+"</td><td>"+this.title+"</td><td>"+this.date+"</td><td>관리자</td>";
					$("#tbody").html(txt);
				});
			}
		});
		
	});
});
</script>
</head>
<body>

<select name="items" id="items" >
	<option value="전체보기">전체보기</option>
	<option value="공지사항" >공지사항</option>
	<option value="뉴스">뉴스</option>
</select>
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

<a href="${initParam.rootPath}/boardnotice/boardnotice_form.do"><button>등록</button></a>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<table border="1" width="600" style="text-align:center">
	<tr>
		<td>말머리</td>
		<td>${boardNotice.items}</td>
	</tr>
	<tr>
		<td>제목</td>
		<td>${boardNotice.title}</td>
	</tr>
	<tr>
		<td>작성날짜</td>
		<td><fmt:formatDate value="${boardNotice.date}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td>관리자</td>
	</tr>	
	<tr>
		<td>내용</td>
		<td>${boardNotice.img}<br>${boardNotice.txt}</td>
	</tr>
</table>
<form action="${initParam.rootPath}/boardnotice/boardNoticeList.do" method="post">
	<input type="submit" value="뒤로가기"/>
</form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
span, td, th{
	padding: 5px; 
}
span.error{
	font-size:small;
	color: red;
}
</style>
</head>
<body>
<form action="${initParam.rootPath}/boardnotice/boardNoticeAdd.do" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" value="${boardNotice.title}" placeholder="제목을 입력해주세요"><span class="error"><form:errors path="boardNotice.title" delimiter="&nbsp;"/></td>
	</tr>
	<tr>
		<th>말머리</th>
		<td>
			<select name="items" id="items">
			<option>공지사항</option>
			<option>뉴스</option>
			</select>
		</td>
	</tr>
	<tr>	
		<th>사진</th>
		<td><input type="file" name="upImage"></td>
	</tr>

	<tr>
		<th>내용</th>
		<td><textarea name="txt" row="120" cols="70" placeholder="내용을 입력해주세요">${boardNotice.txt}</textarea><span class="error"><form:errors path="boardNotice.txt" delimiter="&nbsp;"/></td>
	</tr>	
	<tr>
		<td>
			<input type="submit" value="등록">
		</td>
	</tr>
</table>
<sec:csrfInput/>
</form>
</body>
</html>
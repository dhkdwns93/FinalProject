<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" 
href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
function modify_event(){
	if (confirm("수정 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/boardnotice/boardnotice_view.do";
	}else{   
		//취소
	    return false;
	}
};
</script>
<style type="text/css">
form{display:inline}
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
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>
<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
<br><br>
<h1>공지사항 수정</h1>
<hr>
<c:if test="${boardNotice.saveImg != null}">
<form action="${initParam.rootPath}/common/admin/boardnotice/boardNoticeImageDelete.do" method="post">
		<input type="hidden" name="id" value="${boardNotice.id}">
		<input type="hidden" name="items" value="${boardNotice.items}">
		<input type="hidden" name="title" value="${boardNotice.title}">
		<input type="hidden" name="txt" value="${boardNotice.txt}">
		<input type="hidden" name="img" value="${boardNotice.img}">
		<input type="hidden" name="saveImg" value="${boardNotice.saveImg}">
		<input class="btn btn-default" type="submit" value="이미지 삭제">
<sec:csrfInput/>
</form>
</c:if>
<form action="${initParam.rootPath}/common/admin/boardnotice/boardNoticeUploadForm.do" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<td>제목</td>
		<td>
			<input type="text" name="title" value="${boardNotice.title}" placeholder="제목을 입력해주세요" class="form-control">
			<span class="error"><form:errors path="boardNotice.title" delimiter="&nbsp;"/></span>
		</td>
	</tr>
	<tr>
		<td>말머리</td>
		<td>
			<select class="form-control" name="items" id="items">
			<option>공지사항</option>
			<option>뉴스</option>
			</select>
		</td>
	</tr>
		<c:if test="${boardNotice.saveImg == null}">
		<tr>
			<td>사진</td>
			<td>
				<input type="file" name="upImage">
			</td>
		</tr>
		</c:if>		
		<c:if test="${boardNotice.saveImg != null}">
		<tr>	
			<td>사진</td>
			<td>
				${boardNotice.img}<br>
			</td>
		</tr>
		</c:if>
	<tr>	
		<td>내용</td>
		<td>
			<textarea name="txt" row="120" cols="70" placeholder="내용을 입력해주세요" class="form-control">${boardNotice.txt}</textarea>
			<span class="error"><form:errors path="boardNotice.txt" delimiter="&nbsp;"/></span>
		</td>
	</tr>	
</table>
	<input type="hidden" name="id" value="${boardNotice.id}">
	<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return modify_event();">
		<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
	</button>
<sec:csrfInput/>
</form>
<form action="${initParam.rootPath}/boardnotice/boardNoticeView.do" method="post">
    <input type="hidden" name="id" value="${boardNotice.id}">
    <button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
		<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
	</button>
<sec:csrfInput/>
</form>
</div>
</body>
</html>
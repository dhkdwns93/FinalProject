<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<h1>공지사항 수정</h1><br>
<hr>
<c:if test="${boardNotice.saveImg != null}">
<form action="${initParam.rootPath}/common/admin/boardnotice/boardNoticeImageDelete.do" method="post">
		<input type="hidden" name="id" value="${boardNotice.id}">
		<input type="hidden" name="items" value="${boardNotice.items}">
		<input type="hidden" name="title" value="${boardNotice.title}">
		<input type="hidden" name="txt" value="${boardNotice.txt}">
		<input type="hidden" name="img" value="${boardNotice.img}">
		<input type="hidden" name="saveImg" value="${boardNotice.saveImg}">
		<input type="submit" value="이미지 삭제">
<sec:csrfInput/>
</form>
</c:if>
<form action="${initParam.rootPath}/common/admin/boardnotice/boardNoticeUploadForm.do" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<td>제목</td>
	</tr>
	<tr>
		<td>
			<input type="text" name="title" value="${boardNotice.title}" placeholder="제목을 입력해주세요" class="form-control">
			<span class="error"><form:errors path="boardNotice.title" delimiter="&nbsp;"/></span>
		</td>
	</tr>
	<tr>
		<td>
		</td>
	</tr>
	<tr>
		<td>말머리</td>
	</tr>
	<tr>
		<td>
			<select name="items" id="items">
			<option>공지사항</option>
			<option>뉴스</option>
			</select>
		</td>
	</tr>
		<c:if test="${boardNotice.saveImg == null}">
		<tr>
			<td>사진</td>
		</tr>
		<tr>
			<td>
				<input type="file" name="upImage">
			</td>
		</tr>
		</c:if>
		
		<c:if test="${boardNotice.saveImg != null}">
		<tr>	
			<td>사진</td>
		</tr>
		<tr>
			<td>
				${boardNotice.img}<br>
			</td>
		</tr>
		</c:if>
	<tr>
		<td>
		</td>
	</tr>
	<tr>	
		<td>내용</td>
	</tr>
	<tr>
		<td>
			<textarea name="txt" row="120" cols="70" placeholder="내용을 입력해주세요" class="form-control">${boardNotice.txt}</textarea>
			<span class="error"><form:errors path="boardNotice.txt" delimiter="&nbsp;"/></span>
		</td>
	</tr>	
</table>
	<input type="hidden" name="id" value="${boardNotice.id}">
	<input type="submit" value="등록" onclick="return modify_event();">
<sec:csrfInput/>
</form>
<form action="${initParam.rootPath}/boardnotice/boardNoticeView.do" method="post">
    <input type="hidden" name="id" value="${boardNotice.id}">
	<input type="submit" value="뒤로가기">
<sec:csrfInput/>
</form>
</div>
</body>
</html>
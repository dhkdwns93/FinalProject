<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글작성</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- Latest compiled and minified CSS 아이콘 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script type="text/javascript">
function update_event(){
	if(confirm("수정 완료")==true){
		location.href="${initParam.rootPath}/boardRecipe/boardRecipe_updateOk.do";
	}
}
function insert_event(){
	if(confirm("등록 WANT?")==true){
		location.href="${initParam.rootPath}/boardRecipe/boardRecipeList.do";
	}else{
		return false;
	}
}
var numberAddInsert=0;
$(document).ready(function(){
		$(document).on("click", "button#insertShareRecipeIrdnt", function(){
			if(numberAddInsert<20){
				window.open("${initParam.rootPath}/common/member/boardRecipe/boardRecipe_search_result.do", "search_result", "width=900,height=400,resizable=yes");
				var inputTextHtml=$('#seeIrdnt').append('<div id="ShareRecipeIrdntText"><input type="hidden" id="irdntId" name="irdntId" value="${param.irdntId}" ><input type="text" id="irdntName" name="irdntName" value=${param.irdntName}>&nbsp&nbsp<button type="button" id="deleteIrdnt" class="btn btn-default">재료삭제</button><br></div>');
				numberAddInsert=numberAddInsert+1;
			}else{
				$('span#irdnterror').text("재료선택은 20개까지 선택가능합니다.");
			}
		});
		
		$("div#seeIrdnt").on("click", "button#deleteIrdnt", function(){
			var ShareRecipeIrdntText=$(this).parent().remove();
	});
});
</script>
<style>
div.ex1{
	direction: rtl;
}

.where {
  display: block;
  margin: 25px 15px;
  font-size: 11px;
  color: #000;
  text-decoration: none;
  font-family: verdana;
  font-style: italic;
} 

.filebox input[type="file"] {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip:rect(0,0,0,0);
    border: 0;
}

.filebox label {
    display: inline-block;
    padding: .5em .75em;
    color: #999;
    font-size: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #fdfdfd;
    cursor: pointer;
    border: 1px solid #ebebeb;
    border-bottom-color: #e2e2e2;
    border-radius: .25em;
}


.filebox .upload-name {
    display: inline-block;
    padding: .5em .75em;
    font-size: inherit;
    font-family: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #f5f5f5;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
}
.ccformfield {
	color:#000000; 
	background:#FFFFFF;
	border: 1px solid #f1f1f1;
	padding:15.5px;
	width:60%;
	height:34px;
	font-family: 'Lato',Arial,sans-serif;
	font-size:14px;
	margin:0;
}
.ccfield-prepend{
	margin-bottom:20px;
	width:100%;
}
.ccform-addon{
	color:#bfbfbf; 
	float:left;
	padding:8px;
	width:8%;
	height:34px;
	background:#FFFFFF;
	border: 1px solid #f1f1f1;
	text-align:center;
	
}
.ccformfield {
	color:#000000; 
	background:#FFFFFF;
	border: 1px solid #f1f1f1;
	padding:15.5px;
	width:60%;
	height:34px;
	font-family: 'Lato',Arial,sans-serif;
	font-size:14px;
	margin:0;
}
.ccformfield2 {
	color:#000000; 
	background:#FFFFFF;
	border: 1px solid #f1f1f1;
	padding:15.5px;
	width:70%;
	height:80px;
	font-family: 'Lato',Arial,sans-serif;
	font-size:14px;
	margin:0;
}
.ccformfield2 {
	font-family: 'Lato',Arial,sans-serif;
}
.ccformfield {
	font-family: 'Lato',Arial,sans-serif;
}
.ccbtn{
	font-size:13px;
	border:none;
	background:#a6a6a6;
	height:28px;
	color:#FFFFFF;
	cursor:pointer;
	text-decoration:none;
	font-weight:bold;
}
.ccbtn:hover{
	background:#737373;
}
.ccfield-submit-part{
	text-align:center;
}
div.align{
text-align:right;
}
/* 에러메시지 */
.error{
  font-size:80% !important;
  color:#808080 !important;
}
</style>
</head>
<body>
<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
<h2>글수정</h2>
<hr>
		
<c:if test="${requestScope.error != null }">
	<script type="text/javascript">alert("사진을 등록하세요.");</script>
</c:if>																									

<form method="post" action="${initParam.rootPath }/common/boardRecipe/boardRecipeUpdateOk.do"<%--  enctype="multipart/form-data" --%> name="boardPopup" >
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<table class="table table-bordered"  style="width:100%; border:1; ">
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="memberId" value="${boardShareRecipe.memberId}" class="ccformfield" readonly>
				
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="title" size="20" value="${boardShareRecipe.title}" class="ccformfield">
					<span class="error"><form:errors path="boardShareRecipe.title" delimiter="&nbsp;&nbsp;"/></span>
				</td>
			</tr>
			<tr>
			<th>재료명</th>
				<td>
				<div id="seeIrdnt">
					<button type="button" id="insertShareRecipeIrdnt" class="btn">사용한재료추가</button><br>
					<c:forEach items="${boardShareRecipe.shareRecipeIrdnt }" var="share">
						<c:forEach items="${share.irdntId }" var="myIrdntName">
							<input type="text" name="irdntId" value="${myIrdntName.irdntName }">
						</c:forEach>
					</c:forEach>
				</div> 
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="4" cols="80" name="txt" class="ccformfield2">${boardShareRecipe.txt}</textarea>
					<span class="error"><form:errors path="boardShareRecipe.txt" delimiter="&nbsp;&nbsp;" class="ccformfield"/></span>
				</td>
			</tr>
			<tr>
				<th>사진</th>
				<td><div class="filebox bs3-primary">
                            <input value="${boardShareRecipe.original}" class="ccformfield" value="사진선택" disabled="disabled">

                            <label for="ex_filename">업로드</label> 
                          <input type="file" id="ex_filename" name="upImage" class="upload-hidden">
					<!-- 이미지 업로드
					<input type="file" name="upImage" > -->
					<input type="hidden" name="saveName" value="${boardShareRecipe.saveName}" readonly>
					<input type="hidden" name="original" value="${boardShareRecipe.original}" readonly>
				</div></td>
			</tr>
			<tr>
				<th>기타재료</th>
				<td>
				<textarea rows="4" cols="80" name="etc" class="ccformfield2">${boardShareRecipe.etc}</textarea>
				<%-- <input type="text" name="etc" value="${boardShareRecipe.etc}" class="ccformfield2"> --%>
				</td>
			</tr>
			
			</table>
			<input type="hidden" name="date" value="${boardShareRecipe.date}">
			<input type="hidden" name="recipeId" value="${boardShareRecipe.recipeId}">
			<input type="hidden" name="recommand" value="${boardShareRecipe.recommand }">
			<input type="hidden" name="hits" value="${boardShareRecipe.hits }">
		</form>	
			<div class="form-inline form-group" >
			<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;" onclick="return update_event();">
				<span class="glyphicon glyphicon-ok" aria-hidden="true">수정</span>
			</button>
			<button type="button" class="btn btn-default btn-lg" style="border:0;outline:0;" onClick="location.reload();" >
				<span class="glyphicon glyphicon-refresh" aria-hidden="true">초기화</span>
			</button>
			<!-- 뒤로가기 -->
			<button type="button" class="btn btn-default btn-lg" style="border:0;outline:0;" onClick="javascript:history.go(-1);" >
					<span class="glyphicon glyphicon-arrow-left" aria-hidden="true">뒤로가기</span>
				</button>
			</div>
		
</div>
</body>
</html>











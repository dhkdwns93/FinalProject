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
<!-- Latest compiled and minified CSS 아이콘 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
/*/* function popupRecipeName()
{
	
	window.open("/turnup_fridger2.2/boardRecipe/boardRecipe_search_result.do","recipeName","width=1100, height=700");
}  */

function list(){
	return location.href="${initParam.rootPath }/boardRecipe/boardRecipeList.do";
	
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
				window.open("${initParam.rootPath}/common/member/boardRecipe/boardRecipe_search_result.do", "search_result", "width=500,height=400,resizable=yes");
				var inputTextHtml=$('#seeIrdnt').append('<div id="ShareRecipeIrdntText"><input type="hidden" id="irdntId" name="irdntId" value="${param.irdntId}" ><input type="text" id="irdntName" name="meIrdntName" value=${param.irdntName}>&nbsp&nbsp<button type="button" id="deleteIrdnt" class="btn">재료삭제</button><br></div>');
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

.filebox.bs3-primary label {
  color: #fff;
    background-color: #337ab7;
    border-color: #2e6da4;
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
/* 에러메시지 */
.error{
  font-size:80% !important;
  color:#808080 !important;
}
#absolute {
  
  position: absolute;
  right: 0;
} 
td, th{
	padding:30px;
}
</style>
</head>
<body>
<c:if test="${requestScope.error != null }">
	<script type="text/javascript">alert("사진을 등록하세요.");</script>
</c:if>								
<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">					
<legend>글쓰기 </legend><div class="absolute">
		<button type="button" class="btn btn-default btn-lg" style="border:0;outline:0;" onClick="return list();" >
			<span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true" >목록</span>
		</button>
	
	</div>
	<form method="post" action="${initParam.rootPath}/common/member/boardRecipe/boardRecipeRegister.do" enctype="multipart/form-data" name="boardPopup" >
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<table class="table table-bordered">
			<tr>
				<th>작성자</th>
				<td>
				<sec:authentication property="principal.memberId" var="memberId"/>
				<input type="text" name="memberId" value="${memberId }" class="ccformfield" readonly>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				
				<td>
				<input type="text" name="title" size="20" placeholder="제목을 입력해주세요"
				value="${param.title }" class="ccformfield"><span class="error">
				<form:errors path="boardShareRecipe.title" delimiter="&nbsp;&nbsp;"/>
				</span>
				</td>
				
			</tr>
			
			<tr>
			<th>재료선택</th>
			
				<td>
				<div id="seeIrdnt">
				<span class="error">
					<form:errors path="shareRecipeIrdnt.irdntId" delimiter="&nbsp;&nbsp;"/></span>
					<%-- <input type="text" name ="meIrdntName" id="meIrdntName" value="${param.irdntName }" readonly> --%> 
					
					<!-- 검색클릭하면 재료명으로 검색해서 id만 골라오는거 하기. 여기에 id저장. --> 
					<!-- <input type="button" id="recipeName" value="검색" onclick="popupRecipeName()" > -->
					<button type="button" id="insertShareRecipeIrdnt" class="btn">사용한재료추가</button><br>
					<div id="ShareRecipeIrdnt">
					<input type="hidden" name="irdntId" id="irdntId" value="-1" class="ccformfield" readonly><br>
					<input type="hidden" name="meIrdntName" id="meIrdntName" class="ccformfield" value="-1" >
					</div>
				</div>
				</td>
			</tr>
			
			<tr>
				<th>내용</th>
				<td><textarea rows="4" cols="80" name="txt" class="ccformfield2" placeholder="내용을 입력주세요" value="${param.txt }"></textarea>
				<span class="error">
				<form:errors path="boardShareRecipe.txt" delimiter="&nbsp;&nbsp;"/>
				
				</span>
				</td>
			</tr>
			<tr>
			
				<th>사진</th>
				<td><div class="filebox bs3-primary">
                            <input class="ccformfield" class="ccformfield" value="${param.original }" disabled="disabled">

                            <label for="ex_filename">업로드</label> 
                          <input type="file" id="ex_filename" name="upImage" class="upload-hidden"> 
                        </div>
			<!-- 	<input type="text" value="" placeholder="사진을 선택해주세요"><input type="file" name="upImage" > -->
				</td>
			</tr>
			<tr>
				<th>기타재료</th>
				<td>
				<textarea rows="4" cols="80" name="etc" class="ccformfield2" placeholder="기타재료를 입력주세요" value="${param.etc }"></textarea>
				<%-- <input type="text" name="etc" row="10" cols="80" placeholder="기타재료를 입력주세요" class="ccformfield"
				value="${param.etc }"> --%>
				</td>
			</tr>
			</table>
		<input type="hidden" name="recipeId" value="0"> 
		<input type="hidden" name="recommand" value="0">
		<input type="hidden" name="hits" value="0" >
		<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;"  >
			<span class="glyphicon glyphicon-pencil" aria-hidden="true">등록</span>
		</button>
		
		<button type="button" class="btn btn-default btn-lg" style="border:0;outline:0;" onClick="return list();" >
			<span class="glyphicon glyphicon-remove" aria-hidden="true" >취소</span>
		</button>
		 
		 
		 <button type="button" class="btn btn-default btn-lg" style="border:0;outline:0;" onclick="location.reload()" >
			<span class="glyphicon glyphicon-refresh" aria-hidden="true">초기화</span>
		</button>
	
		</form>
		
		
		</div>
	
</body>
</html>
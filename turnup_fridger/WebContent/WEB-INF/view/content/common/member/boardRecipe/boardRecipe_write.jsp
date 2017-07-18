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
<script type="text/javascript">
/*/* function popupRecipeName()
{
	
	window.open("/turnup_fridger2.2/boardRecipe/boardRecipe_search_result.do","recipeName","width=1100, height=700");
}  */
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
</style>
</head>
<body>
<c:if test="${requestScope.error != null }">
	<script type="text/javascript">alert("사진을 등록하세요.");</script>
</c:if>								
					
<legend>글쓰기 </legend>
	<form method="post" action="${initParam.rootPath}/common/member/boardRecipe/boardRecipeRegister.do" enctype="multipart/form-data" name="boardPopup" >
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<table class="table table-bordered">
			<tr>
				<th>작성자</th>
				<td>
				<sec:authentication property="principal.memberId" var="memberId"/>
				<input type="text" name="memberId" value="${memberId }" readonly>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				
				<td>
				<input type="text" name="title" size="20" placeholder="제목을 입력해주세요"
				value="${param.title }"><span class="error">
				<form:errors path="boardShareRecipe.title" delimiter="&nbsp;&nbsp;"/>
				</span>
				</td>
				
			</tr>
			
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
					<input type="hidden" name="irdntId" id="irdntId" value="-1" readonly><br>
					<input type="hidden" name="meIrdntName" id="meIrdntName" value="-1" >
					</div>
				</div>
				</td>
			</tr>
			
			<tr>
				<th>내용</th>
				<td><textarea rows="4" cols="80" name="txt" placeholder="내용을 입력주세요" value="${param.txt }"></textarea>
				<span class="error">
				<form:errors path="boardShareRecipe.txt" delimiter="&nbsp;&nbsp;"/>
				
				</span>
				</td>
			</tr>
			<tr>
				<th>사진</th>
				<td><div class="filebox bs3-primary">
                            <input class="upload-name" value="사진선택" disabled="disabled">

                            <label for="ex_filename">업로드</label> 
                          <input type="file" id="ex_filename" name="upImage" class="upload-hidden"> 
                        </div>
			<!-- 	<input type="text" value="" placeholder="사진을 선택해주세요"><input type="file" name="upImage" > -->
				</td>
			</tr>
			<tr>
				<th>기타재료</th>
				<td>
				<input type="text" name="etc" row="10" cols="80" placeholder="기타재료를 입력주세요"
				value="${param.etc }">
				</td>
			</tr>
			</table>
		<input type="hidden" name="recipeId" value="0"> 
		<input type="hidden" name="recommand" value="0">
		<input type="hidden" name="hits" value="0" >
		<button type="submit" id="submit" class="btn">등록</button>
		<input type="button" name="back" value="취소" onClick="javascript:history.go(-1);" class="btn"/>
		<%-- <a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do"><input type="button" value="취소" class="btn"/></a> --%>
		<button type="button" onclick="location.reload()" class="btn">초기화</button><br>
		</form>
		
		
		
	
</body>
</html>
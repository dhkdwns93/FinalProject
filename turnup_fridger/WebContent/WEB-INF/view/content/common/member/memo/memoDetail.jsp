<%@page import="java.util.Date"%>
<%@page import="kr.co.turnup_fridger.vo.MyMemo"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${initParam.rootPath}/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// 처음에 확인버튼 숨기기
	$("#submit").hide();
	
	// 수정버튼 클릭 → 수정화면으로 세팅(버튼 전환, readonly 해제)
	$("#mod").on("click", function(){
		$("#submit").show();
		$(".one").hide();
		$(".box").prop("readonly", false);
	}); 
	
	// 확인버튼 클릭 → 수정 처리
	$("#submit").on("click", function(){
		$.ajax({
			"url":"${initParam.rootPath}/memo/modMemo.do",
			"type": "post",
			"data": {'memoId' : '${requestScope.memo.memoId}', 'memoName' : $("#name").val(), 'memoTxt' : $("#txt").val(), '${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json",
			"success":function(memo){
				// 받아온 수정된 메모정보로 다시 상세보기화면 세팅
				alert('수정완료');
				$("#name").text(memo.memoName);
				$("#txt").text(memo.memoTxt);
				
				$(".box").prop("readonly", true);
				
				$("#submit").hide();
				$(".one").show();
			},
			"error":function(xhr, msg, code){
				alert('error - '+code)
			}
		});
	});
	
	// 삭제 처리
	$("#del").on("click", function(){
		if(confirm('정말 삭제하시겠습니까?')){
			$.ajax({
				"url":"${initParam.rootPath}/memo/delMemo.do",
				"data":"memoId=${requestScope.memo.memoId}",
				"success":function(){
					alert('삭제되었습니다');
					// 삭제후 메모목록화면으로 전환
					location.replace('${initParam.rootPath}/common/member/memo/memoList.do');
				}
			});// ajax
		}
		return false;
	});
});
</script> 
<style type="text/css">
@CHARSET "UTF-8";
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

div{
	font-size: 30px;
	text-align: right;
	font-family: 'Nanum Pen Script', serif;
	color: white;
}

body{
	background: url('${initParam.rootPath}/img/note.jpg') no-repeat center;
	background-size: cover;
}

#title{
	font-size: 30px;
	text-align: right;
	font-family: 'Nanum Pen Script', serif;
	color: white;
	}
	
table{
	align: center;
	text-align: center;
}
</style>
</head>
<body>
	<div>
		<fmt:formatDate value="${requestScope.memo.registeredDate }" pattern="yyyy년 MM월 dd일" />의 메모
	</div>
	<table align="center">
		<tr>
			<td><span class="error"><form:errors path="myMemo.memoName" /></span><br>
			<input type="text" id="name" class="box" name="memoName" size="50" value="${requestScope.memo.memoName}" readonly style="background-color: transparent"></td>
		</tr>
		<tr>
			<!-- rows : 세로  cols : 가로 -->
			<td><span class="error"><form:errors path="myMemo.memoTxt" /></span><br> 
			<textarea id="txt" rows="21" cols="51" class="box" name="memoTxt" readonly style="background-color: transparent">${requestScope.memo.memoTxt }</textarea></td>
		</tr>
		<tr>
			<td>
				 <button type="button" id="mod" class="one">수정</button>
				 <button type="button" id="del" class="one">삭제</button>
				 <button type="button" id="submit">확인</button>
			</td>
		</tr>
	</table>
</body>
</html>
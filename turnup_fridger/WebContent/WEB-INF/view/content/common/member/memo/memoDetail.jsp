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
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
				
				opener.location.reload(); // 수정처리 완료 후 부모창(메모목록) 새로고침
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
					window.close();	// 삭제후 팝업창 닫기
					opener.parent.location.reload(); // 닫으면서 부모창 새로고침
				}
			});// ajax
		}
		return false;
	});
	
	// 문자전송
	$("#send").on("click", function(){
		$.ajax({
			"url" : "${initParam.rootPath}/sms/sendSMS.do",
			"type" : "post",
			"data" : {'memoName' :$("#name").val(), 'memoTxt' : $("#txt").val(), 'memberTel' : $("#memberTel").val(), '${_csrf.parameterName}' : '${_csrf.token}'},
			"success" : function(){
				alert('전송 완료');
			}
		});
	});
	
});
</script> 
<style type="text/css">
@CHARSET "UTF-8";
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

 #memoDate{
	color: white;
	font-size: 30px;
	text-align: right;
	font-family: 'Nanum Pen Script', serif;
}

#detail{
	margin-left: auto;
	margin-right: auto;
}

body{
	text-align: center;
	background: url('${initParam.rootPath}/img/note-new.jpg') no-repeat center;
	background-size: cover;
}
#name, #txt{
	font-size: 18px;
}

</style>
</head>
<body>
	<div id="memoDate">
		<fmt:formatDate value="${requestScope.memo.registeredDate }" pattern="yyyy년 MM월 dd일" />의 장바구니 메모
	</div>
	<sec:authentication property='principal.memberTel' var='tel'/>
	<input type="hidden" id="memberTel" value="${tel}">
	<table id="detail">
		<tr>
			<td><span class="error"><form:errors path="myMemo.memoName" /></span><br>
			<input type="text" id="name" class="box" name="memoName" size="41" value="${requestScope.memo.memoName}" readonly style="background-color: transparent"></td>
		</tr>
		<tr>
			<!-- rows : 세로  cols : 가로 -->
			<td><span class="error"><form:errors path="myMemo.memoTxt" /></span><br> 
			<textarea id="txt" rows="12" cols="43" class="box" name="memoTxt" readonly style="background-color: transparent">${requestScope.memo.memoTxt }</textarea></td>
		</tr>
		<tr>
			<td>
				 <!-- <button type="button" id="mod" class="one btn btn-info">수정</button> -->
				 <button type="button" id="mod" class="btn btn-default btn-md one"  style="border:0;outline:0;paddind:auto;">
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
				</button>
				<!--  <button type="button" id="del" class="one">삭제</button> -->
				 <button type="button" id="del" class="btn btn-default btn-md one"  style="border:0;outline:0;">
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				 <!-- <button type="button" id="send" class="one">문자전송</button> -->
				 <button type="button" id="send" class="btn btn-default btn-md one"  style="border:0;outline:0;">
					<span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
				</button>
				 <!-- <button type="button" id="submit">확인</button> -->
				 <button type="button" id="submit" class="btn btn-default btn-md"  style="border:0;outline:0;">
					<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
				 </button>
			</td>
		</tr>
	</table>
</body>
</html>
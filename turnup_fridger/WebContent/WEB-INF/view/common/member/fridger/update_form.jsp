<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- <script type="text/javascript">
$(document).ready(function(){
	
	$(document).on("click","#submitBtn", function(){
		/* alert($("input#fridgerName").val());
		 window.opener.name = "parentPage"; // 부모창의 이름 설정
		    document.fridgerUpdateForm.target = "parentPage"; // 타켓을 부모창으로 설정
		   document.fridgerUpdateForm.action = "${ initParam.rootPath }/common/member/fridger/update.do";
		    document.fridgerUpdateForm.submit(); */
		    //self.close();
		alert($("input#fridgerName").val());
		$.ajax({
			"url":"${ initParam.rootPath }/common/member/fridger/update.do",
			"type":"post",
			"data":{'fridgerId' : $("input#fridgerId").val(),
					'fridgerName' : $("input#fridgerName").val(),
					'memberId': $("input#memberId").val(),
					'${_csrf.parameterName}':'${_csrf.token}'
					},
			"dataType":"text",
			"beforeSend":function(){	
				if(confirm("수정하시겠습니까?") != true){
					return false;
				}
			},
			"success": function(result){
				console.log(result);
				if(result == "success"){
				window.opener.location.reload;
				self.close();
				}
				location.reload;
				
		
				
		     },
	        "error":function(xhr, msg, code){
				alert("오류발생-" + code);
			}
			
		});	//end of ajax

	/*     document.fridgerUpdateForm.action = "${ initParam.rootPath }/common/member/fridger/update.do";
	    document.fridgerUpdateForm.submit();
 */
	}); 
})

</script> -->

<script type="text/javascript">
function closeWin(){
	document.fridgerUpdateForm.action="${ initParam.rootPath }/common/member/fridger/update.do";
	window.opener.location.reload();

}
</script>
<body>
	<h2>냉장고 업뎃폼</h2>	
	<form name="fridgerUpdateForm"  method="post" onsubmit="closeWin()">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<table>
			<tr>
				<th>냉장고 ID</th>
				<td><input type="text" name="fridgerId" id="fridgerId" value="${ requestScope.fridger.fridgerId }" readonly="readonly">
				<span class="error"><form:errors
							path="fridger.fridgerId" delimiter="&nbsp;"/>
							<c:if test="${ requestScope.errorMsg_fridgerId != null }">
							${ requestScope.errorMsg_fridgerId }
							</c:if>
							</span></td>
			
			</tr>
			<tr>
				<th>냉장고 이름</th>
				<td><input type="text" name="fridgerName" id="fridgerName"
					value="${ param.fridgerName }" placeholder="${ requestScope.fridger.fridgerName }">
					<span class="error"><form:errors
							path="fridger.fridgerName" delimiter="&nbsp;" />
							<c:if test="${ requestScope.errorMsg_fridgerName != null }">
							${ requestScope.errorMsg_fridgerName }
							</c:if>
							</span></td>
			</tr>
			<!-- 회원id는 principal 값으로  -->
			<tr>
				<th>냉장고주인ID</th>
				<sec:authentication property="principal.memberId" var="memberId"/>
				<td><input type="text" name="memberId" id="memberId" 
					placeholder="${ memberId }">
					<span class="error"><form:errors
							path="fridger.memberId" delimiter="&nbsp;" />
							<c:if test="${ requestScope.errorMsg_memberId != null }">
							${ requestScope.errorMsg_memberId }
							</c:if>
							</span>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" id="submitBtn" value="업데이트">
					<input type="reset" value="초기화">
				</td>
			</tr>
		</table>
		
	</form>


</body>
</html>
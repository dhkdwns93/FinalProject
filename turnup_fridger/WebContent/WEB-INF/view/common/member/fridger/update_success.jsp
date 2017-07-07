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
			"dataType":"json",
			"beforeSend":function(){	
				if(confirm("수정하시겠습니까?") != true){
					return false;
				}
			},
			"success": function(result){
				console.log(result);
			   if(result.resultCode=="SUCCESS"){
				  	window.opener.name = "parentPage"; // 부모창의 이름 설정
					document.fridgerUpdateForm.target = "parentPage"; // 타켓을 부모창으로 설정
					document.fridgerUpdateForm.submit();
					self.close();
			   }
				   
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
$(document).ready(function(){
	console.log(window.opener.location);	
	window.opener.location.reload;
	self.close();
});
</script>
<body>
<h2>업뎃 성공했다</h2>
냉장고 ID : ${ requestScope.fridger.fridgerId }<br>
냉장고 이름 : ${ requestScope.fridger.fridgerName }<br>
냉장고 주인 : ${ requestScope.fridger.memberId }<br>

</body>
</html>
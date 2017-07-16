<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)member_list
작성자 :  김경혜
최초 작성일 170705
변경이력 
170711 한번더회원탈퇴처리 확인
170712 전체회원리스트 스크롤처리, 회원명단 엑셀로 뽑아내기
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script src="/turnup_fridger/scripts/jquery.base64.min.js"></script>
<script src="/turnup_fridger/scripts/jquery.battatech.excelexport.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var btn=$("exportBtn");
	var tbl="tblExport";
	
	$("button#deleteMemberBtn").on("click",function(){
		return window.confirm("정말 이 회원을 탈퇴처리 하시겠습니까?");
	});//end of deleteMemberBtn
	
	//엑셀로 다운로드
	function itoStr($num){
		$num<10?$num='0'+$num:$num;
		return $num.toString();
	}
	$("a#exportBtn").on("click",function(){
		//파일명 지정
		var dt=new Date();
		var year=itoStr(dt.getFullYear());
		var month=itoStr(dt.getMonth()+1);
		var day=itoStr(dt.getDate());
		var hour=itoStr(dt.getHours());
		var mins=itoStr(dt.getMinutes());
		
		var downloadDate=year+month+day+"_"+hour+mins;
		var fileName="TurnupFridger_MemberList_"+downloadDate+".xls";
		
		var uri=$("#tblExport").btechco_excelexport({
			containerid:tbl, datatype:$datatype.Table, worksheetName:fileName, encoding:"UTF-8", returnUri:true
		});//end of uri
		
		$(this).prop('download',fileName).prop('href',uri).prop('target','_blank');;
	});//end of exportBtn 
});

</script>
</head>
<body>
<div class="container">
<jsp:include page="/WEB-INF/view/content/user/layout_menu_security.jsp" />
<hr>

<h2>전체개인회원정보</h2>
	<div id="wrap">
		<!-- 엑셀로 추출버튼 -->
		<a id="exportBtn" href="#" download=""><button type="button">(Excel)Download</button></a>
		<div id="allMemberList"
			style="border: 1px solid black; overflow-x: hidden; overflow-y: scroll; height: 150px; width: 1000px;">
			<table class="table" id="tblExport" border="1" width="900px">
				<thead id="thead">
					<tr>
						<th>번호</th>
						<th>회원 ID</th>
						<th>이름</th>
						<th>주소</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>성별</th>
						<th>관리자 기능</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="member" items="${requestScope.memberList}"
						varStatus="loop">
						<tr>
							<td>${(loop.index)+1}</td>
							<td>${member.memberId }</td>
							<td>${member.memberName }</td>
							<td>${member.memberAddress }</td>
							<td>${member.memberEmail }</td>
							<td>${member.memberTel}</td>
							<td>${member.memberSex}</td>
							<td>
								<!-- 개인회원강제탈퇴처리 -->
								<form
									action="${initParam.rootPath}/common/admin/member_delete.do"
									method="post">
									<input type="hidden" name="memberId" value="${member.memberId}">
									<sec:csrfInput />
									<button type="submit" id="deleteMemberBtn">탈퇴</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)admin_list
작성자 :  김경혜
최초 작성일 170705
변경이력 
170711 관리자 탈퇴처리 한번더확인, 관리자 권한처리 한번더확인
170712 전체관리자리스트 스크롤처리, 관리자명단 엑셀로 뽑아내기
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
	var loginId=$("input#loginId").val();
	var loginAuthority=$("input#loginAuthority").val();
	$("button#changeAdminAuthorityBtn").on("click",function(){
		var adminIdChange=$(this).parent().children(":nth-child(1)").val();
		var originalAuthorityChange=$(this).parent().children(":nth-child(2)").val();
		//headMaster는 권한수정이 불가
		if(originalAuthorityChange==("ROLE_HEADMASTERADMIN")){
			alert("HeadMaster관리자는 권한수정이 불가합니다.");
			return false;
		}
		//로그인한 관리자는 권한수정이 불가
		if(adminIdChange==loginId){
			alert("Login한 관리자는 권한수정이 불가합니다.");
			return false;
		}
		return window.confirm("정말 이 관리자의 권한을 수정 하시겠습니까?");
	});//end of changeAdminAuthorityBtn
	
	$("button#deleteAdminBtn").on("click",function(){
		var originalAuthorityChange=$(this).parent().children(":nth-child(2)").val();
		//headMaster는 탈퇴처리 불가
		if(originalAuthorityChange==("ROLE_HEADMASTERADMIN")){
			alert("HeadMaster관리자는 탈퇴처리가 불가합니다.");
			return false;
		}

		//Master관리자는 headMaster만 탈퇴처리 할 수 있음.
		if(originalAuthorityChange==("ROLE_MASTERADMIN")){
			if(loginAuthority!=("[ROLE_HEADMASTERADMIN]")){
				alert("Master관리자는 HeadMaster관리자만 탈퇴처리 할 수 있습니다.");
				return false;
			}
		}
		return window.confirm("정말 이 관리자를 탈퇴처리 하시겠습니까?");
	});//end of deleteAdminBtn
	
	//엑셀로 다운로드
	var btn=$("exportBtn");
	var tbl="tblExport";
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
		var fileName="TurnupFridger_AdminList_"+downloadDate+".xls";
		
		var uri=$("#tblExport").btechco_excelexport({
			containerid:tbl, datatype:$datatype.Table, worksheetName:fileName, encoding:"UTF-8", returnUri:true
		});//end of uri
		
		$(this).prop('download',fileName).prop('href',uri).prop('target','_blank');;
	});//end of exportBtn 
});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/view/content/user/layout_menu_security.jsp" />
<hr>


<h2>전체관리자등록정보</h2>
<input type="hidden" id="loginId" value='<sec:authentication property="principal.adminId"/>'>
<input type="hidden" id="loginAuthority" value='<sec:authentication property="authorities"/>'>
<div id="wrap">
	<!-- 엑셀로 추출버튼 -->
	<a id="exportBtn" href="#" download=""><button type="button">(Excel)Download</button></a>
	<div id="allAdminList"
		style="border: 1px solid black; overflow-x: hidden; overflow-y: scroll; height: 150px; width: 1000px;">
		<table id="tblExport" border="1" width="900px">
			<thead id="thead">
				<tr>
					<th>번호</th>
					<th>관리자 ID</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>관리자권한</th>
					<th>Master관리자 기능</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="admin" items="${requestScope.adminList}"
					varStatus="loop">
					<tr>
						<td>${(loop.index)+1}</td>
						<td>${admin.adminId }</td>
						<td>${admin.adminName }</td>
						<td>${admin.adminTel }</td>
						<td>${admin.adminEmail }</td>
						<td>${admin.adminAuthority }</td>
						<td>
							<!-- 일반 Admin에게 보이는 것 --> <sec:authorize
								access="hasRole('ROLE_ADMIN')">권한없음</sec:authorize> 
							<!-- MasterAdmin/HeadMasterAdmin에게 보이는 것  --> <sec:authorize
								access="hasAnyRole('ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
								<!-- 관리자권한수정 -->
								<form
									action="${initParam.rootPath }/common/admin/master/admin_change_authority.do"
									method="post">
									<input type="hidden" id="adminId" name="adminId"
										value="${admin.adminId }"> <input type="hidden"
										id="originalAuthority" name="originalAuthority"
										value="${admin.adminAuthority }"> <select
										name="adminAuthority" value="${admin.adminAuthority}">
										<option value="${admin.adminAuthority}">--권한선택--</option>
										<option value="ROLE_ADMIN">일반 Admin</option>
										<option value="ROLE_MASTERADMIN">MasterAdmin</option>
									</select>
									<sec:csrfInput />
									<button type="submit" id="changeAdminAuthorityBtn">권한수정</button>
								</form>

								<!-- 관리자탈퇴처리 -->
								<form
									action="${initParam.rootPath}/common/admin/master/admin_delete.do"
									method="post">
									<input type="hidden" id="adminId" name="adminId"
										value="${admin.adminId}"> <input type="hidden"
										id="originalAuthority" name="originalAuthority"
										value="${admin.adminAuthority }">
									<sec:csrfInput />
									<button type="submit" id="deleteAdminBtn">탈퇴</button>
								</form>
							</sec:authorize>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
		<hr>
 <sec:authorize access="hasAnyRole('ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
 마스터관리자메뉴(마스터관리자만)
 	<!-- 관리자 등록 -->
 	<a href="${initParam.rootPath}/common/admin/master/join_admin_form.do"><button type="button">관리자 등록</button></a>
 </sec:authorize>
</body>
</html>
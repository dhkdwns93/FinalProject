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
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/turnup_fridger/scripts/jquery.base64.min.js"></script>
<script src="/turnup_fridger/scripts/jquery.battatech.excelexport.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var loginId=$("input#loginId").val();
	var loginAuthority=$("input#loginAuthority").val();

	
	$(document).on("click","button#changeAdminAuthorityBtn",function(){
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
	
	$(document).on("click","button#deleteAdminBtn",function(){
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
	$(document).on("click","a#exportBtn",function(){
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
	
	/******* 관리자등록 popup *********/
	$("button#RegisterAdminBtn").on("click",function(){
		window.open("${initParam.rootPath}/common/admin/master/join_admin_form.do","join_admin_form","width=400,height=500,resizable=no");
	});//end of findIdPwBtn
	
});
</script>
<style>
/* contact-form 넓이*/
.form-page{
	width:110%;
	margin-left:5%;
}
/* EXCEL 형식 */
.ExcelTable2007 {
	border: 1px solid #B0CBEF;
	border-width: 1px 0px 0px 1px;
	width:100%;
	font-size: 15px;
	font-family: Calibri;
	font-weight: 100;
	border-spacing: 0px;
	border-collapse: collapse;
}
.ExcelTable2007 TH {
	background-image: url("${initParam.rootPath }/img/excel-2007-header-bg.gif");
	background-repeat: repeat-x; 
	font-weight: normal;
	font-size: 14px;
	border: 1px solid #9EB6CE;
	border-width: 0px 1px 1px 0px;
	height: 17px;
}
.ExcelTable2007 TD {
	border: 0px;
	background-color: white;
	padding: 0px 4px 0px 2px;
	border: 1px solid #D0D7E5;
	border-width: 0px 1px 1px 0px;
}
.ExcelTable2007 TD B {
	border: 0px;
	background-color: white;
	font-weight: bold;
}
.ExcelTable2007 TD.heading {
	background-color: #E4ECF7;
	text-align: center;
	border: 1px solid #9EB6CE;
	border-width: 0px 1px 1px 0px;
}
.ExcelTable2007 TH.heading {
	background-image: url("${initParam.rootPath }/img/excel-2007-header-left.gif");
	background-repeat: none;
}

h1 {
	font-family: "Viner Hand ITC" !important;
	src: url("/font/VINERITC.TTF");
	font-weight:bold !important;
	color:#4d4d4d !important;
}
</style>
</head>
<body>


<div class="container">
<div class='wrapperDiv'>
	<jsp:include page="/WEB-INF/view/layout/side_menu/adminSideMenu.jsp"/>
	<div class='right-box-sidemenu'>

	<div class="form-page">
	
		<h1>Manager Management</h1>
		<hr>
		<input type="hidden" id="loginId" value='<sec:authentication property="principal.adminId"/>'>
		<input type="hidden" id="loginAuthority" value='<sec:authentication property="authorities"/>'>
		<div id="wrap">
			<!-- 엑셀로 추출버튼 -->
			<a id="exportBtn" href="#" download=""><button type="button">(Excel)Download</button></a>
			
		 	<!-- 관리자 등록 -->
			<sec:authorize access="hasAnyRole('ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
		 	<button type="button" id="RegisterAdminBtn" class="btn btn-default" style="border:0;outline:0;float:right;"><span class="glyphicon glyphicon-ok" aria-hidden="true">관리자등록</span></button>
		 </sec:authorize>
		 
	
			
			<div id="allAdminList" 
			style="width:100%; border-style:outset; overflow-x:scroll; overflow-y:scroll; height:400px;padding:10px;">
				<table id="tblExport" border="1" class="ExcelTable2007">
					<thead id="thead">
						<tr>
							<th class="heading">&nbsp;</th>
							<th>A</th>
							<th>B</th>
							<th>C</th>
							<th>D</th>
							<th>E</th>
							<th>F</th>
							<th>G</th>
						</tr>
					</thead>
					<tbody id="tbody">
						<tr>
							<td align="left" valign="middle" class="heading">1</td>
							<td align="left" valign="middle" ><b>No</b></td>
							<td align="left" valign="middle" ><b>Admin ID</b></td>
							<td align="left" valign="middle" ><b>Name</b></td>
							<td align="left" valign="middle" ><b>Tel</b></td>
							<td align="left" valign="middle" ><b>Email</b></td>
							<td align="left" valign="middle" ><b>Authority</b></td>
							<td align="left" valign="middle" ><b>Control Box</b></td>
						</tr>
						
						<c:forEach var="admin" items="${requestScope.adminList}"
							varStatus="loop">
							<tr>
								<td align="left" valign="middle" class="heading">${(loop.index)+2}</td>
								<td align="center" valign="middle" >${(loop.index)+1}</td>
								<td align="left" valign="middle" >${admin.adminId }</td>
								<td align="left" valign="middle" >${admin.adminName }</td>
								<td align="left" valign="middle" >${admin.adminTel }</td>
								<td align="left" valign="middle" >${admin.adminEmail }</td>
								<td align="left" valign="middle" >${admin.adminAuthority }</td>
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
											<button type="submit" id="changeAdminAuthorityBtn"><span class="glyphicon glyphicon-refresh" aria-hidden="true">권한수정</span></button>
											<br>
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
											<button type="submit" id="deleteAdminBtn"><span class="glyphicon glyphicon-remove" aria-hidden="true">탈퇴</span></button>
										</form>
									</sec:authorize>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		 <!-- reload -->
		 <button type="button" onclick="location.reload()" class="btn btn-default btn-lg"  style="border:0;outline:0;float:right;">
			<span class="glyphicon glyphicon-refresh" aria-hidden="true">Reset</span>
		 </button>
		 
		 </div><!-- form-page -->
 	</div><!-- rightside menu -->
</div>
</div><!-- container -->
</body>
</html>
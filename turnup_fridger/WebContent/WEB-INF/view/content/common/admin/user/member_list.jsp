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
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
<style>
/* contact-form 넓이*/
.form-page{
	display:inline-block;
	width:95%;
	margin-left:5%;
}
/* EXCEL 형식 */
.ExcelTable2007 {
	border: 1px solid #B0CBEF;
	border-width: 1px 0px 0px 1px;
	font-size: 11pt;
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
</style>
</head>
<body>
<div class="container">
<div class='wrapperDiv'>
	<jsp:include page="/WEB-INF/view/layout/side_menu/adminSideMenu.jsp"/>
	<div class='right-box-sidemenu'>

	<div class="form-page">
		<h2>회원 관리</h2>
			<div id="wrap">
				<!-- 엑셀로 추출버튼 -->
				<a id="exportBtn" href="#" download=""><button type="button">(Excel)Download</button></a>
				<div id="allMemberList"
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
							<th>H</th>
						</tr>
						</thead>

						<tbody>
							<tr>
								<td align="left" valign="middle" class="heading">1</td>
								<td align="left" valign="middle" ><b>No</b></td>
								<td align="left" valign="middle" ><b>Member ID</b></td>
								<td align="left" valign="middle" ><b>Name</b></td>
								<td align="left" valign="middle" ><b>Address</b></td>
								<td align="left" valign="middle" ><b>Email</b></td>
								<td align="left" valign="middle" ><b>Tel</b></td>
								<td align="left" valign="middle" ><b>Gender</b></td>
								<td align="left" valign="middle" ><b>Control Box</b></td>
							</tr>
							
							<c:forEach var="member" items="${requestScope.memberList}"
								varStatus="loop">
								<tr>
									<td align="left" valign="middle" class="heading">${(loop.index)+2}</td>
									<td align="left" valign="middle" >${(loop.index)+1}</td>
									<td align="left" valign="middle" >${member.memberId }</td>
									<td align="left" valign="middle" >${member.memberName }</td>
									<td align="left" valign="middle" >${member.memberAddress }</td>
									<td align="left" valign="middle" >${member.memberEmail }</td>
									<td align="left" valign="middle" >${member.memberTel}</td>
									<td align="left" valign="middle" >${member.memberSex}</td>
									<td align="left" valign="middle">
										<!-- 개인회원강제탈퇴처리 -->
										<form
											action="${initParam.rootPath}/common/admin/member_delete.do"
											method="post">
											<input type="hidden" name="memberId" value="${member.memberId}">
											<sec:csrfInput />
											<button type="submit" id="deleteMemberBtn"><span class="glyphicon glyphicon-remove" aria-hidden="true">탈퇴</span></button>
										</form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		 </div><!-- form-page -->
 	</div><!-- rightside menu -->
</div>
</div><!-- container -->
</body>
</html>
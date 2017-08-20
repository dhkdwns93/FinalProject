<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)admin_mypage
작성자 :  김경혜
최초 작성일 170705
변경이력 
170711 headMaster는 정보 수정 버튼 안보이게 수정
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${ initParam.rootPath }/scripts/jquery.js"></script>
<script src="${ initParam.rootPath }/scripts/bootstrap.min.js"></script>
<script src="${ initParam.rootPath }/scripts/mdb.js"></script>
<link href="${ initParam.rootPath }/css/bootstrap.css" rel="stylesheet">
<link href="${ initParam.rootPath }/css/landing-page.css" rel="stylesheet">
<link href="${ initParam.rootPath }/css/createStyle.css" rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){
	$("button#accessDenied").on("click",function(){
		alert("HeadMaster관리자는 Web상에서 정보수정이 불가합니다.\nDB관리자에게 문의하세요");
	});//end of accessDenied
});
</script>
<style>
<style>
.font-Viner_Hand_ITC {
	font-family: "Viner Hand ITC";
	src: url("/font/VINERITC.TTF");
}
.font-Broadway {
	font-family: "Broadway";
	src: url("/font/BROADW.TTF");
}
/* 프로필 보이는 부분 ex. 회원가입성공페이지*/
.card.hovercard {
	margin-left: auto;
	margin-right: auto;
	position: relative;
	width: 430px;
	padding-top: 0;
	overflow: hidden;
	text-align: center;
	background-color: #fff;
	border: 1px solid #f1f1f1;
	border-radius: 5px;
}
.card.hovercard img {
	width: 430px;
	height: 230px;
}
.card.hovercard .avatar {
	position: relative;
	top: -100px;
	margin-bottom: -40px;
}
.card.hovercard .avatar img {
	width: 150px;
	height: 150px;
	max-width: 150px;
	max-height: 150px;
	-webkit-border-radius: 50%;
	-moz-border-radius: 50%;
	border-radius: 50%;
}
.card.hovercard .info {
	position: relative;
	top: -50px;
	padding: 4px 8px 10px;
}
.card.hovercard .info .title {
	margin-bottom: 4px;
	font-size: 28px;
	line-height: 1;
	color: #6D6C75;
	vertical-align: middle;
	padding-top:20px;
}
.card.hovercard .info .desc {
	overflow: hidden;
	font-size: 14px;
	line-height: 20px;
	color: #737373;
	text-overflow: ellipsis;
	padding-top:25px;
}
/* ****** */
.card.hovercard .bottom-mypage {
	padding: 0 20px;
	margin-top:30px;
	margin-bottom: -10px;
}
/* ****** */
.mypage-table {
	margin-left: auto;
	margin-right: auto;
	width : 90%;
	/* border:1px solid lightgrey; */
}
.table-attribute-name{
	width:33%;
    color: #444444;
    font-weight:bold;
    font-size:18px;
    padding-top : 10px;
    padding-bottom:10px;
}
.table-attribute-text{
	font-size:15px;
	text-align:left;
	padding-top:3px;
	padding-left:5px;
}
/* 회색버튼 ex)회원가입성공페이지_ 로그인버튼 */
.btn-block {
  color:#444444;
  display: block;
  width: 100%;
  padding-right: 0;
  padding-left: 0;
  margin-top :5px;
  margin-bottom : 5px;
  -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
          box-sizing: border-box;
}
.btn-block + .btn-block {
  margin-top: 5px;
}
input[type="submit"].btn-block,
input[type="reset"].btn-block,
input[type="button"].btn-block {
  width: 100%;
}
.btn-block:hover,
.btn-block:focus,
.btn-block:active,
.btn-block.active,
.btn-block.disabled,
.btn-block[disabled] {
  font-weight:bold;
  color: #444444;
  background-color: #f1f1f1;
}
.btn-block:active,
.btn-block.active {
  background-color: #d8d8d8 \9;
}
</style>
</head>
<body>
	<div class="container">
		<div class='wrapperDiv'>
			<jsp:include page="/WEB-INF/view/layout/side_menu/adminSideMenu.jsp"/>
			<div class='right-box-sidemenu'>
				<div class="card hovercard">
					<img src="${initParam.rootPath }/img/business.jpg" alt>
					<div class="avatar">
						<img src="${initParam.rootPath }/img/administer.ico" alt>
					</div>
					<div class="info">	
						<div class="title font-Viner_Hand_ITC">My Information for Admin</div>
						<div class="desc">
							<table class="mypage-table">
								<tr>
									<td class="font-Broadway table-attribute-name">Admin ID</td>
									<th><sec:authentication property="principal.adminId"></sec:authentication></th>
								</tr>
								<tr>
									<td class="font-Broadway table-attribute-name">Admin Name</td>
									<th><sec:authentication property="principal.adminName"></sec:authentication></th>
								</tr>
								<tr>
									<td class="font-Broadway table-attribute-name">Admin Tel</td>
									<th><sec:authentication property="principal.adminTel"></sec:authentication></th>
								</tr>
								<tr>
									<td class="font-Broadway table-attribute-name">Admin Email</td>
									<th><sec:authentication property="principal.adminEmail"></sec:authentication></th>
								</tr>
								<tr>
									<td class="font-Broadway table-attribute-name">Authority</td>
									<th><sec:authentication property="principal.adminAuthority"></sec:authentication></th>
								</tr>
							</table>
						</div><!-- info dsec -->
						<div class="bottom-mypage">
							<sec:authorize access="hasAnyRole('ROLE_MASTERADMIN','ROLE_ADMIN')">
								<a href="${initParam.rootPath }/common/admin/admin_change_info.do"><button type="button" class="btn btn-default">관리자 개인정보수정</button></a>
							</sec:authorize>
							<!-- headMaster는 관리자 정보수정 버튼 안보임 -->
							<sec:authorize access="hasRole('ROLE_HEADMASTERADMIN')">
								<button type="button" id="accessDenied" class="btn btn-default">HeadMaster관리자는 정보수정이 불가합니다.</button>
							</sec:authorize>
						</div><!--bottom  -->
						</div><!-- info -->
				</div><!-- card hovercard -->
			</div><!-- rightside menu -->
		</div>
	</div><!-- container -->
</body>
</html>
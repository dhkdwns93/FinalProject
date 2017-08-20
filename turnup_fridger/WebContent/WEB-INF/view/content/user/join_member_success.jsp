<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
 (jsp)join_member_success
작성자 :  김경혜
최초 작성일 170703
변경이력 
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
	font-size: 12px;
	line-height: 20px;
	color: #737373;
	text-overflow: ellipsis;
	padding-top:25px;
}
.card.hovercard .bottom {
	position: relative;
	top: -25px;
	padding: 0 20px;
	margin-bottom: 17px;
}
.member-join-success-table {
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

<body>	
	<div class='wrapperDiv'>
		<jsp:include page="/WEB-INF/view/layout/side_menu/nonMemberSideMenu.jsp"/>
		<div class='right-box-sidemenu'>
			<div class="join-member">
			<div class="card hovercard">
				<img src="img/asparagus.jpg" alt>
				<div class="avatar">
					<img src="img/cooker.jpeg" alt>
				</div>
				<div class="info">
					<div class="title font-Viner_Hand_ITC">Welcome to Turnup-Fridger!</div>
					<div class="desc">
					<table class="member-join-success-table">
						<tr>
							<td class="font-Broadway table-attribute-name">ID</td>
							<td class="table-attribute-text">${requestScope.member.memberId}</td>
						</tr>
						<tr>
							<td class="font-Broadway table-attribute-name">Name</td>
							<td class="table-attribute-text">${requestScope.member.memberName }</td>
						</tr>
						<tr>
							<td class="font-Broadway table-attribute-name">Address</td>
							<td class="table-attribute-text">${requestScope.member.memberAddress }</td>
						</tr>
						<tr>
							<td class="font-Broadway table-attribute-name">Email</td>
							<td class="table-attribute-text">${requestScope.member.memberEmail }</td>
						</tr>
						<tr>
							<td class="font-Broadway table-attribute-name">Tel</td>
							<td class="table-attribute-text">${requestScope.member.memberTel }</td>
						</tr>
						<tr>
							<td class="font-Broadway table-attribute-name">Gender</td>
							<td class="table-attribute-text">${requestScope.member.memberSex }</td>
						</tr>
						<tr>
							<td class="font-Broadway table-attribute-name" style="font-size:15px">기피재료목록</td>
							<td class="table-attribute-text">
								<c:forEach items="${requestScope.myDislikeIrdntNameList }"
									var="myDislikeIrdntName">
									<li>${myDislikeIrdntName }</li>
								</c:forEach>
							</td>
						</tr>
					</table><!-- end of table  -->			
					</div><!-- desc -->
				</div>
				<!-- info -->
				<div class="bottom">
					<a href="${initParam.rootPath}/login_form.do"><button
							type="button" class="btn btn-block">LOGIN</button></a>
				</div>
				<!-- bottom -->
			</div>
			<!-- card hovercard -->
			</div><!-- rounded -->
		</div>
		<!-- rightbox -->
	</div><!-- wrapperDiv -->
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8"%>
<!-- 
 (jsp)join_admin_success
작성자 :  김경혜
최초 작성일 170705
변경이력 
 -->
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script type="text/javascript">
$(document).ready(function(){
	$("button#accessDenied").on("click",function(){
		alert("HeadMaster관리자는 Web상에서 정보수정이 불가합니다.\nDB관리자에게 문의하세요");
	});//end of accessDenied
	
	$(document).on("click","#goBackBtn",function(){
		//opener.location.href="${initParam.rootPath}/common/admin/admin_list.do";
		window.close();
	});//end of goBackBtnc
});
</script>
<style>
<style>
.font-Viner_Hand_ITC {
	font-family: "Viner Hand ITC" !important;
	src: url("/font/VINERITC.TTF") !important;
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

.container{
   display:inline-block;
   width:100%;
   height:100%
   max-width:430px;
}
</style>
</head>
<body>


<div class="container">
	
<div class="card hovercard">
	<img src="${initParam.rootPath }/img/business.jpg" alt>
	<div class="avatar">
		<img src="${initParam.rootPath }/img/administer.ico" alt>
	</div>
	<div class="info">	
		<div class="title font-Viner_Hand_ITC">Registration Successful</div>
		<div class="desc">
		<table class="mypage-table">
		<tr>
			<td class="font-Broadway table-attribute-name">Admin ID</td>
			<th>${requestScope.admin.adminId}</th>
		</tr>
		<tr>
			<td class="font-Broadway table-attribute-name">Admin Name</td>
			<th>${requestScope.admin.adminName }</th>
		</tr>
		<tr>
			<td class="font-Broadway table-attribute-name">Admin Tel</td>
			<th>${requestScope.admin.adminTel }</th>
		</tr>
		<tr>
			<td class="font-Broadway table-attribute-name">Admin Email</td>
			<th>${requestScope.admin.adminEmail }</th>
		</tr>
		<tr>
			<td class="font-Broadway table-attribute-name">Authority</td>
			<th>${requestScope.admin.adminAuthority }</th>
		</tr>
		</table>
		</div><!-- info dsec -->
		<div class="bottom-mypage">
			<button type="button" id="goBackBtn" class="btn btn-default btn-lg"  style="border:0;outline:0;">
				<span class="glyphicon glyphicon-remove" aria-hidden="true">Close</span>
			</button>
		</div><!--bottom  -->
		</div><!-- info -->
		
		
		</div><!-- card hovercard -->
		
</div>
</body>
</html>
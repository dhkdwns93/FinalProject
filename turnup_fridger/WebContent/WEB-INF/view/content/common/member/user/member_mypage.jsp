<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 
 (jsp)member_mypage
작성자 :  김경혜
최초 작성일 170704
변경이력 
170714 박연수 // 즐겨찾기목록 추가. 
170717 (경혜) // error alert 주석처리
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${ initParam.rootPath }/scripts/jquery.js"></script>
<script src="${ initParam.rootPath }/scripts/bootstrap.min.js"></script>
<script src="${ initParam.rootPath }/scripts/mdb.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#favoriteSection").hide();
	$.ajax({
		"url":"/turnup_fridger/common/member/getFavorite.do",
		//"type":"POST",
		"dataType":"json",
		"success":function(list){
			$("#favoriteSection").show();
			$("#fTbody").empty();
			$.each(list, function(){
				$("#fTbody").append($("<tr>").append($("<td>").append(this.recipeId))
						.append($("<td>").append($("<a>").prop("href", "${initParam.rootPath}/recipe/show/detail.do?recipeId="+this.recipeId).append(this.recipeInfo.recipeName))));
				 });//each	 		 
			},//success		
			"error":function(xhr, msg, code){
				//alert("오류발생-" +msg+ ":" +code);
			}//error
	});
	
	$(document).on("click","#deleteMemberBtn", function(){
		$("#deleteMemberModal").modal("show");
	});	// end of click on requstBtn
	
	$("button#favoriteSectionBtn").on("click",function(){
		$("#favoriteSectionModal").modal("show");
	});//end of favorateSectionBtn
})
</script>

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

.ccbtn{
	font-size:13px;
	border:none;
	background:#f8ae45;
	height:28px;
	color:#FFFFFF;
	cursor:pointer;
	text-decoration:none;
	font-weight:bold;
}
</style>

</head>
<body>
	<div>
		<jsp:include page="/WEB-INF/view/content/common/member/user/member_delete_form.jsp"/>
	</div>
	<div class="container">
		<div class='wrapperDiv'>
			<jsp:include page="/WEB-INF/view/layout/side_menu/memberSideMenu.jsp"/>
			<div class='right-box-sidemenu'>
				<div class="card hovercard">
					<img src="${initParam.rootPath }/img/asparagus.jpg" alt>
					<div class="avatar">
						<img src="${initParam.rootPath }/img/cooker.jpeg" alt>
					</div>
					<div class="info">
						<div class="title font-Viner_Hand_ITC">My Information</div>
						<div class="desc">
							<table class="mypage-table">
								<tr>
									<td class="font-Broadway table-attribute-name">ID</td>
									<th><sec:authentication property="principal.memberId"></sec:authentication></th>
								</tr>
								<tr>
									<td class="font-Broadway table-attribute-name">Name</td>
									<th><sec:authentication property="principal.memberName"></sec:authentication></th>
								</tr>
								<tr>
									<td class="font-Broadway table-attribute-name">Address</td>
									<th><sec:authentication property="principal.memberAddress"></sec:authentication></th>
								</tr>
								<tr>
									<td class="font-Broadway table-attribute-name">Email</td>
									<th><sec:authentication property="principal.memberEmail"></sec:authentication></th>
								</tr>
								<tr>
									<td class="font-Broadway table-attribute-name">Tel</td>
									<th><sec:authentication property="principal.memberTel"></sec:authentication></th>
								</tr>
								<tr>
									<td class="font-Broadway table-attribute-name">Gender</td>
									<th><sec:authentication property="principal.memberSex"></sec:authentication></th>
								</tr>
								<tr>
									<td class="font-Broadway table-attribute-name" style="font-size:15px">기피재료목록</td>
									<td class="table-attribute-text">
										<c:forEach items="${requestScope.myDislikeIrdntNameList }" var="myDislikeIrdntName">
												<li>${myDislikeIrdntName }</li>
										</c:forEach> 
									</td>
								</tr>
							</table>
							<button type="button" class="ccbtn"  id="favoriteSectionBtn"  data-toggle="modal"  data-target="#favoriteSectionModal">등록된 즐겨찾기</button>
						</div><!-- info  desc -->
						<div class="bottom-mypage">
							<a href="${initParam.rootPath }/common/member/member_change_info.do"><button type="button" class="btn btn-block">회원정보수정</button></a>
							<button type="button" class="btn btn-block" id="deleteMemberBtn" data-toggle="modal"  data-target="#deleteMemberModal" >회원탈퇴하기</button>
						</div><!-- bottom -->
				</div><!-- info -->
				</div><!-- card hover card -->
				<div class="modal fade" id="favoriteSectionModal" tabindex="-1" role="dialog" aria-labelledby="createFridgerModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h3 class="modal-title font-Viner_Hand_ITC" id="myModalLabel">Favorite Recipe</h3>
							</div>
							<div class="modal-body">
							<h3 style="text-align:center;">추가한 즐겨찾기 목록</h3><br><br>
								<table class="table table-hover table-condensed" style="width:300px;margin-left:auto;margin-right:auto;">
									<thead id="fThead">
										<tr>
											<th>레시피id</th>
											<th>레시피이름</th>
										</tr>		
									</thead>
									<tbody id="fTbody">
									</tbody>
								</table>
							</div><!--modal-body  -->
							<div class="modal-footer">
								<input type="button" id="cancel" class="btn btn-default" data-dismiss="modal" onclick="resetModal()" value="Close">
							</div><!-- modal footer -->
						</div><!-- .modal-content -->
					</div><!-- .modal-dialog -->
				</div><!-- .modal fade -->
			</div><!-- rightside menu -->
		</div>
	</div><!-- container -->
</body>
</html>
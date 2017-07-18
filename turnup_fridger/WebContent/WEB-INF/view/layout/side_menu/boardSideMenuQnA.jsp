<%@ page contentType="text/html;charset=UTF-8"%>

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style type="text/css">
.wrapperDiv{
	display:-webkit-flex;
	display:flex;
}
.left-box-sidemenu{
 	background:#E6E6E6;
 	float:left;
 	width:30%;
	min-width:200px;
	max-width:250px;
 	height:100%;
	margin-left:5%;
	margin-bottom:auto;
 	border-radius:10%;
 	padding : 2%;
}
.left-title-sidemenu{
 	background:white;
 	float:left;
 	width:30%;
	min-width:200px;
	max-width:250px;
 	height:100%;
	margin-left:5%;
	margin-bottom:auto;
 	border-radius:10%;
 	padding : 2%;
 	font-size:100%;
}
</style>
<br><br><br><br>	
<div class='left-title-sidemenu'>
	<div class='left-title-sidemenu'>
		<div><h2>QnA</h2></div>
		<hr style="border:0;height:3px;background:#ccc;">
	</div>
	
	<div class='left-title-sidemenu'>
		<div>
			<h2>
				<a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" id="submenu2Link" style="text-align:right;">
				<h4 style="color:black;">
					공지사항&nbsp;&nbsp;
					<button type="button" class="btn btn-default btn-lg" style="background:none;color:black;width:30%;border:0;outline:0;">
						<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					</button>
				</h4></a>
			</h2>
		</div>
	</div>	
	<div class='left-box-sidemenu'>	
		<a href="${initParam.rootPath}/common/boardqna/boardQnAList.do" id="submenu2Link" style="text-align:right;">
			<h3 style="color:white;">
				QnA&nbsp;&nbsp;
				<button type="button" class="btn btn-default btn-lg" style="background:none;color:white;width:30%;border:0;outline:0;">
					<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				</button>
			</h3>
		</a>
	</div>
	<div class='left-title-sidemenu'>
		<div>
			<h2>
				<a href="${initParam.rootPath}/common/boardfree/boardFreeList.do" id="submenu2Link"  style="text-align:right;">
				<h4 style="color:black;">
					자유게시판&nbsp;&nbsp;
					<button type="button" class="btn btn-default btn-lg" style="background:none;color:black;width:30%;border:0;outline:0;">
						<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					</button>
				</h4></a>
				<a href="${initParam.rootPath}/boardreview/boardReviewList.do" id="submenu2Link"  style="text-align:right;">
				<h4 style="color:black;">
					후기&nbsp;&nbsp;
					<button type="button" class="btn btn-default btn-lg" style="background:none;color:black;width:30%;border:0;outline:0;">
						<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					</button>
				</h4></a>
			</h2>
		</div>
	</div>
</div>



<%@ page contentType="text/html;charset=UTF-8"%>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style>
.wrapperDiv{
	display:-webkit-flex;
	display:flex;
}
.left-box-sidemenu{
 	background:white;
 	float:left;
 	width:20%;
	min-width:200px;
	max-width:250px;
 	height:100%;
	margin-left:5%;
	margin-bottom:auto;
 	border-radius:10%;
 	padding : 2%;
 	font-size:100%;
}
.right-box-sidemenu{
	-webkit-flex:none;
	flex:none;
	position:relative;
	background:white;
	float:right;
	width:67%;
	height:100%;
	margin-right:5%;
}

.list-group-item {
	border: none;
	color: #555;
	text-decoration: none;
	background-color: #ffcc99;
}

.list-group-item:hover, .list-group-item:focus {
	color: #555;
	text-decoration: none;
	background-color: #fff2e6 !important;
}

</style>


<div class='left-box-sidemenu'>
		<div>
			<h2>게시판</h2>
		</div>
		<hr style="border:0;height:3px;background:#ccc;">
		<div class="list-group">
			<a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" class="list-group-item" style="text-align:right;">
				공지사항
				<button type="button" class="btn btn-default btn-lg" style="background:none;color:black;width:30%;border:0;outline:0;">
					<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				</button>
			</a>
			
			<a href="${initParam.rootPath}/common/boardqna/boardQnAList.do" class="list-group-item" style="text-align:right;">
				QnA
				<button type="button" class="btn btn-default btn-lg" style="background:none;color:black;width:30%;border:0;outline:0;">
					<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				</button>
			</a>
			
			
			<a href="${initParam.rootPath}/common/boardfree/boardFreeList.do" class="list-group-item" style="text-align:right;">
				자유게시판
				<button type="button" class="btn btn-default btn-lg" style="background:none;color:black;width:30%;border:0;outline:0;">
					<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				</button>
			</a>
				
			<a href="${initParam.rootPath}/boardreview/boardReviewList.do" class="list-group-item"  style="text-align:right;">
				후기
				<button type="button" class="btn btn-default btn-lg" style="background:none;color:black;width:30%;border:0;outline:0;">
					<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				</button>
			</a>
		</div>
</div>
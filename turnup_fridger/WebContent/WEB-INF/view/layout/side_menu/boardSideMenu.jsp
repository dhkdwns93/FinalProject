<%@ page contentType="text/html;charset=UTF-8"%>
<style>
.left-box{
 	background:white;
 	float:left;
 	width:20%;
 	height:100%;
 	padding : 2%;
 	font-size:500%;
}
.right-box{
	background:white;
	float:right;
	width:75%;
	height:70%;
</style>
<div class='left-box'>
<table>
	<tr>
		<tb>
			 <a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" id="submenu2Link" style="text-align:right;"><h3>공지사항&nbsp;&nbsp;></h3></a>
		</tb>
	</tr>
	<tr>
		<tb>
        	 <a href="${initParam.rootPath}/common/boardqna/boardQnAList.do" id="submenu2Link" style="text-align:right"><h3>QnA&nbsp;&nbsp;></h3></a>

		</tb>
	</tr>
	<tr>
		<tb>
         <a href="${initParam.rootPath}/common/boardfree/boardFreeList.do" id="submenu2Link" style="text-align:right"><h3>자유게시판&nbsp;&nbsp;></h3></a>
		</tb>
	</tr>
	<tr>
		<tb>
        	 <a href="${initParam.rootPath}/boardreview/boardReviewList.do" id="submenu2Link" style="text-align:right"><h3>후기&nbsp;&nbsp;></h3></a>
		</tb>
	</tr>
</table>
</div>






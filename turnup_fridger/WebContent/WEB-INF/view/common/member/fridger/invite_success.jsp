<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>초대요청성공</h2>
No : ${ requestScope.joinProcess.processNo }<br>
냉장고ID :  ${ requestScope.joinProcess.processFridgerId }<br>
처리상태 :  ${ requestScope.joinProcess.processState }<br>
&nbsp;&nbsp;&nbsp;&nbsp;(10:가입요청대기/11:가입요청승인/12:가입요청거절/20:초대요청대기/21:초대요청승인/22:초대요청거절)<br>
요청일 :  ${ requestScope.joinProcess.reqDate }<br>
응답일 : ${ requestScope.joinProcess.respDate }<br>
요청회원 :  ${ requestScope.joinProcess.reqMemberId }<br>
응답회원 : ${ requestScope.joinProcess.respMemberId }<br>
<br>
<a href="${initParam.rootPath}"><button type="button">index가기</button></a>
</body>
</html>
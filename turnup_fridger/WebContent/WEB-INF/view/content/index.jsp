<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
 (jsp)index
작성자 : 
최초 작성일
변경이력 
170703 (경혜)로그인 버튼 추가
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body.index { /* 첫 화면 가운데부분  */
    color: #f8f8f8;
    background: url(/turnup_fridger/img/banana.jpg) no-repeat center center;
    background-size: cover;
}

h3 {	/* 효율적인 식재료 관리를 위한 냉장고 털어먹기 */
    position: relative;
    padding-top: 30%;
    padding-bottom: 15%;
    text-shadow: 2px 2px 3px rgba(0,0,0,0.6);
}

h1 { /* turnup-fidger */
	text-align: center;
	position: absolute;
	top: 40%;
    margin-left: auto;
    margin-right: auto;
    text-shadow: 2px 2px 3px rgba(0,0,0,0.6);
    font-size: 7em;
    font-family: 'Philosopher', sans-serif;
    font-weight: 600;  
}
</style>
</head>
<body class="index">
<div class="container-fluid">
<h1>Turnup-Fridger</h1>
<h3>효율적인 식재료 관리를 위한 냉장고 털어먹기</h3>
</div>

</body>
</html>
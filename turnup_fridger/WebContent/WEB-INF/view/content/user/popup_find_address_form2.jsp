<%@ page contentType="text/html;charset=UTF-8"%>
<!-- 
 (jsp)popup_find_address_form
작성자 :  김경혜
최초 작성일 170711
변경이력 
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Turnup-fridger Search-Address</title>

<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"  rel="stylesheet">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- confirm창 js -->
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular.min.js"></script>
<script src="https://angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.6.0.js" type="text/javascript"></script>
<script src="https://m-e-conroy.github.io/angular-dialog-service/javascripts/dialogs.min.js" type="text/javascript"></script>

<script type="text/javascript" src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<script type="text/javascript">
angular.module('modalTest',['ui.bootstrap','dialogs'])
.controller('dialogServiceTest',function($scope,$rootScope,$timeout,$dialogs){
  $scope.confirmed = 'You have yet to be confirmed!';
  $scope.name = '"Your name here."';
  
  $scope.launch = function(which){
    var dlg = null;
    switch(which){
        
      // Error Dialog
      case 'error':
        dlg = $dialogs.error('This is my error message');
        break;
        
      // Wait / Progress Dialog
      case 'wait':
        dlg = $dialogs.wait(msgs[i++],progress);
        fakeProgress();
        break;
        
      // Notify Dialog
      case 'notify':
        dlg = $dialogs.notify('Something Happened!','Something happened that I need to tell you.');
        break;
        
      // Confirm Dialog
      case 'confirm':
        dlg = $dialogs.confirm('Please Confirm','Is this awesome or what?');
        dlg.result.then(function(btn){
          $scope.confirmed = 'You thought this quite awesome!';
        },function(btn){
          $scope.confirmed = 'Shame on you for not thinking this is awesome!';
        });
        break;
       
      // Create Your Own Dialog
      case 'create':
        dlg = $dialogs.create('/dialogs/whatsyourname.html','whatsYourNameCtrl',{},{key: false,back: 'static'});
        dlg.result.then(function(name){
          $scope.name = name;
        },function(){
          $scope.name = 'You decided not to enter in your name, that makes me sad.';
        });
        
        break;
    }; // end switch
  }; // end launch
  
  // for faking the progress bar in the wait dialog
  var progress = 25;
  var msgs = [
    'Hey! I\'m waiting here...',
    'About half way done...',
    'Almost there?',
    'Woo Hoo! I made it!'
  ];
  var i = 0;
  
  var fakeProgress = function(){
    $timeout(function(){
      if(progress < 100){
        progress += 25;
        $rootScope.$broadcast('dialogs.wait.progress',{msg: msgs[i++],'progress': progress});
        fakeProgress();
      }else{
        $rootScope.$broadcast('dialogs.wait.complete');
      }
    },1000);
  }; // end fakeProgress 
  
}) // end dialogsServiceTest
.controller('whatsYourNameCtrl',function($scope,$modalInstance,data){
  $scope.user = {name : ''};

  $scope.cancel = function(){
    $modalInstance.dismiss('canceled');  
  }; // end cancel
  
  $scope.save = function(){
    $modalInstance.close($scope.user.name);
  }; // end save
  
  $scope.hitEnter = function(evt){
    if(angular.equals(evt.keyCode,13) && !(angular.equals($scope.name,null) || angular.equals($scope.name,'')))
				$scope.save();
  }; // end hitEnter
}) // end whatsYourNameCtrl
.run(['$templateCache',function($templateCache){
  $templateCache.put('/dialogs/whatsyourname.html','<div class="modal"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><h4 class="modal-title"><span class="glyphicon glyphicon-star"></span> User\'s Name</h4></div><div class="modal-body"><ng-form name="nameDialog" novalidate role="form"><div class="form-group input-group-lg" ng-class="{true: \'has-error\'}[nameDialog.username.$dirty && nameDialog.username.$invalid]"><label class="control-label" for="username">Name:</label><input type="text" class="form-control" name="username" id="username" ng-model="user.name" ng-keyup="hitEnter($event)" required><span class="help-block">Enter your full name, first &amp; last.</span></div></ng-form></div><div class="modal-footer"><button type="button" class="btn btn-default" ng-click="cancel()">Cancel</button><button type="button" class="btn btn-primary" ng-click="save()" ng-disabled="(nameDialog.$dirty && nameDialog.$invalid) || nameDialog.$pristine">Save</button></div></div></div></div>');
}]); // end run / module

$(document).ready(function(){
	$(function(){
			$("button#useAddressAPIBtn").postcodifyPopUp();
	});//end of useAddressAPIBtn 
	
	$("button#simpleConfirm").on("click",function(){
		var inputAddress=$(this).parent().children(":nth-child(3)").val();
		if(confirm(inputAddress+"를 입력하시겠습니까?")==true){
			opener.document.usePopup.memberAddress.value=inputAddress;
			window.close();
		}else{
			return false;
		}
	});//end of useAddressBtn
});
</script>
<style>
.ccfield-prepend {
	margin-bottom: 20px;
	width: 100%;
}

.ccform-addon {
	color: #bfbfbf;
	float: left;
	padding: 8px;
	width: 8%;
	height: 34px;
	background: #FFFFFF;
	border: 1px solid #f1f1f1;
	text-align: center;
}

.ccformfield {
	color: #000000;
	background: #FFFFFF;
	border: 1px solid #f1f1f1;
	padding: 15.5px;
	width: 60%;
	height: 34px;
	font-family: 'Lato', Arial, sans-serif;
	font-size: 14px;
	margin: 0;
}

.ccformfield {
	font-family: 'Lato', Arial, sans-serif;
}

.ccformfield-2 {
	color: #000000;
	background: #FFFFFF;
	border: 1px solid #f1f1f1;
	padding: 15.5px;
	width: 20%;
	height: 34px;
	font-family: 'Lato', Arial, sans-serif;
	font-size: 14px;
	margin: 0;
}

.ccbtn {
	font-size: 13px;
	border: none;
	background: #a6a6a6;
	height: 28px;
	color: #FFFFFF;
	cursor: pointer;
	text-decoration: none;
	font-weight: bold;
}

.ccbtn:hover {
	background: #737373;
}

.ccfield-submit-part {
	text-align: center;
}
/* 기타 일반 text  */
h1 {
	font-family: "Viner Hand ITC";
	src: url("/font/VINERITC.TTF");
	font-weight: bold;
	color: #4d4d4d;
}

.form-text {
	font-size: 14px;
	color: #808080;
}
/* 에러메시지 */
.error-popup {
	font-size: 100% !important;
	color: #808080 !important;
}
/* popup-body 넓이*/
.popup-body {
	width: 100%;
	display: inline-block;
	margin-top: 10%;
	margin-left: auto;
	margin-right: auto;
}
.popup-btn{
 	text-align:center;
}
</style>
</head>
<body>

	<div class="container">

		<div class="popup-body">
			<h1 class="modal-title font-Viner_Hand_ITC">Search Address</h1>
			<hr>
				<div id="postcodify">
					<div class="ccfield-prepend">
					<button type="button" id="useAddressAPIBtn" class="ccbtn"><span class="glyphicon glyphicon-search" aria-hidden="true">Click!</span></button>
					</div>
					<div id="resultSearch">
						<div class="ccfield-prepend">
							<div><label for="name" class="form-text">우편번호</label></div>
							<span class="ccform-addon"><i class="material-icons">&#xE153;</i></span>
							<input type="text" name="" class="postcodify_postcode ccformfield-2" value="" readonly="readonly">
						</div>
						<div class="ccfield-prepend">
							<div><label for="name" class="form-text">도로명주소</label></div>
							<span class="ccform-addon"><i class="material-icons">&#xE8B4;</i></span>
							<input type="text" id="inputAddress" name="inputAddress" class="postcodify_address ccformfield" value=""
								style="width: 300px" readonly="readonly">
							<button type="button" id="useAddressBtn" class="ccbtn"><span class="glyphicon glyphicon-pencil" aria-hidden="true">Use</span></button>
						</div>
						<div class="ccfield-prepend">
							<div><label for="name" class="form-text">지번주소</label></div>
							<span class="ccform-addon"><i class="material-icons">&#xE8B4;</i></span>
							<input type="text" id="inputAddress" name="inputAddress" class="postcodify_jibeon_address ccformfield"
								value="" style="width: 300px" readonly="readonly">
							<button type="button" id="useAddressBtn" class="ccbtn"><span class="glyphicon glyphicon-pencil" aria-hidden="true">Use</span></button>
						</div>
					</div>
				</div><!-- postcodify -->
				<div class="popup-btn">
					<hr>
					<button type="button" onclick="self.close()" class="btn btn-default btn-lg"  style="border:0;outline:0;">
						<span class="glyphicon glyphicon-remove" aria-hidden="true">Close</span>
					</button>
				</div>


		</div>
		<!-- popup-body -->
	</div>
	<!-- container -->
</body>
</html>
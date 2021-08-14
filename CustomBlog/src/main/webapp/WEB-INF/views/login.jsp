<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;600&family=Nanum+Gothic&display=swap" rel="stylesheet"></link>
<meta charset="UTF-8">
<title> Login </title>
<style type="text/css">
body {
	background-color: #f3f3f3;
	font-family: "Quicksand", 'Nanum Gothic';
}

.wrap {
	position: absolute;
	top: 50%;
	left: 50%;
	margin: -100px 0 0 -100px;
}
</style>
<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">

$(function() {
	
	$("#btn_login").on("click", function() {
		$("form").submit();
	});
	
	// validation
	$("form").submit(function(event) {
		
		let userid = $("#userid").val();
		let userpw = $("#userpw").val();
		
		if (userid == "") {
			alert("Please enter id");
			event.preventDefault();
			return;
		}
		
		if (userpw == "") {
			alert("Please enter password");
			event.preventDefault();
			return;
		}
	});
});
</script>
</head>
<body>
 <div class="wrap">
	<form action="login" method="POST">
		<label>ID &nbsp; &nbsp; &nbsp;<input type="text" id="userid" name="userid"></label>
		<br>
		<label>PW &nbsp; &nbsp;<input type="password" id="userpw" name="userpw"></label>
		<div style="padding-top: 10px; padding-left: 70px;"><input type="submit" id="btn_login" value="LOGIN"></div>
	</form>
</div>
</body>
</html>
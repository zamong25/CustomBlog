<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Login </title>
<style type="text/css">
.wrap {
  position: absolute;top: 50%;left: 50%;margin:-150px 0 0 -150px
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
		<label>ID <input type="text" id="userid" name="userid"></label>
		<br>
		<label>PW <input type="password" id="userpw" name="userpw"></label>
		<br>
		<input type="submit" id="btn_login" value="LOGIN">
	</form>
</div>
</body>
</html>
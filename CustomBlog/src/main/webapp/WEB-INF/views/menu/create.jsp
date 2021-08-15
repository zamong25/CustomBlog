<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="/resources/css/createMenu.css" rel="stylesheet" type="text/css"></link>
<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;600&family=Nanum+Gothic&display=swap" rel="stylesheet"></link>
<meta charset="UTF-8">
<script type="text/javascript">
function formCheck(){
	var menu_name = document.getElementById("menu_name").value;
	
	if (menu_name == "") {
		alert("Please write menu name");
		return false;
	}
	
	return true;
}
</script>
</head>
<body>
	<div class="wrapper">
		<h3> [ CREATE NEW MENU ] </h3>
		<form action="/menu/create" method="POST" onsubmit="return formCheck();">
			<label> NAME </label>
			<input type="text" id="menu_name" name="menu_name">
			<div class="btn"><input type="submit" id="button" value="Create"></div>
		</form>
	</div>
</body>
</html>
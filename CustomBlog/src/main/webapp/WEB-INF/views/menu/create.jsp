<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<script type="text/javascript">

function formCheck(){
	var menu_name = document.getElementById("menu_name").value;
	
	if(menu_name == ""){
		alert("Please write menu name");
		return false;
	}
	
	return true;
	
}
</script>

</head>
<body>

	<h3>Create new menu</h3>
	<form action="/menu/create" method="POST" onsubmit="return formCheck();">
		
		<label> Name </label>
		<input type="text" id="menu_name" name="menu_name">
		<br>
		
		<input type="submit" id="button" value="Create">
		
	</form>
	
</body>
</html>
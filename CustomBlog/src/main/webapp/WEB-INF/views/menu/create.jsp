<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<script src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">

let sendStatus = false;

$(function() {
	
	check();
	
	$("button").click(function() {
		
		if (sendStatus) alert("Created menu successfully");
		else alert("Please rewrite menu name");
		
	});
	
});

function check() {
	
	$("#name").keyup(function() {
		let menu_name = $("#name").val();
		
		if (menu_name.length == 0) {
			alert("Please write menu name");
			sendStatus = false;
		}
		else sendStatus = true;
	});
}

</script>

</head>
<body>

	<h3>Create new menu</h3>
	<form action="/menu/create" method="get">
		
		<label> Name </label>
		<input type="text" id="name" name="menu_name">
		<br>
		
		<input type="submit" id="button" value="Create">
		
	</form>
	
</body>
</html>
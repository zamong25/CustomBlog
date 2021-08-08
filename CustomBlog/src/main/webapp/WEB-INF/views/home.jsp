<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<style type="text/css">
#menuList li { 
	list-style: none; 
	border-width: 1px; 
 	border-style: solid; 
	border-color: red; 
	padding : 10px; 
 }

</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" ></script>
<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">

$(function() {
	getMenu();
	getRecentBoard();
	$("#menuList").sortable();
	$("#menuList").disableSelection();
});

function getMenu() {
	
	$.ajax({
		url : "selectBoardByMenu"
		, method : "GET"
		, data : { }
		, success : outputMenu
	});
}

function outputMenu(res) {
	let result = "";
	
	if (res.length == 0) {
		$("#menuList").html("<b>There is no menu</b>");
	} else {
		
		result += '<ul>'
		$.each(res, function(index, item) {
		
		});
		result += '</ul>'
		
		$("#menuList").html(result);
	}
}


// select recent board
function getRecentBoard() {
	$.ajax({
		url : "selectRecentBoard"
		, method : "GET"
		, success : outputBoard
	});
}

function outputBoard(res) {
	let result = "";
	
	if (res.length == 0) {
		$("#recentBoardDiv").html("<b>There is no board</b>");
	} else {
		
		$.each(res, function(index, item) {
			result += '<a href="/readBoard?boardnum='+ item.boardnum + '">'
			result += '<h3>' + item.title + '</h3>'
			result += '</a>'
			result += item.menu_name + ' | ' + item.regdate + '<br>'
			result += item.text + '<br>'
		});
		
		$("#recentBoardDiv").html(result);
	}
}

</script>
</head>
<body>
	<h1>menu</h1>
	<div id="menuList"></div>
	<ul id="menuList">
		<c:forEach var="menu" items="${menuList}">		
			<li>${menu.menu_name}</li>
		</c:forEach>
	</ul>
	<br>
	<div id="recentBoardDiv"></div>
</body>
</html>

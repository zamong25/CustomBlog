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
	getRecentBoard();
	$("#menuList li.home").on("click", getRecentBoard);
	$("#menuList li.eachMenu").on("click" , getBoardByMenu);
	/* $("#menuList").sortable();
	$("#menuList").disableSelection(); */
});


function getRecentBoard() {
	
	$.ajax({
		url : "selectRecentBoard"
		, method : "GET"
		, success : outputBoard
		, error : function(err) {
			console.log(err);
		}
	});
}


function getBoardByMenu() {
	let menu_name = $(this).text();
	
	$.ajax({
		url : "selectBoardByMenu"
		, method : "GET"
		, data : { "menu_name" : menu_name }
		, success : outputBoard
		, error : function(err) {
			console.log(err);
		}
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
	<ul id="menuList">
		<li class="home">Home</li>
		<c:forEach var="menu" items="${menuList}">		
			<li class="eachMenu">${menu.menu_name}</li>
		</c:forEach>
	</ul>
	<br>
	<div id="recentBoardDiv"></div>
</body>
</html>

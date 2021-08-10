<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title> Home </title>
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

let page = 1;
let menuName = "";

$(function() {
	getRecentBoard();
	$("#menuList li.home").on("click", init);
	$("#menuList li.eachMenu").on("click" , getBoardByMenu);
	$("#btn_search").on("click", getRecentBoard);
	/* $("#menuList").sortable();
	$("#menuList").disableSelection(); */
});


function init() {
	location.href = "/";
}


function getRecentBoard() {
	
	let searchItem = $("#searchItem>option:selected").val();
	let searchWord = $("#searchWord").val();
	
	$.ajax({
		url : "selectRecentBoard"
		, method : "GET"
		, data : { "searchItem" : searchItem, "searchWord" : searchWord }
		, success : outputBoard
		, error : function(err) {				
			console.log(err);
		}
	});
}


function getBoardByMenu() {
	
	$("#seeMordDiv").css("display", "block");
	menuName = $(this).text();
	
	console.log(menuName); // it works
	
	$.ajax({
		url : "selectBoardByMenu"
		, method : "GET"
		, data : { "menu_name" : menuName }
		, dataType : "json"
		, success : outputBoard
		, error : function(err) {
			console.log(err);
		}
	});
}

function outputBoard(res) {
	
	let searchItem = $("#searchItem>option:selected").val();
	let searchWord = $("#searchWord").val();

	let boardResult = "";
	
	if (res.length == 0) {
		$("#recentBoardDiv").html("<b>There is no board</b>");
	} else {
		
		// boardlist
		$.each(res, function(index, item) {
			boardResult += '<a href="/readBoard?boardnum='+ item.boardnum + '">'
			boardResult += '<h3>' + item.title + '</h3>'
			boardResult += '</a>'
			boardResult += item.menu_name + ' | ' + item.regdate + '<br>'
			boardResult += item.text + '<br>'
		});
		
		$("#recentBoardDiv").html(boardResult);
	}
	
	$("#seeMore").attr('href', '/listBoard?menu=' + menuName);
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
		<form id="search" method="GET">
			<select id="searchItem">
				<option value="title"  ${searchItem=='title' ? 'selected' : ''}>Title</option>
				<option value="text"   ${searchItem=='text'  ? 'selected' : ''}>Text</option>
			</select>
			<input type="text" id="searchWord" value="${searchWord}">
			<input type="button" id="btn_search" value="Search">
		</form>
	<br>
	<div id="seeMordDiv" style="display:none;"><a id="seeMore">See more</a></div>
	<div id="recentBoardDiv"></div>
</body>
</html>

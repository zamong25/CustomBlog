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
	let menu_name = $(this).text();
	
	$.ajax({
		url : "selectBoardByMenu"
		, method : "GET"
		, data : { "menu_name" : menu_name }
		, dataType : "json"
		, success : outputBoard
		, error : function(err) {
			console.log(err);
		}
	});
}

function outputBoard(res) {
	
	let list = res.list;
	let result = "";
	console.log(res.navi.pagePerGroup);
	if (res.length == 0) {
		$("#recentBoardDiv").html("<b>There is no board</b>");
	} else {
		
		$.each(list, function(key, value) {
			result += '<a href="/readBoard?boardnum='+ value.boardnum + '">'
			result += '<h3>' + value.title + '</h3>'
			result += '</a>'
			result += value.menu_name + ' | ' + value.regdate + '<br>'
			result += value.text + '<br>'
		});
		
		 for (var num=startpage; num<=endpage; num++) {
             if (num == page) {
            	 result += '<a href="#" onclick="commentList(' + board_id + ', ' + num + '); return false;" class="page-btn">' + num + '</a>';
             } else {
            	 result += '<a href="#" onclick="commentList(' + board_id + ', ' + num + '); return false;" class="page-btn">' + num + '</a>';
             }
          }
      		
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
	<form id="search" action="listboard" method="GET">
			<select id="searchItem">
				<option value="title"  ${searchItem=='title' ? 'selected' : ''}>Title</option>
				<option value="text"   ${searchItem=='text'  ? 'selected' : ''}>Text</option>
			</select>
			<input type="text" id="searchWord" value="${searchWord}">
			<input type="button" id="btn_search" value="Search">
		</form>
	<br>
	<div id="recentBoardDiv"></div>
	
	
	
</body>
</html>

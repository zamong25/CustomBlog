<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<link href="resources/css/homeCSS.css" rel="stylesheet" type="text/css"></link>
<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;600&family=Nanum+Gothic&display=swap" rel="stylesheet"></link>
<title> Home </title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" ></script>
<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">

let page = 1;
let menuName = "";

$(function() {
	
	getRecentBoard();
	$(".menuList li.homeli").on("click", init);
	$(".menuList li.eachMenu").on("click" , getBoardByMenu);
	$("#btn_search").on("click", getRecentBoard);
	
	$("#icon_search").on("click", function() {
		
		$("#searchDIV").toggle();
	})
	
	// when not logined
	$("#btn_login").on("click", function() {
		$(location).attr("href", "/login");
	})
	
	
	// when logined 
	$("#btn_writeBoard").on("click", function() {
		$(location).attr("href", "/writeBoard");
	})
	
	$("#btn_logout").on("click", function() {
		$(location).attr("href", "/logout");
	})
	
	$("#btn_menuCreate").on("click", function() {
		$(location).attr("href", "/menu/create");
	})
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
	menuName = $(this).children("div").children("div").text();
	
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
		
		let count = 1; // for img
		
		// boardlist
		$.each(res, function(index, item) {
			if (index < 6) {
				boardResult += '<div class="polaroid">'
				boardResult += '	<a href="/readBoard?boardnum='+ item.boardnum + '">'
				boardResult += '		<img src="resources/images/board/photo' + count + '.jpeg">'
				boardResult += '		<div class="title">' + item.title + '</div>'
				boardResult += '		<div class="option">' + item.menu_name + ' | ' + item.regdate + '</div>'
				boardResult += '		<div class="boardText">' + item.text + '</div>'
				boardResult += '	</a>'
				boardResult += '</div>'
			}
			count++;
		});
		
		$(".content #recentBoardDiv").html(boardResult);
	}
	
	$("#seeMore").attr('href', '/listBoard?menu=' + menuName);
}

</script>
</head>
<body>
<div class="frame">
	<div class="header">
		<img src="resources/images/headerprofile.jpeg" class="myprofile">
		<div class="name" style="font-size: 15px; font-weight: bold; padding: 5px;">YUHA JO</div>
		<div class="mail" style="font-size: 12px; padding-bottom:5px;">jungeunhart@gmail.com</div>
		<div style="width: 30px; margin: 0 auto;">
			<a href="https://github.com/uzzing"><img src="resources/images/github.png" width="30" height="30"></a>
		</div>
	</div>
	<div class="container">
		<div class="navi">
			&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
			<c:choose>
				<c:when test="${not empty sessionScope.loginId}">
					<h3>WELCOME ${sessionScope.loginName}</h3>
					<input type="button" id="btn_menuCreate" value="NEW MENU">
					<input type="button" id="btn_writeBoard" value="NEW BOARD">
					<input type="button" id="btn_logout" value="LOGOUT">
					<div><img src="resources/images/search.png" id="icon_search" width="20" height="20" style="padding-top: 5px;"></div>
				</c:when>
				<c:otherwise>
					<div style="text-align: right;">
						<img src="resources/images/login.png" id="btn_login" width="20" height="20" style="vertical-align: middle;">
						<img src="resources/images/search.png" id="icon_search" width="20" height="20" style="vertical-align: middle;">
					</div>
				</c:otherwise>
			</c:choose>
			<div id="searchDIV" style="display:none;">
				<form id="search" method="GET">
					<select id="searchItem">
						<option value="title"  ${searchItem=='title' ? 'selected' : ''}>Title</option>
						<option value="text"   ${searchItem=='text'  ? 'selected' : ''}>Text</option>
					</select>
					<br>
					<input type="text" id="searchWord" value="${searchWord}" style="width: 80px;">
					<input type="button" id="btn_search" value="Search">
				</form>
			</div>
			<ul class="menuList">
				<li class="homeli">
					<div class="screen">
						<span></span><span></span><span></span><span></span>
						<div style="font-weight: bold;">Home</div>
					</div>
				</li>
				<c:forEach var="menu" items="${menuList}">
					<li class="eachMenu">
						<div class="screen">
							<span></span><span></span><span></span><span></span>
							<div style="font-weight: bold;">${menu.menu_name}</div>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="content">
			<div id="seeMordDiv" style="display:none;">
				<a id="seeMore">
					SEE MORE
					<img src="resources/images/goEachMenu.png" width="25" height="25" style="vertical-align: middle;">
				</a>
			</div>
			<div id="recentBoardDiv"></div>
		</div>
	</div>
	<div class="footer">
		Copyright 2021. uzzing All rights reserved.
	</div>
</div>
</body>
</html>

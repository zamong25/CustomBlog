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

$(function() {
	getRecentBoard(1);
	$("#menuList li.home").on("click", init);
	$("#menuList li.eachMenu").on("click" , getBoardByMenu);
	$("#btn_search").on("click", getRecentBoard(1));
	/* $("#menuList").sortable();
	$("#menuList").disableSelection(); */
});

function init() {
	location.href = "/";
}


function getRecentBoard(page) {
	
	let searchItem = $("#searchItem>option:selected").val();
	let searchWord = $("#searchWord").val();
	let searchForm = $('#search');
	
	$.ajax({
		url : "selectRecentBoard"
		, method : "GET"
		, data : { "searchItem" : searchItem, "searchWord" : searchWord, "page" : page }
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
	
	let boardlist = res.boardlist;
	let navi = res.navi;
	
	let searchItem = $("#searchItem>option:selected").val();
	let searchWord = $("#searchWord").val();
	
	
	let boardResult = "";
	let pagination = "";

	
	if (res.length == 0) {
		$("#recentBoardDiv").html("<b>There is no board</b>");
	} else {
		
		// boardlist
		$.each(boardlist, function(key, value) {
			boardResult += '<a href="/readBoard?boardnum='+ value.boardnum + '">'
			boardResult += '<h3>' + value.title + '</h3>'
			boardResult += '</a>'
			boardResult += value.menu_name + ' | ' + value.regdate + '<br>'
			boardResult += value.text + '<br>'
		});
		
		$("#recentBoardDiv").html(boardResult);
		
		// paging
		pagination += '<br>'
		pagination += '<a href="javascript:search(' + (navi.currentPage - navi.pagePerGroup) + ');"> ◁◁ </a> &nbsp;'
            			 
        pagination += '<a href="javascript:search(' + (navi.currentPage - 1) + ');"> ◀ </a> &nbsp;'
		
		 for (var page = navi.startPageGroup; page <= navi.endPageGroup; page++) {
             
			 if (navi.currentPage == page) { 
            	pagination += '<span style="color:blue;font-weight:bolder;font-size:1.3em">' + page + '</span> &nbsp;';
             }
             else {
            	pagination += '<a href="javascript:search(' + navi.currentPage + ');">' + page + '</a>'
             }
         }
            			 
         pagination += '<a href="javascript:search(' + (navi.currentPage + 1) + ');"> ▶ </a> &nbsp;'
            			 
         pagination += '<a href="javascript:search(' + (navi.currentPage + navi.pagePerGroup) + ');"> ▷▷ </a>'
          
         pagination += '<br>'
      
		$("#pagination").html(pagination);
	}
}

function search(currentPage) {
	
	page = $('#page').val(currentPage);

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
			<input type="hidden" name="page" id="page">
			<input type="button" id="btn_search" value="Search">
		</form>
	<br>
	<div id="recentBoardDiv"></div>
	
	<div id="pagination" ></div>
	
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link href="resources/css/listBoard.css" rel="stylesheet" type="text/css"></link>
<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;600&display=swap" rel="stylesheet"></link>
<meta charset="UTF-8">
<title>Boards</title>
<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(function() {
	$("#btn_writeBoard").on("click", function() {
		$(location).attr("href", "/writeBoard");
	})
});
</script>
</head>
<body>
<div class="frame">
	<div class="header">
		<h2>${menu}</h2>
	</div>
	<div class="topbar">
		<div class="goToHome">
			<a href="${pageContext.request.contextPath}/">
				<img id="homeImage" src="resources/images/home.png" width="20px">
			</a>
		</div>
		<c:if test="${not empty sessionScope.loginId}">
			<div class="button">
				<input type="button" id="btn_writeBoard" value="WRITE BOARD">
			</div>
		</c:if>
	</div>
	<div class="searchbar">
		<form id="search" action="listBoard" method="GET">
			<input type="hidden" name="menu" value="${menu}">
			<select name="searchItem">
				<option value="title" ${searchItem=='title' ? 'selected' : ''}>Title</option>
				<option value="text" ${searchItem=='text'  ? 'selected' : ''}>Text</option>
			</select>
			<input type="text" name="searchWord" value="${searchWord}">
			<input type="submit" id="btn" value="Search">
		</form>
	</div>
	<div class="content">
		<c:forEach var="board" items="${list}" varStatus="status">
			<c:set var="count" value="${count + 1}"></c:set>
				<div class="polaroid">
					<a href="/readBoard?boardnum=${board.boardnum}">
						<img src="resources/images/board/photo${count}.jpeg">
						<div class="title">${board.title}</div>
						<div class="option">${board.menu_name} | ${board.regdate}</div>
						<div class="boardText" height="100">${board.text}</div>
					</a>
				</div>
		</c:forEach>
	</div>
	<div class="navigator">
		<div class="navigatorIn">
			<input type="hidden" name="currentPage" id="page">
			<a href="listBoard?menu=${menu}&currentPage=${navi.currentPage-navi.pagePerGroup}&searchItem=${searchItem}&searchWord=${searchWord}">
			◁◁
			</a>
		
			<a href="listBoard?menu=${menu}&currentPage=${navi.currentPage-1}&searchItem=${searchItem}&searchWord=${searchWord}">
			◀
			</a>&nbsp;
			
			<c:forEach var="page" begin="${navi.startPageGroup}" end="${navi.endPageGroup}">
				<c:if test="${navi.currentPage == page}">
					<span style="color:#667aff;font-weight:bolder;font-size:1.3em">${page}</span> &nbsp;
				</c:if>
				
				<c:if test="${navi.currentPage != page}">
					<a href="listBoard?menu=${menu}&currentPage=${page}&searchItem=${searchItem}&searchWord=${searchWord}">${page}</a> &nbsp;
				</c:if>	
			</c:forEach>
			
			<a href="listBoard?menu=${menu}&currentPage=${navi.currentPage+1}&searchItem=${searchItem}&searchWord=${searchWord}">
			▶
			</a>
			&nbsp;
			
			<a href="listBoard?menu=${menu}&currentPage=${navi.currentPage+navi.pagePerGroup}&searchItem=${searchItem}&searchWord=${searchWord}">
			▷▷
			</a>
		</div>
	</div>
</div>
</body>
</html>
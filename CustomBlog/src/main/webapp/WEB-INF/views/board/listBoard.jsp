<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Boards</title>
<style>
#boardBox {
	border: 1px;
	color: gray;
	border-radius: 0.4em;
}

input[type=submit] {
	border : none;
}
</style>

</head>
<body>

	<div>
		<h3>${menu}</h3>
		
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
	
	<br>
	
	<div id="boardBox">
		<c:forEach var="board" items="${list}">
			<a href="/readBoard?boardnum=${board.boardnum}">
				${board.title}
			</a>
			<div>${board.menu_name} | ${board.regdate}</div>
			<div>${board.text}</div>
		</c:forEach>
	</div>
	
	<div class="navigator">
		<a href="listBoard?menu=${menu}&currentPage=${navi.currentPage-navi.pagePerGroup}&searchItem=${searchItem}&searchWord=${searchWord}">
		◁◁
		</a>
	
		<a href="listBoard?menu=${menu}&currentPage=${navi.currentPage-1}&searchItem=${searchItem}&searchWord=${searchWord}">
		◀
		</a>&nbsp;
		
		<c:forEach var="page" begin="${navi.startPageGroup}" end="${navi.endPageGroup}">
			<c:if test="${navi.currentPage == page}">
				<span style="color:blue;font-weight:bolder;font-size:1.3em">${page}</span> &nbsp;
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
	
</body>
</html>
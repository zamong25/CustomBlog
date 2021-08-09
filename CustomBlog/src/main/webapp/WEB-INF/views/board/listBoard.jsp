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
		<h3>${list[0].menu_name}</h3>
		
		<form id="search" action="listboard" method="GET">
			<select id="searchItem">
				<option value="title" ${searchItem=='title' ? 'selected' : ''}>Title</option>
				<option value="text" ${searchItem=='text'  ? 'selected' : ''}>Text</option>
			</select>
			<input type="text" id="searchWord" value="${searchWord}">
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
	
</body>
</html>
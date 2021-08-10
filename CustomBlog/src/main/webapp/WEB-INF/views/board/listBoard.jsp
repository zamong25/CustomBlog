<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Boards</title>
<style>
.boardBox {
	border: 1px solid gray;
	border-radius: 0.4em;
	padding : 5px;
	width : 200px;
}

input[type=submit] {
	border : none;
}

#menuTitle {
	font-weight : bolder;
	font-size : 1.5em;
}

#homeImage {
	width : 25px;
}
</style>
<script type="text/javascript">

$(function() {
	
	let page = $("$page").val();
	
	
});
</script>
</head>
<body>

	<div>
		<span id="menuTitle">${menu}</span>
		<br>
		<p><a href="${pageContext.request.contextPath}/"><img id="homeImage" src="resources/images/home.png"></a></p>
		<form id="search" action="listBoard" method="GET">
			<input type="hidden" name="menu" value="${menu}">
			<select name="searchItem">
				<option value="title" ${searchItem=='title' ? 'selected' : ''}>Title</option>
				<option value="text" ${searchItem=='text'  ? 'selected' : ''}>Text</option>
			</select>
			<input type="text" name="searchWord" value="${searchWord}">
			<input type="submit" id="btn" value="Search">
		</form>
		<br>
	</div>

	<c:forEach var="board" items="${list}" varStatus="status">
		<div class="boardBox">
			<a href="/readBoard?boardnum=${board.boardnum}">
				${board.title}
			</a>
			<br>
			${board.menu_name} | ${board.regdate}
			<br>
			${board.text}
		</div>
		<br>
	</c:forEach>
	
	<div class="navigator">
		<input type="hidden" name="currentPage" id="page">
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
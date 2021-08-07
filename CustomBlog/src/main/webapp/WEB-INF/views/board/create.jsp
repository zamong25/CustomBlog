<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
function formCheck() {
	let title = document.getElementById("title");
	let text  = document.getElementById("text");
	
	if(title.value.trim().length == 0 || text.value.trim().length == 0) {
		alert('Please write title and text');
		return false;
	}
	return true;
}
/* 
function boardList() {
	let target = '${pageContext.request.contextPath}';
	location.href = target + '/board';
} */

</script>
</head>
<body>
	<div class="wrapper">
	<h2>[ Create board ]</h2>
	<form action="create" method="POST" enctype="multipart/form-data">
		<%-- <input type="hidden" name="userid" value="${sessionScope.loginId}"> --%>
		
		<table border="1">
			<tr>
				<th>Title</th>
				<td><input type="text" name="title" id="title"></td>
			</tr>
			<tr>
				<th>Menu</th>
				<td>
					<select name="menu_name">
						<option value="">Choose</option>
						<c:forEach  var="menu" items="${menus}">
							<option value="${menu.menu_name}">${menu.menu_name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>Text</th>
				<td>
					<textarea rows="10" cols="50" name="text" id="text"></textarea>
				</td>
			</tr>
			<tr>
				<th>File</th>
				<td><input type="file" name="upload" size="30"></td>
			</tr>
			<tr>
				<th class="btn" colspan="2">
					<input type="submit" value="Save" onclick="return formCheck();">
					<!-- <input type="button" value="Cancle" onclick="boardList();"> -->
				</th>
			</tr>
		</table>
	</form>
</div>
	
</body>
</html>
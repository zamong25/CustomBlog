<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="resources/css/writeBoardCSS.css" rel="stylesheet" type="text/css"></link>
<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;600&family=Nanum+Gothic&display=swap" rel="stylesheet"></link>
<meta charset="UTF-8">
<title>New Board</title>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script>

let boardnum = 0;

$(function() {
	
	$("#btn_insert").on('click', insert);
	$("#btn_update").on('click', update);
	
	let title = $("#title").val();
	if (title.trim().length == 0) {
		$("#btn_insert").css("display", "inline");
		$("#btn_update").css("display", "none");
	}
	else {
		$("#btn_insert").css("display", "none");
		$("#btn_update").css("display", "inline");
	}
});

function insert() {
	
	let title = $("#title").val();
	let menuName = $("#menu_name option:selected").val();
	let text = $("#text").val();
	let file = $("#file")[0].files[0];
	
	if (title.trim().length == 0) {
		alert("Please enter data of title");
		return;
	}
	
	if (menuName.length == 0) {
		alert("Please enter data of menu");
		return;
	}
	
	if (text.trim().length == 0) {
		alert("Please enter data of text");
		return;
	}
		
	var formData = new FormData();
	formData.append("title", title);
	formData.append("menu_name", menuName);
	formData.append("text", text);
	
	if (file != null) {
		formData.append("file", file);
	}
	
	if (title.trim().length != 0 && menuName.length != 0 && text.trim().length != 0) {
		$.ajax({
			url : 'writeBoard'
			, method : 'POST'
			, data : formData
			, processData : false
			, contentType : false
			, success : function(res) {
				alert("Inserted successfully");
				location.href = "/";
			}
			, error : function(err) {
				console.log(err);
			}
		});
	}
}

function update() {
	
	let boardnum = $("#boardnum").val();
	let title = $("#title").val();
	let menuName = $("#menu_name option:selected").val();
	let text = $("#text").val();
	let file = $("#file")[0].files[0];
	
	var formData = new FormData();
	formData.append("boardnum", boardnum);
	formData.append("title", title);
	formData.append("menu_name", menuName);
	formData.append("text", text);
	
	if (file != null) {
		formData.append("file", file);
	}

	$.ajax({
		url : 'updateBoard'
		, method : 'POST'
		, data : formData
		, processData : false
		, contentType : false
		, success : function(res) {
			alert("Inserted successfully");
			location.href = "/";
		}
		, error : function(err) {
			console.log(err);
		}
	});
}

</script>
</head>
<body>
<div class="wrapper">
	<h2>[ Write board ]</h2>
	<form action="createBoard" method="POST" enctype="multipart/form-data">
		<input type="hidden" id="boardnum" value="${board.boardnum}">
		<table>
			<tr>
				<th>Title</th>
				<td>
					<input type="text" name="title" id="title" value="${board.title}" style="width: 550px;">
				</td>
			</tr>
			<tr>
				<th>Menu</th>
				<td>
					<select name="menu_name" id="menu_name">
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
					<textarea rows="20" cols="80" name="text" id="text">${board.text}</textarea>
				</td>
			</tr>
			<tr>
				<th>File</th>
				<td>
					<input type="file" name="file" id="file" size="30">
					<br>${board.originalfile}
				</td>
			</tr>
			<tr>
				<th class="btn" colspan="2">
					<input type="button" id="btn_insert" value="Create">
					<input type="button" id="btn_update" value="Update">
				</th>
			</tr>
		</table>
	</form>
</div>
	
</body>
</html>
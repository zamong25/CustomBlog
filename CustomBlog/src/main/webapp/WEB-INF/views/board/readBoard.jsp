<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">

let boardnum = 0;

$(function() {
	$('#btn_update').on('click', update);
	$("#btn_delete").on('click', deleteBoard);
})

function update() {
	let boardnum = $("#boardnum").val();
	location.href="/updateBoard?boardnum=" + boardnum;
}

function deleteBoard() {
	
	let boardnum = $("#boardnum").val();
	
	let check = confirm("Do you want to delete?");
	
	if (check) {
		$.ajax({
			url : 'deleteBoard'
			, method : 'GET'
			, data :{ "boardnum" : boardnum }
			, success : function() {
				alert("Deleted successfully");
				location.href = "/";
			}
			, error : function(err) {
				alert("Please try again");
				console.log(err);
			}
		});
	}
}

</script>
</head>
<body>
	<span id="menu">${board.menu_name}</span>
	<input type="hidden" id="boardnum" value="${board.boardnum}">
	<table border="1">
			<tr>
				<th>Title</th>
				<td>
					${board.title}
				</td>
			</tr>
			<tr>
				<th>Date</th>
				<td>
					${board.regdate}
				</td>
			</tr>
			<tr>
				<th>Text</th>
				<td>
					${board.text}
				</td>
			</tr>
			<tr>
				<th>File</th>
				<td>
					<a href="download?boardnum=${board.boardnum}">${board.originalfile}</a>
				</td>
			</tr>
			<tr>
				<th class="btn" colspan="2">
					<input type="button" id="btn_update" value="Update">
					<input type="button" id="btn_delete" value="Delete">
				</th>
			</tr>
		</table>

</body>
</html>
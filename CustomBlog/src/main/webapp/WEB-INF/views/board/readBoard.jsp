<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
#homeImage {
	width : 25px;
}
</style>
<script type="text/javascript" src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">

let boardnum = 0;
let replynum = 0;

$(function() {
	initReply(); // get all reply
	$('#btn_updateBoard').on('click', updateBoard);
	$("#btn_deleteBoard").on('click', deleteBoard);
	$('#btn_insertReply').on('click', insertReply);
	$('#btn_updateReply').on('click', updateReply);
})

// Board
function updateBoard() {
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

// Reply
function insertReply() {
	
	let boardnum = $("#boardnum").val();
	let userid	= $("#userid").val();
	let userpw	= $("#userpw").val();
	let replytext = $("#replytext").val();
	
	if (userid.trim().length == 0 || userpw.trim().length == 0 || replytext.trim().length == 0) {
		alert("Please enter data");
		return;
	}
	
	let replyData = { "boardnum" : boardnum, "userid" : userid,
						"userpw" : userpw, 	"replytext" : replytext};
	
	$.ajax({
		url : 'insertReply'
		, method : 'POST'
		, data : replyData
		, success : function() {
			alert("Submitted successfully");
			$("#userid").val("");
			$("#userpw").val("");
			$("#replytext").val("");
			initReply(); // reshow data
		}
		, error : function(err) {
			console.log(err);
		}
	})
}

function initReply() {
	
	boardnum = $("#boardnum").val();
	
	$.ajax({
		url : "selectReplyByBoard"
		, method  : "GET"
		, data : { "boardnum" : boardnum }
		, success : outputReply
		, error : function(err) {
			console.log(err);
		}
	});
}

// inside of initReply()
function outputReply(res) {
	
	let result = '';
	
	if (res.length != 0) {
	
		$.each(res, function(index, item){
			
			let random = Math.floor(Math.random() * 5 + 1); // for random profile image
			
			result += '<div class="replyBox">'
			result += 	'<img src="resources/images/profile' + random + '.png" alt="" width="20" height="20">'
			result += 		item.userid 	+ '<br>'
			result += 		item.replytext 	+ '<br>'
			result +=  		item.regdate 	+ '<br>'
			result += '		<input type="button" class="delbtn"    data-num="'+ item.replynum +'"  value="Delete">'
			result += '		<input type="button" class="updatebtn" data-num="'+ item.replynum +'"  value="Modify">'
			result += '</div>'
		});

		$("#replyTarget").html(result);
		
		// button
		$(".delbtn").on('click', deleteReply);
		$(".updatebtn").on('click', getDataForUpdateReply);
	}
}

// delbtn
function deleteReply() {
	
	let replynum = $(this).attr('data-num');

	$.ajax({
		url : 'deleteReply'
		, method : 'GET'
		, data : { "replynum" : replynum }
		, success : function(res) {
			alert(res);
			initReply();
		}
	});
}

// updatebtn - GET
function getDataForUpdateReply() {
	
	let userpw = prompt("Please enter password"); // check whether that user wrote reply
	
	replynum = $(this).attr('data-num');

	$.ajax({
		url : 'selectOneReply'
		, method : 'GET'
		, data : { "replynum" : replynum }
		, success : function(res) {
			
			// check reply
			if (res.userpw == userpw) {
				$("#userid").val(res.userid);
				$("#userpw").val(res.userpw);
				$("#replytext").val(res.replytext);
				
				$("#btn_insertReply").css("display", "none");
				$("#btn_updateReply").css("display", "inline");
			}
			else {
				alert("The password is wrong");
				return;
			}
		}
	});
}

// POST
function updateReply() {
	
	let replytext = $("#replytext").val();
	let userpw = $("#userpw").val();

	if(replytext.trim().length == 0) {
		alert("Please write content");
		return;
	}
	
	let replyData = { "replynum" : replynum, "userpw" : userpw, "replytext": replytext };
	
	$.ajax({
		url : 'updateReply'
		, method : 'POST'
		, data : replyData
		, success : function() {
			
			$("#userid").val("");
			$("#userpw").val("");
			$("#replytext").val("");
			
			$("#btn_insertReply").css("display", "inline");
			$("#btn_updateReply").css("display", "none");
			
			initReply();
		}
	})
}

</script>
</head>
<body>
	<p><a href="${pageContext.request.contextPath}/"><img id="homeImage" src="resources/images/home.png"></a></p>
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
			
			<c:if test="${not empty sessionScope.loginId}">
			<tr>
				<th class="btn" colspan="2">
					<input type="button" id="btn_updateBoard" value="Update">
					<input type="button" id="btn_deleteBoard" value="Delete">
				</th>
			</tr>
			</c:if>
	</table>
		
	<div class="wrapper">
		<h2> Reply </h2>
		<div>
			<label>ID : <input type="text" id="userid" name="userid"></label>
			<label>Password : <input type="text" id="userpw" name="userpw"></label>
			<label>Content : <input type="text" id="replytext" name="replytext"></label>
			<input type="button" id="btn_insertReply" value="Save">
			<input type="button" id="btn_updateReply" value="Modify">
		</div>
		<br>
		<div id="replyTarget"></div>
	</div>
</body>
</html>
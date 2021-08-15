<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="resources/css/readBoardCSS.css" rel="stylesheet" type="text/css"></link>
<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;600&family=Nanum+Gothic&display=swap" rel="stylesheet"></link>
<meta charset="UTF-8">
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
	
	let boardnum = $(".content #boardnum").val();
	
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
	});
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
			result += '		<div class="user">'
			result += '			<img src="resources/images/profile' + random + '.png" alt="" width="20" height="20">'
			result += '				&nbsp;' + item.userid
			result += '		</div>'
			result += '		<div class="regdate">' + item.regdate 	+ '</div>'
			result += '		<div class="replytext">' + item.replytext + '</div>'
			result += '		<div class="buttons">'
			result += '			<input type="button" class="delbtn"    data-num="'+ item.replynum +'"  value="Delete">'
			result += '			<input type="button" class="updatebtn" data-num="'+ item.replynum +'"  value="Modify">'
			result += '		</div>'
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
	
	let userpw = prompt("Please enter password"); // check whether that user wrote reply
	
	replynum = $(this).attr('data-num');

	
	$.ajax({
		url : 'selectOneReply'
		, method : 'GET'
		, data : { "replynum" : replynum }
		, success : function(res) {
			
			// check reply
			if (res.userpw == userpw) {
				
				$.ajax({
					url : 'deleteReply'
					, method : 'GET'
					, data : { "replynum" : replynum }
					, success : function(res) {
						alert(res);
						
						$("#replyTarget").empty();
						
						initReply();
					}
				});
				
			}
			else {
				alert("The password is wrong");
				return;
			}
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
<div class="frame">
	<div class="content">
		<input type="hidden" id="boardnum" value="${board.boardnum}">
		<div id="menu">${board.menu_name}</div>
		<div class="title">${board.title}</div>
		<div class="option">
			<div class="profile">
				<img src="resources/images/headerprofile.jpeg">
			</div>
			<div class="name">YUHA</div>
			<div class="date">${board.regdate}</div>
			<c:if test="${not empty sessionScope.loginId}">
				<div class="buttons">
					<input type="button" id="btn_updateBoard" value="Update">
					<input type="button" id="btn_deleteBoard" value="Delete">
				</div>
			</c:if>
			<div class="home"><a href="${pageContext.request.contextPath}/"><img id="homeImage" src="resources/images/home.png" width="20"></a></div>
		</div>
		<div class="line"><img src="resources/images/line.png" width="100%" height="1.5"></div>
		<div class="text"><pre>${board.text}</pre></div>
		<c:if test="${board.originalfile != null}">
			<div class="file"><label style="font-weight: bold; color: gray;">File : </label><a href="download?boardnum=${board.boardnum}">${board.originalfile}</a></div>
		</c:if>
	</div>
	<div class="reply">
		<div class="replyTitle">REPLY</div>
		<div class="writeReply">
			<div class="id">ID : <br><input type="text" id="userid" name="userid"></div>
			<div class="password">PASSWORD : <input type="text" id="userpw" name="userpw"></div>
			<div class="contents">TEXT : <textarea id="replytext" rows="5" name="replytext"></textarea>
			<div class="buttons">
				<input type="button" id="btn_insertReply" value="Save">
				<input type="button" id="btn_updateReply" value="Modify" style="display: none;">
			</div>
		</div>
		<br>
		<div id="replyTarget"></div>
	</div>
</div>
</body>
</html>
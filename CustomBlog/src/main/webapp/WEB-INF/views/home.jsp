<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
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

$(function() {
	$("#menuList").sortable();
	$("#menuList").disableSelection();
});

/* function submit() {
    var idsInOrder = [];
    $("#menuList li").each(function() {
    	idsInOrder.push($(this).index()) });
    alert(idsInOrder.join('\n'));
} */

function submit() {
	
}

</script>
</head>
<body>
	<h1>menu</h1>
	<ul id="menuList">
		<c:forEach var="menu" items="${menuList}">		
			<li>
				<a href="" >${menu.menu_name}</a>
			</li>
		</c:forEach>
	</ul>
	
	<input type="submit" value="Submit" onclick="submit()">
</body>
</html>

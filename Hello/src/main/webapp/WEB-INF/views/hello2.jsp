<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>

<%@ page import="com.example.hello.test.service.vo.TestVO3" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<html>

<head>
	<title>Test2</title>
</head>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	
	
	
});

</script>

<body>
<%
	Map<String, Object> dataMap = (HashMap<String, Object>)request.getAttribute("dataMap");

	if("0000".equals(dataMap.get("result"))) {
	
 	List<TestVO3> testList = (List<TestVO3>)dataMap.get("testList");
 	
	for(TestVO3 vo : testList) {
		String code = vo.getCode();
		String name = vo.getName();
%>
<h2>코드 : <%=code%></h2>
<h2>이름 : <%=name%></h2><br />
<%
		}
	}
%>
</body>
</html>

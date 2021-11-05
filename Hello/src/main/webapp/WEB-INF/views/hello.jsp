<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>

<%@ page import="com.example.hello.test.service.vo.TestVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<html>

<head>
	<title>Test</title>
</head>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	
	/** select box 선택 액션 */
	// 선택한 값으로 테이블에 값을 보여줌
	$("#selBox").change(function() {
		
		var selCode = $("#selBox option:selected").attr("selCode");
		var selName = $("#selBox option:selected").attr("selName");
		
		$("#selName").text(selName == null ? "-" : selName);
		$("#selCode").text(selCode == null ? "-" : selCode);
	});
	
});

function depth2(val) {
	
	var reqData = { "code" : val };
	
	$.ajax({
		type:"POST",
		url:"/hello/test/p1/getDepth2",
		contentType: "application/json",
		data: JSON.stringify(reqData),
		dataType : "json",
		success : function(data) {
			if(data.result == "0000"){
				nextSelBox(data.nextList);				
			} else {
				alert("서비스 에러");
			}
		},
		error: function() {
			console.log("통신 실패");
		}
	});
}

/** Next Select Box */
function nextSelBox(nextList) {
	
	$('#selBox2').children('option').remove();
	$("#selBox2").append("<option>2 Depth</option>");
	
	for(var i = 0; i < nextList.length; i++) {
		
		var str = "<option>" + nextList[i].name + "</option>";
		
		$("#selBox2").append(str);	
		
	}
}

/** 보이기/감추기 */
function allOfDivOnOff() {
	if($("#allOfDiv").css("visibility") == "visible"){
		$("#allOfDiv").css("visibility", "hidden");
	} else {
		$("#allOfDiv").css("visibility", "visible");
	}
}


</script>

<body>

<div id="allOfDiv" style="visibility: visible;">
	<div align="center">
		<h1>JSP HELLO</h1> 
	</div>
	
	<!-- SELECT BOX -->
	<div style="margin-top: 5%" align="center">
		<select id=selBox onchange="depth2(this.value);">
			<option value="0" selected> 1 Depth </option>
			<%
				Map dataMap = (HashMap)request.getAttribute("dataMap");
					
						List<TestVO> testList = new ArrayList<TestVO>();
						
						testList = (List<TestVO>)dataMap.get("testList");
						
						for(TestVO vo : testList) {
							String code = vo.getCode();
							String name = vo.getName();
			%>
				<option selCode="<%=code%>" selName="<%=name%>" value="<%=code%>"><c:out value="<%=name%>"/></option>
			<%
				}
			%>
		</select>
		<select id=selBox2>
			<option selected> 2 Depth </option>
		</select>
	</div>
	
	<!-- 1 Depth -->
	<div style="margin-top: 3%" align="center">
		<table border="1" width="200" height="50">
			<caption>1 Depth</caption>
			<thead>
				<tr align="center">
					<th>코드</th>
					<th>이름</th>
				</tr>
			</thead>
			<tbody>
				<tr align="center">
					<td id="selCode"> - </td>
					<td id="selName"> - </td>
				</tr>
			</tbody>
		</table>
		<h1 id="sportsName"></h1>
	</div>

<%-- 
	<!-- 2 Depth -->
	<div style="margin-top: 5%" align="center" >	
		<table border="1" width="200" height="100">
			<caption>2 Depth</caption>
			<thead>
				<tr align="center">
					<th>코드</th>
					<th>이름</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${testList}" var="test">
					<tr align="center">
						<td><c:out value="${test.code}"/></td>
						<td><c:out value="${test.name}"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
--%>
	
</div>


 
<div style="margin-top: 10%" align="center">
	<button onclick="allOfDivOnOff();">보이기/감추기</button>
</div>

</body>
</html>

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
	<meta charset="utf-8">
	
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
		
		if( selCode == null ){
			$('#selBox2').children('option').remove();
			$("#selBox2").append("<option value='0'>2 Depth</option>");
		}
		
		$("#selName").text(selName == null ? "-" : selName);
		$("#selCode").text(selCode == null ? "-" : selCode);
	});
	
	$("#selBox").change(function() {
		
		var selCode = $("#selBox option:selected").attr("selCode");
		
		if( selCode == null ){
			
			$('#depth2').empty();
			$('#choiceDiv').empty();
		}
		
	});
	
});

/** Get Depth2 ajax */
function depth2(value) {
	//this.value 연습
	
	// 아무 선택을 안했을때는 리턴
	if(value == 0 ){
		return;
	}
	
	var reqData = { "code" : value };
	
	$.ajax({
		type:"POST",
		url:"/hello/test/p1/getDepth2",
		contentType: "application/json",
		data: JSON.stringify(reqData),
		dataType : "json",
		success : function(data) {
			if(data.result == "0000"){
				depth2SelBox(data.nextList);
				depth2Div(data.nextList);
			} else {
				$('#choiceDiv').empty();
				$('#depth2').empty();
				alert("에러 메세지 출력");
			}
		},
		error: function() {
			console.log("통신 실패");
		}
	});
}

/** Get Depth2 Make Select Box */
function depth2SelBox(nextList) {
	
	$('#selBox2').children('option').remove();
	$("#selBox2").append("<option value='0'>2 Depth</option>");
	
	for(var i = 0; i < nextList.length; i++) {
		
		var str = "<option selCode=" + nextList[i].code + " selName=" + nextList[i].name + " value=" + nextList[i].code + ">" + nextList[i].name + "</option>";
		
		$("#selBox2").append(str);	
		
	}
}

/** Get Depth2 Make div */
function depth2Div(nextList) {
	
	$('#depth2').empty();
	
	var str = "";
	str += "<table border='1' width='200' height='100'>";
	str += "	<caption>2 Depth</caption>";
	str += "	<thead>";
	str += "		<tr align='center'>";
	str += "			<th>코드</th>";
	str += "			<th>이름</th>";
	str += "		</tr>";
	str += "	</thead>";
	str += "	<tbody>";
	for(var i = 0; i < nextList.length; i++) {
		str += "	<tr align='center'>";
		str += "		<td>" + nextList[i].code + "</td>";
		str += "		<td>" + nextList[i].name + "</td>";
		str += "	</tr>";
	}
	str += "	</tbody>";
	str += "</table>";
	
	$("#depth2").append(str);	
}

/** 최종 선택 */
function choice() {
	
	$('#choiceDiv').empty();
	
	var choiceC = $("#selBox2 option:selected").attr("selCode");
	var choiceN = $("#selBox2 option:selected").attr("selName");
	
	if( choiceC == null ) {
		return;
	}
	
	var str = "";
	str += "<table border='1' width='200' height='100'>";
	str += "	<caption>최종 선택</caption>";
	str += "	<thead>";
	str += "		<tr align='center'>";
	str += "			<th>코드</th>";
	str += "			<th>이름</th>";
	str += "		</tr>";
	str += "	</thead>";
	str += "	<tbody>";
	str += "		<tr align='center'>";
	str += "			<td>" + choiceC + "</td>";
	str += "			<td>" + choiceN + "</td>";
	str += "		</tr>";
	str += "	</tbody>";
	str += "</table>";
	
	$("#choiceDiv").append(str);
}

/** 다음 버튼 */
function nextPg() {
	
	// 자동 submit 방지
	event.preventDefault();
	
	var result = confirm("다음 페이지로 넘어 갈까?");
	
	if(result) {
		
		var depth1C = $("#selBox option:selected").attr("selCode");
		var depth1N = $("#selBox option:selected").attr("selName");
		
		var depth2C = $("#selBox2 option:selected").attr("selCode");
		var depth2N = $("#selBox2 option:selected").attr("selName");

		// 선택여부 체크
		if( depth1C == null ){
			alert("1 Depth를 선택해주세요");
			return;
		}
		
		if( depth2C == null ){
			alert("2 Depth를 선택해주세요");
			return;
		} 
		
		$("#depth1C").val(depth1C);
		$("#depth1N").val(depth1N);
		
		$("#depth2C").val(depth2C);
		$("#depth2N").val(depth2N);
	
		// 페이지 이동
		$("#fm").submit();
		
		console.log($("#depth1C").val());
		console.log($("#depth1N").val());
		console.log($("#depth2C").val());
		console.log($("#depth2N").val());
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
<form id="fm" action="http://localhost:8082/hello/test/p2" method="post" >
	<input type = "hidden" id ="depth1C" name= "depth1C" />
	<input type = "hidden" id ="depth1N" name= "depth1N" />
	
	<input type = "hidden" id = "depth2C" name= "depth2C" />
	<input type = "hidden" id = "depth2N" name= "depth2N" />
	
	
	<div id="allOfDiv" style="visibility: visible;">
		<div align="center">
			<h1>JSP HELLO</h1> 
		</div>
		
		<!-- SELECT BOX -->
		<div style="margin-top: 5%" align="center">
			<select id=selBox onchange="depth2(this.value);">
				<option value="0" selected> 1 Depth </option>
				<%
					Map<String, Object> dataMap = (HashMap<String, Object>)request.getAttribute("dataMap");
				
					
					if("0000".equals(dataMap.get("result"))) {
						
				 	List<TestVO> testList = (List<TestVO>)dataMap.get("testList");
				 	
					for(TestVO vo : testList) {
						String code = vo.getCode();
						String name = vo.getName();
					%>
						<option selCode="<%=code%>" selName="<%=name%>" value="<%=code%>"><c:out value="<%=name%>"/></option>
					<%
						}
					}
				%>
			</select>
			<select id=selBox2 onchange="choice();">
				<option selected> 2 Depth </option>
			</select>
		</div>
		
		<!-- 1 Depth -->
		<div id="depth1" style="margin-top: 3%" align="center">
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
		
		<!-- 2 Depth -->
		<div id="depth2" style="margin-top: 3%" align="center">
		</div>
		
		<!-- 최종선택 -->
		<div id="choiceDiv" style="margin-top: 3%" align="center">
		</div>
		
		<!-- 다음 버튼 -->
		<div style="margin-top: 3%" align="center">
			<button onclick="nextPg();">다음</button>	
		</div>
	</div>
	
	<!-- 보이기/감추기 버튼 -->
	<div style="margin-top: 10%" align="center">
		<button onclick="allOfDivOnOff();">보이기/감추기</button>
	</div>

</form>
</body>
</html>

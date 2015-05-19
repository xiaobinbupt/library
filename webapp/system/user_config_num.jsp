<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String user_id = request.getParameter("user_id");
	String config_num = request.getParameter("config_num");
	String name = request.getParameter("name");
	String real_name = request.getParameter("real_name");
	String district = request.getParameter("district");
	String pages = request.getParameter("page");
	if(name == null){
		name = "";
	}
	if(real_name == null){
		real_name = "";
	}
	if(district == null){
		district = "";
	}
	if(pages == null){
		pages = "";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'user_config_num.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<script type="text/javascript">
function submit_form() {
	var config_num = document.getElementById("config_num").value;
	if (config_num == '') {
		alert('配额不能为空!');
		return;
	}
	if(isNaN(config_num)){
		alert('配额必须是数字!');
		return;
	}
	if(parseInt(config_num) < 1){
		alert('配额必须大于0!');
		return;
	} 
	document.forms[0].submit();
}
</script>
</head>

<body>
	<form method="post"
		action="<%=basePath%>/api?servlet=system&cmd=upd_user_config_num">
		<input type="hidden" id="user_id" name="user_id" value="<%=user_id%>">
		<input type="hidden" id="name" name="name" value="<%=name%>">
		<input type="hidden" id="real_name" name="real_name" value="<%=real_name%>">
		<input type="hidden" id="district" name="district" value="<%=district%>">
		<input type="hidden" id="page" name="page" value="<%=pages%>">
		<table width="80%" border="1" align="center">
			<tr>
				<td>借阅配额:</td>
				<td><input name="config_num" type="text" id="config_num"
					value="<%=config_num == null ? "0" : config_num%>" />
				</td>
				<td width="5%"><input type="button" onclick="submit_form();"
					value="提交" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>

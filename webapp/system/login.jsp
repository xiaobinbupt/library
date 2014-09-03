<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String err = (String) request.getAttribute("err");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>login</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body>
	<div>
		<a href="/regist" title="注册" target="_self">注册</a>
	</div>
	<div align="center">
		<%
			if (err != null) {
		%>
		<h1>
			<strong><%=err%></strong>
		</h1>
		<%
			}
		%>
	</div>
	<form id="form" name="form" method="post"
		action="<%=basePath%>/api?servlet=system&cmd=login">
		<table width="60%" border="1" align="center">
			<tr>
				<td width="30%">用户名:</td>
				<td><input name="name" type="text" id="name" size="70%" /></td>
			</tr>
			<tr>
				<td>密码:</td>
				<td><input name="password" type="password" id="password"
					size="70%" /></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="reset" name="reset"
					id="reset" value="重置" /> <input type="submit" name="submit"
					id="submit" value="提交" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>

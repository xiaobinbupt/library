<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String user_name = (String) request.getSession().getAttribute(
			"user_name");
	Integer role_id = (Integer) request.getSession().getAttribute(
			"role_id");
	if (role_id == null) {
		role_id = 1;
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title></title>

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
	<table width="80%" border="0">
		<tr>
			<%
				if (user_name != null) {
			%>
			<td>欢迎您:<%=user_name%> &nbsp;&nbsp;&nbsp;&nbsp;<a
				href="<%=basePath%>/api?servlet=system&cmd=logout">退出</a>
			</td>
			<td><a href="<%=basePath%>/api?servlet=book&cmd=list">图书管理</a>
			</td>
			<td><a href="<%=basePath%>/api?servlet=book&cmd=new_book_list_admin">推荐阅读管理</a>
			</td>
			<td><a href="<%=basePath%>/api?servlet=borrow&cmd=list">借阅管理</a>
			</td>
			<td><a href="<%=basePath%>/api?servlet=feedback&cmd=list">意见及建议</a>
			</td>
			<td><a
				href="<%=basePath%>/api?servlet=system&cmd=prepare_upd_user">用户信息</a>
			</td>
			<td><a href="<%=basePath%>/api?servlet=system&cmd=user_list">用户管理</a>
			</td>
			<%
				} else {
			%>
			<td><a
				href="<%=basePath%>/api?servlet=system&cmd=prepare_regist">注册</a></td>
			<td><a href="<%=basePath%>/api?servlet=system&cmd=prepare_login">登录</a>
			</td>
			<%
				}
			%>
		</tr>
	</table>
	<hr />
</body>
</html>

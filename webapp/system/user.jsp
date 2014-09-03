<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	User user = (User) request.getAttribute("user");
	Object info = request.getAttribute("info");
	String err = (String) request.getAttribute("err");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>regist</title>

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
		var name = document.getElementById("name").value;
		if (name == '') {
			alert('用户名不能为空!');
			return;
		}
		var password = document.getElementById("password").value;
		if (password == '') {
			alert('密码不能为空!');
			return;
		}
		var password = document.getElementById("password").value;
		if (password == '') {
			alert('密码不能为空!');
			return;
		}
		var password_repat = document.getElementById("password_repat").value;
		if (password_repat == '') {
			alert('确认密码不能为空!');
			return;
		}
		if (password_repat != password) {
			alert('密码不一致!');
			return;
		}
		var real_name = document.getElementById("real_name").value;
		if (real_name == '') {
			alert('真实姓名不能为空!');
			return;
		}
		var mobile = document.getElementById("mobile").value;
		if (mobile == '') {
			alert('电话不能为空!');
			return;
		}
		var address = document.getElementById("address").value;
		if (address == '') {
			alert('地址不能为空!');
			return;
		}
		document.forms[0].submit();
	}
</script>

</head>

<body>
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
	<form id="form1" name="form1" method="post"
		action="<%=basePath%>/api?servlet=system&cmd=upd_user">
		<input type="hidden" name="id" id="id"
			value="<%=user == null ? "" : user.getId()%>">
		<table width="70%" border="1" align="center">
			<tr>
				<td width="20%">用户名:</td>
				<td width="80%"><input name="name" type="text" id="name"
					value="<%=user == null ? "" : user.getName()%>" size="100%"
					<%=user == null ? "" : (err == null ? "readonly":"")%> /></td>
			</tr>
			<%
				if (info == null) {
			%>
			<tr>
				<td>密码:</td>
				<td><input name="password" type="password" id="password"
					value="<%=user == null ? "" : user.getPassword()%>" size="100%" />
				</td>
			</tr>
			<tr>
				<td>确认密码:</td>
				<td><input name="password_repat" type="password"
					value="<%=user == null ? "" : user.getPassword()%>"
					id="password_repat" size="100%" /></td>
			</tr>
			<%
				}
			%>
			<tr>
				<td>真实姓名:</td>
				<td><input name="real_name" type="text" id="real_name"
					value="<%=user == null ? "" : user.getReal_name()%>" size="100%"
					<%=info == null ? "" : "readonly=\"\""%> /></td>
			</tr>
			<tr>
				<td>电话:</td>
				<td><input name="mobile" type="text" id="mobile" size="100%"
					value="<%=user == null ? "" : user.getMobile()%>"
					<%=info == null ? "" : "readonly=\"\""%> /></td>
			</tr>
			<tr>
				<td>地址:</td>
				<td><input name="address" type="text" id="address" size="100%"
					value="<%=user == null ? "" : user.getAddress()%>"
					<%=info == null ? "" : "readonly=\"\""%> /></td>
			</tr>
			<tr>
				<td>简介:</td>
				<td><input name="des" type="text" id="des" size="100%"
					value="<%=user == null ? "" : user.getDes()%>"
					<%=info == null ? "" : "readonly=\"\""%> /></td>
			</tr>
			<tr>
				<td colspan="2"><table width="100%" border="0">
						<tr>
							<td width="50%" align="center"><input type="button"
								value="返回" onclick="history.back();" /></td>
							<%
								if (info == null) {
							%>
							<td width="50%" align="center"><input type="reset"
								name="reset" id="reset" value="重置" /></td>
							<td width="50%" align="center"><input type="button"
								value="提交" onclick="submit_form();" /></td>
							<%
								}
							%>
						</tr>
					</table></td>
			</tr>
		</table>
	</form>
</body>
</html>

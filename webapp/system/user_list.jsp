<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	List<User> list = (List<User>) request.getAttribute("list");
	
	String name = (String)request.getAttribute("name");
	String real_name = (String)request.getAttribute("real_name");
	
	int total_pages = (Integer)request.getAttribute("total_pages");
	int page_now = (Integer)request.getAttribute("page");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>用户列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
<script type="text/javascript">
	function page_up() {
		var page_now = document.getElementById("page");
		page_now.value =<%=page_now - 1%>;
		document.getElementById("search").submit();
	}

	function page_down() {
		var page_now = document.getElementById("page");
		page_now.value =<%=page_now + 1%>;
		document.getElementById("search").submit();
	}
</script>
</head>

<body>
	<jsp:include page="/top_admin.jsp"></jsp:include>
	<div align="center">
		<form id="search" name="search" method="post"
			action="<%=basePath%>/api?servlet=system&cmd=user_list">
			<input type="hidden" id="page" name="page" value="<%=page_now%>">
			<table width="50%" border="1" align="center">
				<tr>
					<td width="15%">用户名:</td>
					<td><input name="name" type="text" id="name"
						value="<%=name == null ? "" : name%>" /></td>
					<td width="15%">真实姓名:</td>
					<td><input name="real_name" type="text" id="real_name"
						value="<%=real_name == null ? "" : real_name%>" /></td>
					<td width="5%"><input type="submit" value="查询" /></td>
				</tr>
			</table>
		</form>
		<hr />
		<h2>
			<strong>用户列表</strong>
		</h2>
	</div>
	<table width="90%" border="1" align="center">
		<tr>
			<td align="right" colspan="11">
				<%
					if (page_now > 1) {
				%> <a onclick="page_up();" style="cursor: pointer;">上一页</a> <%
 	}
 %>&nbsp;&nbsp;&nbsp;&nbsp; <%=page_now%>/<%=total_pages%>&nbsp;&nbsp;&nbsp;&nbsp;<%
 	if (page_now < total_pages) {
 %> <a onclick="page_down();" style="cursor: pointer;">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;<%
 	}
 %> <input type="text" id="jump_page_up" style="width: 50"><input
				type="button" onclick="jump_up(<%=total_pages%>);" value="跳">
			</td>
		</tr>
		<tr align="center">
			<td width="5%">用户名</td>
			<td width="5%">姓名</td>
			<td width="15%">地址</td>
			<td width="4%">电话</td>
			<td width="4%">创建时间</td>
			<td width="5%">描述</td>
			<td width="3%">订单</td>
		</tr>
		<%
			for (User user : list) {
		%>
		<tr align="center">
			<td><%=user.getName()%></td>
			<td><%=user.getReal_name()%></td>
			<td><%=user.getAddress()%></td>
			<td><%=user.getMobile()%></td>
			<td><%=user.getCreate_time().toLocaleString()%></td>
			<td><%=user.getDes()%></td>
			<td><a
				href="<%=basePath%>/api?servlet=borrow&cmd=list&user_id=<%=user.getId()%>">查看</a></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td align="right" colspan="11">
				<%
					if (page_now > 1) {
				%> <a onclick="page_up();" style="cursor: pointer;">上一页</a> <%
 	}
 %>&nbsp;&nbsp;&nbsp;&nbsp; <%=page_now%>/<%=total_pages%>&nbsp;&nbsp;&nbsp;&nbsp;<%
 	if (page_now < total_pages) {
 %> <a onclick="page_down();" style="cursor: pointer;">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;<%
 	}
 %> <input type="text" id="jump_page_down" style="width: 50"><input
				type="button" onclick="jump_down(<%=total_pages%>);" value="跳">
			</td>
		</tr>
	</table>
	<div align="center">
		<h3>
			<strong><a onclick="history.back();"
				href="javascript:return false;">返回</a>
			</strong>
		</h3>
	</div>
</body>
</html>

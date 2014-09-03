<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Borrow borrow = (Borrow) request.getAttribute("borrow");
	Book book = (Book) request.getAttribute("book");
	Integer role_id = (Integer) request.getSession().getAttribute(
			"role_id");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>订单</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<script type="text/javascript">
	function init() {
		var status = document.getElementById("status");
		status.options[
<%=borrow == null ? 0 : borrow.getStatus()%>
	].selected = true
	}
</script>

</head>

<body onload="init();">
	<form id="form1" name="form1" method="post"
		action="<%=basePath%>/api?servlet=borrow&cmd=upd">
		<input name="id" type="hidden" id="id"
			value="<%=borrow == null ? "" : borrow.getId()%>" /> <input
			name="book_id" type="hidden" id="book_id"
			value="<%=book == null ? "" : book.getId()%>" />
		<table width="50%" border="1" align="center">
			<tr>
				<td colspan="2" align="center"><h1>借阅书籍</h1></td>
			</tr>
			<tr>
				<td width="20%">名称:</td>
				<td><%=book == null ? "" : book.getName()%></td>
			</tr>
			<tr>
				<td>封面图:</td>
				<td><img
					src="<%=book == null ? "" : basePath + "/images/book/"
					+ book.getImg()%>"
					width="100" height="100" /></td>
			</tr>
			<tr>
				<td>数量:</td>
				<td><input name="num" type="text" id="num"
					value="<%=borrow == null ? 1 : borrow.getNum()%>" size="50%" /></td>
			</tr>
			<%
				if (role_id != null && role_id.intValue() == 2) {
			%>
			<tr>
				<%
					} else {
				%>
			
			<tr style="display:none;">
				<%
					}
				%>
				<td>状态:</td>
				<td><select name="status" id="status">
						<option value="0">新建</option>
						<option value="2">已借出</option>
						<option value="3">已归还</option>
				</select></td>
			</tr>
			<tr>
				<td>备注:</td>
				<td><input name="des" type="text" id="des"
					value="<%=borrow == null ? 1 : borrow.getDes()%>" /></td>
			</tr>
			<tr>
				<td colspan="2"><table width="100%" border="0">
						<tr align="center">
							<td><input type="reset" name="重置" id="重置" value="重置" /></td>
							<td><input type="submit" name="提交" id="提交" value="提交" /></td>
						</tr>
					</table></td>
			</tr>
		</table>
	</form>
</body>
</html>

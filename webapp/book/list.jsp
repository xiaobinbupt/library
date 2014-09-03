<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";

	List<Book> list = (List<Book>) request.getAttribute("list");
	String user_name = (String) request.getSession().getAttribute(
	"user_name");
	Integer role_id = (Integer) request.getSession().getAttribute(
	"role_id");
	if (role_id == null) {
		role_id = 1;
	}
	
	int total_pages = (Integer)request.getAttribute("total_pages");
	int page_now = (Integer)request.getAttribute("page");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>图书列表</title>

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
		page_now.value = <%=page_now - 1%>;
		document.getElementById("search").submit();
	}

	function page_down() {
		var page_now = document.getElementById("page");
		page_now.value = <%=page_now + 1%>;
		document.getElementById("search").submit();
	}

	function book_query() {
		document.getElementById("page").value = 1;
		document.getElementById("search").submit();
	}
</script>

</head>

<body>
	<jsp:include page="/top_admin.jsp"></jsp:include>
	<form id="search" name="search" method="post"
		action="<%=basePath%>/api?servlet=book&cmd=list&search=1">
		<input type="hidden" id="page" name="page" value="<%=page_now%>">
		<table width="80%" border="1" align="center">
			<tr>
				<td>名称:</td>
				<td><input type="text" name="name" /></td>
				<td>作者:</td>
				<td><input type="text" name="author" /></td>
				<td>类型:</td>
				<td><input type="text" name="type" /></td>
			</tr>
			<tr>
				<td>年龄:</td>
				<td><input type="text" name="age" /></td>
				<td>出版社:</td>
				<td><input type="text" name="pub" /></td>
				<td colspan="2"><input type="button" value="查询"
					onclick="book_query();" /></td>
			</tr>
		</table>
	</form>
	<div>
		<a href="<%=basePath%>/api?servlet=book&cmd=prepare_add">新建书籍</a>
	</div>
	<hr />
	<div align="center">
		<h2>
			<strong>书籍列表</strong>
		</h2>
	</div>
	<table width="100%" border="1" align="center">
		<tr>
			<td align="right" colspan="9">
				<%
					if (page_now > 1) {
				%> <a onclick="page_up();" style="cursor: pointer;">上一页</a> <%
 	}
 %>&nbsp;&nbsp;&nbsp;&nbsp; <%=page_now%>/<%=total_pages%>&nbsp;&nbsp;&nbsp;&nbsp;<%
 	if (page_now < total_pages) {
 %> <a onclick="page_down();" style="cursor: pointer;">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;<%
 	}
 %>
 				<input type="text" id="jump_page_up" style="width: 50"><input type="button" onclick="jump_up(<%=total_pages %>);" value="跳">
			</td>
		</tr>
		<tr align="center">
			<td>ISDN</td>
			<td>名称</td>
			<td>作者</td>
			<td>类型</td>
			<td>出版社</td>
			<td>年龄</td>
			<td>数量</td>
			<td>库存</td>
			<td width="5%">修改</td>
			<td width="5%">配图</td>
			<td width="5%">删除</td>
		</tr>
		<%
			for (Book book : list) {
		%>
		<tr align="center">
			<td><%=book.getIsdn()%></td>
			<td><%=book.getName()%></td>
			<td><%=book.getAuthor()%></td>
			<td><%=book.getType()%></td>
			<td><%=book.getPub()%></td>
			<td><%=book.getAge()%></td>
			<td><%=book.getNum()%></td>
			<td><%=book.getStock()%></td>
			<td><a
				href="<%=basePath%>/api?servlet=book&cmd=prepare_upd&id=<%=book.getId()%>">修改</a>
			</td>
			<td><a
				href="<%=basePath%>/api?servlet=book&cmd=prepare_upd_img&id=<%=book.getId()%>">配图</a>
			</td>
			<td><a
				href="<%=basePath%>/api?servlet=book&cmd=del&id=<%=book.getId()%>">删除</a>
			</td>
		</tr>
		<%
			}
		%>
		<tr>
			<td align="right" colspan="9">
				<%
					if (page_now > 1) {
				%> <a onclick="page_up();" style="cursor: pointer;">上一页</a> <%
 	}
 %>&nbsp;&nbsp;&nbsp;&nbsp; <%=page_now%>/<%=total_pages%>&nbsp;&nbsp;&nbsp;&nbsp;<%
 	if (page_now < total_pages) {
 %> <a onclick="page_down();" style="cursor: pointer;">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;<%
 	}
 %>
 				<input type="text" id="jump_page_down" style="width: 50"><input type="button" onclick="jump_down(<%=total_pages %>);" value="跳">
			</td>
		</tr>
	</table>
	<p>&nbsp;</p>
</body>
</html>

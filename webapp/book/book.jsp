<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Book book = (Book) request.getAttribute("book");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>图书</title>

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
	<form id="form1" name="form1" method="post"
		action="<%=basePath%>/api?servlet=book&cmd=upd">
		<input type="hidden" name="id"
			value="<%=book == null ? "" : book.getId()%>">
		<table width="80%" border="1" align="center">
			<tr>
				<td>名称:</td>
				<td><input name="name" type="text" id="name"
					value="<%=book == null ? "" : book.getName()%>" size="100%" />
				</td>
			</tr>
			<tr>
				<td>ISDN:</td>
				<td><input name="isdn" type="text" id="name2"
					value="<%=book == null ? "" : book.getIsdn()%>" size="100%" />
				</td>
			</tr>
			<tr>
				<td>数量:</td>
				<td><input name="num" type="text" id="num"
					value="<%=book == null ? "" : book.getNum()%>" size="100%" />
				</td>
			</tr>
			<tr>
				<td>库存:</td>
				<td><input name="stock" type="text" id="name3"
					value="<%=book == null ? "" : book.getStock()%>" size="100%" />
				</td>
			</tr>
			<tr>
				<td>作者:</td>
				<td><input name="author" type="text" id="name4"
					value="<%=book == null ? "" : book.getAuthor()%>" size="100%" />
				</td>
			</tr>
			<tr>
				<td>类型:</td>
				<td><input name="type" type="text" id="name5"
					value="<%=book == null ? "" : book.getType()%>" size="100%" />
				</td>
			</tr>
			<tr>
				<td>出版社:</td>
				<td><input name="pub" type="text" id="name6"
					value="<%=book == null ? "" : book.getPub()%>" size="100%" />
				</td>
			</tr>
			<tr>
				<td>适读年龄:</td>
				<td><input name="age" type="text" id="name7"
					value="<%=book == null ? "" : book.getAge()%>" size="100%" />
				</td>
			</tr>
			<tr>
				<td>简介:</td>
				<td><textarea name="des" cols="100%" rows="10" id="name8"><%=book == null ? "" : book.getDes()%></textarea>
				</td>
			</tr>
			<tr align="center">
				<td colspan="2"><table width="100%" border="0">
						<tr align="center">
							<td><input type="button" value="返回"
								onclick="window.history.back();" /></td>
							<td>&nbsp;</td>
							<td><input type="reset" name="reset" id="reset" value="重置" />
							</td>
							<td>&nbsp;</td>
							<td><input type="submit" name="submit" id="submit"
								value="提交" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Toy toy = (Toy) request.getAttribute("toy");
	Object page_now = request.getAttribute("page");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>玩具</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<script type="text/javascript">
	function submit_upd(){
		document.getElementById("form1").submit();
	}
</script>

</head>

<body>
	<form id="form1" name="form1" method="post"
		action="<%=basePath%>/api?servlet=toy&cmd=upd">
		<input type="hidden" name="id"
			value="<%=toy == null ? "" : toy.getId()%>">
		<input type="hidden" name="page" id="page"
			value="<%=page_now%>">
		<table width="80%" border="1" align="center">
			<tr>
				<td>名称:</td>
				<td><input name="name" type="text" id="name"
					value="<%=toy == null ? "" : toy.getName()%>" size="100%" />
				</td>
			</tr>
			<tr>
				<td>ISDN:</td>
				<td><input name="isdn" type="text" id="name2"
					value="<%=toy == null ? "" : toy.getIsdn()%>" size="100%" />
				</td>
			</tr>
			<tr>
				<td>价格:</td>
				<td><input name="price" type="text" id=""price""
					value="<%=toy == null ? "" : toy.getPrice()%>" size="100%" />元
				</td>
			</tr>
			<tr>
				<td>库存:</td>
				<td><input name="stock" type="text" id="name3"
					value="<%=toy == null ? "" : toy.getStock()%>" size="100%" />
				</td>
			</tr>
			<tr>
				<td>简介:</td>
				<td><textarea name="des" cols="100%" rows="10" id="name8"><%=toy == null ? "" : toy.getDes()%></textarea>
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
							<td><input type="button" onclick="submit_upd();"
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

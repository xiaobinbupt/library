<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";

	List<Toy> list = (List<Toy>) request.getAttribute("list");
	String name = (String)request.getAttribute("name");
	if(name == null){
		name = "";
	}
	String isdn = (String)request.getAttribute("isdn");
	if(isdn == null){
		isdn = "";
	}
	
	String user_name = (String) request.getSession().getAttribute(
	"user_name");
	
	int total_pages = (Integer)request.getAttribute("total_pages");
	int page_now = (Integer)request.getAttribute("page");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>玩具列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
<script type="text/javascript">
	function get_order(toy_id) {
		$.ajax({
			type : "post",
			url : "<%=basePath%>api?servlet=order&cmd=get_toy_order&toy_id=" + toy_id,
			dataType : "json",
			success : function(data) {
				var orders = data[0].orders;
				alert(orders);
			}
		});
	}
</script>
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

	function query() {
		document.getElementById("page").value = 1;
		document.getElementById("search").submit();
	}
</script>
</head>

<body>
	<jsp:include page="/top_admin.jsp"></jsp:include>
	<form id="search" name="search" method="post"
		action="<%=basePath%>/api?servlet=toy&cmd=list&search=1">
		<input type="hidden" id="page" name="page" value="<%=page_now%>">
		<table width="50%" border="1" align="center">
			<tr>
				<td>ISDN:</td>
				<td><input type="text" name="isdn" value="<%=isdn %>" /></td>
				<td>名称:</td>
				<td><input type="text" name="name" value="<%=name %>" /></td>
			</tr>
		</table>
		<center><input type="button" value="查询" onclick="query();" /></center>
	</form>
	<div>
		<a href="<%=basePath%>/api?servlet=toy&cmd=prepare_add&page=<%=page_now%>">新建玩具</a>
	</div>
	<hr />
	<div align="center">
		<h2>
			<strong>玩具列表</strong>
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
			<td>价格(元)</td>
			<td>库存</td>
			<td>订单</td>
			<td width="5%">修改</td>
			<td width="5%">配图</td>
			<td width="5%">删除</td>
		</tr>
		<%
			for (Toy toy : list) {
		%>
		<tr align="center">
			<td><%=toy.getIsdn()%></td>
			<td><%=toy.getName()%></td>
			<td><%=toy.getPrice()%></td>
			<td><%=toy.getStock()%></td>
			<td><a id="get_order" href="javascript:void(0);" onclick="get_order(<%=toy.getId()%>)">查看</a>
			</td>
			<td><a
				href="<%=basePath%>/api?servlet=toy&cmd=prepare_upd&id=<%=toy.getId()%>&page=<%=page_now%>">修改</a>
			</td>
			<td><a
				href="<%=basePath%>/api?servlet=toy&cmd=prepare_upd_img&id=<%=toy.getId()%>">配图</a>
			</td>
			<td><a
				href="<%=basePath%>/api?servlet=toy&cmd=del&id=<%=toy.getId()%>&page=<%=page_now%>">删除</a>
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

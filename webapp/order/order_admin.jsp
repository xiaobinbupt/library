<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Order order = (Order) request.getAttribute("order");
	Toy toy = (Toy) request.getAttribute("toy");
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
<%=order == null ? 0 : order.getStatus()%>
	].selected = true
	}
	
	function get_total(){
		var num = document.getElementById("num").value;
		var total = document.getElementById("total");
		total.value = num * <%=toy.getPrice()%>;
	}
</script>

</head>

<body onload="init();">
	<form id="form1" name="form1" method="post"
		action="<%=basePath%>/api?servlet=order&cmd=upd">
		<input name="id" type="hidden" id="id"
			value="<%=order == null ? "" : order.getId()%>" /> <input
			name="toy_id" type="hidden" id="toy_id"
			value="<%=toy == null ? "" : toy.getId()%>" />
		<table width="50%" border="1" align="center">
			<tr>
				<td colspan="2" align="center"><h1>购买玩具</h1></td>
			</tr>
			<tr>
				<td width="20%">名称:</td>
				<td><%=toy == null ? "" : toy.getName()%></td>
			</tr>
			<tr>
				<td>图片:</td>
				<td><img
					src="<%=toy == null ? "" : basePath + "/images/toy/"
					+ toy.getImg()%>"
					width="100" height="100" /></td>
			</tr>
			<tr>
				<td>数量:</td>
				<td><input name="num" type="text" id="num"
					value="<%=order == null ? 1 : order.getNum()%>" size="50%" onchange="get_total();"/></td>
			</tr>
			<tr>
				<td>单价:</td>
				<td><%=toy.getPrice() %>元</td>
			</tr>
			<tr>
				<td>总价:</td>
				<td><input name="total" type="text" id="total"
					value="<%=toy.getPrice() * order.getNum()%>" size="50%" readonly="readonly"/>元</td>
			</tr>
			<tr style="display:none;">
				<td>状态:</td>
				<td><select name="status" id="status">
						<option value="0">新建</option>
						<option value="1">确认</option>
						<option value="2">完成</option>
				</select></td>
			</tr>
			<tr>
				<td>备注:</td>
				<td><input name="des" type="text" id="des"
					value="<%=order == null ? 1 : order.getDes()%>" /></td>
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

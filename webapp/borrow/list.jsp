<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	List<Borrow> list = (List<Borrow>) request.getAttribute("list");
	Integer role_id = (Integer) request.getSession().getAttribute("role_id");
	String status_value = (String)request.getAttribute("status");
	String real_name = (String)request.getAttribute("real_name");
	
	int total_pages = (Integer)request.getAttribute("total_pages");
	int page_now = (Integer)request.getAttribute("page");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>订单列表</title>

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
function init_data() {
	<%if(status_value != null){%>
			var status = document.getElementById("status");
			for ( var i = 0; i < status.options.length; i++) {
				if (status.options[i].value =='<%=status_value%>') {
				status.options[i].selected = true;
				break;
			}
		}
<%}%>
	}
	
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

	function upd_status(upd_status){
		var cs = document.getElementsByName("checkbox");
		var ids = '';
		for(var i = 0; i < cs.length; i++){
			if(cs[i].checked==true){
				ids += cs[i].value + ",";
			}
		}
		if(ids == ''){
			alert('请先选择!');
		}
		var f = document.getElementById("search");
		f.action="<%=basePath%>/api?servlet=borrow&cmd=upd_status&upd_status=" + upd_status + "&ids=" + ids;
		f.submit();
	}
	
	function select_all(result){
		var cs = document.getElementsByName("checkbox");
		for(var i = 0; i < cs.length; i++){
			cs[i].checked = result;
		}
	}
</script>
</head>

<body onload="init_data();">
	<jsp:include page="/top_admin.jsp"></jsp:include>
	<div align="center">
		<form id="search" name="search" method="post"
			action="<%=basePath%>/api?servlet=borrow&cmd=list">
			<input type="hidden" id="page" name="page" value="<%=page_now%>">
			<table width="50%" border="1" align="center">
				<tr>
					<td width="15%">真实姓名:</td>
					<td><input name="real_name" type="text" id="real_name"
						value="<%=real_name == null ? "" : real_name%>" />
					</td>
					<td width="10%">状态:</td>
					<td width="20%"><select name="status" id="status">
							<option value="">请选择..</option>
							<option value="0">新建</option>
							<option value="1">确认</option>
							<option value="2">已借出</option>
							<option value="3">已归还</option>
					</select></td>
					<td width="5%"><input type="submit" value="查询" />
					</td>
				</tr>
			</table>
		</form>
		<hr />
		<h2>
			<strong>借阅列表</strong>
		</h2>
	</div>
	<table width="90%" border="1" align="center">
		<tr>
			<td colspan="4"><input type="button" value="全选"
				onclick="select_all(true);">/<input type="button" value="取消"
				onclick="select_all(false);">&nbsp;&nbsp;&nbsp;&nbsp; <input
				type="button" value="借出" onclick="upd_status(2);">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="归还" onclick="upd_status(3);">
			</td>
			<td align="right" colspan="7">
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
			<td width="4%">选择</td>
			<td width="10%">用户名</td>
			<td width="10%">姓名</td>
			<td>图书</td>
			<td width="10%">ISDN</td>
			<td width="5%">数量</td>
			<td width="6%">状态</td>
			<td width="10%">创建时间</td>
			<td width="5%">操作</td>
			<td width="5%">删除</td>
		</tr>
		<%
			for (Borrow borrow : list) {
		%>
		<tr align="center">
			<td><input type="checkbox" value="<%=borrow.getId()%>"
				name="checkbox"></td>
			<td><%=borrow.getUser_name()%></td>
			<td><a
				href="<%=basePath%>/api?servlet=system&cmd=prepare_upd_user&info=true&id=<%=borrow.getUser_id()%>"><%=borrow.getReal_name()%></a>
			</td>
			<td><%=borrow.getBook_name()%></td>
			<td><%=borrow.getIsdn()%></td>
			<td><%=borrow.getNum()%></td>
			<td><%=borrow.getStatus_name()%></td>
			<td><%=borrow.getCreate_time_format()%></td>
			<td><a
				href="<%=basePath%>/api?servlet=borrow&cmd=prepare_upd&id=<%=borrow.getId()%>">修改</a>
			</td>
			<td><a
				href="<%=basePath%>/api?servlet=borrow&cmd=del&id=<%=borrow.getId()%>">删除</a>
			</td>
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
				href="javascript:return false;">返回</a> </strong>
		</h3>
	</div>
</body>
</html>

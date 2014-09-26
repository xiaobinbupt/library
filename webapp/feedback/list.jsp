<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<jsp:include page="/top.jsp" flush="true" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	List<FeedBack> list = (List<FeedBack>)request.getAttribute("list");
	List<String> ages = (List<String>)request.getAttribute("ages");
	List<String> pubs = (List<String>)request.getAttribute("pubs");
	List<String> authors = (List<String>)request.getAttribute("authors");
	
	int total_pages = (Integer)request.getAttribute("total_pages");
	int page_now = (Integer)request.getAttribute("page");
	Long user_id = (Long)request.getSession().getAttribute("user_id");
	Integer role_id = (Integer)request.getSession().getAttribute("role_id");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>绘本馆</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link type="text/css" rel="stylesheet" href="<%=basePath%>/css/css.css">
<link href="images/favicon.ico" rel="shortcut icon">
<script type="text/javascript" src="<%=basePath%>/js/main.js"></script>

<script type="text/javascript">
	function page_up() {
		var page_now = document.getElementById("page");
		page_now.value =
<%=page_now - 1%>
	;
		document.getElementById("search").submit();
	}

	function page_down() {
		var page_now = document.getElementById("page");
		page_now.value =
<%=page_now + 1%>
	;
		document.getElementById("search").submit();
	}
	
	function check_content(){
		var content = document.getElementById("content").value;
		if(content == ''){
			alert('建议不能为空!');
			return false;
		}
		document.getElementById("b_submit").disabled="disabled";
		document.getElementById("addFeedBack").submit();
	}
</script>

</head>
<body marginwidth="0" marginheight="0" bottommargin="0" rightmargin="0"
	topmargin="0" leftmargin="0" onload="init_data();">
	<table width="950" height="81" align="center" cellspacing="0"
		cellpadding="0" border="0">
		<tbody>
			<tr valign="top">
				<td width="210"><jsp:include page="/left.jsp" flush="true" />
				</td>
				<td width="10"></td>
				<td width="730">
					<form action="<%=basePath%>/api?servlet=feedback&cmd=list"
						name="search" method="post" id="search">
						<input type="hidden" id="page" name="page" value="<%=page_now%>">
					</form>
					<table width="730" height="150" cellspacing="0" cellpadding="0"
						cellpadding="0" border="0">
						<tbody>
							<tr>
								<td width="730" valign="top" bgcolor="#FFFFFF">
									<table width="730" height="29" bgcolor="FAF1E2" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="210" valign="top" height="23"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1"><strong>用户反馈</strong>
												</td>
												<td valign="top" height="23"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1" align="right">
													<%
														if (page_now > 1) {
													%> <a onclick="page_up();"
													style="cursor: pointer;display: inline;">上一页</a> <%
 	}
 %>&nbsp;&nbsp;&nbsp;&nbsp; <%=page_now%>/<%=total_pages%>&nbsp;&nbsp;&nbsp;&nbsp;<%
 	if (page_now < total_pages) {
 %> <a onclick="page_down();" style="cursor: pointer;display: inline;">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;<%
 	}
 %> <input type="text" id="jump_page_up" style="width: 50"><input
													type="button" onclick="jump_up(<%=total_pages%>);"
													value="跳">
												</td>
											</tr>
										</tbody>
									</table>

									<table width="100%" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td height="14"></td>
											</tr>
										</tbody>
									</table> <%
 	for (int i = 0; i < list.size(); i++) {
 		FeedBack f = list.get(i);
 %>
									<table width="658" height="24" bgcolor="D5E2B7" align="center"
										cellspacing="1" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td bgcolor="#FFFFFF"
													style="PADDING-left:10px;PADDING-right:10px;PADDING-top:5px;PADDING-bottom:5px;"
													class="show"><font color="#999999">会员名：<font
														color="00529B"><%=f.getUser_name()%></font>
														&nbsp;&nbsp;&nbsp;&nbsp;时间：<font color="00529B"><%=f.getCreate_time().toLocaleString()%></font>
												</font>&nbsp;&nbsp;&nbsp;&nbsp; <%
 	if (role_id != null && role_id == 2) {
 %> <a
													href="<%=basePath%>/api?servlet=feedback&cmd=del&id=<%=f.getId()%>">删除</a>
													<%
														}
													%> <br><%=f.getContent()%></td>
											</tr>
										</tbody>
									</table>
									<table width="100%" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td height="14"></td>
											</tr>
										</tbody>
									</table> <%
 	}
 %>
									<table width="730" height="29" bgcolor="FAF1E2" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td valign="top" height="23"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1" align="right">
													<%
														if (page_now > 1) {
													%> <a onclick="page_up();"
													style="cursor: pointer;display: inline;">上一页</a> <%
 	}
 %> &nbsp;&nbsp;&nbsp;&nbsp; <%=page_now%>/<%=total_pages%>
													&nbsp;&nbsp;&nbsp;&nbsp; <%
 	if (page_now < total_pages) {
 %> <a onclick="page_down();" style="cursor: pointer;display: inline;">下一页</a>
													&nbsp;&nbsp;&nbsp;&nbsp;<%
														}
													%> <input type="text" id="jump_page_down" style="width: 50"><input
													type="button" onclick="jump_down(<%=total_pages%>);"
													value="跳">
												</td>
											</tr>
										</tbody>
									</table></td>
							</tr>
						</tbody>
					</table>
					<form action="<%=basePath%>/api?servlet=feedback&cmd=add"
						method="post" id="addFeedBack">
						<table width="720" height="75" background="images/chan_bg.gif"
							align="center" border="0">
							<tbody>
								<tr>
									<td><textarea rows="5" cols="100" name="content"
											id="content"></textarea>
									</td>
								</tr>
								<tr>
									<td align="center"><input type="reset" value="重置">&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="button" id="b_submit"
										value="<%=user_id == null ? "请登录" : "提交"%>"
										<%=user_id == null ? "disabled=\"disabled\"" : ""%>
										onclick="check_content();"></td>
								</tr>
							</tbody>
						</table>
					</form></td>
			</tr>
		</tbody>
	</table>
	<jsp:include page="/footer.jsp" flush="true" />
</body>
</html>


<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<jsp:include page="/top.jsp" flush="true" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	List<Toy> list = (List<Toy>)request.getAttribute("list");
	String name = (String)request.getAttribute("name");
	
	int total_pages = (Integer)request.getAttribute("total_pages");
	int page_now = (Integer)request.getAttribute("page");
	
	Object err = request.getAttribute("err");
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
<link type="text/css" rel="stylesheet" href="<%=basePath%>css/css.css">
<link href="images/favicon.ico" rel="shortcut icon">
<script type="text/javascript" src="<%=basePath%>js/main.js"></script>

<script type="text/javascript">
	function init_data() {
<%if(err != null){%>
		document.getElementById("login_div_1").style.display = "block";
		document.getElementById("login_div_2").style.display = "block";
<%}%>
	}

	function page_up() {
		var page_now = document.getElementById("page");
		page_now.value = page_now.value - 1;
		document.getElementById("search").submit();
	}

	function page_down() {
		var page_now = document.getElementById("page");
		page_now.value = Number(page_now.value) + 1;
		document.getElementById("search").submit();
	}

	function query() {
		document.getElementById("page").value = 1;
		document.getElementById("search").submit();
	}
</script>

</head>
<body marginwidth="0" marginheight="0" bottommargin="0" rightmargin="0"
	topmargin="0" leftmargin="0" onload="init_data();">
	<table width="950" height="81" align="center" cellspacing="0"
		cellpadding="0" border="0">
		<tbody>
			<tr valign="top">
				<td width="950">
					<form action="<%=basePath%>api?servlet=toy&cmd=list&search=1"
						name="search" method="post" id="search">
						<input type="hidden" id="page" name="page" value="<%=page_now%>">
						<table width="100%" align="center" cellspacing="0" cellpadding="0"
							border="0">
							<tbody>
								<tr>
									<td valign="top" height="31" bgcolor="efefef"
										style="PADDING-left:13px;PADDING-top:4px;" class="zi-leibie2">
										名称<input class="zi-leibie4"  style="width: 200"type="text" name="name" value="<%=name == null ? "" : name%>">
										&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="搜索" onclick="query();"></td>
								</tr>
							</tbody>
						</table>
					</form>
					<table width="950" height="140" bgcolor="D5E2B7" cellspacing="1"
						cellpadding="0" border="0">
						<tbody>
							<tr>
								<td width="950" valign="top" bgcolor="#FFFFFF">
									<table width="950" height="29" bgcolor="FAF1E2" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="210" valign="top" height="23"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1"><strong>玩具列表</strong>
												</td>
												<td valign="top" height="23"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1" align="right">
													<%
														if (page_now > 1) {
													%> <a onclick="page_up();" style="cursor: pointer;display: inline;">上一页</a>
													<%
														}
													%>&nbsp;&nbsp;&nbsp;&nbsp; <%=page_now%>/<%=total_pages%>&nbsp;&nbsp;&nbsp;&nbsp;<%
 	if (page_now < total_pages) {
 %> <a onclick="page_down();" style="cursor: pointer;display: inline;">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;<%
 	}
 %>
 													<input type="text" id="jump_page_up" style="width: 50"><input type="button" onclick="jump_up(<%=total_pages %>);" value="跳">
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
 	for (int i = 0; i < list.size();) {
 %>
									<table width="950" height="75" background="images/chan_bg.gif"
										align="center" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr valign="top">

												<%
													for (int j = 0; j < 5; j++) {
															Toy toy = null;
															if (i < list.size()) {
																toy = list.get(i);
															}
												%>
												<td width="144" height="75">
													<table width="144" align="center" cellspacing="0"
														cellpadding="0" border="0">
														<tbody>
															<tr>
																<%
																	if (toy != null) {
																%>
																<td><div align="center">
																		<a class="chan"
																			href="<%=basePath%>api?servlet=toy&cmd=info_customer&info=true&toy_id=<%=toy.getId()%>">
																			<img width="110" height="110" border="0" src="<%=basePath%>images/toy/<%=toy.getImg()%>">
																			</a>
																	</div>
																</td>
																<%
																	}
																%>
															</tr>
														</tbody>
													</table>
													<table width="100" align="center" cellspacing="0"
														cellpadding="0" border="0">
														<tbody>
															<tr>
																<td height="3"></td>
															</tr>
														</tbody>
													</table>
													<table width="130" align="center" cellspacing="0"
														cellpadding="0" border="0">
														<tbody>
															<tr>
																<%
																	if (toy != null) {
																%>
																<td><div align="center">
																		<a class="chan"
																			href="<%=basePath%>api?servlet=toy&cmd=info_customer&info=true&toy_id=<%=toy.getId()%>"><%=toy.getName()%></a>
																	</div>
																</td>
																<%
																	}
																%>
															</tr>
														</tbody>
													</table>
												</td>
												<%
													i++;
														}
												%>

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
									<table width="950" height="29" bgcolor="FAF1E2" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td valign="top" height="23"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1" align="right">
													<%
														if (page_now > 1) {
													%> <a onclick="page_up();" style="cursor: pointer;display: inline;">上一页</a>
													<%
														}
													%> &nbsp;&nbsp;&nbsp;&nbsp; <%=page_now%>/<%=total_pages%>
													&nbsp;&nbsp;&nbsp;&nbsp; <%
 	if (page_now < total_pages) {
 %> <a onclick="page_down();" style="cursor: pointer;display: inline;">下一页</a>
													&nbsp;&nbsp;&nbsp;&nbsp;<%
														}
													%>
													<input type="text" id="jump_page_down" style="width: 50"><input type="button" onclick="jump_down(<%=total_pages %>);" value="跳">
												</td>
											</tr>
										</tbody>
									</table></td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
	<jsp:include page="/footer.jsp" flush="true" />	
</body>
</html>


<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<jsp:include page="/top.jsp" flush="true" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	List<Book> list = (List<Book>)request.getAttribute("list");
	List<Category> categorys = (List<Category>) request
			.getAttribute("categorys");
	
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
					<table width="730" height="150" cellspacing="0" cellpadding="0"
						border="0">
						<tbody>
							<tr>
								<td width="730" valign="top"><a
									href="javascript:gotoshow()"><img width="730" height="150"
										border="0" name="bannerADrotator"
										src="<%=basePath%>images/advn2.jpg"
										style="FILTER: revealTrans(duration=2,transition=20)"> </a>
								</td>
								<script language="javascript">
									nextAd()
								</script>
							</tr>
						</tbody>
					</table>
					<form action="<%=basePath%>api?servlet=book&cmd=new_book_list"
						name="search" method="post" id="search">
						<input type="hidden" id="page" name="page" value="<%=page_now%>">
					</form>
					<table width="730" height="140" bgcolor="D5E2B7" cellspacing="1"
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
													class="zi-leibie1"><strong>新书推荐</strong>
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
									<table width="720" height="75" background="images/chan_bg.gif"
										align="center" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr valign="top">

												<%
													for (int j = 0; j < 5; j++) {
															Book book = null;
															if (i < list.size()) {
																book = list.get(i);
															}
												%>
												<td width="144" height="75">
													<table width="144" align="center" cellspacing="0"
														cellpadding="0" border="0">
														<tbody>
															<tr>
																<%
																	if (book != null) {
																%>
																<td><div align="center">
																		<a class="chan"
																			href="<%=basePath%>api?servlet=book&cmd=info_customer&info=true&book_id=<%=book.getId()%>">
																			<img width="110" height="110" border="0" src="<%=basePath%>images/book/<%=book.getImg()%>">
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
																	if (book != null) {
																%>
																<td><div align="center">
																		<a class="chan"
																			href="<%=basePath%>api?servlet=book&cmd=info_customer&info=true&book_id=<%=book.getId()%>"><%=book.getName()%></a>
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
									<table width="730" height="29" bgcolor="FAF1E2" cellspacing="0"
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


<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<jsp:include page="/top.jsp" flush="true" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	Object info = request.getAttribute("info");
	Borrow borrow = (Borrow) request.getAttribute("borrow");
	Book book = (Book) request.getAttribute("book");
	List<String> ages = (List<String>)request.getAttribute("ages");
	List<String> pubs = (List<String>)request.getAttribute("pubs");
	List<String> authors = (List<String>)request.getAttribute("authors");
	int max_num = (Integer)request.getAttribute("max_num");
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
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link type="text/css" rel="stylesheet" href="<%=basePath%>/css/css.css">
<link href="images/favicon.ico" rel="shortcut icon">

<script type="text/javascript">
	function submit_form() {
		var num = document.getElementById("num").value;
		if (num == '') {
			alert('数量不能为空!');
			return;
		}
		if (num > <%=max_num%>) {
			alert('数量超过最大值!');
			return;
		}
		document.getElementById("upd_borrow").submit();
	}
</script>

</head>

<body marginwidth="0" marginheight="0" bottommargin="0" rightmargin="0"
	topmargin="0" leftmargin="0">
	<table width="950" height="81" align="center" cellspacing="0"
		cellpadding="0" border="0">
		<tbody>
			<tr valign="top">
				<td width="210"><jsp:include page="/left.jsp" flush="true" />
				</td>
				<td width="10"></td>
				<td width="730">
					<table width="730" height="292" bgcolor="D5E2B7" cellspacing="1"
						cellpadding="0" border="0">
						<tbody>
							<tr>
								<td width="730" valign="top" bgcolor="#FFFFFF">
									<table width="730" height="29" bgcolor="FAF1E2" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="210" valign="top" height="28"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1"><strong>订阅信息</strong></td>
											</tr>
										</tbody>
									</table>
									<table width="100%" height="28" cellspacing="0" cellpadding="0"
										border="0">
										<tbody>
											<tr>
												<td>&nbsp;</td>
											</tr>
										</tbody>
									</table>
									<form action="<%=basePath%>/api?servlet=borrow&cmd=upd"
										method="post" name="upd_borrow" id="upd_borrow">
										<input name="id" type="hidden" id="id"
											value="<%=borrow == null ? "" : borrow.getId()%>" /> <input
											name="book_id" type="hidden" id="book_id"
											value="<%=book == null ? "" : book.getId()%>" />
										<table width="100%" cellspacing="0" cellpadding="0" border="0">
											<tbody>
												<tr>
													<td>
														<table width="600" height="27" align="center"
															cellspacing="0" cellpadding="0" border="0">
															<tbody>
																<tr>
																	<td width="80" class="zi16"><div align="center">
																			<font color="333333">书籍</font>
																		</div></td>
																	<td width="520" class="zi16"><%=book.getName()%></td>
																</tr>
															</tbody>
														</table>
														<table width="100%" cellspacing="0" cellpadding="0"
															border="0">
															<tbody>
																<tr>
																	<td height="10"></td>
																</tr>
															</tbody>
														</table>
														<table width="600" height="27" align="center"
															cellspacing="0" cellpadding="0" border="0">
															<tbody>
																<tr>
																	<td width="80" class="zi16"><div align="center">
																			<font color="333333">数量</font>
																		</div>
																	</td>
																	<td width="520" class="zi16"><input type="text"
																		class="input_combobox5" name="num" id="num"
																		value="<%=borrow == null ? 1 : borrow.getNum()%>"
																		<%=info == null ? "" : "readonly=\"\""%> /><font
																		color="red">最多<%=max_num%><%=max_num == 0?",已借完5本,请还书后再借!":"" %></font>
																	</td>
																</tr>
															</tbody>
														</table>
														<table width="100%" cellspacing="0" cellpadding="0"
															border="0">
															<tbody>
																<tr>
																	<td height="10"></td>
																</tr>
															</tbody>
														</table>
														<table width="600" height="27" align="center"
															cellspacing="0" cellpadding="0" border="0">
															<tbody>
																<tr>
																	<td width="80" class="zi16"><div align="center">
																			<font color="333333">状态</font>
																		</div>
																	</td>
																	<td width="520" class="zi16"><font color="red"
																		size="4"><%=borrow == null ? "新建" : borrow.getStatus_name()%></font>
																	</td>
																</tr>
															</tbody>
														</table>

														<table width="100%" cellspacing="0" cellpadding="0"
															border="0">
															<tbody>
																<tr>
																	<td height="20"></td>
																</tr>
															</tbody>
														</table>
														<table width="600" height="27" align="center"
															cellspacing="0" cellpadding="0" border="0">
															<tbody>
																<tr>
																	<td width="520" class="zi16" align="center"><input
																		type="button" onclick="window.history.back();"
																		value="返回" class="yud">
																	</td>
																	<td width="520" class="zi16">
																		<%
																			if (info == null && max_num > 0) {
																		%> 
																		<input type="button" onclick="submit_form();"
																		value="提交" class="yud"> 
	<%
 		}
 	%>
																	</td>
																</tr>
															</tbody>
														</table>
													</td>

												</tr>
											</tbody>
										</table>
									</form>
									<table width="100%" height="28" cellspacing="0" cellpadding="0"
										border="0">
										<tbody>
											<tr>
												<td>&nbsp;</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table></td>
			</tr>
		</tbody>
	</table>
	<jsp:include page="/footer.jsp" flush="true" />	
</body>
</html>

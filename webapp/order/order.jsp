<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<jsp:include page="/top.jsp" flush="true" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	Object info = request.getAttribute("info");
	Order order = (Order) request.getAttribute("order");
	Toy toy = (Toy) request.getAttribute("toy");
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
		if (num > <%=toy.getStock()%>) {
			alert('数量超过最大值!');
			return;
		}
		document.getElementById("upd_order").submit();
	}
	
	function get_total(){
		var num = document.getElementById("num").value;
		var total = document.getElementById("total");
		total.value = num * <%=toy.getPrice()%>;
	}
</script>

</head>

<body marginwidth="0" marginheight="0" bottommargin="0" rightmargin="0"
	topmargin="0" leftmargin="0">
	<table width="950" height="81" align="center" cellspacing="0"
		cellpadding="0" border="0">
		<tbody>
			<tr valign="top">
				<td width="950">
					<table width="950" height="292" bgcolor="D5E2B7" cellspacing="1"
						cellpadding="0" border="0">
						<tbody>
							<tr>
								<td width="950" valign="top" bgcolor="#FFFFFF">
									<table width="950" height="29" bgcolor="FAF1E2" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="210" valign="top" height="28"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1"><strong>购买信息</strong></td>
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
									<form action="<%=basePath%>/api?servlet=order&cmd=upd"
										method="post" name="upd_order" id="upd_order">
										<input name="id" type="hidden" id="id"
											value="<%=order == null ? "" : order.getId()%>" /> <input
											name="toy_id" type="hidden" id="toy_id"
											value="<%=toy == null ? "" : toy.getId()%>" />
										<table width="100%" cellspacing="0" cellpadding="0" border="0">
											<tbody>
												<tr>
													<td>
														<table width="600" height="27" align="center"
															cellspacing="0" cellpadding="0" border="0">
															<tbody>
																<tr>
																	<td width="80" class="zi16"><div align="center">
																			<font color="333333">玩具</font>
																		</div></td>
																	<td width="520" class="zi16"><%=toy.getName()%></td>
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
																		value="<%=order == null ? 1 : order.getNum()%>"
																		<%=info == null ? "" : "readonly=\"\""%> onchange="get_total();"/><font
																		color="red">最多<%=toy.getStock() + (order == null?0:order.getNum())%><%=(toy.getStock() + (order == null?0:order.getNum())) == 0?",已卖完,请稍后购买!":"" %></font>
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
																			<font color="333333">单价</font>
																		</div>
																	</td>
																	<td width="520" class="zi16"><%=toy.getPrice()%>元</td>
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
																			<font color="333333">总价</font>
																		</div>
																	</td>
																	<td width="520" class="zi16"><input type="text" id="total" readonly="readonly" value="<%=order == null ? toy.getPrice() : order.getNum() * toy.getPrice()%>">元</td>
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
																		size="4"><%=order == null ? "新建" : order.getStatus_name()%></font>
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
																			if (info == null && toy.getStock() > 0) {
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

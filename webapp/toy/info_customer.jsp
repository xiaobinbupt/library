<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<jsp:include page="/top.jsp" flush="true" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	Toy toy = (Toy)request.getAttribute("toy");
	
	String err = (String) request.getAttribute("err");
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
<script type="text/javascript" src="<%=basePath%>js/main.js"></script>
<link href="images/favicon.ico" rel="shortcut icon">
<script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(
		function() {
			$("#buy_button").click(
				function() {
					if(confirm("确定购买么？")){
						window.location.href="<%=basePath%>api?servlet=order&cmd=prepare_add&id=<%=toy.getId()%>";
					}
				});
		});
</script>
<script type="text/javascript">
	function init_err() {
<%if (err != null) {%>
		document.getElementById("login_div_1").style.display = "block";
		document.getElementById("login_div_2").style.display = "block";
<%}%>
	}
</script>

</head>
<body marginwidth="0" marginheight="0" bottommargin="0" rightmargin="0"
	topmargin="0" leftmargin="0" onload="init_err();">
	<table width="950" height="81" align="center" cellspacing="0"
		cellpadding="0" border="0">
		<tbody>
			<tr valign="top">
				<td width="950">
					<table width="950" height="100%" bgcolor="D5E2B7" cellspacing="1"
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
													class="zi-leibie1"><strong>玩具展示</strong></td>
											</tr>
										</tbody>
									</table>
									<table width="100%" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td height="14"></td>
											</tr>
										</tbody>
									</table>
									<table width="720" height="214" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="32" valign="top">&nbsp;</td>
												<td width="296" valign="top"><img width="250"
													height="250" border="0"
													src="<%=basePath%>/images/toy/<%=toy.getImg()%>">
												</td>
												<td width="392"><table width="100%" height="28"
														cellspacing="0" cellpadding="0" border="0">
														<tbody>
															<tr>
																<td class="show">玩具名：<span class="zi-leibie2"><%=toy.getName()%></span>
																</td>
															</tr>
														</tbody>
													</table>
													<table width="100%" height="28" cellspacing="0"
														cellpadding="0" border="0">
														<tbody>
															<tr>
																<td class="show">编号：<%=toy.getIsdn()%></td>
															</tr>
														</tbody>
													</table>
													<table width="100%" height="28" cellspacing="0"
														cellpadding="0" border="0">
														<tbody>
															<tr>
																<td class="show">价格：<%=toy.getPrice()%>元</td>
															</tr>
														</tbody>
													</table>
													<table width="100%" height="28" cellspacing="0"
														cellpadding="0" border="0">
														<tbody>
															<tr>
																<td class="show">剩余：<%=toy.getStock()%></td>
															</tr>
														</tbody>
													</table>
													<table width="229" height="50" cellspacing="0"
														cellpadding="0" border="0">
														<tbody>
															<tr>
																<td>
																	<%
																		if(toy.getStock() > 0){
																	%>
																	<div align="left">
																		<a id="buy_button"><img width="86" height="25"
																			border="0" src="images/buy.gif"> </a> &nbsp;&nbsp;
																		<%
																			}else{
																		%>
																		<div align="left">
																			<a><img width="86" height="25" border="0"
																				src="images/buy_none.gif"> </a> &nbsp;&nbsp;
																			<%
																				}
																			%>
																			<a onclick="window.history.back();"><img
																				width="86" height="25" border="0"
																				src="images/back.gif"> </a> &nbsp;&nbsp;
																		</div>
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
									</table>

									<table width="720" height="24" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="32" valign="top" height="16" bgcolor="efefef">&nbsp;</td>
												<td width="669" bgcolor="efefef" class="zi-leibie1"><strong>玩具简介</strong>
												</td>
												<td width="19" valign="top">&nbsp;</td>
											</tr>
										</tbody>
									</table>
									<table width="100%" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td height="14"></td>
											</tr>
										</tbody>
									</table>
									<table width="720" height="16" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr valign="top">
												<td width="32" height="16">&nbsp;</td>
												<td width="669" class="show">
													<div id="main">
														<div style="clear:both;overflow:hidden;" id="contain">
															<%=toy.getDes()%>
														</div>
														<div>
															<img border="0" src="images/quan.jpg" onclick="show();"
																style="float:right;" id="button">
														</div>
													</div> <script type="text/javascript">
														function $$(id) {
															return document
																	.getElementById(id);
														}
														var contain = $$("contain").innerHTML;
														function hide() {
															if (contain.length > 200) {
																$$("contain").innerHTML = contain
																		.substr(
																				0,
																				400)
																		+ "……";
															}
															$$("button").src = "images/quan.jpg";
															$$("button").onclick = show;
														}
														function show() {
															$$("contain").innerHTML = contain;
															$$("button").src = "images/bu.jpg";
															$$("button").onclick = hide;
														}
														hide();
													</script>
												</td>
												<td width="19">&nbsp;</td>
											</tr>
										</tbody>
									</table>
									<table width="100%" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td height="14"></td>
											</tr>
										</tbody>
									</table>

									<table width="100%" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td height="14"></td>
											</tr>
										</tbody>
									</table>

									<table width="720" height="24" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="32" valign="top" height="16" bgcolor="efefef">&nbsp;</td>
												<td width="669" bgcolor="efefef" class="zi-leibie1"><strong>图片展示</strong>
												</td>
												<td width="19" valign="top">&nbsp;</td>
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
 	if (toy.getInfo_img1() != null && !"".equals(toy.getInfo_img1())) {
 %>
									<table width="720" height="16" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr valign="top">
												<td width="32" height="16">&nbsp;</td>
												<td width="669" class="xinwen"><img border="0"
													src="<%=basePath%>/images/toy/<%=toy.getInfo_img1()%>">
												</td>
												<td width="19">&nbsp;</td>
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
 	if (toy.getInfo_img2() != null && !"".equals(toy.getInfo_img2())) {
 %>
									<table width="720" height="16" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr valign="top">
												<td width="32" height="16">&nbsp;</td>
												<td width="669" class="xinwen"><img border="0"
													src="<%=basePath%>/images/toy/<%=toy.getInfo_img2()%>">
												</td>
												<td width="19">&nbsp;</td>
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
 	if (toy.getInfo_img3() != null && !"".equals(toy.getInfo_img3())) {
 %>
									<table width="720" height="16" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr valign="top">
												<td width="32" height="16">&nbsp;</td>
												<td width="669" class="xinwen"><img border="0"
													src="<%=basePath%>/images/toy/<%=toy.getInfo_img3()%>">
												</td>
												<td width="19">&nbsp;</td>
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
 	if (toy.getInfo_img4() != null && !"".equals(toy.getInfo_img4())) {
 %>
									<table width="720" height="16" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr valign="top">
												<td width="32" height="16">&nbsp;</td>
												<td width="669" class="xinwen"><img border="0"
													src="<%=basePath%>/images/toy/<%=toy.getInfo_img4()%>">
												</td>
												<td width="19">&nbsp;</td>
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
 	if (toy.getInfo_img5() != null && !"".equals(toy.getInfo_img5())) {
 %>
									<table width="720" height="16" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr valign="top">
												<td width="32" height="16">&nbsp;</td>
												<td width="669" class="xinwen"><img border="0"
													src="<%=basePath%>/images/toy/<%=toy.getInfo_img5()%>">
												</td>
												<td width="19">&nbsp;</td>
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
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
</body>
</html>
<jsp:include page="/footer.jsp" flush="true" />

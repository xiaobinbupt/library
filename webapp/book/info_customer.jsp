<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<jsp:include page="/top.jsp" flush="true" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	Book book = (Book)request.getAttribute("book");
	List<FeedBackBook> list = (List<FeedBackBook>)request.getAttribute("list");
	List<String> ages = (List<String>)request.getAttribute("ages");
	List<String> pubs = (List<String>)request.getAttribute("pubs");
	List<String> authors = (List<String>)request.getAttribute("authors");
	
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

			$("#borrow_button").click(
					function() {
		$.ajax({
			type : "post",
			url : "<%=basePath%>api?servlet=borrow&cmd=get_user_remain_stock",
			dataType : "json",
			success : function(data) {
				var remain_stock = data[0].remain_stock;
				if(remain_stock > 0){
					window.location.href="<%=basePath%>/api?servlet=borrow&cmd=prepare_add&id=<%=book.getId()%>";
															} else {
																alert("已经借满5本，请还书后再借!");
															}
														}
													});
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

	function check_content() {
		var content = document.getElementById("content").value;
		if (content == '') {
			alert("评论内容不能为空！");
			return false;
		}
		document.getElementById("book_feedback").submit();
	}
</script>

</head>
<body marginwidth="0" marginheight="0" bottommargin="0" rightmargin="0"
	topmargin="0" leftmargin="0" onload="init_err();">
	<table width="950" height="81" align="center" cellspacing="0"
		cellpadding="0" border="0">
		<tbody>
			<tr valign="top">
				<td width="210"><jsp:include page="/left.jsp" flush="true" />
				</td>
				<td width="10"></td>
				<td width="730">
					<table width="730" height="100%" bgcolor="D5E2B7" cellspacing="1"
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
													class="zi-leibie1"><strong>绘本展示</strong>
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
									<table width="720" height="214" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="32" valign="top">&nbsp;</td>
												<td width="296" valign="top"><img width="250"
													height="250" border="0"
													src="<%=basePath%>/images/book/<%=book.getImg()%>"></td>
												<td width="392"><table width="100%" height="28"
														cellspacing="0" cellpadding="0" border="0">
														<tbody>
															<tr>
																<td class="show">绘本名：<span class="zi-leibie2"><%=book.getName()%></span>
																</td>
															</tr>
														</tbody>
													</table>
													<table width="100%" height="28" cellspacing="0"
														cellpadding="0" border="0">
														<tbody>
															<tr>
																<td class="show">书号：<%=book.getIsdn()%></td>
															</tr>
														</tbody>
													</table>
													<table width="100%" height="28" cellspacing="0"
														cellpadding="0" border="0">
														<tbody>
															<tr>
																<td class="show">作者：<%=book.getAuthor()%></td>
															</tr>
														</tbody>
													</table>
													<table width="100%" height="28" cellspacing="0"
														cellpadding="0" border="0">
														<tbody>
															<tr>
																<td class="show">适合阅读年龄：<%=book.getAge()%>岁
															</tr>
														</tbody>
													</table>
													<table width="100%" height="28" cellspacing="0"
														cellpadding="0" border="0">
														<tbody>
															<tr>
																<td class="show">出版社：<%=book.getPub()%></td>
															</tr>
														</tbody>
													</table>
													<table width="100%" height="28" cellspacing="0"
														cellpadding="0" border="0">
														<tbody>
															<tr>
																<td class="show">剩余：<%=book.getStock()%> 本</td>
															</tr>
														</tbody>
													</table>
													<table width="229" height="50" cellspacing="0"
														cellpadding="0" border="0">
														<tbody>
															<tr>
																<td>
																	<%
																		if(book.getStock() > 0){
																	%>
																	<div align="left">
																		<a id="borrow_button"><img
																			width="86" height="25" border="0"
																			src="images/jie.gif"> </a> &nbsp;&nbsp;
																		<%
																			}else{
																		%>
																		<div align="left">
																			<a><img width="86" height="25" border="0"
																				src="images/jie_none.gif"> </a> &nbsp;&nbsp;
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
													</table></td>
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
												<td width="669" bgcolor="efefef" class="zi-leibie1"><strong>内容简介</strong>
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
															<%=book.getDes()%>
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
													</script></td>
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
												<td width="669" bgcolor="efefef" class="zi-leibie1"><strong>书摘与插图</strong>
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
 	if (book.getInfo_img1() != null && !"".equals(book.getInfo_img1())) {
 %>
									<table width="720" height="16" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr valign="top">
												<td width="32" height="16">&nbsp;</td>
												<td width="669" class="xinwen"><img border="0"
													src="<%=basePath%>/images/book/<%=book.getInfo_img1()%>">
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
 	if (book.getInfo_img2() != null && !"".equals(book.getInfo_img2())) {
 %>
									<table width="720" height="16" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr valign="top">
												<td width="32" height="16">&nbsp;</td>
												<td width="669" class="xinwen"><img border="0"
													src="<%=basePath%>/images/book/<%=book.getInfo_img2()%>">
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
 	if (book.getInfo_img3() != null && !"".equals(book.getInfo_img3())) {
 %>
									<table width="720" height="16" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr valign="top">
												<td width="32" height="16">&nbsp;</td>
												<td width="669" class="xinwen"><img border="0"
													src="<%=basePath%>/images/book/<%=book.getInfo_img3()%>">
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
									<table width="720" height="24" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="32" valign="top" height="16" bgcolor="efefef">&nbsp;</td>
												<td width="669" bgcolor="efefef" class="zi-leibie1"><strong>会员评论</strong>
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
 	if (list != null && list.size() > 0) {
 		for (FeedBackBook f : list) {
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
 	if ((role_id != null && role_id == 2)
 					|| (f.getUser_id() > 0 && user_id != null && f
 							.getUser_id() == user_id)) {
 %> <a
													href="<%=basePath%>/api?servlet=book&cmd=del_feedback&book_id=<%=book.getId()%>&id=<%=f.getId()%>">删除</a>
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
 	}
 %>
									<table width="100%" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<form
													action="<%=basePath%>/api?servlet=book&cmd=add_feedback&book_id=<%=book.getId()%>"
													method="post" id="book_feedback" name="book_feedback">
													<td>
														<table width="658" height="62" align="center"
															cellspacing="0" cellpadding="0" border="0">
															<tbody>
																<tr>
																	<td class="show"><textarea maxlength="500"
																			class="input_combobox4a" rows="6" cols="70"
																			name="content" id="content"></textarea>
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
														<table width="660" height="62" align="center"
															cellspacing="0" cellpadding="0" border="0">
															<tbody>
																<tr>
																	<td valign="top" class="zi3"><input type="button"
																		onclick="check_content();" class="yud"
																		value="<%=user_id == null ? "请登录" : " 写好了，提交 "%>"
																		<%=user_id == null ? "disabled=\"disabled\"" : ""%>>
																	</td>
																</tr>
															</tbody>
														</table>
												</form>
												</td>

											</tr>
										</tbody>
									</table>
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

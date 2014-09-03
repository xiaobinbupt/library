<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	List<String> ages = (List<String>) request.getAttribute("ages");
	List<String> pubs = (List<String>) request.getAttribute("pubs");
	List<String> authors = (List<String>) request
			.getAttribute("authors");
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
</head>
<body marginwidth="0" marginheight="0" bottommargin="0" rightmargin="0"
	topmargin="0" leftmargin="0">
	<table width="210" height="150" bgcolor="DBDBDB" align="center"
		cellspacing="1" cellpadding="0" border="0">
		<tbody>
			<tr>
				<td bgcolor="efefef">
					<table width="188" align="center" cellspacing="0" cellpadding="0"
						border="0">
						<tbody>
							<tr>
								<td width="167" height="29" class="zi-leibie1"><strong>网站公告</strong>
								</td>
							</tr>
						</tbody>
					</table></td>
			</tr>
			<tr>
				<td valign="top" height="118" bgcolor="#FFFFFF">
					<table width="100%" align="center" cellspacing="0" cellpadding="0"
						border="0">
						<tbody>
							<tr>
								<td height="4"></td>
							</tr>
						</tbody>
					</table>

					<table width="188" height="24" align="center" cellspacing="0"
						cellpadding="0" border="0">
						<tbody>
							<tr>
								<td>• <a class="zi-leibie2" href="rule.jsp"><font
										color="#FF0000">关于小船长绘本馆的说明</font> </a>
								</td>
							</tr>
							<tr>
								<td>• <a class="zi-leibie2" href="introduce.jsp"><font
										color="#FF0000">为什么选择绘本阅读</font> </a>
								</td>
							</tr>
							<tr>
								<td>• <a class="zi-leibie2"><font color="#FF0000" >客服电话:0311-88888888</font></a>
								</td>
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
				<td height="10"></td>
			</tr>
		</tbody>
	</table>
	<table width="100%" cellspacing="0" cellpadding="0" border="0">
		<tbody>
			<tr>
				<td height="10"></td>
			</tr>
		</tbody>
	</table>
	<table width="210" height="80" bgcolor="D5E2B7" cellspacing="1"
		cellpadding="0" border="0">
		<tbody>
			<tr>
				<td width="210" valign="top" height="80" bgcolor="#FFFFFF">
					<table width="100%" bgcolor="FAF1E2" align="center" cellspacing="0"
						cellpadding="0" border="0">
						<tbody>
							<tr>
								<td valign="top" height="29"
									style="PADDING-left:12px;PADDING-top:6px;" class="zi-leibie1"><strong>按阅读年龄分</strong>
								</td>
							</tr>
						</tbody>
					</table>
					<table width="100%" cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td height="10"></td>
							</tr>
						</tbody>
					</table> <%
 	for (int i = 0; i < ages.size(); i++) {
 %>

					<table width="160" height="24" align="center" cellspacing="0"
						cellpadding="0" border="0">
						<tbody>
							<tr>
								<td width="70" background="<%=basePath%>/images/bgolda.gif"><div
										align="center">
										<strong><a class="zi-leibie2"
											href="<%=basePath%>/api?servlet=book&cmd=list&search=1&age=<%=ages.get(i)%>"><font
												color="#333333"><%=ages.get(i)%>岁</font> </a> </strong>
									</div></td>
								<td width="10"></td>
								<td width="70" background="<%=basePath%>/images/bgoldb.gif"><div
										align="center">
										<%
											i++;
												if (i < ages.size()) {
										%>
										<strong><a class="zi-leibie2"
											href="<%=basePath%>/api?servlet=book&cmd=list&search=1&age=<%=ages.get(i)%>"><font
												color="#333333"><%=ages.get(i)%>岁</font> </a> </strong>
										<%
											}
										%>
									</div>
								</td>
								<td width="10"></td>

							</tr>
						</tbody>
					</table>
					<table width="100%" cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td height="5"></td>
							</tr>
						</tbody>
					</table> <%
 	}
 %>

					<table width="100%" bgcolor="FAF1E2" align="center" cellspacing="0"
						cellpadding="0" border="0">
						<tbody>
							<tr>
								<td valign="top" height="29"
									style="PADDING-left:12px;PADDING-top:6px;" class="zi-leibie1"><strong>按出版社分</strong>
								</td>
							</tr>
						</tbody>
					</table>
					<table width="100%" cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td height="10"></td>
							</tr>
						</tbody>
					</table> <%
 	for (String pub : pubs) {
 %>
					<table width="190" align="center" cellspacing="0" cellpadding="0"
						border="0">
						<tbody>
							<tr>
								<td width="15"></td>
								<td width="175" class="zi-leibie2">• <a class="zi-leibie2"
									href="<%=basePath%>/api?servlet=book&cmd=list&search=1&pub=<%=pub%>"><%=pub%></a>
								</td>
							</tr>
						</tbody>
					</table>
					<table width="190" align="center" cellspacing="0" cellpadding="0"
						border="0">
						<tbody>
							<tr>
								<td height="5"></td>
							</tr>
						</tbody>
					</table> <%
 	}
 %>

					<table width="100%" bgcolor="FAF1E2" align="center" cellspacing="0"
						cellpadding="0" border="0">
						<tbody>
							<tr>
								<td valign="top" height="29"
									style="PADDING-left:12px;PADDING-top:6px;" class="zi-leibie1"><strong>按作者分</strong>
								</td>
							</tr>
						</tbody>
					</table>
					<table width="100%" cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td height="10"></td>
							</tr>
						</tbody>
					</table> <%
 	for (String author : authors) {
 %>
					<table width="190" align="center" cellspacing="0" cellpadding="0"
						border="0">
						<tbody>
							<tr>
								<td width="15"></td>
								<td width="175" class="zi-leibie2">• <a class="zi-leibie2"
									href="<%=basePath%>/api?servlet=book&cmd=list&search=1&author=<%=author%>"><%=author%></a>
								</td>
							</tr>
						</tbody>
					</table>
					<table width="190" align="center" cellspacing="0" cellpadding="0"
						border="0">
						<tbody>
							<tr>
								<td height="5"></td>
							</tr>
						</tbody>
					</table> <%
 	}
 %> <!--
									<table width="100%" bgcolor="FAF1E2" align="center"
										cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td valign="top" height="29"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1"><strong>按主题分</strong></td>
											</tr>
										</tbody>
									</table>
									<table width="100%" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td height="10"></td>
											</tr>
										</tbody>
									</table>
									<table width="190" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="15"></td>
												<td width="175" class="zi-leibie2"><a
													class="zi-leibie2" href="classzhu.asp?key=%D2%D5%CA%F5">艺术</a>
													| <a class="zi-leibie2"
													href="classzhu.asp?key=%C9%FA%C3%FC%BD%CC%D3%FD">生命教育</a> |
													<a class="zi-leibie2" href="classzhu.asp?key=%C8%A4%CE%B6">趣味</a>
													| <a class="zi-leibie2"
													href="classzhu.asp?key=%C8%CF%D6%AA">认知</a></td>
											</tr>
										</tbody>
									</table>
									<table width="190" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td height="5"></td>
											</tr>
										</tbody>
									</table>

									<table width="100%" bgcolor="FAF1E2" align="center"
										cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td valign="top" height="29"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1"><strong>大奖绘本</strong></td>
											</tr>
										</tbody>
									</table>
									<table width="100%" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td height="10"></td>
											</tr>
										</tbody>
									</table>
									<table width="190" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="15"></td>
												<td width="175" class="zi-leibie2"><a
													class="zi-leibie2"
													href="classjiang.asp?key=%C3%C0%B9%FA%BF%AD%B5%CF%BF%CB%B4%F3%BD%B1">美国凯迪克大奖</a>
													| <a class="zi-leibie2"
													href="classjiang.asp?key=%B9%FA%BC%CA%B0%B2%CD%BD%C9%FA%BD%B1">国际安徒生奖</a>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="190" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td height="5"></td>
											</tr>
										</tbody>
									</table>
									<table width="100%" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td height="10"></td>
											</tr>
										</tbody>
									</table>
									<table width="100%" bgcolor="FAF1E2" align="center"
										cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td valign="top" height="29"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1"><strong>大师绘本</strong></td>
											</tr>
										</tbody>
									</table>
									<table width="100%" cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td height="10"></td>
											</tr>
										</tbody>
									</table>
									<table width="190" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="15"></td>
												<td width="175" class="zi-leibie2"><a
													class="zi-leibie2" href="classshi.asp?key=%B2%A8%CC%D8">波特</a>
													| <a class="zi-leibie2"
													href="classshi.asp?key=%C0%EE%B2%AE%B6%D9">李伯顿</a> | <a
													class="zi-leibie2"
													href="classshi.asp?key=%C0%EE%C5%B7%A1%A4%C0%EE%B0%C2%C4%E1">李欧·李奥尼</a>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="190" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td height="5"></td>
											</tr>
										</tbody>
									</table>
									-->
				</td>
			</tr>
		</tbody>
	</table>
</body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	List<Category> categorys = (List<Category>) request
			.getAttribute("categorys");
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
					</table>
				</td>
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
										color="#FF0000">计划及价格</font> </a></td>
							</tr>
							<tr>
								<td>• <a class="zi-leibie2" href="introduce.jsp"><font
										color="#FF0000">为什么选择绘本阅读</font> </a></td>
							</tr>
							<tr>
								<td>• <a class="zi-leibie2" href="rule.jsp"><font
										color="#FF0000">促销政策</font> </a></td>
							</tr>
							<tr>
								<td>• <a class="zi-leibie2" href="<%=basePath%>api?servlet=book&cmd=new_book_list"><font
										color="#FF0000">新书推荐</font> </a></td>
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
					</table>

					<table width="160" height="24" align="center" cellspacing="0"
						cellpadding="0" border="0">
						<tbody>
							<tr>
								<td width="70" background="<%=basePath%>images/bgolda.gif"><div
										align="center">
										<strong><a class="zi-leibie2"
											href="<%=basePath%>api?servlet=book&cmd=list"><font
												color="#333333">全部</font> </a> </strong>
									</div>
								</td>
							</tr>
							<tr>
								<td width="70" background="<%=basePath%>images/bgolda.gif"><div
										align="center">
										<strong><a class="zi-leibie2"
											href="<%=basePath%>api?servlet=book&cmd=list&search=1&age_end=3"><font
												color="#333333">3岁及以下</font> </a> </strong>
									</div>
								</td>
								<td width="10"></td>
								<td width="70" background="<%=basePath%>images/bgoldb.gif"><div
										align="center">
										<strong><a class="zi-leibie2"
											href="<%=basePath%>api?servlet=book&cmd=list&search=1&age_begin=3&age_end=6"><font
												color="#333333">3-6岁</font> </a> </strong>
									</div></td>
							</tr>
							<tr>
								<td width="70" background="<%=basePath%>images/bgolda.gif"><div
										align="center">
										<strong><a class="zi-leibie2"
											href="<%=basePath%>api?servlet=book&cmd=list&search=1&age_begin=6&age_end=12"><font
												color="#333333">6-12</font> </a> </strong>
									</div>
								</td>
								<td width="10"></td>
								<td width="70" background="<%=basePath%>images/bgoldb.gif"><div
										align="center">
										<strong><a class="zi-leibie2"
											href="<%=basePath%>api?servlet=book&cmd=list&search=1&age_begin=12"><font
												color="#333333">12岁及以上</font> </a> </strong>
									</div></td>
							</tr>
						</tbody>
					</table>
					<table width="100%" cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td height="5"></td>
							</tr>
						</tbody>
					</table>

					<table width="100%" bgcolor="FAF1E2" align="center" cellspacing="0"
						cellpadding="0" border="0">
						<tbody>
							<tr>
								<td valign="top" height="29"
									style="PADDING-left:12px;PADDING-top:6px;" class="zi-leibie1"><strong>按分类分</strong>
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
					<table width="190" align="center" cellspacing="0" cellpadding="0"
						border="0">
						<tbody>
							<tr>
								<td width="15"></td>
								<td width="175" class="zi-leibie2">• <a class="zi-leibie2"
									href="<%=basePath%>api?servlet=book&cmd=list">全部</a>
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
 	for (Category c : categorys) {
 %>
					<table width="190" align="center" cellspacing="0" cellpadding="0"
						border="0">
						<tbody>
							<tr>
								<td width="15"></td>
								<td width="175" class="zi-leibie2">• <a class="zi-leibie2"
									href="<%=basePath%>api?servlet=book&cmd=list&search=1&category=<%=c.getId()%>"><%=c.getName()%></a>
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
				</td>
			</tr>
		</tbody>
	</table>
</body>
</html>

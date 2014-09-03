<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String err = (String) request.getAttribute("err");
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

<script type="text/javascript">
	function login_display() {
		document.getElementById("err_info").innerHTML = "";
		document.getElementById("login_div_1").style.display = "block";
		document.getElementById("login_div_2").style.display = "block";
	}

	function login_cancel() {
		document.getElementById("err_info").innerHTML = "";
		document.getElementById("login_div_1").style.display = "none";
		document.getElementById("login_div_2").style.display = "none";
	}
</script>

</head>
<body marginwidth="0" marginheight="0" bottommargin="0" rightmargin="0"
	topmargin="0" leftmargin="0">
	<div class="mask" style="display: none" id="login_div_1"></div>
	<div class="dialog" style="display: none" id="login_div_2">
		<table width="500" height="292" bgcolor="D5E2B7" cellspacing="1"
			cellpadding="0" border="0">
			<tbody>
				<tr>
					<td width="500" valign="top" bgcolor="#FFFFFF">
						<table width="500" height="29" bgcolor="FAF1E2" cellspacing="0"
							cellpadding="0" border="0">
							<tbody>
								<tr>
									<td width="100" valign="top" height="28"
										style="PADDING-left:12px;PADDING-top:6px;" class="zi-leibie1"><strong>登录帐户</strong>
									</td>
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
						<table width="100%" cellspacing="0" cellpadding="0" border="0">
							<tbody>
								<tr>
									<form action="<%=basePath%>/api?servlet=system&cmd=login"
										method="post" name="form">
										<div align="center" id="err_info">
											<%
												if (err != null) {
											%>
											<h1>
												<strong><%=err%></strong>
											</h1>
											<%
												}
											%>
										</div>
										<td><table width="400" height="27" align="center"
												cellspacing="0" cellpadding="0" border="0">
												<tbody>
													<tr>
														<td width="100" class="zi16"><div align="center">
																<p class="zi16">
																	<font color="333333">用户名</font>
																</p>
															</div></td>
														<td width="510" class="zi16"><input type="text"
															class="input_combobox5" name="name"></td>
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
											<table width="400" height="27" align="center" cellspacing="0"
												cellpadding="0" border="0">
												<tbody>
													<tr>
														<td width="100" class="zi16"><div align="center">
																<p class="zi16">
																	<font color="333333">密码</font>
																</p>
															</div></td>
														<td width="510" class="zi16"><input type="password"
															class="input_combobox5" name="password">
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
											<table width="600" height="27" align="center" cellspacing="0"
												cellpadding="0" border="0">
												<tbody>
													<tr>
														<td class="zi16" align="center"><input type="button"
															value="返回" class="yud" onclick="login_cancel();">
														</td>
														<td class="zi16"><input type="submit" value="登录 "
															class="yud" name="Submit"></td>
													</tr>
												</tbody>
											</table>
											<table width="600" height="27" align="center" cellspacing="0"
												cellpadding="0" border="0">
												<tbody>
													<tr>
														<td width="80" class="zi16">&nbsp;</td>
														<td width="520" class="zi10">&nbsp;</td>
													</tr>
												</tbody>
											</table></td>
									</form>
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
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>

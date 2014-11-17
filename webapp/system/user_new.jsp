<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<jsp:include page="/top.jsp" flush="true" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String user_name = (String) request.getSession().getAttribute(
			"user_name");
	String err = (String) request.getAttribute("err");
	User user = (User) request.getAttribute("user");
	Object info = request.getAttribute("info");
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
		var name = document.getElementById("regist").name.value;
		if (name == '') {
			alert('用户名不能为空!');
			return;
		}
		if (name.length < 3) {
			alert('用户名太短!');
			return;
		}
		var password = document.getElementById("regist").password.value;
		if (password == '') {
			alert('密码不能为空!');
			return;
		}
		if (password.length < 6 || password.length > 20) {
			alert('密码长度不对!');
			return;
		}
		var password_repat = document.getElementById("regist").password_repat.value;
		if (password_repat == '') {
			alert('确认密码不能为空!');
			return;
		}
		if (password_repat != password) {
			alert('密码不一致!');
			return;
		}
		var real_name = document.getElementById("regist").real_name.value;
		if (real_name == '') {
			alert('真实姓名不能为空!');
			return;
		}
		var mobile = document.getElementById("regist").mobile.value;
		if (mobile == '') {
			alert('电话不能为空!');
			return;
		}
		var address = document.getElementById("regist").address.value;
		if (address == '') {
			alert('地址不能为空!');
			return;
		}
		document.getElementById("regist").submit();
	}
	
	function init_district(){
		<%
			if(user != null){
		%>
		var district = document.getElementById("district");
		var options = district.options;
		for(var i = 0; i < options.length; i++){
			if(options[i].value == '<%=user.getDistrict()%>'){
				options[i].selected = "selected";
				break;
			}
		}
		<%
			}
		%>
	}
</script>

</head>

<body marginwidth="0" marginheight="0" bottommargin="0" rightmargin="0"
	topmargin="0" leftmargin="0" onload="init_district();">
	<table width="950" height="81" align="center" cellspacing="0"
		cellpadding="0" border="0">
		<tbody>
			<tr valign="top">
				<td width="210">
					<table width="210" height="94" bgcolor="D5E2B7" cellspacing="1"
						cellpadding="0" border="0">
						<%
							if (user_name == null) {
						%>
						<tbody>
							<tr>
								<td width="210" valign="top" height="94" bgcolor="#FFFFFF">
									<table width="100%" bgcolor="FAF1E2" align="center"
										cellspacing="0" cellpadding="0" border="0">
										<tbody>
											<tr>
												<td valign="top" height="29"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1"><strong>已有小船长绘本馆帐户？</strong>
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
									<table width="186" align="center" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td height="35" class="zi-leibie1">请直接<a
													onclick="login_display();"><font color="#00529B">登录</font>
												</a>。</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>

						<%
							}
						%>
					</table>
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
													class="zi-leibie1"><strong><%=user_name == null ? "注册小船长绘本馆帐户" : "用户信息"%></strong>
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
									<form action="<%=basePath%>/api?servlet=system&cmd=upd_user"
										method="post" name="regist" id="regist">
										<input type="hidden" name="id" id="id"
											value="<%=user == null ? "" : user.getId()%>">
										<table width="100%" cellspacing="0" cellpadding="0" border="0">
											<tbody>
												<tr>
													<td>
														<table width="600" height="27" align="center"
															cellspacing="0" cellpadding="0" border="0">
															<tbody>
																<tr>
																	<td width="80" class="zi16"><div align="center">
																			<font color="333333">用户名</font>
																		</div>
																	</td>
																	<td width="520" class="zi16"><input type="text"
																		class="input_combobox5" name="name" id="name"
																		value="<%=user == null ? "" : user.getName()%>"
																		<%=user == null ? "" : (err == null ? "readonly" : "")%> />
																		<%
																			if (err != null) {
																		%> <font color="red"><%=err%></font> <%
 	}
 %>
																	</td>
																</tr>
															</tbody>
														</table> <%
 	if (info == null) {
 %>
														<table width="600" height="27" align="center"
															cellspacing="0" cellpadding="0" border="0">
															<tbody>
																<tr>
																	<td width="80" class="zi16">&nbsp;</td>
																	<td width="520" class="zi10"><font color="989898">最少
																			3 个字符</font>
																	</td>
																</tr>
															</tbody>
														</table> <%
 	}
 %>
														<table width="100%" cellspacing="0" cellpadding="0"
															border="0">
															<tbody>
																<tr>
																	<td height="10"></td>
																</tr>
															</tbody>
														</table> <%
 	if (info == null) {
 %>
														<table width="600" height="27" align="center"
															cellspacing="0" cellpadding="0" border="0">
															<tbody>
																<tr>
																	<td width="80" class="zi16"><div align="center">
																			<font color="333333">密码</font>
																		</div>
																	</td>
																	<td width="520" class="zi16"><input
																		type="password" class="input_combobox5"
																		name="password" id="password"
																		value="<%=user == null ? "" : user.getPassword()%>" />
																	</td>
																</tr>
															</tbody>
														</table>
														<table width="600" height="27" align="center"
															cellspacing="0" cellpadding="0" border="0">
															<tbody>
																<tr>
																	<td width="80" class="zi16">&nbsp;</td>
																	<td width="520" class="zi10"><font color="989898">6-20个字符，一个汉字为两个字符</font>
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
																			<font color="333333">确认密码</font>
																		</div></td>
																	<td width="520" class="zi16"><input
																		type="password" class="input_combobox5"
																		name="password_repat" id="password_repat"
																		value="<%=user == null ? "" : user.getPassword()%>" />
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

														<table width="100%" cellspacing="0" cellpadding="0"
															border="0">
															<tbody>
																<tr>
																	<td height="10"></td>
																</tr>
															</tbody>
														</table> <%
 	}
 %>
														<table width="600" height="27" align="center"
															cellspacing="0" cellpadding="0" border="0">
															<tbody>
																<tr>
																	<td width="80" class="zi16"><div align="center">
																			<font color="333333">真实姓名</font>
																		</div></td>
																	<td width="520" class="zi16"><input type="text"
																		class="input_combobox5" name="real_name"
																		id="real_name"
																		value="<%=user == null ? "" : user.getReal_name()%>"
																		<%=info == null ? "" : "readonly=\"\""%> /> <font
																		color="989898">&nbsp; </font></td>
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
																	<td width="80" class="zi16"><div align="center">电话</div>
																	</td>
																	<td width="520" class="zi16"><input type="text"
																		class="input_combobox5" name="mobile" id="mobile"
																		value="<%=user == null ? "" : user.getMobile()%>"
																		<%=info == null ? "" : "readonly=\"\""%> /> <font
																		color="989898">&nbsp; </font></td>
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
																	<td width="80" class="zi16"><div align="center">行政区</div>
																	</td>
																	<td width="520" class="zi16">
																		<select class="input_combobox5" id="district" name="district">
																			<option value="长安区">长安区（星期一送书）</option>
																			<option value="裕华区">裕华区（星期二送书）</option>
																			<option value="桥西区">桥西区（星期三送书）</option>
																			<option value="新华区">新华区（星期五送书）</option>
																		</select>
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
																	<td width="80" class="zi16"><div align="center">地址</div>
																	</td>
																	<td width="520" class="zi16"><input type="text"
																		class="input_combobox5" name="address" id="address"
																		value="<%=user == null ? "" : user.getAddress()%>"
																		<%=info == null ? "" : "readonly=\"\""%> /> <font
																		color="989898">&nbsp; </font></td>
																</tr>
																<tr>
																	<td width="80" class="zi16"></td>
																	<td width="520" class="zi16"><font
																		color="red">可选择家庭地址，工作单位地址，二环内方便接收图书的地方即可</font></td>
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
																			<font color="333333">描述</font>
																		</div></td>
																	<td width="520" class="zi16"><textarea rows="5"
																			cols="40" name="des" id="des"
																			<%=info == null ? "" : "readonly=\"\""%>><%=user == null ? "" : user.getDes()%></textarea>
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
																		value="返回" class="yud"></td>
																	<%
																		if (info == null) {
																	%>
																	<td width="520" class="zi16"><input type="button"
																		onclick="submit_form();" value="提交" class="yud">
																	</td>
																	<%
																		}
																	%>
																</tr>
															</tbody>
														</table></td>

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

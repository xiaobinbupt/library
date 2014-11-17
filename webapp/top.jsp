<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<jsp:include page="/system/login_new.jsp" flush="true" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String user_name = (String) request.getSession().getAttribute(
			"user_name");
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

</head>
<body marginwidth="0" marginheight="0" bottommargin="0" rightmargin="0"
	topmargin="0" leftmargin="0">
	<table width="950" align="center" cellspacing="0" cellpadding="0"
		border="0">
		<tbody>
			<tr>
				<td height="5"></td>
			</tr>
		</tbody>
	</table>
	<table width="950" height="38"
		background="<%=basePath%>images/bg6.gif" align="center"
		cellspacing="0" cellpadding="0" border="0">
		<tbody>
			<tr>
				<td width="10" class="zi-banner"><img width="10" height="38"
					src="<%=basePath%>images/zuo.gif">
				</td>
				<td width="12" class="zi-banner"></td>
				<td width="94" class="zi-banner">
					<a class="zi-banner" href="<%=basePath%>api?servlet=book&cmd=new_book_list">
					<strong><font color="#ffffff">新书推荐</font></strong> </a>
				</td>
				<td width="94" class="zi-banner">
					<a class="zi-banner" href="<%=basePath%>api?servlet=book&cmd=list&search=1">
					<strong><font color="#ffffff">图书列表</font> </strong> </a>
				</td>
				<td width="94" class="zi-banner">
					<a class="zi-banner" href="<%=basePath%>api?servlet=feedback&cmd=list">
					<strong><font color="#ffffff">意见及建议</font></strong> </a>
				</td>
				<td width="342" class="zi-banner"><div align="right">
						<%
							if (user_name != null && !"".equals(user_name)) {
						%>
						<img width="17" height="38" align="absmiddle"
							src="<%=basePath%>images/line1.gif"><font color="#FFFFFF">欢迎您:&nbsp;<a
							class="zi-banner"
							href="<%=basePath%>api?servlet=system&cmd=prepare_upd_user"><font
								color="#FFFFFF"><%=user_name%></font> </a>
						</font> &nbsp;&nbsp;<a class="zi-banner"
							href="<%=basePath%>api?servlet=borrow&cmd=list"><font
							color="#FFFFFF">订阅列表</font> </a> &nbsp;&nbsp;<a class="zi-banner"
							href="<%=basePath%>api?servlet=system&cmd=logout"><font
							color="#FFFFFF">退出</font> </a>
						<%
							} else {
						%>
						<img width="17" height="38" align="absmiddle"
							src="<%=basePath%>images/line1.gif"> <a class="zi-banner"
							onclick="login_display();"><font color="#FFFFFF">登录</font> </a>&nbsp;&nbsp;<a
							class="zi-banner"
							href="<%=basePath%>api?servlet=system&cmd=prepare_regist"><font
							color="#FFFFFF">注册</font> </a>
						<%
							}
						%>
					</div>
				</td>
				<td width="12" class="zi-banner">&nbsp;</td>
				<td width="10" class="zi-banner"><img width="10" height="38"
					src="<%=basePath%>images/you.gif">
				</td>
			</tr>
		</tbody>
	</table>
	<table width="950" align="center" cellspacing="0" cellpadding="0"
		border="0">
		<tbody>
			<tr>
				<td height="5"></td>
			</tr>
		</tbody>
	</table>
</body>
</html>

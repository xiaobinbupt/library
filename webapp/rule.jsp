<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<jsp:include page="/top.jsp" flush="true" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
													class="zi-leibie1"><strong>租赁费用:</strong>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="100%" height="28" cellspacing="0" cellpadding="0"
										border="0">
										<tbody>
											<tr>
												<td>
													<p>&nbsp;&nbsp;• 会员可根据个人需要，自主选择季租、年租等不同方式</p>
													<p>&nbsp;&nbsp;• 季度租金：90元/季度</p>
													<p>&nbsp;&nbsp;• 年租：300元/年</p>
													<p>&nbsp;&nbsp;• 无论何种租赁方式，均需交纳押金100元</p>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="950" height="29" bgcolor="FAF1E2" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="210" valign="top" height="28"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1"><strong>费用收取:</strong>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="100%" height="28" cellspacing="0" cellpadding="0"
										border="0">
										<tbody>
											<tr>
												<td>
													<p>&nbsp;&nbsp;租赁押金和租赁费均可采取以下两种方式完成：</p>
													<p>&nbsp;&nbsp;1、由“小船长”网站工作人员第一次配送时上门收取，并开具收据证明；</p>
													<p>&nbsp;&nbsp;2、会员登录网站订阅时，用支付宝支付相应的租期金额</p>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="950" height="29" bgcolor="FAF1E2" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="210" valign="top" height="28"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1"><strong>绘本配送:</strong>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="100%" height="28" cellspacing="0" cellpadding="0"
										border="0">
										<tbody>
											<tr>
												<td>
													<p>&nbsp;&nbsp;无论采取以上何种租赁方式，单个会员每周租赁绘本数量最高限额为五本，每周配送一次</p>
													<p>&nbsp;&nbsp;配送流程：会员在网站或者微信冀生活选择绘本种类——公司配送——签发回执</p>
													<p>&nbsp;&nbsp;配送范围：仅限于二环之内（包括二环边）。超出配送范围，请与“小船长”网站联系，双方协商解决</p>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="950" height="29" bgcolor="FAF1E2" cellspacing="0"
										cellpadding="0" border="0">
										<tbody>
											<tr>
												<td width="210" valign="top" height="28"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1"><strong>赔偿事宜:</strong>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="100%" height="28" cellspacing="0" cellpadding="0"
										border="0">
										<tbody>
											<tr>
												<td>
													<p>&nbsp;&nbsp;会员应该自觉爱护图书，避免人为损坏。如果出现图书损坏影响阅读的情况，不能修复的，请会员按照绘本定价70%的金额购买被损坏书籍。特殊情况，由双方协商解决</p>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="950" height="29" bgcolor="FAF1E2" cellspacing="0"
										cellpadding="0" border="0"">
										<tbody>
											<tr>
												<td width="210" valign="top" height="28"
													style="PADDING-left:12px;PADDING-top:6px;"
													class="zi-leibie1"><div align="center"><strong>本协议最终解释权归小船长网站所有</strong></div>
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
	<jsp:include page="/footer.jsp" flush="true" />	
</body>
</html>

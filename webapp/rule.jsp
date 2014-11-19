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
									<table width="100%" height="28" cellspacing="0" cellpadding="0"
										border="0">
										<tbody>
											<tr>
												<td>
													<p>&nbsp;&nbsp;&nbsp;&nbsp;“小船长”网络绘本馆<a href="http://www.xiaochuanzhang.com">www.xiaochuanzhang.com</a>（微信号：<b>xiaochuanzhang_1</b>,咨询电话：<b>18831199966</b>），是一个提供专业绘本阅读的网络电子借阅平台，主要服务于0至6岁以及低学龄儿童，拥有数千本精美绘本（并在不断更新添加中），致力于从小培养孩子的阅读习惯，并以此搭建良好的亲子关系，为孩子建立优良的初期学习平台。“小船长”会员可通过网络平台通过租赁方式获得绘本阅读。我们的服务宗旨：“一天一元钱，绘本送到家”。</p>
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
													class="zi-leibie1"><strong>会员权益:</strong>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="100%" height="28" cellspacing="0" cellpadding="0"
										border="0">
										<tbody>
											<tr>
												<td>
													<p>&nbsp;&nbsp;1、会员帐号仅限会员本人使用。</p>
													<p>&nbsp;&nbsp;2、会员在服务期内，可借阅网上所有绘本，并免费送到您指定的地点（并收回上次借阅书籍），每位会员<b>每周可借阅五本</b>绘本。</p>
													<p>&nbsp;&nbsp;3、暂停借阅：会员可以在有效期内申请中途暂停借阅，每暂停借阅一次将产生<b>10元</b>的收取图书的费用。（申请次数不限，天数累计，计入并延长会员有效期）。</p>
													<p>&nbsp;&nbsp;4、<b>会员服务到期，请提前或及时续费；如果到期后7日内未续费，或未退还书的，按照每天每本0.5元的管理费，从押金中扣除（逾期管理费从逾期第1天开始计算）。</b></p>
													<p>&nbsp;&nbsp;5、租赁押金和租赁费均可采取以下两种方式完成：<br/>&nbsp;&nbsp;&nbsp;&nbsp;（1）由“小船长”网站工作人员第一次配送时上门收取，并开具收据证明；<br/>&nbsp;&nbsp;&nbsp;&nbsp;（2）会员登录网站订阅时，用支付宝支付相应的租期金额。</p>
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
													<p>&nbsp;&nbsp;• 月租：40元/月</p>
													<p>&nbsp;&nbsp;• 季租：90元/季度</p>
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
													<p>&nbsp;&nbsp;1、无论采取以上何种租赁方式，单个会员每周租赁绘本数量<b>最高限额为五本</b>，分区配送：<b>长安区（星期一送书），裕华区（星期二送书），桥西区（星期三送书），新华区（星期五送书）</b>，每周配送一次。</p>
													<p>&nbsp;&nbsp;2、配送流程：会员在小船长网站注册会员——订阅绘本——公司配送——签发回执。</p>
													<p>&nbsp;&nbsp;3、配送范围：仅限于二环之内。超出配送范围，请与“小船长”网站联系，双方协商解决。</p>
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
													class="zi-leibie1"><strong>赔偿事宜及其他:</strong>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="100%" height="28" cellspacing="0" cellpadding="0"
										border="0">
										<tbody>
											<tr>
												<td>
													<p>&nbsp;&nbsp;1、本馆以专业紫外线臭氧图书消毒机执行图书消毒程序，每次图书入库前，都会进行消毒，请您和您的孩子放心阅读。</p>
													<p>&nbsp;&nbsp;2、当您收到我们的工作人员送来的图书时，请当面检查您所借图书是否有涂画、撕页、污损等情况，如有上述情况，请向工作人员反映；否则还书时发现有上述情况，责任由您自负。</p>
													<p>&nbsp;&nbsp;3、会员应该自觉爱护图书，避免人为损坏。图书有轻微损毁，请您及时修补一下，或者在我们工作人员取书时主动告知，由我们进行修补。如果出现图书损坏影响阅读的情况，不能修复的，请会员按照绘本定价70%购买被损坏书籍。特殊情况，由双方协商解决。</p>
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

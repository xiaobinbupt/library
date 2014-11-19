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
													<p>&nbsp;&nbsp;&nbsp;&nbsp;图书是送给孩子最好的礼物。不过很多家长也有烦恼：孩子看的书由于纸张和印刷的关系，价格都比较昂贵，而且买来后孩子看完了就没什么用了，丢在一边很浪费，去图书馆一次只能借一两本，而且还要亲自跑到馆里去查找，有没有一个不用出家门就能为孩子借到精美图书的地方呢？</p>
													<p>&nbsp;&nbsp;&nbsp;&nbsp;您的福音来了，“小船长”网络绘本馆<a href="http://www.xiaochuanzhang.com">www.xiaochuanzhang.com</a>，是一个提供专业绘本阅读的网络电子借阅平台，主要服务于0至6岁以及低学龄儿童，拥有数千本精美绘本（并在不断更新添加中），致力于从小培养孩子的阅读习惯，并以此搭建良好的亲子关系，为孩子建立优良的初期学习平台。“小船长”会员可通过网络平台通过租赁方式获得绘本阅读，我们的配送人员会按照配送原则，把您订阅的绘本送到您指定的地点。我们的目的“一天一元钱，绘本送到家”。</p>
													<p>&nbsp;&nbsp;&nbsp;&nbsp;现在为了更好的回馈我们的会员朋友，小船长绘本馆开始送礼了，只要您登录我们的网站（<a href="http://www.xiaochuanzhang.com">www.xiaochuanzhang.com</a>，电话<b>18831199966</b>,微信号：<b>xiaochuanzhang_1</b>），成为我们的会员，不仅能给孩子送去精美的绘本，还会给您或者您的家人带来温暖的爱意。</p>
													<p>&nbsp;&nbsp;&nbsp;&nbsp;季卡会员（90元）可获赠价值30元的XF-820防爆电热水袋双插毛绒暖手宝一个。</p>
													<p align="center"><img src="images/activity/XF-820.jpg"></p>
													<p>&nbsp;&nbsp;&nbsp;&nbsp;年卡会员（300元）可获赠价值70元的XF-803防爆热水袋双插毛绒玩具卡通暖手宝一个。</p>
													<p align="center"><img src="images/activity/XF-803.jpg"></p>
													<p>&nbsp;&nbsp;&nbsp;&nbsp;数量有限赠完为止。</p>
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

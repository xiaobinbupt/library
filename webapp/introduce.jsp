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
													class="zi-leibie1"><strong>绘本内容:</strong>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="100%" height="28" cellspacing="0" cellpadding="0"
										border="0">
										<tbody>
											<tr>
												<td>
													<p>&nbsp;&nbsp;绘本并不是一般意义上，写给孩子的，带插图的书。绘本是用图画与文字，共同叙述一个故事，表达特定情感，主题的读本，通过绘画和文字两种媒介，互动来说故事的一门艺术。在绘本中，图画不再是点缀，而是图书的命脉，甚至有些绘本，一个字也没有，只有绘画来讲故事。绘本非常强调情绪和主题的连续性，在短短的几十页之内，形成一个连继的视觉影像。绘本的作者和画者，相当于电影导演，他必须在有限的篇幅里，把故事讲的既好看，又清晰。一本优秀的图画书，可以让不认字的孩子，“读”出其中的意思。另外，绘本都比较唯美，版式精到独特，和封面、扉页、下文以及封底，构成一个近乎完美的整体。</p>
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
													class="zi-leibie1"><strong>发展:</strong>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="100%" height="28" cellspacing="0" cellpadding="0"
										border="0">
										<tbody>
											<tr>
												<td>
													<p>&nbsp;&nbsp;绘本十七世纪诞生于欧洲，二十世纪三十年代，绘本图画书的主流传向了美国，绘本图书迎来了黄金时代。五六十年代，绘本开始在韩国、日本兴起，七十年，台湾也开始了绘本阅读，随后引起绘本阅读的热潮。绘本不仅是讲故事，学知识，而且可以全面帮助孩子建构精神，培养多元智能。二十一世纪，绘本阅读已经成了全世界儿童阅读的时尚。</p>
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
													class="zi-leibie1"><strong>阅读意义:</strong>
												</td>
											</tr>
										</tbody>
									</table>
									<table width="100%" height="28" cellspacing="0" cellpadding="0"
										border="0">
										<tbody>
											<tr>
												<td>
													<p>&nbsp;&nbsp;绘本最值得强调的就是它的文学性和艺术性。它出现于19世纪晚期，到20世纪中期开始充分发展，是新时代出现的、由传统的高品位的文学和艺术交织出的一种新样式。</p>
													<p>&nbsp;&nbsp;绘本中的文字非常少，但正因为少，对作者的要求更高：它必须精练，用简短的文字构筑出一个跌宕起伏的故事；它必须风趣活泼，符合孩子们的语言习惯。因此，绘本的作者往往对文字仔细推敲，再三锤炼。更值得一说的是图，绘本利用图讲故事的方式，把原本属于高雅层次、仅供少数人欣赏的绘画艺术带到了大众面前，尤其是孩子们的面前。这些图都是插画家们精心手绘，讲究绘画的技法和风格，讲究图的精美和细节，是一种独创性的艺术。可以说，好的绘本中每一页图画都堪称艺术精品。</p>
													<p>&nbsp;&nbsp;绘本中要读的绝不仅仅是文字，而是要从图画中读出故事，进而欣赏绘画。 当然，绘本不能立竿见影地实现我们对孩子的所有期望，但绘本中高质量的图与文，对培养孩子的认知能力、观察能力、沟通能力、想象力、创造力，还有情感发育等等，都有着难以估量的潜移默化的影响。</p>
													<p>&nbsp;&nbsp;专家一致认为：绘本是最适合孩子阅读的图书形式。儿童心理学的研究认为，孩子认知图形的能力从很小就开始慢慢养成。虽然那时的孩子不识字，但已经具备了一定的读图能力，如果这时候家长能有意识地和孩子们一起阅读绘本，营造温馨的环境，给他们读文字，和他们一起看图讲故事。那孩子们从刚开始接触到的就是高水准的图与文，他们将在听故事中品味绘画艺术，将在欣赏图画中认识文字、理解文学。比起那些一闪而过、只带来一时快感的快餐文化，欣赏绘本无疑是一种让眼睛享受、让心灵愉悦、让精神提升的美妙体验。</p>
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

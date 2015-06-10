<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.library.domain.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Toy toy = (Toy) request.getAttribute("toy");
	Object done = request.getAttribute("done");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>玩具</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<script type="text/javascript">
	function submit_form(){
		var img = document.getElementById("img").value;
		var info_img1 = document.getElementById("info_img1").value;
		var info_img2 = document.getElementById("info_img2").value;
		var info_img3 = document.getElementById("info_img3").value;
		var info_img4 = document.getElementById("info_img4").value;
		var info_img5 = document.getElementById("info_img5").value;
		if(img == '' && info_img1 == '' && info_img2 == '' && info_img3 == '' && info_img4 == '' && info_img5 == ''){
			alert('请选择图片!');
			return;
		}
		document.forms[0].submit();
	}

</script>

<body>
	<form id="form0" name="form0" method="post"
		action="<%=basePath%>/api?servlet=toy&cmd=upd_img&name=img&id=<%=toy.getId()%>"
		enctype="multipart/form-data">
		<table width="80%" border="1" align="center">
			<tr>
				<td>名称:</td>
				<td><%=toy == null ? "" : toy.getName()%></td>
			</tr>
			<tr>
				<td>ISDN:</td>
				<td><%=toy == null ? "" : toy.getIsdn()%></td>
			</tr>
			<tr>
				<td>封面图:</td>
				<td><img
					src="<%=toy == null ? "" : basePath + "/images/toy/"
					+ toy.getImg()%>"
					width="100" height="100" />
				</td>
			</tr>
			<tr>
				<td>选择图片:</td>
				<td><input name="img" id="img" type="file" />
				</td>
			</tr>
			<tr>
				<td>介绍图1:</td>
				<td><img
					src="<%=toy == null ? "" : basePath + "/images/toy/"
					+ toy.getInfo_img1()%>"
					width="100" height="100" />
				</td>
			</tr>
			<tr>
				<td>选择图片:</td>
				<td><input name="info_img1" id="info_img1" type="file" />
				</td>
			</tr>
			<tr>
				<td>介绍图2:</td>
				<td><img
					src="<%=toy == null ? "" : basePath + "/images/toy/"
					+ toy.getInfo_img2()%>"
					width="100" height="100" />
				</td>
			</tr>
			<tr>
				<td>选择图片:</td>
				<td><input name="info_img2" id="info_img2" type="file" />
				</td>
			</tr>
			<tr>
				<td>介绍图片3:</td>
				<td><img
					src="<%=toy == null ? "" : basePath + "/images/toy/"
					+ toy.getInfo_img3()%>"
					width="100" height="100" />
				</td>
			</tr>
			<tr>
				<td>选择图片:</td>
				<td><input name="info_img3" id="info_img3" type="file" />
				</td>
			</tr>
			<tr>
				<td>介绍图片4:</td>
				<td><img
					src="<%=toy == null ? "" : basePath + "/images/toy/"
					+ toy.getInfo_img4()%>"
					width="100" height="100" />
				</td>
			</tr>
			<tr>
				<td>选择图片:</td>
				<td><input name="info_img4" id="info_img4" type="file" />
				</td>
			</tr>
			<tr>
				<td>介绍图片5:</td>
				<td><img
					src="<%=toy == null ? "" : basePath + "/images/toy/"
					+ toy.getInfo_img5()%>"
					width="100" height="100" />
				</td>
			</tr>
			<tr>
				<td>选择图片:</td>
				<td><input name="info_img5" id="info_img5" type="file" />
				</td>
			</tr>
			<tr align="center">
				<td colspan="2"><input type="button" value="返回"
					onclick="window.history.go(<%=done == null ? -1 : -2%>);" /> <input
					type="button" value="提交" onclick="submit_form();" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>

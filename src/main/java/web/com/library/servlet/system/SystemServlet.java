package com.library.servlet.system;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.domain.User;
import com.library.hibernate.CompareExpression;
import com.library.hibernate.CompareType;
import com.library.hibernate.HibernateExpression;
import com.library.service.system.SystemService;
import com.library.servlet.BaseServlet;
import com.library.util.Constants;
import com.library.util.StringUtil;

public class SystemServlet extends BaseServlet {

	private SystemService systemService;

	public void setSystemService(SystemService systemService) {
		this.systemService = systemService;
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cmd = request.getParameter(Constants.CMD);
		if ("login".equals(cmd)) {
			login(request, response);
		} else if ("prepare_login".equals(cmd)) {
			prepare_login(request, response);
		} else if ("logout".equals(cmd)) {
			logout(request, response);
		} else if ("prepare_regist".equals(cmd)) {
			prepare_regist(request, response);
		} else if ("upd_user".equals(cmd)) {
			upd_user(request, response);
		} else if ("prepare_upd_user".equals(cmd)) {
			prepare_upd_user(request, response);
		} else if ("user_list".equals(cmd)) {
			user_list(request, response);
		} else if ("upd_user_config_num".equals(cmd)) {
			upd_user_config_num(request, response);
		}
	}

	private void upd_user_config_num(HttpServletRequest request,
			HttpServletResponse response) {
		String user_id = request.getParameter(Constants.USER_ID);
		String config_num = request.getParameter(Constants.CONFIG_NUM);
		systemService.updUserConfigNum(Long.valueOf(user_id), Integer.valueOf(config_num));
		
		user_list(request, response);
	}

	private void user_list(HttpServletRequest request,
			HttpServletResponse response) {
		Collection<HibernateExpression> ex = new ArrayList<HibernateExpression>();
		String pages = request.getParameter(Constants.PAGE);
		int page = pages == null ? 1 : Integer.valueOf(pages);
		String name = request.getParameter(Constants.NAME);
		String real_name = request.getParameter(Constants.REAL_NAME);
		String district = request.getParameter(Constants.DISTRICT);

		if (!StringUtil.isEmpty(name)) {
			ex.add(new CompareExpression("name", "%" + name + "%",
					CompareType.Like));
			request.setAttribute("name", name);
		}
		if (!StringUtil.isEmpty(district)) {
			ex.add(new CompareExpression("district", district,
					CompareType.Equal));
			request.setAttribute("district", district);
		}
		if (!StringUtil.isEmpty(real_name)) {
			ex.add(new CompareExpression("real_name", "%" + real_name + "%",
					CompareType.Like));
			request.setAttribute("real_name", real_name);
		}

		List<User> list = systemService.getUsers(page, Constants.PAGE_SIZE,
				"create_time", true, ex);
		request.setAttribute("list", list);

		request.setAttribute("page", page);
		long total = systemService.getUsersCount(ex);
		int total_pages = (int) (total / Constants.PAGE_SIZE);
		if (total % Constants.PAGE_SIZE > 0) {
			total_pages++;
		}
		request.setAttribute("total_pages", total_pages);

		direct(request, response, "/system/user_list.jsp");
	}

	private void prepare_upd_user(HttpServletRequest request,
			HttpServletResponse response) {
		String info = request.getParameter(Constants.INFO);
		User user = null;
		if (info != null) {
			request.setAttribute("info", info);
			String id = request.getParameter(Constants.ID);
			user = systemService.getUserById(Long.valueOf(id));
		} else {
			Long user_id = (Long) request.getSession().getAttribute("user_id");
			user = systemService.getUserById(user_id);
		}
		request.setAttribute("user", user);
		direct(request, response, "/system/user_new.jsp");
	}

	private void upd_user(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		String user_name = request.getParameter(Constants.NAME);
		String password = request.getParameter(Constants.PASSWORD);
		String real_name = request.getParameter(Constants.REAL_NAME);
		String mobile = request.getParameter(Constants.MOBILE);
		String district = request.getParameter(Constants.DISTRICT);
		String address = request.getParameter(Constants.ADDRESS);
		String des = request.getParameter(Constants.DES);

		User user = null;
		User tmp = null;
		if (id == null || "".equals(id) || "0".equals(id)) {
			// 新增用户
			tmp = systemService.getUserByName(user_name);
			user = new User();
		} else {
			// 更新用户
			user = systemService.getUserById(Long.valueOf(id));
		}
		user.setDistrict(district);
		user.setAddress(address);
		user.setDes(des == null ? "" : des);
		user.setMobile(mobile);
		user.setName(user_name);
		user.setPassword(password);
		user.setReal_name(real_name);

		if (id == null || "".equals(id) || "0".equals(id)) {
			if (tmp != null) {
				// 用户已存在
				request.setAttribute("err", "用户名已存在!");
				request.setAttribute("user", user);
				direct(request, response, "/system/user_new.jsp");
				return;
			} else {
				user.setRole_id(1);
				long user_id = systemService.addUser(user);

				request.getSession().setAttribute("user_id", user_id);
				request.getSession().setAttribute("user_name", user.getName());
				request.getSession().setAttribute("role_id", user.getRole_id());
			}
		} else {
			systemService.updUser(user);
		}

		direct(request, response, "/api?servlet=book&cmd=list");
	}

	private void prepare_regist(HttpServletRequest request,
			HttpServletResponse response) {
		direct(request, response, "/system/user_new.jsp");
	}

	private void logout(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().removeAttribute("user_name");
		request.getSession().removeAttribute("role_id");
		direct(request, response, "/api?servlet=book&cmd=list");
	}

	private void prepare_login(HttpServletRequest request,
			HttpServletResponse response) {
		direct(request, response, "/system/login.jsp");
	}

	private void login(HttpServletRequest request, HttpServletResponse response) {
		String name = request.getParameter(Constants.NAME);
		String password = request.getParameter(Constants.PASSWORD);
		User user = systemService.getUserByName(name);
		if (user != null && password.equals(user.getPassword())) {
			request.getSession().setAttribute("user_id", user.getId());
			request.getSession().setAttribute("user_name", user.getName());
			request.getSession().setAttribute("role_id", user.getRole_id());
			request.removeAttribute("err");
			String refer = request.getHeader("Referer");
			if (refer.indexOf("logout") > -1) {
				direct(request, response, "/api?servlet=book&cmd=list");
				return;
			} else if (refer.indexOf("err") > -1) {
				int begin = refer.indexOf("&err");
				int end = refer.indexOf("&", begin + 3);
				if (end == -1) {
					refer = refer.substring(0, begin);
				} else {
					refer = refer.substring(0, begin) + refer.substring(end);
				}
			}
			try {
				response.sendRedirect(refer);
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			try {
				response.sendRedirect(request.getHeader("Referer") + "&err="
						+ URLEncoder.encode("用户名或密码错误!", "UTF-8"));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}

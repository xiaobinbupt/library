package com.library.servlet.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.library.domain.Order;
import com.library.domain.Toy;
import com.library.domain.User;
import com.library.hibernate.CompareExpression;
import com.library.hibernate.CompareType;
import com.library.hibernate.HibernateExpression;
import com.library.hibernate.InExpression;
import com.library.service.order.OrderService;
import com.library.service.system.SystemService;
import com.library.service.toy.ToyService;
import com.library.servlet.BaseServlet;
import com.library.util.Constants;
import com.library.util.StringUtil;

public class OrderServlet extends BaseServlet {

	private OrderService orderService;

	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

	private SystemService systemService;

	public void setSystemService(SystemService systemService) {
		this.systemService = systemService;
	}

	private ToyService toyService;

	public void setToyService(ToyService toyService) {
		this.toyService = toyService;
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cmd = request.getParameter(Constants.CMD);
		if ("list".equals(cmd)) {
			list(request, response);
		} else if ("prepare_add".equals(cmd)) {
			prepare_add(request, response);
		} else if ("prepare_upd".equals(cmd)) {
			prepare_upd(request, response);
		} else if ("upd".equals(cmd)) {
			upd(request, response);
		} else if ("del".equals(cmd)) {
			del(request, response);
		} else if ("upd_status".equals(cmd)) {
			upd_status(request, response);
		} else if ("get_toy_order".equals(cmd)) {
			get_toy_order(request, response);
		}
	}

	private void get_toy_order(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String toy_id = request.getParameter(Constants.TOY_ID);
		StringBuffer sb = new StringBuffer();
		if (StringUtil.isNumber(toy_id)) {
			Collection<HibernateExpression> ex = new ArrayList<HibernateExpression>();

			// 排除未完成的订单
			ex.add(new CompareExpression("status", Order.STATUS_DONE,
					CompareType.NotEqual));
			ex.add(new CompareExpression("toy_id", Long.valueOf(toy_id),
					CompareType.Equal));

			List<Order> list = orderService.getOrders(1, Integer.MAX_VALUE,
					"num", false, ex);
			if (list != null && list.size() > 0) {
				for (Order b : list) {
					User u = systemService.getUserById(b.getUser_id());
					sb.append(
							(u.getReal_name() == null ? b.getUser_id() : u
									.getReal_name())).append(":")
							.append(b.getNum()).append("\n");
				}
			}
		}
		JSONArray ret = new JSONArray();
		JSONObject j = new JSONObject();
		if (sb.length() == 0) {
			j.put("orders", "无");
		} else {
			j.put("orders", sb.toString());
		}
		ret.add(j);
		PrintWriter out = response.getWriter();
		out.print(ret.toJSONString());
		out.flush();
		out.close();
	}

	@SuppressWarnings("unchecked")
	private void get_user_remain_stock(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int max_num = Constants.MAX_NUM;
		String user_id_p = request.getParameter(Constants.USER_ID);
		if (StringUtil.isNumber(user_id_p)) {
			long user_id = Long.valueOf(user_id_p);
			if (user_id > 10) {// 不包括管理员
				User u = systemService.getUserById(user_id);
				if (u != null) {
					max_num = u.getConfig_num();
					// 只算新建的订单
					List<Order> list = getOrderList(user_id, null, 1, "0",
							null, null, "0");
					if (list != null && list.size() > 0) {
						for (Order order : list) {
							max_num -= order.getNum();
						}
					}
					if (max_num < 0) {
						max_num = 0;
					}
				} else {
					max_num = 0;
				}
			}
		}
		JSONArray ret = new JSONArray();
		JSONObject j = new JSONObject();
		j.put("remain_stock", max_num);
		ret.add(j);
		PrintWriter out = response.getWriter();
		out.print(ret.toJSONString());
		out.flush();
		out.close();
	}

	private void upd(HttpServletRequest request, HttpServletResponse response) {
		long user_id = (Long) request.getSession().getAttribute("user_id");
		String id = request.getParameter(Constants.ID);
		String toy_id = request.getParameter(Constants.TOY_ID);
		String num = request.getParameter(Constants.NUM);
		String status = request.getParameter(Constants.STATUS);
		String des = request.getParameter(Constants.DES);

		Order order = null;
		int old_num = 0;
		if (id == null || "".equals(id)) {
			order = new Order();
			order.setUser_id(user_id);
			order.setToy_id(Long.valueOf(toy_id));
			order.setCreate_time(new Date());
		} else {
			order = orderService.getOrderById(Long.valueOf(id));
			old_num = order.getNum();
		}
		if (status != null) {
			order.setStatus(Integer.valueOf(status));
		} else {
			order.setStatus(0);
		}
		order.setNum(Integer.valueOf(num));
		order.setDes(des);

		if (id == null || "".equals(id)) {
			orderService.addOrder(order);
			// 减少库存
			toyService.updToyStock(order.getToy_id(), -order.getNum());
		} else {
			orderService.updOrder(order);

			if (Integer.valueOf(num) != old_num) {
				// 数量变更，更新库存
				toyService.updToyStock(order.getToy_id(),
						old_num - order.getNum());
			}
		}

		list(request, response);
	}

	private void upd_status(HttpServletRequest request,
			HttpServletResponse response) {
		String ids = request.getParameter(Constants.IDS);
		String status = request.getParameter(Constants.UPD_STATUS);

		if (status != null) {
			String[] id_array = ids.split(",");
			for (String id : id_array) {
				if (id != null && !"".equals(id)) {
					Order order = orderService.getOrderById(Long.valueOf(id));
					if (("" + order.STATUS_DONE).equals(status)
							&& order.getStatus() == order.STATUS_CONFIRM) {
						// 只有确认的订单才能结束
						order.setStatus(order.STATUS_DONE);
					} else if (("" + order.STATUS_CONFIRM).equals(status)
							&& order.getStatus() == order.STATUS_NEW) {
						// 只有新建订单才能确认
						order.setStatus(order.STATUS_CONFIRM);
					}
					orderService.updOrder(order);
				}
			}
		}
		list(request, response);
	}

	private void prepare_upd(HttpServletRequest request,
			HttpServletResponse response) {
		int role_id = (Integer) request.getSession().getAttribute("role_id");
		String info = request.getParameter(Constants.INFO);
		if (info != null) {
			request.setAttribute("info", info);
		}
		String id = request.getParameter(Constants.ID);
		Order order = orderService.getOrderById(Long.valueOf(id));
		Toy toy = toyService.getById(order.getToy_id());
		request.setAttribute("order", order);
		request.setAttribute("toy", toy);

		if (role_id != 2) {
			direct(request, response, "/order/order.jsp");
		} else {
			direct(request, response, "/order/order_admin.jsp");
		}
	}

	private List<Order> getOrderList(long user_id, String user_id_p,
			int role_id, String page, String district, String real_name,
			String status) {
		Collection<HibernateExpression> ex = new ArrayList<HibernateExpression>();
		if (role_id != 2) {
			ex.add(new CompareExpression("user_id", user_id, CompareType.Equal));
		}
		if (StringUtil.isNumber(user_id_p)) {
			ex.add(new CompareExpression("user_id", Long.valueOf(user_id_p),
					CompareType.Equal));
		}

		if (!StringUtil.isEmpty(district) || !StringUtil.isEmpty(real_name)) {
			Collection<HibernateExpression> ex_user = new ArrayList<HibernateExpression>();
			List<Long> uids = new ArrayList<Long>();
			if (!StringUtil.isEmpty(district)) {
				ex_user.add(new CompareExpression("district", district,
						CompareType.Equal));
			}
			if (!StringUtil.isEmpty(real_name)) {
				ex_user.add(new CompareExpression("real_name", "%" + real_name
						+ "%", CompareType.Like));
			}
			List<User> ul = systemService.getUsers(0, 0, null, true, ex_user);
			if (ul == null || ul.size() == 0) {
				return null;
			}
			for (User u : ul) {
				uids.add(u.getId());
			}
			ex.add(new InExpression("user_id", uids));
		}
		if (status != null && !"".equals(status)) {
			ex.add(new CompareExpression("status", Integer.valueOf(status),
					CompareType.Equal));
		} else {
			// 默认不显示已完成状态的订单
			ex.add(new CompareExpression("status", Order.STATUS_DONE,
					CompareType.NotEqual));
		}

		List<Order> list = orderService.getOrders(
				page == null ? 1 : Integer.valueOf(page), Constants.PAGE_SIZE,
				"create_time", false, ex);
		return list;
	}

	private long getOrderCount(long user_id, String user_id_p, int role_id,
			String district, String real_name, String status) {
		Collection<HibernateExpression> ex = new ArrayList<HibernateExpression>();
		if (role_id != 2) {
			ex.add(new CompareExpression("user_id", user_id, CompareType.Equal));
		}
		if (StringUtil.isNumber(user_id_p)) {
			ex.add(new CompareExpression("user_id", Long.valueOf(user_id_p),
					CompareType.Equal));
		}
		if (!StringUtil.isEmpty(district) || !StringUtil.isEmpty(real_name)) {
			Collection<HibernateExpression> ex_user = new ArrayList<HibernateExpression>();
			List<Long> uids = new ArrayList<Long>();
			if (!StringUtil.isEmpty(district)) {
				ex_user.add(new CompareExpression("district", district,
						CompareType.Equal));
			}
			if (!StringUtil.isEmpty(real_name)) {
				ex_user.add(new CompareExpression("real_name", "%" + real_name
						+ "%", CompareType.Like));
			}
			List<User> ul = systemService.getUsers(0, 0, null, true, ex_user);
			if (ul == null || ul.size() == 0) {
				return 0;
			}
			for (User u : ul) {
				uids.add(u.getId());
			}
			ex.add(new InExpression("user_id", uids));
		}
		if (status != null && !"".equals(status)) {
			ex.add(new CompareExpression("status", Integer.valueOf(status),
					CompareType.Equal));
		} else {
			// 默认不显示已完成状态的订单
			ex.add(new CompareExpression("status", Order.STATUS_DONE,
					CompareType.NotEqual));
		}

		long total = orderService.getOrdersCount(ex);
		return total;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	private void list(HttpServletRequest request, HttpServletResponse response) {
		int role_id = (Integer) request.getSession().getAttribute("role_id");
		String page = request.getParameter(Constants.PAGE);
		String real_name = request.getParameter(Constants.REAL_NAME);
		String district = request.getParameter(Constants.DISTRICT);
		String status = request.getParameter(Constants.STATUS);
		long user_id = (Long) request.getSession().getAttribute("user_id");
		String user_id_p = request.getParameter(Constants.USER_ID);

		List<Order> list = getOrderList(user_id, user_id_p, role_id, page,
				district, real_name, status);
		long total = 0;
		if (list != null && list.size() > 0) {
			total = getOrderCount(user_id, user_id_p, role_id, district,
					real_name, status);
		}

		if (district != null && !"".equals(district)) {
			request.setAttribute("district", district);
		}
		if (real_name != null && !"".equals(real_name)) {
			request.setAttribute("real_name", real_name);
		}
		if (status != null && !"".equals(status)) {
			request.setAttribute("status", status);
		}
		request.setAttribute("page", page == null ? 1 : Integer.valueOf(page));
		int total_pages = (int) (total / Constants.PAGE_SIZE);
		if (total % Constants.PAGE_SIZE > 0) {
			total_pages++;
		}
		request.setAttribute("total_pages", total_pages);
		if (list != null && list.size() > 0) {
			Iterator<Order> it = list.iterator();
			while (it.hasNext()) {
				Order order = it.next();
				Toy toy = toyService.getById(order.getToy_id());
				if (toy == null) {
					orderService.delOrder(order.getId());
					it.remove();
					continue;
				}
				order.setToy(toy);
				User user = systemService.getUserById(order.getUser_id());
				if (user == null) {
					orderService.delOrder(order.getId());
					it.remove();
					continue;
				}
				order.setUser(user);
			}
		}
		if (list == null) {
			list = new ArrayList<Order>();
		}

		// 按用户名排序
		Collections.sort(list, new Comparator() {

			@Override
			public int compare(Object o1, Object o2) {
				return ((Order) o1).getUser().getName()
						.compareTo(((Order) o2).getUser().getName());
			}
		});

		request.setAttribute("list", list);
		if (role_id != 2) {
			direct(request, response, "/order/list.jsp");
		} else {
			direct(request, response, "/order/list_admin.jsp");
		}
	}

	private void del(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		Order order = orderService.getOrderById(Long.valueOf(id));
		if (order.getStatus() == 0) {
			// 订单取消，增加库存
			toyService.updToyStock(order.getToy_id(), order.getNum());
		}

		orderService.delOrder(Long.valueOf(id));
		list(request, response);
	}

	private void prepare_add(HttpServletRequest request,
			HttpServletResponse response) {
		String err = request.getParameter(Constants.ERR);
		if (err != null) {
			request.setAttribute("err", err);
		}

		String id = request.getParameter(Constants.ID);
		Toy toy = toyService.getById(Long.valueOf(id));
		request.setAttribute("toy", toy);

		direct(request, response, "/order/order.jsp");
	}

}

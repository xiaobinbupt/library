package com.library.servlet.borrow;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.library.domain.Book;
import com.library.domain.Borrow;
import com.library.domain.User;
import com.library.hibernate.CompareExpression;
import com.library.hibernate.CompareType;
import com.library.hibernate.HibernateExpression;
import com.library.hibernate.InExpression;
import com.library.service.book.BookService;
import com.library.service.borrow.BorrowService;
import com.library.service.system.SystemService;
import com.library.servlet.BaseServlet;
import com.library.util.Constants;
import com.library.util.StringUtil;

public class BorrowServlet extends BaseServlet {

	private BorrowService borrowService;

	public void setBorrowService(BorrowService borrowService) {
		this.borrowService = borrowService;
	}

	private BookService bookService;

	public void setBookService(BookService bookService) {
		this.bookService = bookService;
	}

	private SystemService systemService;

	public void setSystemService(SystemService systemService) {
		this.systemService = systemService;
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
		} else if ("get_user_remain_stock".equals(cmd)) {
			get_user_remain_stock(request, response);
		}
	}

	@SuppressWarnings("unchecked")
	private void get_user_remain_stock(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		int max_num = Constants.MAX_NUM;
		String user_id_p = request.getParameter(Constants.USER_ID);
		if (StringUtil.isNumber(user_id_p)) {
			long user_id = Long.valueOf(user_id_p);
			if (user_id > 10) {// 不包括管理员
				// 只算新建的订单
				List<Borrow> list = getBorrowList(user_id, null, 1, "0", null,
						null, "0");
				if (list != null && list.size() > 0) {
					for (Borrow borrow : list) {
						max_num -= borrow.getNum();
					}
				}
				if (max_num < 0) {
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
		String book_id = request.getParameter(Constants.BOOK_ID);
		String num = request.getParameter(Constants.NUM);
		// String begin = request.getParameter(Constants.BEGIN);
		// String end = request.getParameter(Constants.END);
		String des = request.getParameter(Constants.DES);
		String status = request.getParameter(Constants.STATUS);

		Borrow borrow = null;
		int old_num = 0;
		if (id == null || "".equals(id)) {
			// 新增
			borrow = borrowService.getBorrowByUserIdBookId(
					Long.valueOf(user_id), Long.valueOf(book_id));
			if (borrow != null) {
				// 重复提交
				list(request, response);
				return;
			}

			borrow = new Borrow();
			borrow.setUser_id(user_id);
			borrow.setBook_id(Long.valueOf(book_id));
			borrow.setCreate_time(new Date());
		} else {
			borrow = borrowService.getBorrowById(Long.valueOf(id));
			old_num = borrow.getNum();
		}
		// borrow.setBegin(begin);
		// borrow.setEnd(end);
		if (status != null) {
			borrow.setStatus(Integer.valueOf(status));
		} else {
			borrow.setStatus(0);
		}
		if (des != null) {
			borrow.setDes(des);
		}
		borrow.setNum(Integer.valueOf(num));

		if (id == null || "".equals(id)) {
			borrowService.addBorrow(borrow);
			// 减少库存
			bookService.updBookStock(borrow.getBook_id(), -borrow.getNum());
		} else {
			borrowService.updBorrow(borrow);

			if (Integer.valueOf(num) != old_num) {
				// 数量变更，更新库存
				bookService.updBookStock(borrow.getBook_id(),
						old_num - borrow.getNum());
			}
			if ("3".equals(status)) {
				// 已归还，增加库存
				bookService.updBookStock(borrow.getBook_id(), borrow.getNum());
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
					Borrow borrow = borrowService.getBorrowById(Long
							.valueOf(id));
					if ("2".equals(status) && borrow.getStatus() < 2) {
						borrow.setStatus(2);
					} else if ("3".equals(status) && borrow.getStatus() == 2) {
						// 只有已借出的才能还书
						borrow.setStatus(3);
						// 增加库存
						bookService.updBookStock(borrow.getBook_id(),
								borrow.getNum());
					}
					borrowService.updBorrow(borrow);
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
		Borrow borrow = borrowService.getBorrowById(Long.valueOf(id));
		Book book = bookService.getById(borrow.getBook_id());
		request.setAttribute("borrow", borrow);
		request.setAttribute("book", book);

		int max_num = Constants.MAX_NUM;
		long user_id = (Long) request.getSession().getAttribute("user_id");
		List<Borrow> list = getBorrowList(user_id, null, 1, "0", null, null,
				null);
		if (list != null && list.size() > 0) {
			for (Borrow b : list) {
				if (b.getId() != borrow.getId()) {
					max_num -= b.getNum();
				}
			}
		}
		if (max_num < 0) {
			max_num = 0;
		} else if (max_num > book.getStock() + borrow.getNum()) {
			max_num = book.getStock() + borrow.getNum();
		}
		request.setAttribute("max_num", max_num);

		if (role_id != 2) {
			List<String> ages = bookService.getAges();
			request.setAttribute("ages", ages);
			List<String> pubs = bookService.getPubs();
			request.setAttribute("pubs", pubs);
			List<String> authors = bookService.getAuthors();
			request.setAttribute("authors", authors);
			direct(request, response, "/borrow/borrow_new.jsp");
		} else {
			direct(request, response, "/borrow/borrow.jsp");
		}
	}

	private List<Borrow> getBorrowList(long user_id, String user_id_p,
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
		}

		List<Borrow> list = borrowService.getBorrows(
				page == null ? 1 : Integer.valueOf(page), Constants.PAGE_SIZE,
				"create_time", false, ex);
		return list;
	}

	private long getBorrowCount(long user_id, String user_id_p, int role_id,
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
		}

		long total = borrowService.getBorrowsCount(ex);
		return total;
	}

	private void list(HttpServletRequest request, HttpServletResponse response) {
		int role_id = (Integer) request.getSession().getAttribute("role_id");
		String page = request.getParameter(Constants.PAGE);
		String real_name = request.getParameter(Constants.REAL_NAME);
		String district = request.getParameter(Constants.DISTRICT);
		String status = request.getParameter(Constants.STATUS);
		long user_id = (Long) request.getSession().getAttribute("user_id");
		String user_id_p = request.getParameter(Constants.USER_ID);

		List<Borrow> list = getBorrowList(user_id, user_id_p, role_id, page,
				district, real_name, status);
		long total = 0;
		if (list != null && list.size() > 0) {
			total = getBorrowCount(user_id, user_id_p, role_id, district,
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
			Iterator<Borrow> it = list.iterator();
			while (it.hasNext()) {
				Borrow borrow = it.next();
				Book book = bookService.getById(borrow.getBook_id());
				if (book == null) {
					borrowService.delBorrow(borrow.getId());
					it.remove();
					continue;
				}
				borrow.setBook_name(book.getName());
				borrow.setBook_img(book.getImg());
				borrow.setIsdn(book.getIsdn());
				User user = systemService.getUserById(borrow.getUser_id());
				if (user == null) {
					borrowService.delBorrow(borrow.getId());
					it.remove();
					continue;
				}
				borrow.setUser_name(user.getName());
				borrow.setReal_name(user.getReal_name());
			}
		}
		if (list == null) {
			list = new ArrayList<Borrow>();
		}
		request.setAttribute("list", list);
		if (role_id != 2) {
			List<String> ages = bookService.getAges();
			request.setAttribute("ages", ages);
			List<String> pubs = bookService.getPubs();
			request.setAttribute("pubs", pubs);
			List<String> authors = bookService.getAuthors();
			request.setAttribute("authors", authors);
			direct(request, response, "/borrow/list_customer.jsp");
		} else {
			direct(request, response, "/borrow/list.jsp");
		}
	}

	private void del(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		Borrow borrow = borrowService.getBorrowById(Long.valueOf(id));
		if (borrow.getStatus() == 0) {
			// 订单取消，增加库存
			bookService.updBookStock(borrow.getBook_id(), borrow.getNum());
		}

		borrowService.delBorrow(Long.valueOf(id));
		list(request, response);
	}

	private void prepare_add(HttpServletRequest request,
			HttpServletResponse response) {
		String err = request.getParameter(Constants.ERR);
		if (err != null) {
			request.setAttribute("err", err);
		}

		String id = request.getParameter(Constants.ID);
		Book book = bookService.getById(Long.valueOf(id));
		request.setAttribute("book", book);

		int max_num = Constants.MAX_NUM;
		long user_id = (Long) request.getSession().getAttribute("user_id");
		if (user_id > 10) {//不算管理员
			// 只算新建的订单
			List<Borrow> list = getBorrowList(user_id, null, 1, "0", null,
					null, "0");
			if (list != null && list.size() > 0) {
				for (Borrow borrow : list) {
					max_num -= borrow.getNum();
				}
			}
		}
		if (max_num < 0) {
			max_num = 0;
		} else if (max_num > book.getStock()) {
			max_num = book.getStock();
		}
		request.setAttribute("max_num", max_num);

		List<String> ages = bookService.getAges();
		request.setAttribute("ages", ages);
		List<String> pubs = bookService.getPubs();
		request.setAttribute("pubs", pubs);
		List<String> authors = bookService.getAuthors();
		request.setAttribute("authors", authors);
		direct(request, response, "/borrow/borrow_new.jsp");
	}

}

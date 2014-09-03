package com.library.servlet.feedback;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.domain.Book;
import com.library.domain.FeedBack;
import com.library.domain.User;
import com.library.hibernate.CompareExpression;
import com.library.hibernate.CompareType;
import com.library.hibernate.HibernateExpression;
import com.library.service.book.BookService;
import com.library.service.feedback.FeedBackService;
import com.library.service.system.SystemService;
import com.library.servlet.BaseServlet;
import com.library.util.Constants;
import com.library.util.StringUtil;

public class FeedBackServlet extends BaseServlet {

	private SystemService systemService;

	public void setSystemService(SystemService systemService) {
		this.systemService = systemService;
	}

	private BookService bookService;

	public void setBookService(BookService bookService) {
		this.bookService = bookService;
	}

	private FeedBackService feedBackService;

	public void setFeedBackService(FeedBackService feedBackService) {
		this.feedBackService = feedBackService;
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cmd = request.getParameter(Constants.CMD);
		if ("list".equals(cmd)) {
			list(request, response);
		} else if ("add".equals(cmd)) {
			add(request, response);
		} else if ("del".equals(cmd)) {
			del(request, response);
		}
	}

	private void del(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		try {
			feedBackService.delById(Long.valueOf(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		list(request, response);
	}

	private void add(HttpServletRequest request, HttpServletResponse response) {
		String content = request.getParameter(Constants.CONTENT);
		content = content.replaceAll("\r\n", "<br>");
		content = content.replaceAll(" ", "&nbsp;");
		Long user_id = (Long) request.getSession().getAttribute("user_id");
		FeedBack f = new FeedBack();
		f.setContent(content);
		f.setCreate_time(new Date());
		f.setUser_id(user_id == null ? 0 : user_id.longValue());
		feedBackService.add(f);

		list(request, response);
	}

	private void list(HttpServletRequest request, HttpServletResponse response) {
		String pages = request.getParameter(Constants.PAGE);
		int page = pages == null ? 1 : Integer.valueOf(pages);

		List<FeedBack> list = feedBackService.getFeedBacks(page);
		if (list != null && list.size() > 0) {
			for (FeedBack f : list) {
				if (f.getUser_id() > 0) {
					User u = systemService.getUserById(f.getUser_id());
					f.setUser_name(u.getName());
				} else {
					f.setUser_name("游客");
				}
			}
		}
		request.setAttribute("list", list);

		request.setAttribute("page", page);
		long total = feedBackService.getFeedBackCount();
		int total_pages = (int) (total / Constants.PAGE_SIZE_10);
		if (total % Constants.PAGE_SIZE > 0) {
			total_pages++;
		}
		request.setAttribute("total_pages", total_pages);

		List<String> ages = bookService.getAges();
		request.setAttribute("ages", ages);
		List<String> pubs = bookService.getPubs();
		request.setAttribute("pubs", pubs);
		List<String> authors = bookService.getAuthors();
		request.setAttribute("authors", authors);

		direct(request, response, "/feedback/list.jsp");
	}
}

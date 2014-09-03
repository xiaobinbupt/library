package com.library.servlet.book;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.library.domain.Book;
import com.library.domain.FeedBack;
import com.library.domain.FeedBackBook;
import com.library.domain.User;
import com.library.hibernate.CompareExpression;
import com.library.hibernate.CompareType;
import com.library.hibernate.HibernateExpression;
import com.library.service.book.BookService;
import com.library.service.system.SystemService;
import com.library.servlet.BaseServlet;
import com.library.util.Constants;
import com.library.util.StringUtil;

public class BookServlet extends BaseServlet {

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
		} else if ("prepare_upd_img".equals(cmd)) {
			prepare_upd_img(request, response);
		} else if ("upd_img".equals(cmd)) {
			upd_img(request, response);
		} else if ("del".equals(cmd)) {
			del(request, response);
		} else if ("info_customer".equals(cmd)) {
			info_customer(request, response);
		} else if ("add_feedback".equals(cmd)) {
			add_feedback(request, response);
		} else if ("del_feedback".equals(cmd)) {
			del_feedback(request, response);
		}
	}

	private void del_feedback(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		try {
			bookService.delFeedBackById(Long.valueOf(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		info_customer(request, response);
	}

	private void add_feedback(HttpServletRequest request,
			HttpServletResponse response) {
		String content = request.getParameter(Constants.CONTENT);
		String book_id = request.getParameter(Constants.BOOK_ID);
		content = content.replaceAll("\r\n", "<br>");
		content = content.replaceAll(" ", "&nbsp;");
		Long user_id = (Long) request.getSession().getAttribute("user_id");
		FeedBackBook f = new FeedBackBook();
		f.setBook_id(Long.valueOf(book_id));
		f.setContent(content);
		f.setCreate_time(new Date());
		f.setUser_id(user_id == null ? 0 : user_id.longValue());
		bookService.addFeedBack(f);

		info_customer(request, response);
	}

	private void info_customer(HttpServletRequest request,
			HttpServletResponse response) {
		String err = request.getParameter(Constants.ERR);
		if (err != null) {
			request.setAttribute("err", err);
		}
		String book_id = request.getParameter(Constants.BOOK_ID);
		Book book = bookService.getById(Long.valueOf(book_id));
		String des = book.getDes().replaceAll("\r\n", "<br>")
				.replaceAll(" ", "&nbsp;");
		book.setDes(des);
		request.setAttribute("book", book);
		List<FeedBackBook> list = bookService.getFeedBacks(Long
				.valueOf(book_id));
		if (list != null && list.size() > 0) {
			for (FeedBackBook f : list) {
				if (f.getUser_id() > 0) {
					User u = systemService.getUserById(f.getUser_id());
					f.setUser_name(u.getName());
				} else {
					f.setUser_name("游客");
				}
			}
		}
		request.setAttribute("list", list);
		List<String> ages = bookService.getAges();
		request.setAttribute("ages", ages);
		List<String> pubs = bookService.getPubs();
		request.setAttribute("pubs", pubs);
		List<String> authors = bookService.getAuthors();
		request.setAttribute("authors", authors);
		direct(request, response, "/book/info_customer.jsp");
	}

	private void del(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		bookService.delBook(Long.valueOf(id));
		list(request, response);
	}

	private void prepare_upd(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		Book book = bookService.getById(Long.valueOf(id));
		request.setAttribute("book", book);
		direct(request, response, "/book/book.jsp");
	}

	private void prepare_upd_img(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		Book book = bookService.getById(Long.valueOf(id));
		request.setAttribute("book", book);
		direct(request, response, "/book/book_img.jsp");
	}

	@SuppressWarnings("rawtypes")
	private void upd_img(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		Book book = bookService.getById(Long.valueOf(id));
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List list = upload.parseRequest(request);
			Iterator items = list.iterator();
			while (items.hasNext()) {
				FileItem item = (FileItem) items.next();
				if (!item.isFormField()) {
					long size = item.getSize();
					if (size <= 0) {
						continue;
					}
					String name = item.getFieldName();
					// 上传原文件
					String file_name = item.getName();
					String type = file_name.substring(file_name
							.lastIndexOf('.'));
					String img_name = id + "_" + name + "_"
							+ System.currentTimeMillis() + type;
					File uploadedFile = new File(Constants.UPLOAD_IMG_IDR
							+ img_name);
					if (!uploadedFile.getParentFile().exists()) {
						uploadedFile.getParentFile().mkdirs();
					}
					if (!uploadedFile.exists()) {
						uploadedFile.createNewFile();
					}
					item.write(uploadedFile);

					if ("img".equals(name)) {
						book.setImg(img_name);
					} else if ("info_img1".equals(name)) {
						book.setInfo_img1(img_name);
					} else if ("info_img2".equals(name)) {
						book.setInfo_img2(img_name);
					} else if ("info_img3".equals(name)) {
						book.setInfo_img3(img_name);
					}
				}
			}
			bookService.updBook(book);

			request.setAttribute("book", book);
			request.setAttribute("done", "down");
			direct(request, response, "/book/book_img.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void upd(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		String name = request.getParameter(Constants.NAME);
		String isdn = request.getParameter(Constants.ISDN);
		String author = request.getParameter(Constants.AUTHOR);
		String type = request.getParameter(Constants.TYPE);
		String age = request.getParameter(Constants.AGE);
		String pub = request.getParameter(Constants.PUB);
		String des = request.getParameter(Constants.DES);
		String stock = request.getParameter(Constants.STOCK);
		String num = request.getParameter(Constants.NUM);

		Book book = null;
		if (id == null || "".equals(id)) {
			// 新增
			book = new Book();
		} else {
			book = bookService.getById(Long.valueOf(id));
		}
		book.setAge(age);
		book.setAuthor(author);
		book.setDes(des);
		book.setIsdn(isdn);
		book.setName(name);
		book.setPub(pub);
		book.setStock(Integer.valueOf(stock));
		book.setType(type);
		book.setNum(Integer.valueOf(num));

		if (id == null || "".equals(id)) {
			bookService.addBook(book);
		} else {
			bookService.updBook(book);
		}

		list(request, response);
	}

	private void prepare_add(HttpServletRequest request,
			HttpServletResponse response) {
		direct(request, response, "/book/book.jsp");
	}

	private void list(HttpServletRequest request, HttpServletResponse response) {
		String err = request.getParameter(Constants.ERR);
		if (err != null) {
			request.setAttribute("err", err);
		}
		Collection<HibernateExpression> ex = new ArrayList<HibernateExpression>();
		String search = request.getParameter(Constants.SEARCH);
		String pages = request.getParameter(Constants.PAGE);
		int page = pages == null ? 1 : Integer.valueOf(pages);
		if (search != null) {
			String name = request.getParameter(Constants.NAME);
			String author = request.getParameter(Constants.AUTHOR);
			String age = request.getParameter(Constants.AGE);
			String pub = request.getParameter(Constants.PUB);

			if (!StringUtil.isEmpty(name)) {
				ex.add(new CompareExpression("name", "%" + name + "%",
						CompareType.Like));
				request.setAttribute("name", name);
			}
			if (!StringUtil.isEmpty(author)) {
				ex.add(new CompareExpression("author", "%" + author + "%",
						CompareType.Like));
				request.setAttribute("author", author);
			}
			if (!StringUtil.isEmpty(age)) {
				ex.add(new CompareExpression("age", age, CompareType.Equal));
				request.setAttribute("age", age);
			}
			if (!StringUtil.isEmpty(pub)) {
				ex.add(new CompareExpression("pub", "%" + pub + "%",
						CompareType.Like));
				request.setAttribute("pub", pub);
			}
		}

		List<Book> list = bookService.getBooks(page, Constants.PAGE_SIZE,
				"isdn", true, ex);
		request.setAttribute("list", list);

		request.setAttribute("page", page);
		long total = bookService.getBooksCount(ex);
		int total_pages = (int) (total / Constants.PAGE_SIZE);
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

		Integer role_id = (Integer) request.getSession()
				.getAttribute("role_id");
		if (role_id != null && role_id.intValue() == 2) {
			direct(request, response, "/book/list.jsp");
		} else {
			direct(request, response, "/book/list_customer.jsp");
		}
	}
}

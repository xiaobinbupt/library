
package com.library.servlet.book;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.library.domain.Book;
import com.library.domain.FeedBackBook;
import com.library.domain.NewBook;
import com.library.domain.User;
import com.library.service.system.SystemService;
import com.library.servlet.BaseServlet;
import com.library.util.Constants;
import com.library.util.StringUtil;

public class BookServlet extends BaseServlet {

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
		} else if ("new_book_list".equals(cmd)) {
			new_book_list(request, response);
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
		} else if ("add_to_new".equals(cmd)) {
			add_to_new(request, response);
		} else if ("del_new_book".equals(cmd)) {
			del_new_book(request, response);
		} else if ("new_book_list_admin".equals(cmd)) {
			new_book_list_admin(request, response);
		}
	}

	private void del_new_book(HttpServletRequest request,
			HttpServletResponse response) {
		String book_id = request.getParameter(Constants.ID);
		bookService.delNewBookByBookID(Long.valueOf(book_id));
		new_book_list_admin(request, response);
	}

	private void new_book_list_admin(HttpServletRequest request,
			HttpServletResponse response) {
		String pages = request.getParameter(Constants.PAGE);
		int page = pages == null ? 1 : Integer.valueOf(pages);

		List<Book> list = bookService.getNewBooks(page);
		request.setAttribute("list", list);

		request.setAttribute("page", page);
		long total = bookService.getNewBooksCount();
		int total_pages = (int) (total / Constants.PAGE_SIZE);
		if (total % Constants.PAGE_SIZE > 0) {
			total_pages++;
		}
		request.setAttribute("total_pages", total_pages);

		direct(request, response, "/book/new_book_list_admin.jsp");
	}

	@SuppressWarnings("unchecked")
	private void add_to_new(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String book_id = request.getParameter(Constants.ID);
		NewBook nb = bookService.getNewBookByBookID(Long.valueOf(book_id));
		if (nb == null) {
			nb = new NewBook();
			nb.setBook_id(Long.valueOf(book_id));
			bookService.addNewBook(nb);
		}
		JSONArray ret = new JSONArray();
		JSONObject j = new JSONObject();
		j.put("ok", 0);
		ret.add(j);
		PrintWriter out = response.getWriter();
		out.print(ret.toJSONString());
		out.flush();
		out.close();

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
					if(u != null){
						f.setUser_name(u.getName());
					}else{
						f.setUser_name("游客");
					}
				} else {
					f.setUser_name("游客");
				}
			}
		}
		request.setAttribute("list", list);
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
		String page = request.getParameter(Constants.PAGE);
		request.setAttribute("page", page);
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
		String category = request.getParameter(Constants.CATEGORY);
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
		book.setAge(age.trim());
		String[] ages = age.trim().split("-");
		book.setAge_begin(Integer.valueOf(ages[0].trim()));
		book.setAge_end(Integer.valueOf(ages[1].trim()));
		book.setAuthor(author.trim());
		book.setDes(des.trim());
		book.setIsdn(isdn.trim());
		book.setName(name.trim());
		book.setPub(pub.trim());
		book.setStock(Integer.valueOf(stock.trim()));
		book.setType(type.trim());
		book.setCategorys(category);
		book.setNum(Integer.valueOf(num.trim()));

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
		StringBuffer hql = new StringBuffer("from Book ");
		String search = request.getParameter(Constants.SEARCH);
		String pages = request.getParameter(Constants.PAGE);
		int page = pages == null ? 1 : Integer.valueOf(pages);
		if (search != null) {
			hql.append(" where");
			boolean and = false;
			String name = request.getParameter(Constants.NAME);
			String age_begin = request.getParameter(Constants.AGE_BEGIN);
			String age_end = request.getParameter(Constants.AGE_END);
			String category = request.getParameter(Constants.CATEGORY);
			if (!StringUtil.isEmpty(name)) {
				and = true;
				hql.append(" name like '%" + name + "%'");
				request.setAttribute("name", name);
			}

			if (!StringUtil.isEmpty(category)) {
				if (and) {
					hql.append(" and ");
				}
				hql.append(" categorys like '%," + category + ",%'");
				request.setAttribute("category", category);
				and = true;
			}

			if (StringUtil.isNumber(age_begin) || StringUtil.isNumber(age_end)) {
				if (and) {
					hql.append(" and ");
				}
				if (StringUtil.isNumber(age_begin)
						&& StringUtil.isNumber(age_end)) {
					hql.append(" ((").append(age_end)
							.append(" >= age_end and ").append(age_begin)
							.append(" <= age_end) or (").append(age_begin)
							.append(" <= age_begin and ").append(age_end)
							.append(" >= age_begin) or (").append(age_begin)
							.append(" >= age_begin and ").append(age_end)
							.append(" <= age_end))");
					request.setAttribute("age_begin", age_begin);
					request.setAttribute("age_end", age_end);
				} else if (StringUtil.isNumber(age_begin)) {
					request.setAttribute("age_begin", age_begin);
					hql.append(" age_end >= " + age_begin);
				} else if (StringUtil.isNumber(age_end)) {
					request.setAttribute("age_end", age_end);
					hql.append(" age_begin <= " + age_end);
				}
			}
		}
		if (hql.toString().endsWith("where")) {
			hql = hql.delete(hql.length() - 5, hql.length());
		}
		List<Book> list = bookService.getBooks(page, Constants.PAGE_SIZE, hql
				.append(" order by isdn ").toString());
		request.setAttribute("list", list);

		request.setAttribute("page", page);
		long total = bookService.getBooksCount(hql.toString());
		int total_pages = (int) (total / Constants.PAGE_SIZE);
		if (total % Constants.PAGE_SIZE > 0) {
			total_pages++;
		}
		request.setAttribute("total_pages", total_pages);

		Integer role_id = (Integer) request.getSession()
				.getAttribute("role_id");
		if (role_id != null && role_id.intValue() == 2) {
			direct(request, response, "/book/list.jsp");
		} else {
			direct(request, response, "/book/list_customer.jsp");
		}
	}

	private void new_book_list(HttpServletRequest request,
			HttpServletResponse response) {
		String err = request.getParameter(Constants.ERR);
		if (err != null) {
			request.setAttribute("err", err);
		}
		String pages = request.getParameter(Constants.PAGE);
		int page = pages == null ? 1 : Integer.valueOf(pages);

		List<Book> list = bookService.getNewBooks(page);
		request.setAttribute("list", list);

		request.setAttribute("page", page);
		long total = bookService.getNewBooksCount();
		int total_pages = (int) (total / Constants.PAGE_SIZE);
		if (total % Constants.PAGE_SIZE > 0) {
			total_pages++;
		}
		request.setAttribute("total_pages", total_pages);

		direct(request, response, "/book/new_book_list.jsp");
	}

	// private void list(HttpServletRequest request, HttpServletResponse
	// response) {
	// String err = request.getParameter(Constants.ERR);
	// if (err != null) {
	// request.setAttribute("err", err);
	// }
	// StringBuffer hql = new StringBuffer("from Book ");
	// Collection<HibernateExpression> ex = new
	// ArrayList<HibernateExpression>();
	// String search = request.getParameter(Constants.SEARCH);
	// String pages = request.getParameter(Constants.PAGE);
	// int page = pages == null ? 1 : Integer.valueOf(pages);
	// if (search != null) {
	// hql.append(" where ");
	// String name = request.getParameter(Constants.NAME);
	// String age_begin = request.getParameter(Constants.AGE_BEGIN);
	// String age_end = request.getParameter(Constants.AGE_END);
	// if (!StringUtil.isEmpty(name)) {
	// hql.append(" name like '%" + name + "%'" );
	// ex.add(new CompareExpression("name", "%" + name + "%",
	// CompareType.Like));
	// request.setAttribute("name", name);
	// }
	// if (StringUtil.isNumber(age_begin) && StringUtil.isNumber(age_end)) {
	// LogicalExpression t1 = new LogicalExpression(
	// new CompareExpression("age_begin",
	// Integer.valueOf(age_begin), CompareType.Le),
	// new CompareExpression("age_end", Integer
	// .valueOf(age_end), CompareType.Ge),
	// LogicalType.And);
	// LogicalExpression t2 = new LogicalExpression(
	// new CompareExpression("age_begin",
	// Integer.valueOf(age_begin), CompareType.Ge),
	// new CompareExpression("age_end", Integer
	// .valueOf(age_end), CompareType.Le),
	// LogicalType.And);
	// LogicalExpression t1 = new LogicalExpression(
	// new CompareExpression("age_begin",
	// Integer.valueOf(age_begin), CompareType.Ge),
	// new CompareExpression("age_end", Integer
	// .valueOf(age_end), CompareType.Ge),
	// LogicalType.And);
	// LogicalExpression t2 = new LogicalExpression(
	// new CompareExpression("age_begin",
	// Integer.valueOf(age_begin), CompareType.Ge),
	// new CompareExpression("age_end", Integer
	// .valueOf(age_end), CompareType.Le),
	// LogicalType.And);
	//
	//
	// request.setAttribute("age_begin", age_begin);
	// request.setAttribute("age_end", age_end);
	// } else if (StringUtil.isNumber(age_begin)) {
	// request.setAttribute("age_begin", age_begin);
	// ex.add(new CompareExpression("age_end", Integer
	// .valueOf(age_begin), CompareType.Ge));
	// } else if (StringUtil.isNumber(age_end)) {
	// request.setAttribute("age_end", age_end);
	// ex.add(new CompareExpression("age_begin", Integer
	// .valueOf(age_end), CompareType.Le));
	// }
	// }
	//
	// List<Book> list = bookService.getBooks(page, Constants.PAGE_SIZE,
	// "isdn", true, ex);
	// request.setAttribute("list", list);
	//
	// request.setAttribute("page", page);
	// long total = bookService.getBooksCount(ex);
	// int total_pages = (int) (total / Constants.PAGE_SIZE);
	// if (total % Constants.PAGE_SIZE > 0) {
	// total_pages++;
	// }
	// request.setAttribute("total_pages", total_pages);
	//
	// List<Category> categorys = bookService.getCategorys();
	// request.setAttribute("categorys", categorys);
	// // List<String> pubs = bookService.getPubs();
	// // request.setAttribute("pubs", pubs);
	// List<String> authors = bookService.getAuthors();
	// request.setAttribute("authors", authors);
	//
	// Integer role_id = (Integer) request.getSession()
	// .getAttribute("role_id");
	// if (role_id != null && role_id.intValue() == 2) {
	// direct(request, response, "/book/list.jsp");
	// } else {
	// direct(request, response, "/book/list_customer.jsp");
	// }
	// }
}

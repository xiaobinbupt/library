package com.library.service.book.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import net.sf.ehcache.Element;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import com.library.domain.Book;
import com.library.domain.FeedBack;
import com.library.domain.FeedBackBook;
import com.library.hibernate.HibernateExpression;
import com.library.hibernate.HibernateGenericController;
import com.library.service.book.BookService;
import com.library.util.CacheUtil;
import com.library.util.Constants;

public class BookServiceImpl implements BookService {

	private HibernateGenericController controller;

	public void setHibernateGenericController(
			HibernateGenericController controller) {
		this.controller = controller;
	}

	@Override
	public void addBook(Book book) {
		controller.save(book);
	}

	@Override
	public void updBook(Book book) {
		controller.update(book);
	}

	@Override
	public void updBookStock(long book_id, int num) {
		String hql = "update Book set stock = stock + " + num + " where id = "
				+ book_id;
		controller.executeUpdate(hql, new Object[] {});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Book> getBooks(int page, int page_size, String order_by,
			boolean insc, Collection<HibernateExpression> ex) {
		return controller.findBy(Book.class, page, page_size, order_by, insc,
				ex);
	}

	@Override
	public void delBook(long id) {
		controller.deleteById(Book.class, id);
	}

	@Override
	public Book getById(long id) {
		return controller.get(Book.class, id);
	}

	@SuppressWarnings({ "deprecation", "unchecked" })
	@Override
	public List<String> getAges() {
		String key = BookServiceImpl.class.getName() + ",getAges";
		Element em = CacheUtil.getCache().get(key);
		if (em != null) {
			return (List<String>) em.getValue();
		}

		String sql = "SELECT DISTINCT t.age FROM book t order by t.age";
		List<String> ret = new ArrayList<String>();
		Session session = null;
		Connection conn = null;
		ResultSet res = null;
		try {
			session = controller.getSessionFactory().openSession();
			conn = session.connection();
			res = conn.prepareStatement(sql).executeQuery();
			while (res.next()) {
				String age = res.getString("age");
				if (age != null && !"".equals(age)) {
					ret.add(age);
				}
			}
		} catch (HibernateException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (res != null)
					res.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			session.close();
		}

		em = new Element(key, ret);
		CacheUtil.getCache().put(em);

		return ret;
	}

	@SuppressWarnings({ "deprecation", "unchecked" })
	@Override
	public List<String> getPubs() {
		String key = BookServiceImpl.class.getName() + ",getPubs";
		Element em = CacheUtil.getCache().get(key);
		if (em != null) {
			return (List<String>) em.getValue();
		}

		String sql = "SELECT t.public as pub, count(*) FROM book t group by t.public order by count(*) desc limit 15";
		List<String> ret = new ArrayList<String>();
		Session session = null;
		Connection conn = null;
		ResultSet res = null;
		try {
			session = controller.getSessionFactory().openSession();
			conn = session.connection();
			res = conn.prepareStatement(sql).executeQuery();
			while (res.next()) {
				String pub = res.getString("pub");
				if (pub != null && !"".equals(pub)) {
					ret.add(pub);
				}
			}
		} catch (HibernateException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (res != null)
					res.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			session.close();
		}

		em = new Element(key, ret);
		CacheUtil.getCache().put(em);

		return ret;
	}

	@SuppressWarnings({ "deprecation", "unchecked" })
	@Override
	public List<String> getAuthors() {
		String key = BookServiceImpl.class.getName() + ",getAuthors";
		Element em = CacheUtil.getCache().get(key);
		if (em != null) {
			return (List<String>) em.getValue();
		}

		String sql = "SELECT t.author, count(*) FROM book t group by t.author order by count(*) desc limit 20";
		List<String> ret = new ArrayList<String>();
		Session session = null;
		Connection conn = null;
		ResultSet res = null;
		try {
			session = controller.getSessionFactory().openSession();
			conn = session.connection();
			res = conn.prepareStatement(sql).executeQuery();
			while (res.next()) {
				String author = res.getString("author");
				if (author != null && !"".equals(author)) {
					ret.add(author);
				}
			}
		} catch (HibernateException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (res != null)
					res.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			session.close();
		}

		em = new Element(key, ret);
		CacheUtil.getCache().put(em);

		return ret;
	}

	@Override
	public long getBooksCount(Collection<HibernateExpression> ex) {
		return controller.getResultCount(Book.class, ex);
	}

	@Override
	public void addFeedBack(FeedBackBook feedback) {
		controller.save(feedback);
	}

	@Override
	public void delFeedBackById(long id) {
		controller.deleteById(FeedBackBook.class, id);
	}

	@Override
	public List<FeedBackBook> getFeedBacks(long book_id) {
		String hql = "from FeedBackBook where book_id = ? order by create_time desc";
		return controller.findBy(hql, 1, Constants.PAGE_SIZE_10,
				new Object[] { book_id });
	}
}

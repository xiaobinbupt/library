package com.library.service.book;

import java.util.Collection;
import java.util.List;

import com.library.domain.Book;
import com.library.domain.FeedBack;
import com.library.domain.FeedBackBook;
import com.library.hibernate.HibernateExpression;

public interface BookService {

	public void addBook(Book book);

	public void updBook(Book book);

	public void updBookStock(long book_id, int num);

	public List<Book> getBooks(int page, int page_size, String order_by,
			boolean insc, Collection<HibernateExpression> ex);
	
	public long getBooksCount(Collection<HibernateExpression> ex);

	public void delBook(long id);
	
	public Book getById(long id);
	
	public List<String> getAges();
	
	public List<String> getPubs();
	
	public List<String> getAuthors();
	
	public void addFeedBack(FeedBackBook feedback);

	public void delFeedBackById(long id);
	
	public List<FeedBackBook> getFeedBacks(long book_id);
}

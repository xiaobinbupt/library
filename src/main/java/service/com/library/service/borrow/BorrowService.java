package com.library.service.borrow;

import java.util.Collection;
import java.util.List;

import com.library.domain.Borrow;
import com.library.hibernate.HibernateExpression;

public interface BorrowService {

	public void addBorrow(Borrow borrow);

	public void updBorrow(Borrow borrow);

	public void delBorrow(long id);

	public List<Borrow> getBorrows(int page, int page_size, String order_by,
			boolean insc, Collection<HibernateExpression> ex);

	public long getBorrowsCount(Collection<HibernateExpression> ex);

	public Borrow getBorrowById(long id);
	
	public Borrow getBorrowByUserIdBookId(long user_id, long book_id);
}

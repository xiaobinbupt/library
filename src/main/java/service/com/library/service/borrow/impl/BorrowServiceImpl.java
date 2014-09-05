package com.library.service.borrow.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.library.domain.Borrow;
import com.library.hibernate.CompareExpression;
import com.library.hibernate.CompareType;
import com.library.hibernate.HibernateExpression;
import com.library.hibernate.HibernateGenericController;
import com.library.service.borrow.BorrowService;

public class BorrowServiceImpl implements BorrowService {
	private HibernateGenericController controller;

	public void setHibernateGenericController(
			HibernateGenericController controller) {
		this.controller = controller;
	}

	@Override
	public void addBorrow(Borrow borrow) {
		controller.save(borrow);
	}

	@Override
	public void updBorrow(Borrow borrow) {
		controller.update(borrow);
	}

	@Override
	public void delBorrow(long id) {
		controller.deleteById(Borrow.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Borrow> getBorrows(int page, int page_size, String order_by,
			boolean insc, Collection<HibernateExpression> ex) {
		return controller.findBy(Borrow.class, page, page_size, order_by, insc,
				ex);
	}

	@Override
	public long getBorrowsCount(Collection<HibernateExpression> ex) {
		return controller.getResultCount(Borrow.class, ex);
	}

	@Override
	public Borrow getBorrowById(long id) {
		return controller.get(Borrow.class, id);
	}

	@Override
	public Borrow getBorrowByUserIdBookId(long user_id, long book_id) {
		Collection<HibernateExpression> ex = new ArrayList<HibernateExpression>();
		ex.add(new CompareExpression("user_id", user_id, CompareType.Equal));
		ex.add(new CompareExpression("book_id", book_id, CompareType.Equal));
		List<Borrow> list = getBorrows(0, 0, null, true, ex);
		if(list != null && list.size() > 0){
			return list.get(0);
		}
		return null;
	}

}

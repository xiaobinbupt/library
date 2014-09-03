package com.library.service.borrow.impl;

import java.util.Collection;
import java.util.List;

import com.library.domain.Borrow;
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

}

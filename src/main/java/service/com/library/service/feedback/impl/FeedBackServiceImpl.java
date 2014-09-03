package com.library.service.feedback.impl;

import java.util.List;

import com.library.domain.FeedBack;
import com.library.hibernate.HibernateGenericController;
import com.library.service.feedback.FeedBackService;
import com.library.util.Constants;

public class FeedBackServiceImpl implements FeedBackService {
	private HibernateGenericController controller;

	public void setHibernateGenericController(
			HibernateGenericController controller) {
		this.controller = controller;
	}

	@Override
	public void add(FeedBack feedback) {
		controller.save(feedback);
	}

	@Override
	public void delById(long id) {
		controller.deleteById(FeedBack.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<FeedBack> getFeedBacks(int page) {
		String hql = "from FeedBack order by create_time desc";
		return controller.findBy(hql, page, Constants.PAGE_SIZE_10,
				new Object[] {});
	}

	@Override
	public long getFeedBackCount() {
		String hql = "from FeedBack";
		return controller.getResultCount(hql, new Object[] {});
	}

}

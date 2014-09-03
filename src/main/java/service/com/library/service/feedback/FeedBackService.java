package com.library.service.feedback;

import com.library.domain.FeedBack;
import java.util.List;;

public interface FeedBackService {

	public void add(FeedBack feedback);

	public void delById(long id);
	
	public List<FeedBack> getFeedBacks(int page);
	
	public long getFeedBackCount();
}

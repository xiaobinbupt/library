package com.library.filter;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.library.util.Constants;

/**
 * 
 * @author xiaobin
 * 
 */
public class SessionCheckFilter implements Filter {

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.Filter#destroy()
	 */
	public void destroy() {

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest,
	 * javax.servlet.ServletResponse, javax.servlet.FilterChain)
	 */
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) arg0;
		HttpServletResponse response = (HttpServletResponse) arg1;

		String servlet = request.getParameter(Constants.SERVLET);

		HttpSession session = request.getSession(false);
		if (servlet.equals("borrow")) {
			String cmd = request.getParameter(Constants.CMD);
			if (!"get_user_remain_stock".equals(cmd)) {
				if (session == null
						|| session.getAttribute("user_name") == null) {
					try {
						response.sendRedirect(request.getHeader("Referer")
								+ "&err=" + URLEncoder.encode("请先登录!", "UTF-8"));
					} catch (IOException e) {
						e.printStackTrace();
					}
					return;
				}
			}
		} else if (servlet.equals("system")) {
			String cmd = request.getParameter(Constants.CMD);
			String id = request.getParameter(Constants.ID);
			if ("user_list".equals(cmd)
					|| ("upd_user".equals(cmd) && id != null && !id.equals(""))
					|| "prepare_upd_user".equals(cmd)) {
				if (session == null
						|| session.getAttribute("user_name") == null) {
					String referer = request.getHeader("Referer");
					if (referer == null || "".equals(referer)) {
						referer = "api?servlet=book&cmd=list";
					}
					try {
						response.sendRedirect(referer + "&err="
								+ URLEncoder.encode("请先登录!", "UTF-8"));
					} catch (IOException e) {
						e.printStackTrace();
					}
					return;
				}
			}
		}

		arg2.doFilter(request, response);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
	 */
	public void init(FilterConfig config) throws ServletException {
	}
}

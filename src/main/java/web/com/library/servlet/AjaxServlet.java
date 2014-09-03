/**
 * 
 */
package com.library.servlet;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.library.util.Constants;

public class AjaxServlet extends HttpServlet {

	private static final long serialVersionUID = 790607863452082626L;

	private static final String SERVLET_BEAN = "Servlet";

	public void doGet(final HttpServletRequest request,
			final HttpServletResponse response) throws ServletException,
			IOException {
		this.doPost(request, response);
	}

	public void doPost(final HttpServletRequest request,
			final HttpServletResponse response) throws ServletException,
			IOException {
		service(request, response);
	}

	protected void service(final HttpServletRequest request,
			final HttpServletResponse response) throws ServletException, IOException {
		String servlet = request.getParameter(Constants.SERVLET);
		try {
			if (StringUtils.isBlank(servlet)) {
				servlet = "";
				System.out.println("servlet ==" + servlet + ": 命令为空 ");
			}

			BaseServlet command = getServlet(request.getSession()
					.getServletContext(), servlet);
			if (command == null) {
				System.out.println(servlet + ": 命令找不到 ");
			}
			command.execute(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private BaseServlet getServlet(ServletContext sc, String actionName) {
		WebApplicationContext wc = WebApplicationContextUtils
				.getRequiredWebApplicationContext(sc);
		return (BaseServlet) wc.getBean(actionName + SERVLET_BEAN);
	}
}

/**
 * 
 */
package com.library.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.library.domain.Category;
import com.library.service.book.BookService;

public abstract class BaseServlet {
	protected static ApplicationContext ctx = new ClassPathXmlApplicationContext(
			"classpath:applicationContext.xml");

	public static BookService bookService = (BookService) ctx
			.getBean("bookService");

	public abstract void execute(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException;

	public void direct(HttpServletRequest request,
			HttpServletResponse response, String path) {
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		try {
			List<Category> categorys = bookService.getCategorys();
			request.setAttribute("categorys", categorys);
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

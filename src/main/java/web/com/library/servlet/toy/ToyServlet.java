
package com.library.servlet.toy;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.library.domain.Toy;
import com.library.service.toy.ToyService;
import com.library.servlet.BaseServlet;
import com.library.util.Constants;
import com.library.util.StringUtil;

public class ToyServlet extends BaseServlet {

	private ToyService toyService;

	public void setToyService(ToyService toyService) {
		this.toyService = toyService;
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cmd = request.getParameter(Constants.CMD);
		if ("list".equals(cmd)) {
			list(request, response);
		} else if ("prepare_add".equals(cmd)) {
			prepare_add(request, response);
		} else if ("prepare_upd".equals(cmd)) {
			prepare_upd(request, response);
		} else if ("upd".equals(cmd)) {
			upd(request, response);
		} else if ("prepare_upd_img".equals(cmd)) {
			prepare_upd_img(request, response);
		} else if ("upd_img".equals(cmd)) {
			upd_img(request, response);
		} else if ("del".equals(cmd)) {
			del(request, response);
		} else if ("info_customer".equals(cmd)) {
			info_customer(request, response);
		}
	}

	private void info_customer(HttpServletRequest request,
			HttpServletResponse response) {
		String err = request.getParameter(Constants.ERR);
		if (err != null) {
			request.setAttribute("err", err);
		}
		String toy_id = request.getParameter(Constants.TOY_ID);
		Toy toy = toyService.getById(Long.valueOf(toy_id));
		String des = toy.getDes().replaceAll("\r\n", "<br>")
				.replaceAll(" ", "&nbsp;");
		toy.setDes(des);
		request.setAttribute("toy", toy);
		direct(request, response, "/toy/info_customer.jsp");
	}

	private void del(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		toyService.delToy(Long.valueOf(id));
		list(request, response);
	}

	private void prepare_upd(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		Toy toy = toyService.getById(Long.valueOf(id));
		request.setAttribute("toy", toy);
		String page = request.getParameter(Constants.PAGE);
		request.setAttribute("page", page);
		direct(request, response, "/toy/toy.jsp");
	}

	private void prepare_upd_img(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		Toy toy = toyService.getById(Long.valueOf(id));
		request.setAttribute("toy", toy);
		direct(request, response, "/toy/toy_img.jsp");
	}

	@SuppressWarnings("rawtypes")
	private void upd_img(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		Toy toy = toyService.getById(Long.valueOf(id));
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List list = upload.parseRequest(request);
			Iterator items = list.iterator();
			while (items.hasNext()) {
				FileItem item = (FileItem) items.next();
				if (!item.isFormField()) {
					long size = item.getSize();
					if (size <= 0) {
						continue;
					}
					String name = item.getFieldName();
					// 上传原文件
					String file_name = item.getName();
					String type = file_name.substring(file_name
							.lastIndexOf('.'));
					String img_name = id + "_" + name + "_"
							+ System.currentTimeMillis() + type;
					File uploadedFile = new File(Constants.UPLOAD_IMG_IDR + "toy/"
							+ img_name);
					if (!uploadedFile.getParentFile().exists()) {
						uploadedFile.getParentFile().mkdirs();
					}
					if (!uploadedFile.exists()) {
						uploadedFile.createNewFile();
					}
					item.write(uploadedFile);

					if ("img".equals(name)) {
						toy.setImg(img_name);
					} else if ("info_img1".equals(name)) {
						toy.setInfo_img1(img_name);
					} else if ("info_img2".equals(name)) {
						toy.setInfo_img2(img_name);
					} else if ("info_img3".equals(name)) {
						toy.setInfo_img3(img_name);
					} else if ("info_img4".equals(name)) {
						toy.setInfo_img4(img_name);
					} else if ("info_img5".equals(name)) {
						toy.setInfo_img5(img_name);
					}
				}
			}
			toyService.updToy(toy);

			request.setAttribute("toy", toy);
			request.setAttribute("done", "down");
			direct(request, response, "/toy/toy_img.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void upd(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter(Constants.ID);
		String name = request.getParameter(Constants.NAME);
		String isdn = request.getParameter(Constants.ISDN);
		String price = request.getParameter(Constants.PRICE);
		String des = request.getParameter(Constants.DES);
		String stock = request.getParameter(Constants.STOCK);

		Toy toy = null;
		if (id == null || "".equals(id)) {
			// 新增
			toy = new Toy();
		} else {
			toy = toyService.getById(Long.valueOf(id));
		}
		toy.setDes(des.trim());
		toy.setIsdn(isdn.trim());
		toy.setName(name.trim());
		toy.setPrice(Float.valueOf(price.trim()));
		toy.setStock(Integer.valueOf(stock.trim()));

		if (id == null || "".equals(id)) {
			toyService.addToy(toy);
		} else {
			toyService.updToy(toy);
		}

		list(request, response);
	}

	private void prepare_add(HttpServletRequest request,
			HttpServletResponse response) {
		String page = request.getParameter(Constants.PAGE);
		request.setAttribute("page", page);
		direct(request, response, "/toy/toy.jsp");
	}

	private void list(HttpServletRequest request, HttpServletResponse response) {
		String err = request.getParameter(Constants.ERR);
		if (err != null) {
			request.setAttribute("err", err);
		}
		StringBuffer hql = new StringBuffer("from Toy ");
		String search = request.getParameter(Constants.SEARCH);
		String pages = request.getParameter(Constants.PAGE);
		int page = pages == null ? 1 : Integer.valueOf(pages);
		if (search != null) {
			hql.append(" where");
			boolean and = false;
			String isdn = request.getParameter(Constants.ISDN);
			String name = request.getParameter(Constants.NAME);
			if (!StringUtil.isEmpty(isdn)) {
				and = true;
				hql.append(" isdn = '" + isdn + "'");
				request.setAttribute("isdn", isdn);
			}

			if (!StringUtil.isEmpty(name)) {
				if(and){
					hql.append(" and ");
				}
				hql.append(" name like '%" + name + "%'");
				request.setAttribute("name", name);
			}
		}
		if (hql.toString().endsWith("where")) {
			hql = hql.delete(hql.length() - 5, hql.length());
		}
		List<Toy> list = toyService.getToys(page, Constants.PAGE_SIZE, hql
				.append(" order by isdn ").toString());
		request.setAttribute("list", list);

		request.setAttribute("page", page);
		long total = toyService.getToysCount(hql.toString());
		int total_pages = (int) (total / Constants.PAGE_SIZE);
		if (total % Constants.PAGE_SIZE > 0) {
			total_pages++;
		}
		request.setAttribute("total_pages", total_pages);

		Integer role_id = (Integer) request.getSession()
				.getAttribute("role_id");
		if (role_id != null && role_id.intValue() == 2) {
			direct(request, response, "/toy/list.jsp");
		} else {
			direct(request, response, "/toy/list_customer.jsp");
		}
	}
}

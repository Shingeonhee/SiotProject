package com.siot.utils;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class ScriptWriterUtil {
	public static void init(HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
	}
	public static void alert(HttpServletResponse response, String alertTxt) throws IOException {
		init(response);
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('"+alertTxt+"');");
		out.println("</script>");
		out.flush();
	}
	public static void alertAndBack(HttpServletResponse response, String alertTxt) throws IOException {
		init(response);
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('"+alertTxt+"');");
		out.println("history.back();");
		out.println("</script>");
		out.flush();
	}
	public static void AndNext(HttpServletResponse response,String nextPage) throws IOException {
		init(response);
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("location.href='"+nextPage+"'");
		out.println("</script>");
		out.flush();
	}
	
	public static void AndBack(HttpServletResponse response) throws IOException {
		init(response);
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("history.back();");
		out.println("</script>");
		out.flush();
	}
	
	public static void alertAndNext(HttpServletResponse response, String alertTxt,String nextPage) throws IOException {
		init(response);
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('"+alertTxt+"');");
		out.println("location.href='"+nextPage+"'");
		out.println("</script>");
		out.flush();
	}
	
	
}








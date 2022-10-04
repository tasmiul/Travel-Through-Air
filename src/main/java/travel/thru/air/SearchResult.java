package travel.thru.air;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.*;
import jakarta.servlet.annotation.WebServlet;


@WebServlet("/search")
public class SearchResult extends SearchServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void init() throws ServletException {
	      
	   }
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      try {
	         response.setContentType("text/html");
	         String source = request.getParameter("source").toUpperCase();
	         String destination = request.getParameter("destination").toUpperCase();
	         int time = Integer.parseInt(request.getParameter("time").replace(":", ""));

	         long startTime = System.nanoTime();
	         LinkedList<Route> results = getRoutes(source, destination, time);
	         long endTime = System.nanoTime();
	         
	         

	         request.setAttribute("execution_time", endTime - startTime);
	         HttpSession session = request.getSession();
	         session.setAttribute("source", source);
	         session.setAttribute("destination", destination);
	         session.setAttribute("time", request.getParameter("time"));
	         request.setAttribute("showResults", true);
	         session.setAttribute("deals", getActiveDeals());
	         session.setAttribute("airports", airport_flights.keySet());
	         request.setAttribute("results", results);
	         request.setCharacterEncoding("UTF-8");
	         request.getRequestDispatcher("/search.jsp").forward(request, response);
	      } catch (Exception e) {
	         StringWriter sw = new StringWriter();
	         e.printStackTrace(new PrintWriter(sw));
	         PrintWriter out = response.getWriter();
	         out.println(sw);
	      }
	   }
}

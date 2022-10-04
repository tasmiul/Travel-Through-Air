package travel.thru.air;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.*;

@WebServlet("/admin")

@ServletSecurity(@HttpConstraint(
		transportGuarantee = ServletSecurity.TransportGuarantee.NONE,
        rolesAllowed = "admin"
        ))

public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public void init() throws ServletException {
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	      // Set response content type
	      try {
	         response.setContentType("text/html");
	         request.setCharacterEncoding("UTF-8");

	         request.setAttribute("airports", SearchServlet.airport_flights.keySet());
	         request.setAttribute("message", "invisible");
	         getServletConfig().getServletContext().getRequestDispatcher("/admin.jsp").forward(request,
	               response);
	      } catch (Exception ex) {
	         ex.printStackTrace();
	      }
	   }

	   public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      try {
	         ServletContext servletContext = getServletContext();
	         String dealsPath = servletContext.getRealPath("/WEB-INF/resources/deals.csv");

	         response.setContentType("text/html");
	         request.setCharacterEncoding("UTF-8");
	         String departure = request.getParameter("departure").toUpperCase();
	         String arrival = request.getParameter("arrival").toUpperCase();
	         int discount_price = Integer.parseInt(request.getParameter("cost"));
	         int exp = Integer.parseInt(request.getParameter("expiry").replace(":", ""));

	         SearchServlet.addDeal(departure, arrival, exp, discount_price, dealsPath);

	         request.setAttribute("airports", SearchServlet.airport_flights.keySet());
	         request.setAttribute("message", "visible");
	         getServletConfig().getServletContext().getRequestDispatcher("/admin.jsp").forward(request,
	               response);
	      } catch (Exception ex) {
	         ex.printStackTrace();
	      }
	   }

	   public void destroy() {
	      // do nothing.
	   }
}

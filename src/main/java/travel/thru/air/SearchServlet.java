package travel.thru.air;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.*;
import java.util.stream.Collectors;
import jakarta.servlet.annotation.WebServlet;


@WebServlet("/")
public class SearchServlet extends HttpServlet{
	   private static final long serialVersionUID = 1L;
	   public static ArrayList<Deals> deals = new ArrayList<>();
	   public static HashMap<String, HashMap<Integer, Integer>> deals_map = new HashMap<>();
	   public static ArrayList<Flight> flights = new ArrayList<>();
	   public static HashMap<String, HashSet<Flight>> airport_flights = new HashMap<>();
	   
	   //get all the flights
	   private void getFlights(String path) {
	      try {    	  
	         Scanner sc = new Scanner(new File(path));
	         while (sc.hasNext()) {
	            String[] row = sc.next().split(",");

	            String number = row[0];
	            String dep = row[1];
	            int takeoff = Integer.parseInt(row[2]);
	            String arr = row[3];
	            int landing = Integer.parseInt(row[4]);
	            int cost = Integer.parseInt(row[5]);
	            //create a new flight
	            Flight new_flight = new Flight(number, dep, takeoff, arr, landing, cost);
	            flights.add(new_flight);
	            HashSet<Flight> airport_flights_map;

	            if (!airport_flights.containsKey(dep))
	               airport_flights_map = new HashSet<Flight>();
	            else
	               airport_flights_map = airport_flights.get(dep);

	            airport_flights_map.add(new_flight);

	            if (!airport_flights.containsKey(arr))
	               airport_flights.put(arr, new HashSet<Flight>());

	            airport_flights.put(dep, airport_flights_map);
	         }
	         sc.close();
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	   }
	   
	   //add a new deal

	   private static void addNewDeal(String departure, String arrival, int exp, int discount_price) {
	      deals.add(new Deals(departure, arrival, exp, discount_price));
	      String sector = departure + arrival;
	      HashMap<Integer, Integer> temp;

	      if (deals_map.containsKey(sector))
	         temp = deals_map.get(sector);
	      else
	         temp = new HashMap<Integer, Integer>();

	      temp.put(exp, discount_price);
	      deals_map.put(sector, temp);
	   }
	   
	   //put the deal into database
	   public static void addDeal(String departure, String arrival, int exp, int discount_price, String path) {
	      try {
	         FileWriter csvWriter = new FileWriter(path, true);
	         csvWriter.write(
	               '\n' + departure + "," + arrival + "," + Integer.toString(exp) + "," + Integer.toString(discount_price));
	         csvWriter.close();
	         addNewDeal(departure, arrival, exp, discount_price);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	   }

	   private void getDeals(String path) {
	      try {
	         Scanner sc = new Scanner(new File(path));
	         while (sc.hasNext()) {
	            String[] row = sc.next().split(",");
	            addNewDeal(row[0], row[1], Integer.parseInt(row[2]), Integer.parseInt(row[3]));
	         }
	         sc.close();
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	   }
	   
	   //get the current active deals

	   public ArrayList<Deals> getActiveDeals() {
		  
	      Calendar now = Calendar.getInstance();
	      int time_now = 100 * now.get(Calendar.HOUR_OF_DAY) + now.get(Calendar.MINUTE);
	      ArrayList<Deals> activeDeals = new ArrayList<Deals> (deals.stream()
	                                    .filter(deal -> deal.getExpiry() > time_now)
	                                    .sorted(Comparator.comparing(Deals::getExpiry))
	                                    .collect(Collectors.toList()));
	      return activeDeals;
	   }
	   
	   
	   protected LinkedList<Route> getRoutes(String src, String dest, int time) {
	      src = src.toUpperCase();
	      dest = dest.toUpperCase();
	      LinkedList<Route> routes = new LinkedList<>();
	      LinkedList<Flight> flights = new LinkedList<>();
	      this.getRoutes(src, dest, time, 0, "", flights, routes);
	      routes.sort((r1, r2) -> {
	         int res = r1.cost - r2.cost;
	         if (res == 0) {
	            res = r1.flights.size() - r2.flights.size();
	            if (res == 0)
	               return r1.flyingTime - r2.flyingTime;
	            return res;
	         }
	         return res;
	      });
	      return routes;
	   }

	   private void getRoutes(String src, String dest, int time, int cost, String path, LinkedList<Flight> flights,
	         LinkedList<Route> routes) {
	      if (!airport_flights.containsKey(dest) || !airport_flights.containsKey(src))
	         return;
	      if (src.equals(dest)) {
	         if (flights.size() > 0)
	            routes.add(new Route(flights));
	         return;
	      }
	      for (Flight flight : airport_flights.get(src)) {
	         if (flight.getTakeOff() < time)
	            continue;
	         String next_airport = flight.getArr();
	         if (!path.contains(next_airport)) {
	            LinkedList<Flight> flights_copy = new LinkedList<Flight>(flights);
	            flights_copy.add(flight);
	            getRoutes(next_airport, dest, flight.getLanding() + 30, cost + flight.getCost(), path + src + "~",
	                  flights_copy, routes);
	         }
	      }
	   }
	   
	   //_____________________________________________________________________________________//
	   //_____________________________________________________________________________________//

	   public void init() throws ServletException {
	      try {
	         ServletContext servletContext = getServletContext();
	         String csvPath = servletContext.getRealPath("/WEB-INF/resources/deals.csv");
	         String flightsPath = servletContext.getRealPath("/WEB-INF/resources/flights.csv");

	         getDeals(csvPath);
	         getFlights(flightsPath);

	      } catch (Exception e) {
	         StringWriter sw = new StringWriter();
	         e.printStackTrace(new PrintWriter(sw));
	         sw.toString();
	      }
	   }
	   
	   
	   public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      try {
	    	 
	    	 
	         HttpSession session = request.getSession();
	         request.setAttribute("showResults", false);
	         session.setAttribute("deals", getActiveDeals());
	         session.setAttribute("airports", airport_flights.keySet());
	         request.setCharacterEncoding("UTF-8");
	         request.getRequestDispatcher("/search.jsp").forward(request, response);
	      } catch (Exception e) {
	         StringWriter sw = new StringWriter();
	         e.printStackTrace(new PrintWriter(sw));
	         PrintWriter out = response.getWriter();
	         out.println(sw);
	      }
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

	   public void destroy() {
	      // do nothing.
	   }
	
}

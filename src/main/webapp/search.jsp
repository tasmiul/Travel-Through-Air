<%@page import="travel.thru.air.SearchServlet"%>
<%@page import="travel.thru.air.SearchResult"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.Set"%> 
<%@ page import="java.util.ArrayList"%> 
<%@ page import="java.util.LinkedList"%> 
<%@ page import="java.text.NumberFormat"%> 
<%@ page import="java.util.Locale"%>
<%@ page import="travel.thru.air.Deals"%>
<%@ page import="travel.thru.air.Flight"%>
<%@ page import="travel.thru.air.Route"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Travel Thru Air</title>    
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="BCSEIII Internet Technology Lab Assignment 3">
    <meta name="author" content="Sagen Soren">
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/simplex/bootstrap.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
      .search-bar input {
        font-weight: bolder;
        font-size: x-large;
        text-transform:uppercase;
      }
      .search-bar label {
        font-weight: bolder;
      }
      .w-10{
        width: 24% !important;
      }
      .w-45{
        width: 33% !important;
      }
      .discounted{
        text-decoration: line-through;       
      }
      body {
        background: url("images/back.jpg") no-repeat center center fixed;
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
         background-size: cover;
      }
      .navbar{
        border: 5px;
       
      }
      
      .navbar-custom{
        background-color: #000000;
      }
      
      .box1 {
        display: block;
        padding: 5px;
        text-align: justify;
       }

      .box2 {
       display: block;
       padding: 10px;
       text-align: justify;
       }
      
    </style>
    <script>
      function scroller(){
        document.getElementById("results").scrollIntoView({ behavior: "smooth" });
      }
    </script>
    
    <style>
.shape {
    border-style: solid;
    border-width: 0 70px 40px 0;
    float: right;
    height: 0px;
    width: 0px;
    -ms-transform: rotate(360deg); /* IE 9 */
    -o-transform: rotate(360deg); /* Opera 10.5 */
    -webkit-transform: rotate(360deg); /* Safari and Chrome */
    transform: rotate(360deg);
}
.listing {
    background: #fff;
    border: 1px solid #ddd;
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    margin: 15px 0;
    overflow: hidden;
}
.listing:hover {
    -webkit-transform: scale(1.1);
    -moz-transform: scale(1.1);
    -ms-transform: scale(1.1);
    -o-transform: scale(1.1);
    transform: rotate scale(1.1);
    -webkit-transition: all 0.4s ease-in-out;
    -moz-transition: all 0.4s ease-in-out;
    -o-transition: all 0.4s ease-in-out;
    transition: all 0.4s ease-in-out;
}
.shape {
    border-color: rgba(255,255,255,0) #d9534f rgba(255,255,255,0) rgba(255,255,255,0);
}
.listing-radius {
    border-radius: 7px;
}
.listing-danger {
    border-color: #d9534f;
}
.listing-danger .shape {
    border-color: transparent #d9533f transparent transparent;
}
.listing-success {
    border-color: #5cb85c;
}
.listing-success .shape {
    border-color: transparent #5cb75c transparent transparent;
}
.listing-default {
    border-color: #999999;
}
.listing-default .shape {
    border-color: transparent #999999 transparent transparent;
}
.listing-primary {
    border-color: #428bca;
}
.listing-primary .shape {
    border-color: transparent #318bca transparent transparent;
}
.listing-info {
    border-color: #5bc0de;
}
.listing-info .shape {
    border-color: transparent #5bc0de transparent transparent;
}
.listing-warning {
    border-color: #f0ad4e;
}
.listing-warning .shape {
    border-color: transparent #f0ad4e transparent transparent;
}
.shape-text {
    color: #fff;
    font-size: 12px;
    font-weight: bold;
    position: relative;
    right: -40px;
    top: 2px;
    white-space: nowrap;
    -ms-transform: rotate(30deg); /* IE 9 */
    -o-transform: rotate(360deg); /* Opera 10.5 */
    -webkit-transform: rotate(30deg); /* Safari and Chrome */
    transform: rotate(30deg);
}
.listing-content {
    padding: 0 20px 10px;
}

#dealslists {
    border: 10px solid transparent;
    padding: 15px;
    border-image: url("images/border.png") 10 stretch;
}
</style>
    
    
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    
    
    
  </head>
  <body>
    <nav class="navbar navbar-custom">
    <span><h3 style="font-family:courier;color:white;">TRAVEL THRU AIR</h3></span>
    
    <section class="search-sec" >
    <div class="container">
        <form method="POST" action="" onsubmit=onclick="document.getElementById('form-submit').style.display='none';document.getElementById('form-spinner').style.display='inline-block'">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                            <input
              placeholder="Departure Airport"
              class="form-control search-slt"
              id="source"
              name="source"
              list="airport_codes"
              autocomplete="off"
              required 
              <%
                if (session.getAttribute("source")!= null) {
                  out.println("value = " + session.getAttribute("source")); 
               }
              %>             
              
            />  
                      
                      </div>
                        <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                            
                            <input
              placeholder="Arrival Airport"
              class="form-control search-slt"
              id="destination"
              name="destination"
              list="airport_codes"
              autocomplete="off"
              required   
              <%
                if (session.getAttribute("destination")!= null) {
                  out.println("value = " + session.getAttribute("destination")); 
               }
              %>           
              
            />  
                      </div>
                        <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                         
            <input
              placeholder="Select Airport"
              class="form-control search-slt"
              id="time"
              name="time"
              type="time"
              step="900"
              required
              <%
                if (session.getAttribute("time")!= null) {
                  out.println("value = " + session.getAttribute("time")); 
               }
              %>
            />
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                            <button type="submit" id="form-button" class="btn btn-primary wrn-btn">Search</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>
    
    
    </nav>
      
      
    
   
    
    <% 
    //SearchServlet ss = new SearchServlet();
    ArrayList<Deals> deals = (ArrayList<Deals>)session.getAttribute("deals"); %>
  
  
    
    
    
    
     <div class="box1"></div>
  
  <p style="text-align: center;color:white;font-size:80px;font-family:Lucida Handwriting; -webkit-text-stroke-width: 2px;
-webkit-text-stroke-color: #000;">Travel Thru Air</p>
    
    <div class="box1"></div>
    
    <div id="dealslists">
    
    <p style="text-align: center;color:#eef26b;font-size:40px;font-family: Papyrus">Available Deals</p>
    
    </div>
    
    <div class="container">
    <div class="row">
    <% 
    int totalDeals = (int)deals.size();
    for(int i=0;i<totalDeals;i+=3){ %>
        <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
            <div class="listing listing-default">
                <div class="shape">
                    <div class="shape-text">buy</div>
                </div>
                <div class="listing-content">
                    <div class="box1">
                    <div class="col-md-6 text-sm-right text-center">
                    <div class="col-sm-5">
                          <table class="w-100 text-center">
                            <tr>
                              <th class="text-right h6 w-45 pr-2"><%= deals.get(i).getDeparture() %></th>
                              <td class="w-10"><img src="images/plane.png" style="width:1.5em"/></td>
                              <th class="text-left h6 w-45 pl-2"><%= deals.get(i).getArrival() %></th>
                            </tr>
                            
                           </table>
                     </div>
                                                      
                    </div>
                    <p class="lead" style="text-align:right;">Expires at <%= deals.get(i).getDealTime() %> </p>
                    
                    <div class="col-md-6 pt-3 text-sm-right text-center">
                    <h1><small>&#8377;</small><%= deals.get(i).getPrice() %></h1>
                    </div>
                    
                    </div>
                </div>
            </div>
        </div>
        <% if(i+1<totalDeals){ %>
        <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
            <div class="listing listing-radius listing-success">
                <div class="shape">
                    <div class="shape-text">off</div>
                </div>
                <div class="listing-content">
                    <div class="box1">
                    <div class="col-md-6 text-sm-right text-center">
                    <div class="col-sm-5">
                          <table class="w-100 text-center">
                            <tr>
                              <th class="text-right h6 w-45 pr-2"><%= deals.get(i+1).getDeparture() %></th>
                              <td class="w-10"><img src="images/plane.png" style="width:1.5em"/></td>
                              <th class="text-left h6 w-45 pl-2"><%= deals.get(i+1).getArrival() %></th>
                            </tr>
                            
                           </table>
                     </div>
                                                      
                    </div>
                    <p class="lead" style="text-align:right;">Expires at <%= deals.get(i+1).getDealTime() %> </p>
                    
                    <div class="col-md-6 pt-3 text-sm-right text-center">
                    <h1><small>&#8377;</small><%= deals.get(i+1).getPrice() %></h1>
                    </div>
                    
                    </div>
                    
                </div>
            </div>
        </div>
        <% } %>
        <% if(i+2<totalDeals){ %>
        <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
            <div class="listing listing-danger">
                <div class="shape">
                    <div class="shape-text">hot</div>
                </div>
                <div class="listing-content">
                    <div class="box1">
                    <div class="col-md-6 text-sm-right text-center">
                    <div class="col-sm-5">
                          <table class="w-100 text-center">
                            <tr>
                              <th class="text-right h6 w-45 pr-2"><%= deals.get(i+2).getDeparture() %></th>
                              <td class="w-10"><img src="images/plane.png" style="width:1.5em"/></td>
                              <th class="text-left h6 w-45 pl-2"><%= deals.get(i+2).getArrival() %></th>
                            </tr>
                            
                           </table>
                     </div>
                                                      
                    </div>
                    <p class="lead" style="text-align:right;">Expires at <%= deals.get(i+2).getDealTime() %> </p>
                    
                    <div class="col-md-6 pt-3 text-sm-right text-center">
                    <h1><small>&#8377;</small><%= deals.get(i+2).getPrice() %></h1>
                    </div>
                    
                    </div>
                </div>
            </div>
        </div>
        <% } %>
        <%}%>
    </div>
</div>
  
  
  
  
  
  
  <div class="box2">
  </div>
  
  
  
  
  <div class="container mb-5" id="results">
    <div class="row">
      <%
        if (request.getAttribute("showResults") != null && Boolean.parseBoolean(request.getAttribute("showResults").toString())){
          %>
          <script>
              window.onload = scroller;
            </script>
          <%
          LinkedList<Route> search_results = (LinkedList<Route>)request.getAttribute("results");
          
          %>
          
          
          <div class="col-12 mt-5 text-center">
          <p class="display-4 mb-1">
                Results
          </p>
          <% if(session.getAttribute("destination").equals(session.getAttribute("source"))){%><p class="lead">Please enter different Departure and Arrival airport</p><%
          }else{ if(request.getAttribute("execution_time")!=null){%><p class="mb-0">Search took <%=((Long)request.getAttribute("execution_time")/10000000.0)%>ms </p><%} 
           if(search_results.size()==0){%><p class="lead">No Flights Found</p><%}}%>          
          </div>
          
          <%
          for( Route route : search_results ){%>
            <div class="col-12">
              <div class="card my-3 bg-light shadow">
              <div class="row">
                <div class="col">
                  <ul class="list-group list-group-flush">
                  <% for(Flight flight : route.getFlights()){%>
                    <div class="list-group-item bg-light">
                      <div class="row">
                        <div class="col-sm-3">
                          <p class="display-4 mb-0"><%=flight.getNumber()%></p>
                        </div>
                        <div class="col-sm-5">
                          <table class="w-100 text-center">
                            <tr>
                              <th class="text-right h3 w-45 pr-2"><%=flight.getDep()%></th>
                              <td class="w-10"><img src="images/plane.png" style="width:1.5em"/></td>
                              <th class="text-left h3 w-45 pl-2"><%=flight.getArr()%></th>
                            </tr>
                            <tr>
                              <td class="text-right pr-2"><%=flight.getTakeOffTime()%></td>                            
                              <td class="text-muted text-sm"><small>&mdash; <%=flight.getDuration(0)%> &mdash;</small></td>
                              <td class="text-left pl-2"><%=flight.getLandingTime()%></td>
                            </tr>
                          </table>
                        </div>
                        <div class="col-sm-2">
                        <%if(flight.full_cost>-1){%>
                          <p class="discounted lead pt-2 mb-0 text-right">&#8377;<%=NumberFormat.getNumberInstance(Locale.US).format(flight.full_cost)%></p>
                        <%}%>
                        </div>
                        <%if(route.getFlights().size()>1){%>
                        <div class="col-sm-2">
                          <p class="h2 pt-2 mb-0 text-right">                            
                            &#8377;<%=NumberFormat.getNumberInstance(Locale.US).format(flight.getCost())%>
                          </p>
                        </div>
                        <%}%>         
                      </div>
                    </div>
                  <%}%>
                  </ul>
                </div>
                  <div class="col-2">
                  <table class="w-100 h-100">
                          <tr>
                          <td class="mb-0 text-right pr-3">                          
                            <span class="h1">&#8377;<%=NumberFormat.getNumberInstance(Locale.US).format(route.getCost())%></span>
                          </td>
                          </tr>
                          </table>
                  </div>
                </div>
              </div>
            </div>
          
          <% }} %>
    </div>
  </div>
  
  <datalist id="airport_codes">
    <%
      Set<String> airports = (Set<String>)session.getAttribute("airports");
      if(airports != null)
        for ( String airport: airports){%>
          <option value=<%= airport %>>
          <%}%>
   </datalist>
  
  </body>
</html>
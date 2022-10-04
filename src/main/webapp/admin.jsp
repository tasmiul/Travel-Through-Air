<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Travel Thru Air</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta
      name="description"
      content="BCSEIII Internet Technology Lab Assignment 3"
    />
    <meta name="author" content="Tasmiuo Alam Shopnil" />
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/simplex/bootstrap.min.css"
    />
</head>
<body class="pt-5">
    
        <p class="display-2 text-center">MARKETING DEPARTMENT</p>
        <div class="col-6 offset-3 bg-white shadow border rounded">
            <form class="pt-4 mt-3 px-3" method="POST" action="admin">
                    
                    <h3 class="text-center">ADD DEALS</h3>
                    <p class="text-center">___________</p>
                    
                    <div class="col">
                    <p></p>
                      <div class="form-group row">
                        <label class="col-4 text-left col-form-label"><h5>Departure City</h5></label>
                        <div class="col-8">
                            <input placeholder="Departure" class="form-control" list="airport_codes" required name="departure" autocomplete="off"/>
                        </div>
                      </div>
                   </div> 
                     
                
                    <div class="col">
                    <p></p>
                      <div class="form-group row">
                        <label class="col-4 text-left col-form-label"><h5>Arrival City</h5></label>
                        <div class="col-8">
                            <input placeholder="Arrival" class="form-control" list="airport_codes" required name="arrival" autocomplete="off"/>
                        </div>
                      </div>
                   </div>                   
                    
                    
                    
                    <div class="col">
                    <p></p>
                      <div class="form-group row">
                        <label class="col-4 text-left col-form-label"><h5>Discounted Price</h5></label>
                        <div class="col-8">
                            <input class="form-control" type="number" required name="cost" placeholder="Discounted Price">
                        </div>
                      </div>
                   </div>
                    
                    <div class="col">
                    <p></p>
                      <div class="form-group row">
                        <label class="col-4 text-left col-form-label"><h5>Expires at</h5></label>
                        <div class="col-8">
                            <input class="form-control" type="time" required name="expiry">
                        </div>
                      </div>
                   </div>
               
            <button class="btn btn-block btn-info">Submit</button>
            <p>     </p>
            <p>     </p>
            
            <% String al = (String)request.getAttribute("message");
               if(al=="visible"){
            	   %>
            	   <script type="text/javascript">
            	       alert("Deal Added!");
            	   </script><%
               }
            %>
            </form>
        </div>
    
    <datalist id="airport_codes">
    <%
    @SuppressWarnings (value="unchecked")
        Set<String> airports = (Set<String>)request.getAttribute("airports");
        if(airports != null)
            for ( String airport: airports){%>
                <option value=<%= airport %>>
    <%}%>
   </datalist>
  </body>
</html>
<%-- 
    Document   : BuyCar
    Created on : Sep 22, 2017, 9:12:06 PM
    Author     : Aamir
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="newcar.NewCar"%>
<%@page import="newcar.NewCarDAOImpl"%>
<%@page import="newcar.NewCarDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>buyCar</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://dhbhdrzi4tiry.cloudfront.net/cdn/sites/foundation.min.css">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css" rel="stylesheet" type="text/css">
	<meta class="foundation-mq">
    </head>
    <%
        NewCar c=new NewCar();
        try {
                if(request.getSession().getAttribute("role").toString().equals("SUPPLIER") || request.getSession().getAttribute("role").toString().equals("SELLER") ){
                   response.sendRedirect("Unauthorised.jsp");
                }
                else{
                    NewCarDAO cdao=new NewCarDAOImpl();
                    c=cdao.getCar(Integer.parseInt(request.getParameter("id")));
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "<script>alert('You have to Login first');</script>");
                RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            }
        
    %>
    <body style="background-color: blanchedalmond">
    <c:import url="Header.jsp"></c:import>

        <h1 style="margin: auto; text-align: center; width: 60%; color: graytext;">Buy Car</h1>
        <br>
        <div class="row">
            <div class="medium-6 columns">
                <img class="thumbnail" src="<%=c.getImage()%>">
                <div class="panel panel-default">
                    <div class="panel-heading">Features: </div> 
                    <div class="panel-body"><%=c.getFeature()%></div>
                </div>
            </div>
            <div class="medium-6 large-5 columns">
                <h3 style="background-color: "><pre><%="    "+c.getName()+" " +c.getModel()%></pre></h3>
                <div class="row">
                    <div class="small-3 columns">
                        <label for="middle-label" class="middle">Color</label>
                    </div>
                    <div class="small-9 columns">
                        <h5><%=c.getColor()%></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="small-3 columns">
                        <label for="middle-label" class="middle">Top Speed</label>
                    </div>
                    <div class="small-9 columns">
                        <h5><%=c.getSpeed()+" km/hour"%></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="small-3 columns">
                        <label for="middle-label" class="middle">Seats</label>
                    </div>
                    <div class="small-9 columns">
                        <h5><%=c.getSeat()%></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="small-3 columns">
                        <label for="middle-label" class="middle">Fuel Type</label>
                    </div>
                    <div class="small-9 columns">
                        <h5><%=c.getFuel()%></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="small-3 columns">
                        <label for="middle-label" class="middle">Fuel Capacity</label>
                    </div>
                    <div class="small-9 columns">
                        <h5><%=c.getFuelCap()+" liters "%></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="small-3 columns">
                        <label for="middle-label" class="middle">Transmission</label>
                    </div>
                    <div class="small-9 columns">
                        <h5><%=c.getTransmission()%></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="small-3 columns">
                        <label for="middle-label" class="middle">Price</label>
                    </div>
                    <div class="small-9 columns">
                        <h5 class="fa fa-inr" style="font-size:24px"> <%=c.getPrice()%></h5>
                    </div>
                </div>

                <button type="button" class="expanded large button" data-toggle="modal" data-target="#myModal" style="border-radius: 50%">Buy Now</button>


                <div class="modal fade" id="myModal" role="dialog">
                    <div class="modal-dialog">

                <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Enter your Bank Detail</h4>
                            </div>
                            <div class="modal-body" style="margin: auto">
                                <form action="BuyCar?id=<%=c.getId()%>" style="text-align: center;" method="post">
                                    
                                    <select name="bank" class="form-control form" required="">
                                        <option value="">--Choose bank--</option>
                                       <option>Axis bank</option>
                                        <option>Allahabad Bank</option>
                                        <option>Andhra Bank</option>
                                        <option>SWISS BANK</option>
                                        <option>Bandhan Bank</option>
                                        <option>Bank of Baroda</option>
                                        <option>Bank of India</option>
                                        <option>Bank of Maharashtra</option>
                                        <option>CITI bank</option>
                                        <option>CANARA bank</option>
                                        <option>Central Bank of India</option>
                                        <option>Corporation Bank</option>
                                        <option>Dena Bank</option>
                                        <option>DCB Bank</option>
                                        <option>Dhanlaxmi Bank</option>
                                        <option>Federal Bank</option>
                                        <option>HDFC Bank</option>
                                        <option>IDBI Bank</option>
                                        <option>Indian Overseas Bank</option>
                                        <option>Indian Bank</option>
                                        <option>ICICI Bank</option>
                                        <option>IDFC Bank</option>
                                        <option>IndusInd Bank</option>
                                        <option>Jammu and Kashmir Bank</option>
                                        <option>Karnataka Bank</option>
                                        <option>Kotak Mahindra Bank</option>
                                        <option>Oriental Bank of Commerce</option>
                                        <option>Punjab & Sindh Bank</option>
                                        <option>Punjab National Bank</option>
                                        <option>Reserve Bank of India</option>
                                        <option>State Bank of India</option>
                                        <option>Syndicate Bank</option>
                                        <option>UCO Bank</option>
                                        <option>Union Bank of India</option>
                                        <option>United Bank of India</option>
                                        <option>Vijaya Bank</option>
                                        <option>YES Bank</option>                        
                                    </select>
                                    <br>
                                    <input type="number" placeholder="Card number" name="card" class="form-control" title="Card number is not valid" required onkeypress="if(this.value.length === 16) return false;" min="1000000000000000" >
                                    <div class="form-group row">
                                        <div class="col-xs-6">
                                            <input type="month" name="exp" class="form-control" required>
                                        </div>
                                        <div class="col-xs-6">
                                            <input type="password" placeholder="cvv no" name="cvv" class="form-control" pattern="[0-9]{3,4}" title="Invalid CVV" required onkeypress="if(this.value.length > 3) return false;" >
                                        </div>
                                    </div>
                                    <input type="text" placeholder="Card Holder Name" name="holder" class="form-control" pattern="[A-Za-z\s]{3,50}" required>
                                    <br>
                                    <input class="btn btn-success" id="submit" type="submit" value="Place Order">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                                 
        <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
        <script src="https://dhbhdrzi4tiry.cloudfront.net/cdn/sites/foundation.js"></script>
        <script>
              $(document).foundation();
        </script>
        ${error}
    </body>
</html>

<%-- 
    Document   : Orders
    Created on : Sep 26, 2017, 1:05:44 PM
    Author     : Aamir
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="profile.ProfileDAOImplement"%>
<%@page import="profile.ProfileDAO"%>
<%@page import="profile.Profile"%>
<%@page import="order.Order"%>
<%@page import="java.util.List"%>
<%@page import="order.OrderDAOImpl"%>
<%@page import="order.OrderDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Orders</title>
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <%
        
        Profile p=new Profile();
        List<Order> list=new ArrayList<Order>();
        List<Order> listF=new ArrayList<Order>();
        
        try {
                ProfileDAO pdao=new ProfileDAOImplement();
                p=pdao.getProfiles(request.getSession().getAttribute("user").toString());
                
                OrderDAO odao=new OrderDAOImpl();
                list=odao.getOrder();
                
                if(!p.getRole().equals("ADMINISTRATOR")){
                    for (Order o : list) {
                            if(o.getBid() == p.getId() || o.getSid() == p.getId()){
                                listF.add(o);
                            }
                    }
                    request.setAttribute("order", listF);
                }else
                    request.setAttribute("order", list);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "<script>alert('You have to Login first');</script>");
                RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            }
        
    %>
    <body>
        <c:import url="Header.jsp"></c:import>
        <h1 style="margin: auto; text-align: center; width: 60%; color: graytext;" >Orders</h1>

                <br>  
        <table class="table table-striped" style="margin: auto; text-align: center; width: 90%;  font-weight: bold">
            <thead style=" color:gray;">
                <tr>
                        <th>Product ID</th>
                        <th>Seller ID</th>
                        <th>Transaction ID</th>
                        <th>Status</th>
                        <th>Cancel Order</th>
                    <%
                        if(!request.getSession().getAttribute("role").toString().equals("BUYER"))
                        {
                            %>
                                <th>Buyer ID</th>
                                <th>Update</th>
                            <%
                        }
                            if(request.getSession().getAttribute("role").toString().equals("ADMINISTRATOR"))
                            {
                            %>
                                <th>Delete</th>
                            <%
                            }
                        %>
  
   
                </tr>
            </thead>
                
            <tbody>
                <c:forEach items="${order}" var="x" >
                    <tr>
                        <td>${x.getPid()}</td>
                        <td>${x.getSid()}</td>
                        <td>${x.getTid()}</td>
                        <td>${x.getStatus()}</td>
                        <td><a href="CancelOrder?id=${x.getId()}" class="btn btn-danger">Cancel Order</a></td>
                        <%
                        if(!request.getSession().getAttribute("role").toString().equals("BUYER"))
                        {
                            %>
                                <td>${x.getBid()}</td>
                                <td><a href="UpdateOrders.jsp?id=${x.getId()}" class="btn btn-primary">Update</a></td>
                            <%
                        }
                            if(request.getSession().getAttribute("role").toString().equals("ADMINISTRATOR"))
                            {
                            %>
                                <td><a href="DeleteOrders?id=${x.getId()}" class="btn btn-danger">Delete</a></td>
                            <%
                            }
                        %>
                    </tr>
                </c:forEach>
            </tbody>        
        </table>

    </body>
</html>
    
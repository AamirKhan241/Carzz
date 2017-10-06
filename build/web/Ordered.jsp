<%-- 
    Document   : Ordered
    Created on : Sep 26, 2017, 11:54:42 AM
    Author     : Aamir
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="order.Order"%>
<%@page import="order.OrderDAOImpl"%>
<%@page import="order.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Successfull</title>
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <%
        OrderDAO odao=new OrderDAOImpl();
        Order o=odao.getOrderT(Integer.valueOf(request.getParameter("id")));
    %>
    <body>
    <c:import url="Header.jsp"></c:import>
        <h1 style="margin: auto; text-align: center; width: 60%; color: graytext;" >Ordered Successfully</h1>
        <br><br><br>        
        <table class="table table-striped" style="width: 30%; text-align: center; margin: auto">
            <thead>
                <tr>
                    <th colspan="2" style="text-align: center;  background-color: bisque">
                        Order Details
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th>Order Id</th>
                    <td><%=o.getId()%></td>
                </tr>
                <tr>
                    <th>Product Id</th>
                    <td><%=o.getPid()%></td>
                </tr>
                <tr>
                    <th>Transaction Id</th>
                    <td><%=o.getTid()%></td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td><%=o.getStatus()%></td>
                </tr>
                    <tr >
                        <td> <a href="CancelOrder?id=<%=o.getId()%>" class="btn btn-primary" style="width: 300px" >Cancel Order</a></td>
                        <td> <a href="Orders.jsp" class="btn btn-primary" style="width: 300px" >Go To Orders</a></td>
                    </tr>
            </tbody>
        </table>
        
        
    </body>
</html>

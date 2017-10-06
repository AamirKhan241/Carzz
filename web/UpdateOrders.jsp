<%-- 
    Document   : UpdateOrders
    Created on : Sep 26, 2017, 1:24:17 PM
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
        <title>Update Order</title>
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <%
        Order o=new Order();
        try {
                if(!request.getSession().getAttribute("role").toString().equals("BUYER")){
                    OrderDAO odao=new OrderDAOImpl();
                    o=odao.getOrder(Integer.parseInt(request.getParameter("id")));
                }else{
                    response.sendRedirect("Unauthorised.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "<script>alert('You have to Login first');</script>");
                RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            }
        
        
    %>
    <body>
        <c:import url="Header.jsp"></c:import>
        <h1 style="margin: auto; text-align: center; width: 60%; color: graytext;" >Update Order</h1>
        <br>  
        <form action="UpdateOrder?id=<%=o.getId()%>" method="post" style="margin: auto; text-align: center; width: 60%;" >
            <label style="float: left">Order Id:</label>
            <input type="number" class="form form-control" value="<%=o.getId()%>" readonly>
            <br>
            <label style="float: left">Status:</label>
            <input type="text" class="form form-control" value="<%=o.getStatus()%>" name="status" required>
            <br>
            <input type="submit" class="btn btn-success">
        </form>
    </body>
</html>

<%-- 
    Document   : ViewCars
    Created on : Sep 13, 2017, 1:13:40 PM
    Author     : aamir_000
--%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="newcar.NewCar"%>
<%@page import="java.util.List"%>
<%@page import="newcar.NewCarDAOImpl"%>
<%@page import="newcar.NewCarDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Cars</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            th{
                align:"center"
            }
        </style>
    </head>
    <%
        List<NewCar> list=new ArrayList<NewCar>();
        try {
//                String role=request.getSession().getAttribute("role").toString();
                NewCarDAO ncar=new NewCarDAOImpl();
                list=ncar.getCar();
                request.setAttribute("cars", list);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "<script>alert('You have to Login first');</script>");
                RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            }
    %>
    <body>
        
        <c:import url="Header.jsp"></c:import>
        <br>
        <h1 style="margin: auto; text-align: center; width: 60%; color: graytext;">Cars</h1>
        <hr style="color: activeborder;">
        
        <div class="row">

        <c:forEach items="${cars}" var="c" >
            <div class="well col-sm-4" style="width:23%; height: 300px; margin-left: 1%">
                <img class="img-rounded"  src="${c.getImage()}" alt="Image Not Found" style="width: 100%; height: 75%" >
                <label style="float: left; font-size: 20px"> ${c.getName()} ${c.getModel()}</label>
                <label class="fa fa-inr"style="float: right; font-size: 20px"> ${c.getPrice()}</label>
                <br>
                <br>
                <br>
                <div class="row" style="text-align: center">
                    <a  href="BuyCar.jsp?id=${c.getId()}" title="Click here to buy ${c.getName()}" class="fa btn btn-primary" style="margin-top: 1%"> Buy</a>
                       <%
                    try{if(request.getSession().getAttribute("role").toString().equals("ADMINISTRATOR")){
                       %>
                    <a  href="DeleteNewCar?id=${c.getId()}" title="Click here to Delete ${c.getName()}" class="fa btn btn-danger" style="margin-top: 1%"> Delete</a>
                    <a  href="UpdateNewCar.jsp?id=${c.getId()}" title="Click here to Update ${c.getName()}" class="fa btn btn-success" style="margin-top: 1%"> Update</a>
                    <%}}catch(Exception e){}%>
                </div>
            </div>  
        </c:forEach>
            
            <div class="well col-sm-4" style="width:23%; height: 300px; margin-left: 1%; "><div style="margin-top: 20%; text-align: center"><a href="AddCar.jsp"> <span class="glyphicon glyphicon-plus" style="font-size:50px"></span><br>Add Car</a></div></div>
        </div>

        
    </body>
</html>

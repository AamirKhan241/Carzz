<%-- 
    Document   : ViewCars.jsp
    Created on : Sep 18, 2017, 11:17:44 AM
    Author     : aamir_000
--%>

<%@page import="category.Category"%>
<%@page import="category.CategoryDAOImpl"%>
<%@page import="category.CategoryDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="newcar.NewCar"%>
<%@page import="newcar.NewCarDAOImpl"%>
<%@page import="newcar.NewCarDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cars By Category</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <%
        CategoryDAO cdao= new CategoryDAOImpl();
        Category c=cdao.getCategory(Integer.parseInt(request.getParameter("id")));
        
        NewCarDAO ndao=new NewCarDAOImpl();
        List<NewCar> list= ndao.getCarC(Integer.parseInt(request.getParameter("id")));
        request.setAttribute("car", list);
    %>
    <body>
        <c:import url="Header.jsp"></c:import>
        
        <br>
        <h1 style="margin: auto; text-align: center; width: 60%; color: graytext;"><%=c.getCategory_Name()%></h1>
        <hr style="color: activeborder;">
        
        <div class="row">

        <c:forEach items="${car}" var="c" >

                <div class="well col-sm-4" style="width:23%; height: 250px; margin-left: 1%">
                    <img class="img-rounded"  src="${c.getImage()}" title="Manufactured By " alt="Image Not Found" style="width: 100%; height: 90%" >
                    <label style="float: left; font-size: 20px"> ${c.getName()} ${c.getModel()}</label>
                    <a  href="BuyCar.jsp?id=${c.getId()}" title="Click here to buy ${c.getName()}" class="fa btn btn-primary" style="float: right; margin-top: 1%"> &#xf156; ${c.getPrice()}</a>
                </div>  

        </c:forEach>
            
        </div>
    </body>
</html>

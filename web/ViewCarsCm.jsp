<%-- 
    Document   : ViewCarsCm
    Created on : Sep 18, 2017, 12:38:28 PM
    Author     : aamir_000
--%>

<%@page import="company.Company"%>
<%@page import="company.CompanyDAOImpl"%>
<%@page import="company.CompanyDAO"%>
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
        <title>View Cars By Company</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">        
    </head>
    <%
        NewCarDAO ndao=new NewCarDAOImpl();
        List<NewCar> list= ndao.getCarM(Integer.parseInt(request.getParameter("id")));
        request.setAttribute("car", list);
        
        CompanyDAO cdao=new CompanyDAOImpl();
        Company c=cdao.getCompany(Integer.parseInt(request.getParameter("id")));
    %>
    <body>
    <c:import url="Header.jsp"></c:import>
        <br>
        <h1 style="margin: auto; text-align: center; width: 60%; color: graytext;"><%= c.getName()%> Cars</h1>
        <hr style="color: activeborder;">
        
        <div class="row">

        <c:forEach items="${car}" var="c" >

                <div class="well col-sm-4" style="width:25%; height: 200px; margin-left: 1%">
                    <img class="img-rounded"  src="${c.getImage()}" title="Manufactured By " alt="Image Not Found" style="width: 100%; height: 90%" >
                    <label style="float: left; font-size: 20px"> ${c.getName()} ${c.getModel()}</label>
                    <a  href="BuyCar.jsp?id=${c.getId()}" title="Click here to buy ${c.getName()}" class="fa btn btn-primary" style="float: right; margin-top: 1%"> &#xf156; ${c.getPrice()}</a>
                </div>  

        </c:forEach>
            
        </div>
    </body>
</html>

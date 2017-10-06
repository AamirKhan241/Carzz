<%-- 
    Document   : AddCompany
    Created on : Sep 13, 2017, 11:12:33 PM
    Author     : aamir_000
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AddCompany</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <%
        try {
                if(!request.getSession().getAttribute("role").toString().equals("ADMINISTRATOR")){
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
        <h1 style="margin: auto; text-align: center; width: 99%;">Add Company</h1>
        <br>
        <h1 style="color: red; text-align: center">${error}</h1>
        <form action="AddCompany" method="post" style="margin: auto; text-align: center; width: 80%;" enctype="multipart/form-data">
            <input type="text" class="form form-control" placeholder="Company Name" name="name" pattern="[a-zA-Z]{3,20}" title="It can contain small and big characters and length should be between 3 to 20" required>
            <br>
            <textarea type="text" class="form form-control" placeholder="Description" name="desc" minlength="5" maxlength="100" maxlength="100" pattern="{20,100}" title="Length should be between 20 to 100 characters" required></textarea>
            <br>
            <input type="file" name="img" required>
            <br>
            <input type="submit" class="btn btn-primary" name="cat" value="Add">
        </form>
        
    </body>
</html>

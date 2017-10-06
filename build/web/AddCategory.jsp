<%-- 
    Document   : AddCategory
    Created on : Sep 12, 2017, 11:50:02 PM
    Author     : aamir_000
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Category</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            function readURL(input) {
                var path;
                var reader = new FileReader();
    		reader.onload = function (e) {
                    path=e.target.result;
                    $('#blah').attr('src', path);
		};
                reader.readAsDataURL(input.files[0]);
            }   
        </script>
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
        <h1 style="margin: auto; text-align: center; width: 99%;">Add Category</h1>
        <br>
        <h1 style="color: red; text-align: center">${error}</h1>
        <form action="AddCategory" method="post" style="margin: auto; text-align: center; width: 80%;" enctype="multipart/form-data">
            <input type="text" class="form form-control" placeholder="Category Name" name="name" minlength="5" maxlength="20" required pattern="[a-zA-Z\s]+">
            <br>
            <textarea type="text" class="form form-control" placeholder="Description" name="desc" minlength="5" maxlength="100" required></textarea>
            <br>
            <input id='img' type='file' name="img" onchange="readURL(this);" required/>
            <br>
            <input type="submit" class="btn btn-primary" name="cat" >
            <br>
            <hr>
            <img id="blah" src="#" name="data" style="margin: auto; text-align: center; width: 50%;"/>
            <hr>
        </form>
    </body>
</html>

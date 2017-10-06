<%-- 
    Document   : UpdateCategory
    Created on : Sep 12, 2017, 11:52:33 PM
    Author     : aamir_000
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="category.Category"%>
<%@page import="category.CategoryDAOImpl"%>
<%@page import="category.CategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Category</title>
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
        Category c=new Category();
        try {
                if(request.getSession().getAttribute("role").toString().equals("ADMINISTRATOR")){
                    CategoryDAO cdao=new CategoryDAOImpl();
                    c=cdao.getCategory(Integer.parseInt(request.getParameter("id")));
                }else{
                    response.sendRedirect("Unauthorised.jsp");
                }
            } catch (NullPointerException e) {
                e.printStackTrace();
                request.setAttribute("error", "<script>alert('You have to Login first');</script>");
                RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            }
        
    %>
    <body>
        <c:import url="Header.jsp"></c:import>
                
        <h2 style="margin: auto; text-align: center; width: 99%;">Update Category</h2> 
        <br>
        <h1>${error}</h1>
        <br>
        <form action="updateCat?id=<%=c.getId()%>" method="post" style="margin: auto; text-align: center; width: 70%;" enctype="multipart/form-data">
            <input class="form form-control" name="name" type="text" value="<%=c.getCategory_Name()%>" pattern="[a-zA-Z\s]+" required minlength="5" maxlength="20">
            <br>
            <textarea class="form form-control" name="desc" type="text" minlength="10" maxlength="100" required><%=c.getDescription()%></textarea>
            <br>
            <input name="img" type="file" onchange="readURL(this);" >
            <br>
            <input type="submit" class="btn btn-success" value="Update">
            <br>
            <br>
            <img id="blah" src="<%=c.getImage()%>" alt ="image" style="margin: auto; text-align: center; width: 50%;"/>
        </form>
    </body>
</html>


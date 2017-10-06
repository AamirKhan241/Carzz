<%-- 
    Document   : UpdateCompany
    Created on : Sep 13, 2017, 11:44:16 PM
    Author     : aamir_000
--%>

<%@page import="supplier.SupplierDAO"%>
<%@page import="supplier.SupplierDAOImpl"%>
<%@page import="supplier.Supplier"%>
<%@page import="profile.Profile"%>
<%@page import="java.util.List"%>
<%@page import="profile.ProfileDAOImplement"%>
<%@page import="profile.ProfileDAO"%>
<%@page import="company.Company"%>
<%@page import="company.CompanyDAOImpl"%>
<%@page import="company.CompanyDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Company</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        </head>
    <%
        Company c=new Company();
        try {
                if(request.getSession().getAttribute("role").toString().equals("ADMINISTRATOR")){
                    CompanyDAO cdao=new CompanyDAOImpl();
                    c=cdao.getCompany(Integer.parseInt(request.getParameter("id")));
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
        <h1 style="margin: auto; text-align: center; width: 99%;">Update Company</h1>
        <br>
        <h3 style="margin: auto; text-align: center; width: 99%; color: red;">${error}</h3>
        <br>
        <form action="UpdateCompany?id=<%=c.getId()%>" method="post" style="margin: auto; text-align: center; width: 80%;" enctype="multipart/form-data">
            <label style="float: left">Company Name:</label>
            <input type="text" class="form form-control" value="<%=c.getName()%>" name="name" pattern="[a-zA-Z]{3,20}" title="It can contain small and big characters and length should be between 3 to 20" readonly>
            <br>
            <label style="float: left">Company Description: </label>
            <textarea type="text" class="form form-control" placeholder="Description" name="desc" minlength="5" maxlength="100" required="" maxlength="100" pattern="{20,100}" title="Length should be between 20 to 100 characters" required><%=c.getDescription()%></textarea>
            <br>
            <label style="float: left">Image: </label>
            <input type="file" name ="img" >
            <br>
            <input type="submit" class="btn btn-primary" name="cat" value="Update">
        </form>
    </body>
</html>

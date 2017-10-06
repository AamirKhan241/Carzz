<%-- 
    Document   : SupplierDetails
    Created on : Sep 15, 2017, 1:24:45 PM
    Author     : aamir_000
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="supplier.Supplier"%>
<%@page import="supplier.SupplierDAOImpl"%>
<%@page import="supplier.SupplierDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Supplier</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <%
        if(request.getSession().getAttribute("role").toString().equals("ADMINISTRATOR")){
            SupplierDAO sdao=new SupplierDAOImpl();
            List<Supplier> list=sdao.getSupplier();
            request.setAttribute("supplier", list);
        }else{
            response.sendRedirect("Unauthorised.jsp");
        }
    %>
    <body>
    <c:import url="Header.jsp"></c:import>

        <h1 style="margin: auto; text-align: center; width: 60%; color: graytext;">Supplier Details</h1>
        <br>  
        <table class="table table-striped" style="margin: auto; text-align: center; width: 90%;  font-weight: bold">
            <thead style=" color:gray;" >
                <tr>
                    <th>ID</th>
                    <th>Company Id</th>
                    <th>Supplier Id</th>
                    <!--<th>DELETE</th>-->
                    <th>UPDATE</th>
                </tr>
            </thead>
                
            <tbody>
                <c:forEach items="${supplier}" var="x" >
                    <tr>
                        <td>${x.getId()}</td>
                        <td>${x.getcId()}</td>
                        <td>${x.getsId()}</td>
                        <!--<td><a href="DeleteSupplier?id=${x.getId()}" class="btn btn-danger">Delete</a></td>-->
                        <!--<td><a href="UpdateSupplier.jsp?id=${x.getId()}" class="btn btn-primary">Update</a></td>-->
                    </tr>
                </c:forEach>
            </tbody>        
        </table>

    </body>
</html>

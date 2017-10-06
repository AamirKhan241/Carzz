<%-- 
    Document   : ViewCategory
    Created on : Sep 12, 2017, 11:51:23 PM
    Author     : aamir_000
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="category.Category"%>
<%@page import="category.CategoryDAOImpl"%>
<%@page import="java.util.List"%>
<%@page import="category.CategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Categories</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <style>
            th{
                align:"center"
            }
        </style>
    </head>
    <%
        
        System.out.println("view");
        CategoryDAO pdao=new CategoryDAOImpl();
        List<Category> list=pdao.getCategory();
        
        request.setAttribute("category", list);
    %>
    
    <body>
        <c:import url="Header.jsp"></c:import>

                <h1 style="margin: auto; text-align: center; width: 60%; color: graytext;">Cars Categories</h1>
        <br>  
        <table class="table table-striped" style="margin: auto; text-align: center; width: 90%;  font-weight: bold">
            <thead style=" color:gray;">
                <tr>
                        <th>Category</th>
                        <th>Description</th>
                        <th>Image</th>
                        <%
                            try {
                                    if(request.getSession().getAttribute("role").toString().equals("ADMINISTRATOR")){
                                    %>
                                        <th>DELETE</th>
                                        <th>UPDATE</th>
                                    <%
                                    }
                                } catch (Exception e) {
//                                    e.printStackTrace();
//                                    request.setAttribute("error", "<script>alert('You have to Login first');</script>");
//                                    RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
//                                    rd.forward(request, response);
                                }
                        %>
                        <th>View Cars</th>
                </tr>
            </thead>
                
            <tbody>
                <c:forEach items="${category}" var="x" >
                    <tr>
                        <td style="width: 10%">${x.getCategory_Name()}</td>
                        <td>${x.getDescription()}</td>
                        <td style="height: auto; width:30%"><img src="${x.getImage()}" alt="image not uploaded..." height=150 width=200/></td>
                        <%
                            try {
                                    if(request.getSession().getAttribute("role").toString().equals("ADMINISTRATOR")){
                                    %>
                        <td><a href="DeleteCategory?id=${x.getId()}" class="btn btn-danger">Delete</a></td>
                        <td><a href="UpdateCategory.jsp?id=${x.getId()}" class="btn btn-primary">Update</a></td>
                        <%
                                    }
                                } catch (Exception e) {
//                                    e.printStackTrace();
//                                    request.setAttribute("error", "<script>alert('You have to Login first');</script>");
//                                    RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
//                                    rd.forward(request, response);
                                }
                        %>
                        <td><a  href="ViewCarsC.jsp?id=${x.getId()}" class="btn btn-primary" style="margin-top: 1%"> View Cars</a></td>
                    </tr>
                </c:forEach>
                    <tr >
                        <td colspan="5"> <a href="AddCategory.jsp" class="btn btn-primary" style="width: 300px" >Add Category</a></td>
                    </tr>
            </tbody>        
        </table>
    </body>
</html>
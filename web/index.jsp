<%-- 
    Document   : index
    Created on : Sep 12, 2017, 11:46:31 PM
    Author     : aamir_000
--%>

<%@page import="company.CompanyDAOImpl"%>
<%@page import="company.CompanyDAO"%>
<%@page import="company.Company"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="category.Category"%>
<%@page import="category.CategoryDAOImpl"%>
<%@page import="category.CategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <title>CARZZZ.COM</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
            <style>
            ::-webkit-scrollbar {
                width: 0.75%;
                height: 5%;
            }
            ::-webkit-scrollbar-thumb {
                background: #E6E6FA;  
                border-radius: 10px;
            }
            ::-webkit-scrollbar-thumb:hover {
                background: #FAFAD2;  
            }
        </style>
    </head>
    <%
        CategoryDAO cdao=new CategoryDAOImpl();
        List<Category> list=cdao.getCategory();
        request.setAttribute("Category", list);
        
        CompanyDAO comdao=new CompanyDAOImpl();
        List<Company> cList=comdao.getCompany();
        request.setAttribute("company", cList);
    %>
    <body> 
        
        <c:import url="Header.jsp"></c:import>
        
        <div id="myCarousel" class="carousel slide" data-ride="carousel" >
            <!-- Indicators -->
            <ol class="carousel-indicators" >
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
         <%       
             for(int i=1;i<=list.size();i++)
                out.println("<li data-target='#myCarousel' data-slide-to="+i+" ></li>");
         %>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner" style="height: 650px">
                <div class="item active">
                    <img src="https://res.cloudinary.com/bhooooot/image/upload/v1505236015/s2tjjhpzzzwsmtybibuk.jpg" alt="Carzzz.com" width="100%" style="margin-left: auto ; margin-right: auto;margin-bottom: 10px;height: 650px ">
                </div>

            <c:forEach items="${Category}" var="c">
                <div class="item">
                    <a href="ViewCarsC.jsp?id=${c.getId()}">
                        <img src="${c.getImage()}" width="100%" title="click here to see ${c.getCategory_Name()} cars" style="margin-left: auto ; margin-right: auto; height: 650px ">
                        <div class="carousel-caption">
                            <h3>${c.getCategory_Name()}</h3>
                            <p>${c.getDescription()}</p>
                        </div>
                    </a>
                </div>
            </c:forEach>

            </div>

            <!-- Left and right controls -->
            <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>        
        <br>
        <div class="panel-group " style="margin-bottom: 0px; background-color: antiquewhite">
            <div class="panel panel-info container-fluid">
                <div class="row">
                    <div class="panel-heading" style="text-align: center; background-color: #dff0d8">
                        <h2>Companies</h2>
                    </div>
                    <div class="panel-body" >

                        <c:forEach items="${company}" var="com">
                            <div class="col-sm-4" style="width:25%; height: 200px">
                                <a href="ViewCarsCm.jsp?id=${com.getId()}" >
                                    <img class="img-rounded" title="click here to see ${com.getName()} cars" src="${com.getImage()}" alt="Image Not Found" style="width: 100%; height: 90%" >
                                </a>
                            </div>  
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <c:import url="footer.jsp"></c:import>
        ${error}
    </body>
</html>
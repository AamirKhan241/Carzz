<%-- 
    Document   : UpdateNewCar
    Created on : Sep 15, 2017, 1:37:19 PM
    Author     : aamir_000
--%>

<%@page import="profile.Profile"%>
<%@page import="profile.ProfileDAOImplement"%>
<%@page import="profile.ProfileDAO"%>
<%@page import="java.util.List"%>
<%@page import="company.Company"%>
<%@page import="company.CompanyDAOImpl"%>
<%@page import="company.CompanyDAO"%>
<%@page import="category.Category"%>
<%@page import="category.CategoryDAOImpl"%>
<%@page import="category.CategoryDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="newcar.NewCar"%>
<%@page import="newcar.NewCarDAOImpl"%>
<%@page import="newcar.NewCarDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update New Car</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <style>
            #compnew{
                display: none;
            }
        </style>
    </head>
    <%
        NewCar n=new NewCar();
        Company com=new Company();
        Category cat=new Category();
        try {
                NewCarDAO ndao=new NewCarDAOImpl();
                n=ndao.getCar(Integer.parseInt(request.getParameter("id")));
                
                ProfileDAO pdao=new ProfileDAOImplement();
                Profile p=pdao.getProfiles(n.getSuppID());

                if(request.getSession().getAttribute("user").toString().equals(p.getEmail())){
                    String user = (String)request.getSession().getAttribute("user");

                    CategoryDAO cdao=new CategoryDAOImpl();
                    cat=cdao.getCategory(n.getCatID());
                    List<Category> catList=cdao.getCategory();
                    request.setAttribute("category", catList);

                    CompanyDAO cdao1=new CompanyDAOImpl();
                    com=cdao1.getCompany(n.getComID());
                    List<Company> comList=cdao1.getCompany();
                    request.setAttribute("company", comList);
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
        <h3 style="margin: auto; text-align: center; width: 60%; color: gray;">Update Car</h3>
        <br>
        <form action="UpdateNewCar?id=<%=n.getId()%>" method="post" style="margin: auto; text-align: center; width: 80%; color: gray;" enctype="multipart/form-data">
            <label style="float: left">Category: </label>
            <input type="text" class="form-control" value="<%=cat.getCategory_Name()%>" readonly>
            <br>
            <label style="float: left">Company: </label>
            <input type="text" class="form-control" value="<%=com.getName()%>" readonly>
            <br>
            <label style="float: left">Car Name: </label>
            <input type="text" class="form-control" value="<%=n.getName()%>" name="nname" required> 
            <br>
            <label style="float: left">Model: </label>
            <input type="text" class="form-control" value="<%=n.getModel()%>" name="nmodel" required> 
            <br>
            <label style="float: left">Color: </label>
            <input type="text" class="form-control" value="<%=n.getColor()%>" name="ncolor" required> 
            <br>
            <label style="float: left">Top Speed: </label>
            <input type="number" class="form-control" value="<%=n.getSpeed()%>" name="nspeed" required> 
            <br>
            <label style="float: left">Seating Capacity: </label>
            <select class="form-control" name="nseat" >
                <option selected="selected"><%=n.getSeat()%></option>
                <option>Seating Capacity...</option>
                <option>2</option> 
                <option>5</option> 
                <option>7</option> 
            </select>
            <br>            
            <label style="float: left">Fuel Type: </label>
            <select class="form-control" id="fType" name="nfuel" onchange="MyFunction()"  >
                <option selected="selected"><%=n.getFuel()%></option>
                <option> PETROL </option> 
                <option> PETROL/CNG</option> 
                <option> DIESEL</option> 
            </select>
            <br>
            <label style="float: left">Fuel Capacity: </label>
            <input type="number" class="form-control" value="<%=n.getFuelCap()%>" name="nfuelcap" required> 
            <br>
            <label style="float: left">Transmission: </label>
            <select class="form-control" id="fType" name="ntrans" onchange="MyFunction()"   >
                <option selected="selected"><%=n.getTransmission()%></option>
                <option> Automatic </option> 
                <option> Manual </option> 
            </select>
            <br>
            <label style="float: left">Extra Features: </label>
            <textarea class="form-control"  name="nfeature" required><%=n.getFeature()%></textarea>
            <br>
            <label style="float: left">On Road Price: </label>
            <input type="number" class="form-control" value="<%=n.getPrice()%>" name="nrate" required> 
            <br>
            <label style="float: left">Select Image: </label>
            <input type="file" name="nimg" >
            <br>
            <input type="submit" value="Update" class="btn btn-success"> 
        </form>        
    </body>
</html>

<%-- 
    Document   : AddCar
    Created on : Sep 14, 2017, 1:56:36 PM
    Author     : aamir_000
--%>

<%@page import="supplier.Supplier"%>
<%@page import="profile.Profile"%>
<%@page import="profile.ProfileDAOImplement"%>
<%@page import="profile.ProfileDAO"%>
<%@page import="supplier.SupplierDAOImpl"%>
<%@page import="supplier.SupplierDAO"%>
<%@page import="company.CompanyDAOImpl"%>
<%@page import="company.Company"%>
<%@page import="company.CompanyDAO"%>
<%@page import="category.Category"%>
<%@page import="java.util.List"%>
<%@page import="category.CategoryDAOImpl"%>
<%@page import="category.CategoryDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Car</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        .active{
            color: lime;
        }
        #compnew{
                display: none;
        }
        #compused{
                display: none;
        }
        </style> 
    </style>
    </head>
    <%
        CategoryDAO cdao=new CategoryDAOImpl();
        List<Category> c=cdao.getCategory();
        request.setAttribute("category", c);
        CompanyDAO comdao=new CompanyDAOImpl();
    %>
    <body>
        <c:import url="Header.jsp"></c:import>
        <h3 style="margin: auto; text-align: center; width: 60%; color: gray;">Car Details</h3>
        <br>
        <form action="AddNewCar" method="post" style="margin: auto; text-align: center; width: 80%; color: gray;" enctype="multipart/form-data">
            <select class="form-control" id="fType" name="ncategory" required>
                <option selected="selected" value="">Select Category...</option>
                <c:forEach items="${category}" var="c">
                    <option>${c.getCategory_Name()}</option>
                </c:forEach>
            </select>
            <br>
            <select class="form-control" id="ncName" name="ncName" onchange="compn()">
                <%
                    try {                            
                        if(request.getSession().getAttribute("role").toString().equals("BUYER")){
                            response.sendRedirect("Unauthorised.jsp");
                        }else{
                            if(request.getSession().getAttribute("role").toString().equals("SUPPLIER")){
                                ProfileDAO pdao=new ProfileDAOImplement();
                                Profile p=pdao.getProfiles(request.getSession().getAttribute("user").toString());

                                SupplierDAO sdao=new SupplierDAOImpl();
                                Supplier s=sdao.getSupplierS(p.getId());

                                Company com=comdao.getCompany(s.getcId());
                            %>
                            <option selected="selected"><%=com.getName()%></option>
                            <%
                            }else{
                                List<Company> com=comdao.getCompany();
                                request.setAttribute("company", com);
                            %>
                            <option selected="selected" value="">Choose company...</option>
                            <c:forEach items="${company}" var="c" >
                                <option> ${c.getName()} </option> 
                            </c:forEach>
                            <%}
                        }
                    } catch (Exception e) {
                        request.setAttribute("error", "<script>alert('You have to Login first');</script>");
                        RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
                        rd.forward(request, response);
                    }
                %>
            </select>
            <br>
            <input type="text" placeholder="Car Name" class="form-control" name="nname" pattern="[A-Za-z0-9_\s]+{4,20}" title="Enter Valid Car Name special characters A-Z" maxlength="20" required> 
            <br>
            <input type="text" placeholder="Model" class="form-control" name="nmodel" pattern="[A-Za-z0-9_\s]+{3,20}" maxlength="20" required> 
            <br>
            <input type="text" placeholder="Color" class="form-control" name="ncolor" pattern="[A-Za-z_\s]+{3,15}" maxlength="15" required> 
            <br>
            <input type="number" placeholder="Top Speed" class="form-control" name="nspeed" pattern="{1,3}" min="0" max="500" onkeypress="if(this.value.length === 3) return false;" required> 
            <br>
            <select class="form-control" name="nseat" >
                <option selected="selected">Seating Capacity...</option>
                <option>2</option> 
                <option>5</option> 
                <option>7</option> 
            </select>
            <br>
            <select class="form-control" id="fType" name="nfuel" onchange="MyFunction()"  >
                <option selected="selected">Fuel Type...</option>
                <option> PETROL </option> 
                <option> PETROL/CNG</option> 
                <option> DIESEL</option> 
            </select>
            <br>
            <input type="number" placeholder="Fuel Capacity" class="form-control" name="nfuelcap" onkeypress="if(this.value.length === 2) return false;" min="0" max="50" required> 
            <br>
            <select class="form-control" id="fType" name="ntrans" onchange="MyFunction()"  >
                <option selected="selected">Transmission...</option>
                <option> Automatic </option> 
                <option> Manual </option> 
            </select>
            <br>
            <textarea placeholder="Other Features..." class="form-control" name="nfeature" required></textarea>
            <br>
            <input type="number" placeholder="On Road Price" class="form-control" name="nrate" required  onkeypress="if(this.value.length=== 10 )return false;" min="0"> 
            <br>
            <input type="file" name="nimg" required>
            <br>
            <input type="submit" value="Add" class="btn btn-success"> 
            <input type="reset" value="Reset" class="btn btn-success"> 
        </form>        
    </body>
</html>

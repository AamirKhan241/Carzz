<%-- 
    Document   : ViewSupplier
    Created on : Sep 13, 2017, 9:20:58 PM
    Author     : aamir_000
--%>


<%@page import="supplier.SupplierDAOImpl"%>
<%@page import="supplier.SupplierDAO"%>
<%@page import="supplier.Supplier"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="company.Company"%>
<%@page import="company.CompanyDAOImpl"%>
<%@page import="company.CompanyDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Company</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        
    </head>
    <%
        System.out.println("view");
        CompanyDAO pdao=new CompanyDAOImpl();
        List<Company> list=pdao.getCompany();
        request.setAttribute("company", list);        
        SupplierDAO sdao=new SupplierDAOImpl();        
        request.setAttribute("sdao", sdao);       
    %>
    
    <body>
        <c:import url="Header.jsp"></c:import>

        <h1 style="margin: auto; text-align: center; width: 60%; color: graytext;">Companies</h1>
        <br>  
        <table class="table table-striped" style="margin: auto; text-align: center; width: 90%;  font-weight: bold">
            <thead style=" color:gray;" >
                <tr>
                    <th>Company Name</th>
                    <th>Supplier Id</th>
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
                    <th>VIEW CARS</th>
                </tr>
            </thead>
                
            <tbody>
                <c:forEach items="${company}" var="x" >
                    <tr>
                        <td style="width: 10%">${x.getName()}</td>
                        <td>
                            <label style="float: left">Supplier's list</label>
        
                            <select class="form-control" id="supplier" name="cName">
                                <c:forEach var="y" items="${ sdao.getSuppliers( x.getId() ) }">                             
                                    <option>${y.getsId()}</option>
                                </c:forEach>
                            </select>
              
                        </td>
                        <td>${x.getDescription()}</td>
                        <td><img src="${x.getImage()}" height="100px" width="100px"></td>
                        <%
                            try {
                                    if(request.getSession().getAttribute("role").toString().equals("ADMINISTRATOR")){
                        %>
                        <td><a href="DeleteCompany?id=${x.getId()}" class="btn btn-danger">Delete</a></td>
                        <td><a href="UpdateCompany.jsp?id=${x.getId()}" class="btn btn-primary">Update</a></td>
                        <%
                                    }
                                } catch (Exception e) {
//                                    request.setAttribute("error", "<script>alert('You have to Login first');</script>");
//                                    RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
//                                    rd.forward(request, response);
                                }
                        %>
                        <td><a  href="ViewCarsCm.jsp?id=${x.getId()}" class="btn btn-primary" style="margin-top: 1%"> View Cars</a></td>
                    </tr>
                </c:forEach>
                    <tr>
                        <td colspan="6"><a href="AddCompany.jsp" class="btn btn-primary" style="width: 300px" >Add Company</a></td>
                    </tr>             
            </tbody>        
        </table>
    </body>
</html>

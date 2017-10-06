<%-- 
    Document   : UpdateSupplier
    Created on : Sep 17, 2017, 3:53:27 AM
    Author     : aamir_000
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="company.CompanyDAO"%>
<%@page import="company.CompanyDAOImpl"%>
<%@page import="company.Company"%>
<%@page import="supplier.Supplier"%>
<%@page import="supplier.SupplierDAOImpl"%>
<%@page import="supplier.SupplierDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Supplier</title>
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
        <style>
            #UcompD{
                display: none;
            }
        </style>
    </head>
    <%
        SupplierDAO sdao=new SupplierDAOImpl();
        Supplier s=sdao.getSupplier(Integer.parseInt(request.getParameter("id")));
        List<Supplier> Slist=sdao.getSupplier();
        
        CompanyDAO cdao=new CompanyDAOImpl();
        Company c=cdao.getCompany(s.getcId());
        List<Company> Clist=cdao.getCompany();
        
        request.setAttribute("Supplier", Slist);
        request.setAttribute("Company", Clist);
    %>
    <body>
        <c:import url="Header.jsp"></c:import>
                
        <h2 style="margin: auto; text-align: center; width: 99%;">Update Supplier</h2> 
        <br>
        <form action="UpdateSupplier?id=<%=s.getId()%>" method="post" style="margin: auto; text-align: center; width: 70%;" enctype="multipart/form-data">
            
            <label style="float: left">Company Name:</label>
            <select class="form-control" id="Ucomp" name="Ucname" onchange="UcompF()">
                <option selected="selected"><%=c.getName()%></option>
                <option>Select Company...</option>
                <c:forEach items="${Company}" var="x">
                    <option>${x.getName()}</option>         
                </c:forEach>
                <option>Other...</option>
            </select>

            <div id="UcompD">
                <br>
                <h3 style="border:1px silver solid; background-color: blanchedalmond; border-radius: 10%;margin: auto; text-align: center; width: 80%;font-weight: bold; "><u>Specify Company's Details:</u></h3>
                <br>
                <label style="float: left">Company Name:</label>
                <input type="text" name="UcnName" class="form-control" maxlength="20">
                <br>
                <label style="float: left">Company Details:</label>
                <input type="text" name="Ucndesc" class="form-control"  maxlength="100">
                <br>
                <label style="float: left">Image:  </label>
                <input name="Ucimg" type="file" onchange="readURL(this);" >
                <br>
            </div>           
            <script>
                function UcompF(){
                    if(document.getElementById("Ucomp").value === "Other...")document.getElementById("UcompD").style.display="block";
                    else document.getElementById("UcompD").style.display="none";
                }
            </script>

            <input type="submit" class="btn btn-success" value="Update">
        </form>    
    </body>
</html>

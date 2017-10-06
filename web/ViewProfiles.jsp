<%-- 
    Document   : ViewProfiles
    Created on : Sep 12, 2017, 11:53:51 PM
    Author     : aamir_000
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="profile.Profile"%>
<%@page import="profile.ProfileDAOImplement"%>
<%@page import="profile.ProfileDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profiles</title>
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
        try {
                if(request.getSession().getAttribute("role").toString().equals("BUYER")){
                    response.sendRedirect("Unauthorised.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "<script>alert('You have to Login first');</script>");
                RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            }
        ProfileDAO pdao=new ProfileDAOImplement();
        List<Profile> list=pdao.getProfiles();
        request.setAttribute("Profile", list);
    %>
    
    <body>
        <c:import url="Header.jsp"></c:import>

                <h1 style="margin: auto; text-align: center; width: 60%; color: graytext;">Profiles</h1>
        <br>  
        <table class="table table-striped" style="margin: auto; text-align: center; width: 90%;  font-weight: bold">
            <thead style=" color:gray;">
                <tr>
                        <th>Name</th>
                        <th>Date Of Birth</th>
                        <th>Gender</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Contact</th>
                        <th>Address</th>
                        <th>DELETE</th>
                        <th>UPDATE</th>
                </tr>
            </thead>
                
                <tbody>
                    <c:forEach items="${Profile}" var="x">
                        <tr>
                            <td>${x.getfName()} ${x.getlName()}</td>
                            <td>${x.getDOB()}</td>
                            <td>${x.getGender()}</td>
                            <td>${x.getEmail()}</td>
                            <td>${x.getRole()}</td>
                            <td>${x.getContact()}</td>
                            <td>${x.getAddress()}</td>
                            <td><a href="DeleteProfile?id=${x.getId()}" class="btn btn-danger">Delete</a></td>
                            <td><a href="UpdateProfile.jsp?id=${x.getId()}" class="btn btn-primary">Update</a></td>
                        </tr>
                    </c:forEach>
                </tbody>        
            </table>
    </body>
</html>

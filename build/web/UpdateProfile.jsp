<%-- 
    Document   : UpdateProfile
    Created on : Sep 17, 2017, 11:32:20 PM
    Author     : aamir_000
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="supplier.Supplier"%>
<%@page import="supplier.SupplierDAOImpl"%>
<%@page import="supplier.SupplierDAO"%>
<%@page import="profile.Profile"%>
<%@page import="profile.ProfileDAOImplement"%>
<%@page import="profile.ProfileDAO"%>
<%@page import="company.Company"%>
<%@page import="company.CompanyDAOImpl"%>
<%@page import="company.CompanyDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Profile</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function(){  
                var checkField;
                //checking the length of the value of message and assigning to a variable(checkField) on load
                checkField = $("input#Upassword").val().length;  

                var enable = function(){         
                if(checkField > 0){
                    $('#UConfirm_password').removeAttr("disabled");
                $('#Upassword, #UConfirm_password').on('keyup', function () {
                    if (($('#Upassword').val() == $('#UConfirm_password').val())&& checkField != 0) 
                        $('#USubmit').removeAttr("disabled");
                    else 
                        $('#USubmit').attr("disabled","disabled");
                });
                }else{
                    $('#UConfirm_password').attr("disabled","disabled");
                }
                } 
                //calling enableDisableButton() function on load
                enable();            

                $('input#Upassword').keyup(function(){ 
                    //checking the length of the value of message and assigning to the variable(checkField) on keyup
                    checkField = $("input#Upassword").val().length;
                    //calling enableDisableButton() function on keyup
                    enable();
                });
            });
        </script>
        <style>
            #UcompD{
                display: none;
            }
        </style>
        <script>
function validateFormU() {
    var x = document.getElementById("Uemail").value;
    var atpos = x.indexOf("@");
    var dotpos = x.lastIndexOf(".");
    if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length) {
        alert("Not a valid e-mail address");
        return false;
    }
}
</script>

    </head>
    <%
        CompanyDAO cdao=new CompanyDAOImpl();
        Company comp=new Company();
        
        ProfileDAO pdao=new ProfileDAOImplement();
        Profile p;
        try {
                p=pdao.getProfiles(Integer.parseInt(request.getParameter("id")));
            } catch (Exception e) {
                p=pdao.getProfiles(request.getSession().getAttribute("user").toString());
            }

        if(p.getRole().equalsIgnoreCase("SUPPLIER")){
            SupplierDAO sdao=new SupplierDAOImpl();
            Supplier s=sdao.getSupplierS(p.getId()); 
            comp=cdao.getCompany(s.getcId());
        }else{
            comp.setName("");
            comp.setDescription("");
        }
        
        List<Company> list=cdao.getCompany();
        
        request.setAttribute("company", list);
    %>
    <body>
        <c:import url="Header.jsp"></c:import>
        <h2 style="margin: auto; text-align: center; width: 80%;">Update Profiles</h2> 
        <br>        
        <form action="UpdateProfile?id=<%=p.getId()%>" method="post" style="margin: auto; text-align: center; width: 50%;" enctype="multipart/form-data">
            
            <label style="float: left">Role:</label>
            <select class="form-control" id="URole" name="Urole" onchange="MyFunctionU()" >
                <option selected="selected"><%=p.getRole()%></option>
                <option>Choose role...</option>
                <option> ADMINISTRATOR </option> 
                <option> SUPPLIER </option> 
                <option> BUYER </option>         
                <!--<option> BUYER/SELLER </option>-->         
            </select>
            <br>
            <div id="supplDet">
                
                <label style="float: left">Company Name:</label>
                <select class="form-control" id="Ucomp" name="UcName" onchange="UcompF()">
                    <option selected="selected"><%=comp.getName()%></option>
                    <option>Select Company...</option>
                    <c:forEach items="${company}" var="c">
                        <option>${c.getName()}</option>         
                    </c:forEach>
                    <option>Other...</option>
                </select>
                
                
                <div id="UcompD">
                    <br>
                    <h3 style="border:1px silver solid; background-color: blanchedalmond; border-radius: 10%;margin: auto; text-align: center; width: 80%;font-weight: bold; "><u>Specify Company's Details:</u></h3>
                    <br>
                    <label style="float: left">Company Name:</label>
                    <input type="text" name="UncName" pattern="[a-zA-Z]{3,20}" title="It can contain small and big characters and length should be between 3 to 20" class="form-control" maxlength="20">
                    <br>
                    <label style="float: left">Company Details:</label>
                    <input type="text" name="UncDetail" class="form-control" maxlength="100" pattern="{20,100}" title="Length should be between 20 to 100 characters">
                    <br>
                    <input type="file" name="Uncimg">
                    <br>
                </div>           
                <script>
                    function UcompF(){
                        if(document.getElementById("Ucomp").value === "Other...") document.getElementById("UcompD").style.display="block";
                        else document.getElementById("UcompD").style.display="none";
                    }
                </script>
                <br>    
            </div>
                                
            <script>
                function MyFunctionU(){
                    if(document.getElementById("URole").value === "SUPPLIER") document.getElementById("supplDet").style.display="block";
                    else document.getElementById("supplDet").style.display="none";
                }
            </script>
            
            <label style="float: left">First Name:</label>
            <input type="text" placeholder="First Name"  pattern="[A-Za-z]{4,25}" title="Incorrect format Example: John" name="UfName" class="form-control" value="<%=p.getfName()%>" maxlength="50" required>
            <br>
            <label style="float: left">Last Name:</label>
            <input type="text" placeholder="Last Name" name="UlName"  pattern="[A-Za-z]{4,25}" title="Incorrect Format Example: Xavier" class="form-control" value="<%=p.getlName()%>" maxlength="50" required>
            <br>
            <label style="float: left">Date Of Birth:</label>
            <input type="date" placeholder="Date Of Birth" name="UDOB" value="<%=p.getDOB()%>" class="form-control" required>
            <br>
            <label style="float: left" for="gender" >Gender: </label>
            <select class="form-control" name="Ugender">
                <option selected="selected"><%=p.getGender()%></option>
                <option>Male</option>
                <option>Female</option>
            </select>
            <br>
            <label style="float: left;">Email:</label>
            <input type="email" placeholder="Email" name="Uemail" class="form-control" value="<%=p.getEmail()%>" readonly onsubmit="validateFormU()">
            <br>
            <label style="float: left">Password:</label>
            <input id="Upassword" type="password" placeholder="Password" name="Upassword" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" title="[Incorrect pattern. Try correct one like Name@#123]" class="form-control" required maxlength="16">
            
            <br>
            <label style="float: left">Confirm Password:</label>
            <input id="UConfirm_password" type="password" placeholder="Confirm Password" class="form-control" maxlength="16">
            <br>
            <label style="float: left">Contact Number:</label>
            <input type="number" placeholder="Contact Number" name="Ucontact" pattern="[0-9]" title="valid in numeric digit only,0-9" class="form-control" required value="<%=p.getContact()%>" onKeyPress="if(this.value.length===11) return false;" >
            <br>
            <label style="float: left">Address:</label>
            <textarea placeholder="Address" name="Uaddress" class="form-control" required pattern="{20,200}" title="Length should be between 20 to 200 characters"  maxlength="500"><%=p.getAddress()%></textarea>
            <br>               
            <input id="USubmit" type="submit" class="btn btn-primary" value="Update" disabled>
            <a class="btn btn-danger" href="DeleteProfile?id=<%=p.getId()%>">Delete Profile</a>
        </form>          
    </body>

<script>
    $(document).ready(function(){
        if(document.getElementById("URole").value === "SUPPLIER") document.getElementById("supplDet").style.display="block";
                    else document.getElementById("supplDet").style.display="none";
    })
</script>
</html>
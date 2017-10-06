<%-- 
    Document   : Header
    Created on : Sep 12, 2017, 11:48:22 PM
    Author     : aamir_000
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="company.Company"%>
<%@page import="company.CompanyDAOImpl"%>
<%@page import="company.CompanyDAO"%>


<script>
function validateForm() {
    var x = document.getElementById("email").value;
    var atpos = x.indexOf("@");
    var dotpos = x.lastIndexOf(".");
    if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length) {
        alert("Not a valid e-mail address");
        return false;
    }
}
</script>
<script>
function validateFormL() {
    var x = document.getElementById("usrname").value;
    var atpos = x.indexOf("@");
    var dotpos = x.lastIndexOf(".");
    if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length) {
        alert("Not a valid e-mail address");
        return false;
    }
}
</script>

<script>window.console = window.console || function(t) {};</script>
<script>
    if (document.location.search.match(/type=embed/gi)) {
        window.parent.postMessage("resize", "*");
    }
</script>

<style>
    .modal-header, h4, .close {
        background-color: #5cb85c;
        color:white !important;
        text-align: center;
        font-size: 30px;
    }
    .modal-footer {
        background-color: #f9f9f9;
    }
    #suppDet{
        display: none;
    }
    #compn{
        display: none;
    }
    #password-strength-text{
        display: none;
    }
    #password-strength-meter{
        display: none;
    }
</style> 
<script>
    $(document).ready(function(){  
        var checkField;
        //checking the length of the value of message and assigning to a variable(checkField) on load
        checkField = $("input#password").val().length;  

        var enable = function(){         
        if(checkField > 0){
            $('#Confirm_password').removeAttr("disabled");
        $('#password, #Confirm_password').on('keyup', function () {
            if (($('#password').val() == $('#Confirm_password').val())&& checkField != 0) 
                $('#Submit').removeAttr("disabled");
            else 
                $('#Submit').attr("disabled","disabled");
        });
        }else{
            $('#Confirm_password').attr("disabled","disabled");
        }
        } 
        //calling enableDisableButton() function on load
        enable();            

        $('input#password').keyup(function(){ 
            //checking the length of the value of message and assigning to the variable(checkField) on keyup
            checkField = $("input#password").val().length;
            //calling enableDisableButton() function on keyup
            enable();
        });
    });
</script>
<script type="text/javascript">
    function blockSpecialChar(e) {
        var k = e.keyCode;
            console.log(event.which);
            if(k===96 ||k===126 ||k===33 ||k===35 ||k===36 ||k===37 ||k===38||k===40 ||k===41 ||k===42||k===94 ||k===61 ||k===43 ||k===91 ||k===92 ||
                    k===93 ||k===123 ||k===124 ||k===125 ||k===59 ||k===39 ||k===58 ||k===34 ||k===44 ||k===46 ||k===47 ||k===60 ||k===62 ||k===63)
                return false;
     }
</script>
<nav class="navbar navbar-inverse" style="margin-bottom: 0px">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="index.jsp">Carzzz.com</a>
        </div>
        <ul class="nav navbar-nav">
            <% 
                try {
                    if(request.getSession().getAttribute("role").toString().equals("ADMINISTRATOR")){
            %>
            <li class="dropdown">
                <a href="ViewProfiles.jsp">Profiles</a>
            </li>
            <%}
            } catch (Exception e) {}
            %>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">Category<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <%
                        try {
                                if(!request.getSession().getAttribute("role").toString().equals("BUYER")){
                                    %>
                                    <li><a href="AddCategory.jsp">Add Category</a></li>
                                    <%
                                }
                            } catch (Exception e) {
                            }
                    %>
                  <li><a href="ViewCategory.jsp">View Category</a></li>
                </ul>
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">Company<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <%
                        try {
                                if(!request.getSession().getAttribute("role").toString().equals("BUYER")){
                                    %>
                                    <li><a href="AddCompany.jsp">Add Company</a></li>
                                    <%
                                }
                            } catch (Exception e) {
                            }
                    %>                  
                  <li><a href="ViewCompany.jsp">View Companies</a></li>
                </ul>
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">Cars<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <%
                        try {
                                if(!request.getSession().getAttribute("role").toString().equals("BUYER")){
                                    %>
                                    <li><a href="AddCar.jsp">Add Cars</a></li>
                                    <%
                                }
                            } catch (Exception e) {
                            }
                    %>                  
                  <li><a href="ViewNewCars.jsp">View Cars</a></li>
                </ul>
            </li>
            <% 
                try {String log=request.getSession().getAttribute("role").toString();
            %>
            
            <li class="dropdown">
                <a href="Orders.jsp">View Orders</a>
            </li>
            <%} catch (Exception e) {}%>
            
        </ul>
        <%
        
        if( request.getSession().getAttribute("user") == null )
        {
            %>
        <ul class="nav navbar-nav navbar-right" >
            <li><a id='SignUpButton'><span class='glyphicon glyphicon-user'></span> Sign Up</a></li>
            <li><a id='LogInButton' ><span class='glyphicon glyphicon-log-in'></span> LogIn</a></li>
        </ul>
            <%
        }
        else
        {
                %>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="UpdateProfile.jsp" title="Update Profile">Welcome ${name}</a></li>
            <li><a href="LogOut"><span class='glyphicon glyphicon-log-in'></span> Log Out</a></li>
        </ul>
            <%
        }
        %>
        
    </div>
</nav>

<div class="container">
    <div class="modal fade" id="LogIn" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header" style="padding:35px 50px;">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4><span class="glyphicon glyphicon-lock"></span> Login</h4>
                </div>
                <div class="modal-body" style="padding:40px 50px;">
                    <form action="LogIn" method="post" onsubmit="return validateFormL()">
                        <div class="form-group">
                            <label for="usrname"><span class="glyphicon glyphicon-user"></span> Username</label>
                            <input type="email" class="form-control" id="usrname" name="Lemail" placeholder="Enter email" required >
                        </div>
                        <div class="form-group">
                            <label for="psw"><span class="glyphicon glyphicon-eye-open"></span> Password</label>
                            <input type="password" class="form-control" id="psw" name="Lpassword" placeholder="Enter password" required>
                        </div>
                        <button type="submit" class="btn btn-success btn-block"><span class="glyphicon glyphicon-off"></span> Login</button>
                    </form>
                </div>
            </div>      
        </div>
    </div> 
</div>
<script>
    $(document).ready(function(){
        $("#LogInButton").click(function(){
            $("#LogIn").modal();
        });
    });
</script>
<%
    CompanyDAO cdao=new CompanyDAOImpl();
    List<Company> c=cdao.getCompany();
    request.setAttribute("company", c);
%>

<div class="container">
    <div class="modal fade" id="SignUp" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header" style="padding:35px 50px;">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4><span class="glyphicon glyphicon-lock"></span> SignUp</h4>
                </div>
                <div class="modal-body" style="padding:40px 50px;">
                    <form action="GoSignUp" method="post" style="margin: auto; text-align: center; width: 99%;" enctype="multipart/form-data" onsubmit="return validateForm()">
                        <select class="form-control" id="Role" name="role" onchange="supp()" required>
                            <option selected="selected" value="">Choose role...</option>
                                <option> ADMINISTRATOR </option> 
                                <option> SUPPLIER </option> 
                                <option> BUYER </option>         
                                <!--<option> BUYER/SELLER </option>-->         
                        </select>
                        <br>
                        <div id="suppDet">
                            <select class="form-control" id="cName" name="cName" onchange="comp()" >
                                <option selected="selected" value="">Choose company...</option>
                                    <c:forEach items="${company}" var="c" >
                                        <option> ${c.getName()} </option> 
                                    </c:forEach>
                                    <option>Other...</option>         
                            </select>
                            <br>
                            <div id='compn'>
                                <br>
                                <h3 style="border:1px silver solid; background-color: blanchedalmond; border-radius: 10%;margin: auto; text-align: center; width: 80%;font-weight: bold; "><u>Specify Company's Details:</u></h3>
                                <br>
                                <input type="text" placeholder="Company Name" id="cnn" pattern="[a-zA-Z]{3,20}" title="It can contain small and big characters and length should be between 3 to 20" name="ncName" class="form-control" maxlength="100" >
                                <br>
                                <input type="text" placeholder="Company Details" id="cnn" pattern="{20,100}" title="Length should be between 20 to 100 characters" name="ncDetail" class="form-control"  >
                                <br>
                                <input type="file" name="ncimg" >
                                <br>
                            </div>
                            <script>

                            function comp(){
                                if(document.getElementById("cName").value === "Other...") {
                                    document.getElementById("compn").style.display="block";
                                    document.getElementById("cnn").required=true;
                                }
                                else{
                                    document.getElementById("compn").style.display="none";
                                    document.getElementById("cnn").required=false;
                                }
                            }
                            </script>
                        </div>

                        <script>
                            function supp(){
                                if(document.getElementById("Role").value === "SUPPLIER") {
                                    document.getElementById("suppDet").style.display="block";
                                    document.getElementById("cName").required=true;
                                }
                                else {
                                    document.getElementById("suppDet").style.display="none";
                                    document.getElementById("cName").required=false;
                                }
                            }
                        </script>
                        <input type="text" placeholder="First Name" name="fName" pattern="[A-Za-z]{4,25}" title="Incorrect format Example: John" class="form-control" required>
                        <br>
                        <input type="text" placeholder="Last Name" name="lName" pattern="[A-Za-z]{4,25}" title="Incorrect Format Example: Xavier" class="form-control" required>
                        <br>
                        <input type="date" placeholder="Date Of Birth" name="DOB"  id="dob" class="form-control" required>
                        <br>
                        <select class="form-control" name="gender">
                            <option selected="selected">Select Gender...</option>
                            <option>Male</option>
                            <option>Female</option>
                        </select>
                        <br>
                        <input type="email" placeholder="Email" name="email" id="email" class="form-control" required maxlength="100" >
                        <br>
                        <input id="password" type="password" placeholder="Password" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" title="[Incorrect pattern. Try correct one like Name@#123]" name="password" class="form-control" required maxlength="16" >
                        <br>
                        <input id="Confirm_password" type="password" placeholder="Confirm Password" class="form-control" maxlength="16">
                        <br>
                        <input type="number" placeholder="Contact Number" pattern="[0-9]{8,10}" title="valid in numeric digit only,0-9" name="contact"  class="form-control" required onKeyPress="if(this.value.length===10) return false;" >
                        <br>
                        <textarea placeholder="Address" name="address" class="form-control" required pattern="{20,200}" title="Length should be between 20 to 200 characters" ></textarea>
                        <br>
                        <input id="Submit" type="submit" class="btn btn-primary" value="SignUp" disabled>
                        <input type="reset" class="btn btn-primary" placeholder="Reset">
                    </form>
                </div>
            </div>
        </div>
    </div> 
</div>

<script>
    $(document).ready(function(){
        $("#SignUpButton").click(function(){
            $("#SignUp").modal();
        });
    });
</script>  

  <script>
    function da(){
        var d = new Date();
        d.setFullYear(d.getFullYear()-18);
        document.getElementById("dob").defaultValue = d;
    }
</script>
<%@page import="Utils.Encriptar" %>%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuario</title>
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
            if (sesion.getAttribute("logeado") == null || sesion.getAttribute("logeado").equals("0")) {
                response.sendRedirect("login.jsp");
            }
            Connection con = null;
            Statement st = null;
            Encriptar enc = new Encriptar();
        %>
        <div class="container mt-5" >
            <div class="row">
                <div class="col-sm">
                    <form action="datosUsuarios.jsp" method="post">
                        <div class="form-group">
                            <label >User</label>
                            <input type="text" class="form-control" name="user" placeholder="user" value="<%=sesion.getAttribute("user")%>">
                        </div>
                        <div class="form-group">
                            <label >Password</label>
                            <input type="text" class="form-control" name="password1" placeholder="password">
                        </div>
                        <div class="form-group">
                            <label >Repita su password</label>
                            <input type="text" class="form-control" name="password2" placeholder="repita su password">
                        </div>
                        <button type="submit" name="guardar" class="btn btn-primary">Guardar</button>
                        <a href="index.jsp" class="btn btn-danger">Cancelar</a>
                    </form>
                </div>
            </div>
        </div>
    </body>
    <%
        if (request.getParameter("guardar") != null) {
            String user = request.getParameter("user");
            String password1 = request.getParameter("password1");
            String password2 = request.getParameter("password2");
            if (password1.equals(password2)) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost/jsp?user=root");
                    st = con.createStatement();
                    st.executeUpdate("update user set user='" + user + "',password='" + enc.getMd5(password1) + "' where id= '" + sesion.getAttribute("id") + "';");
                    session.setAttribute("user", user);
                    response.sendRedirect("index.jsp");
                } catch (Exception e) {
                    out.print("error en la coneccion" + e);
                }
            } else {
                out.print("<div class=\"alert alert-danger\" role=\"alert\"> Password no coinciden </div>");
            }
        }
    %>
</html>

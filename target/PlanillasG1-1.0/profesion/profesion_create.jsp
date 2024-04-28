<%-- 
    Document   : unidadorganizativa_create
    Created on : 22 abr 2024, 8:27:13 p.m.
    Author     : frane
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profesiones</title>
    </head>
    <body>
        <header>
            <h1>Sistema de Planillas (SIP)</h1>
            <h2>Menu:</h2>
            <nav>
                <ul>
                    <li><a href="../index.jsp">Inicio</a></li>
                    <li><a href="../empresa/empresa_index.jsp">Empresas</a></li>
                    <li><a href="../unidadorganizativa/unidadorganizativa_index.jsp">Unidades Organizativas</a></li>
                    <li><a href="profesion/profesion_index.jsp">Profesiones</a></li>
                </ul>
            </nav>
            <hr>
        </header>
        
        <main>
            <h3>Crear Profesion</h3>
            <br>
            <form action="profesion_store.jsp" method="post">
                <label>Profesion:</label>
                <input type="text" name="nombreprofesion" required>

                <label>Habilitado:</label>
                <input type="checkbox" name="habilitado" value="1">
                <input type="hidden" name="habilitado" value="0">
                
                <button type="submit">Guardar</button>
            </form>
            
        </main>
    </body>
</html>
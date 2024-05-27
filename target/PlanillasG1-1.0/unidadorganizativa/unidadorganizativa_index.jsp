<%-- 
    Document   : unidadorganizativa_index
    Created on : 22 abr 2024, 8:13:32 p.m.
    Author     : frane
--%>

<%@page import="Controllers.EmpresaController"%>
<%@page import="Models.Empresa"%>
<%@page import="Controllers.UnidadorgController"%>
<%@page import="Models.Unidadorganizativa"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Verificar si el usuario está autenticado
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
    <% 
        String rol = (String) session.getAttribute("rol");
        if("r".equals(rol)){
            response.sendRedirect("../index.jsp");
        }
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Unidad Organizativa</title>
        <link rel="stylesheet" href="../css/output.css">
    </head>
    <body>
        <header class="bg-[#80BF96] shadow-md">

            <div class="container text-center text-white">
        
                    <h1 class="text-2xl font-bold py-4 md:text-3xl ">
                        <a href="../index.jsp">Sistema de Planillas</a>
                    </h1>

            </div>  
    
        </header>
        
        <main class="bg-slate-100">

            <section class="container bg-white h-screen">

                <div class="container text-center py-8">
    
                    <h1 class="font-bold text-2xl md:text-3xl border-b-2 pb-4 border-[#80BF96] text-[#629c76]">Unidades Organizativas</h1>
    
                </div>
                <div class="flex justify-center items-center md:justify-start mb-8">
    
                    <a class="bg-[#80BF96] py-2 px-4 text-center rounded-md font-bold 
                    text-white md:ml-8 hover:bg-[#5b9670]" 
                    href="unidadorganizativa_create.jsp">Crear nueva unidad organizativa</a>
    
                </div>

                <div class="overflow-x-auto px-8 pb-8">

                <table class="table-auto mx-auto md:w-full">
                    <thead class="border-b-2 border-slate-600 py-3 px-8 text-center">
                        <td class="px-2 py-2">Nombre de la Unidad Organizativa</td>
                        <td class="px-2 py-2">Empresa Asociada</td>
                        <td class="px-2 py-2">Habilitado</td>
                        <td class="px-2 py-2">Accion</td>
                    </thead>
                    <%
                        EmpresaController controllerEmpresa = new EmpresaController();
                        Empresa empresa = new Empresa();

                        UnidadorgController controller = new UnidadorgController();
                        List<Unidadorganizativa> unidades = controller.mostrarUnidades();   

                        String mensaje;
                    %>
                    <tbody>
                        <%
                            for(Unidadorganizativa unidad : unidades){
                        %>
                        <tr class="text-center border-b border-slate-400">
                            <td class="px-8 py-2 md:px-1"><%=unidad.getNombreunidadorg() %></td>
                            
                            <% 
                                empresa = controllerEmpresa.search(unidad.getId_empresa());
                            %>
                            <td class="px-8 py-2 md:px-1"><%= empresa.getNombreempresa()   %></td>
                            
                            <% 
                                if(Integer.parseInt(unidad.getHabilitado()) == 1){ 
                                    mensaje = "Habilitado";
                                }else{ 
                                    mensaje = "Deshabilitado";
                                }; 
                            %>
                            <td class="px-8 py-2 md:px-1"><%=mensaje %></td>
                            <td class="inline-flex flex-col md:flex-row gap-2 py-2">
                                <form action="unidadorganizativa_edit.jsp" method="POST"
                                class="font-bold bg-[#E1F2D5] px-4 py-2 rounded-md text-[#67814a] hover:bg-[#91aa7f] hover:text-white">
                                    <input type="hidden" name="id" value="<%= unidad.getId_unidadorg() %>">
                                    <input type="submit" value="Editar">
                                </form>                    
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>

            </div>
    </body>
</html>

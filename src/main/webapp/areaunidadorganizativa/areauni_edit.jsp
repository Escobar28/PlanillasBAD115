<%-- 
    Document   : depuni_edit
    Created on : 25 abr 2024, 8:39:04 p. m.
    Author     : Juanjo
--%>

<%@page import="Models.AreaUnidadOrgani"%>
<%@page import="Controllers.AreaUnidadOrganiController"%>
<%@page import="java.util.List"%>
<%@page import="Models.DepUnidadOrgani"%>
<%@page import="Controllers.DepUnidadOrganiController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Verificar si el usuario está autenticado
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    AreaUnidadOrganiController controller = new AreaUnidadOrganiController();
    AreaUnidadOrgani unidad = controller.search(id);
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
        <title>Unidades Organizativas</title>
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

            <section class="container bg-white h-[600vh] min-h-full max-h-screen">

                <div class="container text-center py-8">
    
                    <h1 class="font-bold text-2xl md:text-3xl border-b-2 pb-4 border-[#80BF96] text-[#629c76]">Formulario de actualizacion de area</h1>
    
                </div>

                <form action="areauni_update.jsp" method="post" class="grid md:grid-cols-2 gap-2">
                    
                    <div class="flex flex-col gap-2 px-4">
                        <label>Nombre:</label>
                        <input class="border rounded-lg py-1 px-4 w-full" type="text" name="NOMBREAREAUNIDADORG" value="<%=unidad.getNOMBREAREAUNIDADORG()%>" required>
                        <input type="hidden" name="id" value="<%= unidad.getID_AREAUNIDADORG()%>">
                    </div>

                    <div class="flex flex-col gap-2 px-4">
                        <label>Unidad:</label>
                        <select class="border rounded-lg py-1 px-4 w-full" name="ID_DEPORG" required>
                            <option value="">Selecciona un Departamento...</option>
                            <%                         
                                DepUnidadOrganiController controllerDep = new DepUnidadOrganiController();
                                List<DepUnidadOrgani> depas = controllerDep.mostrarUnidades1();
                                
                                for(DepUnidadOrgani depa : depas){
                                    if(Integer.parseInt(depa.getHabilitado()) == 1){
                            %>
                            <% String selected = (depa.getId_deporg() == unidad.getID_DEPORG())? "selected" : " ";  %>
                            <option value="<%= depa.getId_deporg()%>" <%=selected %>><%= depa.getNombredeporg()%></option>
                            <%  
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <% 
                        String checked;
                        if(Integer.parseInt(unidad.getHabilitado()) == 1){
                            checked = "checked";
                        }else{
                            checked = " ";
                        } 
                    %>
                    <div class="inline-flex px-4 items-center gap-3">
                        <label class="py-6">Habilitado:</label>
                        <input type="checkbox" name="habilitado" value="1" <%=checked %>>
                        <input type="hidden" name="habilitado" value="0">
                    </div>

                    <div class="flex flex-col gap-2 px-4 md:col-span-2 md:flex-row md:mx-auto md:my-4">

                        <button class="bg-[#80BF96] hover:bg-[#629c76] py-2 px-4 text-center rounded-md font-bold text-white md:w-32" type="submit">Guardar</button>
                        <button class="font-bold bg-[#f2f2f2] px-4 py-2 rounded-md text-black hover:bg-[#d4d4d4] hover:text-black md:w-32" type="reset">Limpiar</button>
                    
                    </div>

                </form>

                <div class="md:mx-auto flex justify-center py-12">

                    <a class="bg-gray-900 text-white hover:bg-gray-500 py-2 px-4 text-center rounded" href="./areauni_index.jsp">Regresar al listado</a>

                </div>

            </section>
            
        </main>
    </body>
</html>


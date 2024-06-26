<%-- 
    Document   : unidadorganizativa_index
    Created on : 22 abr 2024, 8:13:32 p.m.
    Author     : frane
--%>

<%@page import="Controllers.EmpleadoController"%>
<%@page import="Models.Empleado"%>
<%@page import="Controllers.DescuentoController"%>
<%@page import="Models.Descuento"%>
<%@page import="Controllers.TipoDescuentoController"%>
<%@page import="Models.TipoDescuento"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%
    // Verificar si el usuario está autenticado
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Descuentos</title>
        <link rel="stylesheet" href="../css/output.css">
        --Agregar los cdns
        <!-- DataTables CSS -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
        
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        
        <!-- DataTables JS -->
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>

    </head>
    <body onload="comenzarTiempo()">
            <% 
                String usuario = (String) session.getAttribute("usuario");
            %>
        <header class="bg-[#80BF96] shadow-md">

            <div class="container text-center text-white">
        
                    <h1 class="text-2xl font-bold py-4 md:text-3xl ">
                        <a href="../index.jsp">Sistema de Planillas</a>
                    </h1>

            </div>  
            <div class="px-12 py-4 text-2xl text-xl flex justify-between bg-black text-white" > 
                <p>Bienvenido:  <%=usuario %> </p>
                <p id="fecha"></p>
            </div>            
    
        </header>
    
        <main class="bg-slate-100">
    
            <section class="container bg-white h-screen">
    
                <div class="container text-center py-8">
                    <% LocalDate now = LocalDate.now(); %>
                    <% DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM yyyy"); %>
                    <h1 class="font-bold text-2xl md:text-3xl border-b-2 pb-4 border-[#80BF96] text-[#629c76]">Reporte por empleado- <%= now.format(formatter) %></h1>
    
                </div>
                <div class="overflow-x-auto px-8 pb-8">

                    <table id="example" class="table-auto mx-auto md:w-full">
                        <thead class="text-center border-b-2 border-slate-600 py-3 px-8">
                            <td class="px-2 py-2">Empleado</td>
                            <td class="px-2 py-2">Salario</td>
                            <td class="px-2 py-2">AFP</td>
                            <td class="px-2 py-2">ISSS</td>
                            <td class="px-2 py-2">RENTA</td>
                            <td class="px-2 py-2">Ingresos</td>
                            <td class="px-2 py-2">Otros descuentos</td>
                            <td class="px-2 py-2">Salario neto</td>
                            <td class="px-2 py-2">Accion</td>
                        </thead>
                        <%                      
                            int currentYear = now.getYear();
                            int currentMonth = now.getMonthValue();
                            EmpleadoController controllerEmpleado = new EmpleadoController();
                            List<Empleado> empleados = controllerEmpleado.mostrarEmpleados();        
                        %>
                        <tbody>
                            <%
                                for(Empleado empleado : empleados){
                                                            //double descuentosTotales = controllerEmpleado1.sumarDescuentosEmpleado(empleado.getId_empleado());  
                                    double otrosDescuentos = controllerEmpleado.sumarDescuentosEmpleado(empleado.getId_empleado(), currentMonth, currentYear); 
                                    double afp = controllerEmpleado.AFPEmpleado(empleado.getId_empleado());
                                    double isss = controllerEmpleado.ISSSEmpleado(empleado.getId_empleado());
                                    double renta = controllerEmpleado.RENTAEmpleado(empleado.getId_empleado());
                                    double salarioNeto = controllerEmpleado.salarioNetoEmpleado(empleado.getId_empleado(), currentMonth, currentYear);
                                    double ingresos = controllerEmpleado.sumarIngresosEmpleado2(empleado.getId_empleado(), currentMonth, currentYear);
                                    double presupuesto = controllerEmpleado.presupuestoNeto(currentMonth, currentYear);
                                    double patron = controllerEmpleado.sumarDescuentosPatronales();
                            %>
                            <tr class="text-center border-b border-slate-400">
                                <td class="px-8 py-2 md:px-1">
                                    <%=empleado.getPrimernombre() %> 
                                    <%
                                        if(empleado.getSegundonombre() != null){
                                    %>
                                            <%=empleado.getSegundonombre()%>
                                    <%
                                        }
                                    %> 
                                    <%=empleado.getPrimerapellido() %> 
                                    <%
                                        if(empleado.getSegundoapellido() != null){
                                    %>
                                            <%=empleado.getSegundoapellido()%>
                                    <%
                                        }
                                    %> 
                                    <%
                                        if(empleado.getApellidocasada() != null){
                                    %>
                                            <%=empleado.getApellidocasada()%>
                                    <%
                                        }
                                    %>
                                </td>                    

                                <td class="px-8 py-2 md:px-1"><%= empleado.getSalario()%></td>
                                <td class="px-8 py-2 md:px-1"><%= String.format("%.2f", afp)%></td>
                                <td class="px-8 py-2 md:px-1"><%= String.format("%.2f", isss)%></td>
                                <td class="px-8 py-2 md:px-1"><%= String.format("%.2f", renta)%></td>
                                <td class="px-8 py-2 md:px-1"><%= String.format("%.2f", ingresos)%></td>
                                <td class="px-8 py-2 md:px-1"><%= String.format("%.2f", otrosDescuentos)%></td>
                                <td class="px-8 py-2 md:px-1"><%= String.format("%.2f", salarioNeto)%></td>
                                <td class="inline-flex flex-col md:flex-row gap-2 py-2">
                                    <form action="descuento2_index.jsp" method="POST"
                                    class="font-bold bg-[#E1F2D5] px-4 py-2 rounded-md text-[#67814a] hover:bg-[#91aa7f] hover:text-white">
                                        <input type="hidden" name="id" value="<%=empleado.getId_empleado()%>">
                                        <input type="submit" value="Ver Descuentos">
                                    </form>
                                        <form action="/PlanillasG1/ingreso/ingreso_empleado_1.jsp" method="POST"
                                    class="font-bold bg-[#E1F2D5] px-4 py-2 rounded-md text-[#67814a] hover:bg-[#91aa7f] hover:text-white">
                                        <input type="hidden" name="id" value="<%=empleado.getId_empleado()%>">
                                        <input type="submit" value="Ver Ingresos">
                                    </form>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </body>
</html>
<script>
       
    function comenzarTiempo(){

        setInterval(actualizarTiempo, 1000);
    }

    function actualizarTiempo(){
        let fecha = new Date();
        let texto = document.getElementById("fecha");

        let dia = String(fecha.getDate()).padStart(2, '0');
        let mes = String(fecha.getMonth() + 1).padStart(2, '0');
        let anio = String(fecha.getFullYear());
        let hora = String(fecha.getHours()).padStart(2, '0');
        let minuto = String(fecha.getMinutes()).padStart(2, '0');
        let segundo = String(fecha.getSeconds()).padStart(2, '0');    
        texto.textContent = dia + '/' + mes + '/' + anio + ' ' + hora + ':' + minuto + ':' + segundo;
    }
</script>
<script>
    $(document).ready( function () {
       $('#example').DataTable();
   });   
</script>
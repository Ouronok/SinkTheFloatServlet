<%@page import="modelo.Partida"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Solucion de hundir la flota</title>

	<style>
		table{
			text-align:center;
			align:center;
		}
		td {
			width: 50px;
		}

		div{
			margin-left: 200px;
		}
	</style>
</head>
<body>
<h1>Hundir la Flota</h1><br>

<% 
		Partida partida = (Partida) session.getAttribute("partida");
		out.println("<p>Solucion Partida<p>");
		out.println("<p>Barcos navegando: "+partida.getRestantes()+"<p>");
		out.println("<p>Barcos hundidos: "+ (partida.getTotales()-partida.getRestantes())+"</p>");
		out.println("<p>Numero de disparos efectuados: "+partida.getDisparos()+"</p>");
		
		 String[] tamano = partida.getTamanoPartida().split("#");
		   int nf = Integer.parseInt(tamano[0]);
		   int nc = Integer.parseInt(tamano[1]);
			out.println("<table");
			out.println("<tr>");
			char letra = 'A';
			out.println("<th></th>");
			for (int i = 0; i < nc; i++) {
				out.println("<th>"+letra+"</th>");
				letra++;
			}
		    for (int i = 0; i < nf; i++) {
		    	out.println("<tr>");
		    	out.println("<th>"+(i+1)+"</th>");
		    	for(int n=0; n<nc;n++){
		    		String color;
		    		if(partida.getCasilla(i, n)==-1){
			    		color = "blue";
		    		} else {
		    			color = "red";
		    		}
		    		out.println("<td style='background-color:"+color+"'></td>");
		    	}
		    	out.println("</tr>");
		    	
		    
		    }
		    out.println("</table>");
		    
		    out.println("<p><a href='NuevaPartidaServlet'>Nueva partida</a></p>");
		    out.println("<p><a href='SalirPartidaServlet'>Salir partida </a></p>"); 
	
	%>
</body>
</html>
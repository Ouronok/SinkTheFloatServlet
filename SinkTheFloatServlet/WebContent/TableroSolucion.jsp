<%@page import="modelo.Partida"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Solucion de hundir la flota</title>

	<style>
		/* Aliniamos el texto con CSS y el el div que contiene el submit para centrar este respecto
		la tabla*/
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
/*Se trta de un código parecido al del Tablero Actual, pero que no contiene botones ni envio 
para selecionar casillas, sino que simplemente muestra la solución de la partida actual*/

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
			/*Puesto que la partida ya se encuentra guardada, simplemente mantiene el funcionamiento del tablero
			actual, pero no solo obtenemos el color de la casilla que hemos pulsado, sino el color de todas la casillas */
			
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
		    
		    //Aparecen menos opciones ya que una vez mostrada la solución, solo podemos crear una nueva partida o salir de esta
		    
		    out.println("<p><a href='NuevaPartidaServlet'>Nueva partida</a></p>");
		    out.println("<p><a href='SalirPartidaServlet'>Salir partida </a></p>"); 
	
	%>
</body>
</html>
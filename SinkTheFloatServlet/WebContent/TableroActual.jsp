<%@page import="modelo.Partida"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Partida de hundir la flota</title>

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

	//Solicitamos la partida que esta guardada en sesion
	Partida partida = (Partida) session.getAttribute("partida");
	boolean over = false;
	//Comprobamos que la partida acaba de ser creada
	if(partida.getDisparos()==0){
		out.println("<p>NUEVA PARTIDA</p>");
	//Comprobamos que la partida ha finalizado
	} else if (partida.getRestantes()==0){
		out.println("<p>GAME OVER</p>");
		over = true;
	} else {
		//Solicitamos la fila y la columna pulsada
		int fila = (int) request.getAttribute("fila");
		int columna = (int) request.getAttribute("columna");
		//Comprobaos que no haya sido pulsada anteriormente
		if((boolean) request.getAttribute("disparada")){
			out.println("<p>Ya habia sido disparada anteriormente</p>");
		} else if (fila==-1 && columna==-1){
		    out.print("<p>Selecciona una casilla valida</p>");
		} else {
			out.println("<p>Pagina del disparo en("+(fila+1)+","+(partida.getCharForNumber(columna+1))+"): Ok!</p>");
		}
		
	}
	//Texto con la informacion necesaria printeando el formato html
	out.println("<p>Barcos navegando:  " +partida.getRestantes()+ " Barcos hundidos: "+ (partida.getTotales()-partida.getRestantes())+"<p>");
	
	out.println("<p>Numero de disparos efectuados: "+partida.getDisparos()+"</p>");
	
   //Solicitamos el tamaño de la partida, numero columnas , numero barcos para poder crear el tablero
   String[] tamano = partida.getTamanoPartida().split("#");
   int nf = Integer.parseInt(tamano[0]);
   int nc = Integer.parseInt(tamano[1]);
    
	out.println("<form action='HundirFlotaServlet' method='GET'>");
	out.println("<table");
	out.println("<tr>");
	char letra = 'A';
	out.println("<th></th>");
	//Creamos el tablero con las letraas en primer lugar , creando las filas y columnas correspondientes
	for (int i = 0; i < nc; i++) {
		out.println("<th>"+letra+"</th>");
		letra++;
	}
	out.println("</tr>");
    for (int i = 0; i < nf; i++) {
    	out.println("<tr>");
    	out.println("<th>"+(i+1)+"</th>");
    	for(int n=0; n<nc;n++){
    		//Asignamos un valor a cada uno de los botones que corresponden a cada casilla
    		String valor = i+"#"+n;
    		
    		String color;
    		if(partida.casillaDisparada(i, n)){
	    		int res = partida.getCasilla(i, n);
	    		//Mediante un switch sabemos el color de la casilla dependiendo de su estado, obtenido en get casilla
	    		switch (res){
	    		case(-1):
	    			color = "blue";
	    			break;
	    		case(-2):
	    			color = "orange";
	    			break;
	    		default:
	    			color = "red";
	    			break;
	    		}
    		} else{
    			color = "White";
    		}
    		//Aqui es donde lo coloreamos y creamos el botón en html
    		out.println("<td style='background-color:"+color+"'><input type='radio' name='casilla' value='"+valor+"'></td>");

    	}

    	out.println("</tr>");

    }
	out.println("</table>");
	//Mientras no haya acadabo la partida podemos seguir probando casillas (pulsando submit, sino desaparece)
	if(!over) {
	    out.println("<div><input type='submit' name='Enviar' value='Submit'></div>");
	}

    out.println("</form>");
    out.println("<br><br><br>");
    //Enlaces mediante HTML para llevar a cabo las opciones consecuentes
    out.println("<p><a href='SolucionPartidaServlet'>Mostrar Solucion</a></p>");
    out.println("<p><a href='NuevaPartidaServlet'>Nueva partida</a></p>");
    out.println("<p><a href='SalirPartidaServlet'>Salir partida</a></p>");    
    



%>
</body>
</html>
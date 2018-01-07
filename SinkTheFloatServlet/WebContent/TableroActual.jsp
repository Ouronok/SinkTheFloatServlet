<%@page import="modelo.Partida"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<style>
	table#taula{
		height:60%;
		width:40%;
		border-collapse: collapse;


	} 
	div{
		text-align: center;

	
	}</style>
<body>
<h1>Hundir la Flota</h1><br>

<%

	Partida partida = (Partida) session.getAttribute("partida");
	boolean over = false;
	if(partida.getDisparos()==0){
		out.println("<p>NUEVA PARTIDA</p>");
		
	} else if (partida.getRestantes()==0){
		out.println("<p>GAME OVER</p>");
		over = true;
	} else {
		int fila = (int) request.getAttribute("fila");
		int columna = (int) request.getAttribute("columna");

		if((boolean) request.getAttribute("disparada")){
			out.println("<p>Ya habia sido disparada anteriormente</p>");
		} else if (fila==-1 && columna==-1){
		    out.print("<p>Selecciona una casilla valida</p>");
		} else {
			out.println("<p>Pagina del disparo en("+(fila+1)+","+(columna+1)+"): Ok!</p>");
		}
		
	}
	out.println("<p>Barcos navegando:  " +partida.getRestantes()+ " Barcos hundidos: "+ (partida.getTotales()-partida.getRestantes())+"<p>");
	
	out.println("<p>Numero de disparos efectuados: "+partida.getDisparos()+"</p>");
	
    
   String[] tamano = partida.getTamanoPartida().split("#");
   int nf = Integer.parseInt(tamano[0]);
   int nc = Integer.parseInt(tamano[1]);
    
	out.println("<form action='HundirFlotaServlet' method='GET'>");
	out.println("<table id='taula'>");
	out.println("<tr>");
	char letra = 'A';
	out.println("<th></th>");
	for (int i = 0; i < nc; i++) {
		out.println("<th>"+letra+"</th>");
		letra++;
	}
	out.println("</tr>");
    for (int i = 0; i < nf; i++) {
    	out.println("<tr>");
    	out.println("<th>"+(i+1)+"</th>");
    	for(int n=0; n<nc;n++){
    		String valor = i+"#"+n;
    		
    		String color;
    		if(partida.casillaDisparada(i, n)){
	    		int res = partida.getCasilla(i, n);
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
    		out.println("<th style='background-color:"+color+"'><input type='radio' name='casilla' value='"+valor+"'></th>");

    	}

    	out.println("</tr>");

    }
	out.println("</table>");
	if(!over) {
	    out.println("<div><input type='submit' name='Enviar' value='Submit'></div>");
	}

    out.println("</form>");
    out.println("<br><br><br>");
    out.println("<p><a href='SolucionPartidaServlet'>Mostrar Solucion</a></p>");
    out.println("<p><a href='NuevaPartidaServlet'>Nueva partida</a></p>");
    out.println("<p><a href='SalirPartidaServlet'>Salir partida</a></p>");    
    



%>
</body>
</html>
package controlador;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import modelo.Partida;

/**
 * Servlet implementation class HundirFlotaServlet
 */
public class HundirFlotaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HundirFlotaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession(true);
		//Solicitamos la partida que se encuentra guardada en la session
		Partida partida = (Partida) session.getAttribute("partida");
		//Si la partida no esta creada la creamos
		if(partida == null) {
			 partida = new Partida(8,8,6);
			 System.out.println("Partida creada");
		} else {
			System.out.println("Casilla pulsada");
			//Solicitamos la informaci�n de la casilla pulsada
			String recv = request.getParameter("casilla");
			int fila;
			int columna;
			//Si esta vacia
			if(recv==null){
				fila=-1;
				columna=-1;
				request.setAttribute("disparada", false);
			//En caso contrario almacenamos la fila y la columna mediante una cadena
			} else {
				String[] casilla = recv.split("#");
				fila = Integer.parseInt(casilla[0]);
				columna = Integer.parseInt(casilla[1]);
				//Almacenamos el atributo de disparada en la casilla pulsada
				if (partida.casillaDisparada(fila, columna)) {
					request.setAttribute("disparada", true);
				} else {
					request.setAttribute("disparada", false);
					int res = partida.pruebaCasilla(fila, columna);
					//Printeamos el resultado de probar dicha casilla
					System.out.println(res);
				}

			}
			request.setAttribute("fila", fila);
			request.setAttribute("columna", columna);
			
			
		}
		//Guardamos la partida en session
		session.setAttribute("partida", partida);
		//Abrimos el tableroActual
		RequestDispatcher vista = request.getRequestDispatcher("TableroActual.jsp");
		vista.forward(request, response);
	}

}

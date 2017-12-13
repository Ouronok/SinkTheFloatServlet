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
		HttpSession session = request.getSession(true);
		Partida partida = (Partida) session.getAttribute("partida");
		if(partida == null) {
			session.setAttribute("partida", new Partida(8,8,6));
			partida = (Partida) session.getAttribute("partida");
		}
		
		String[] casilla = request.getParameter("casilla").split("#");
		int fila = Integer.parseInt(casilla[0]);
		int columna = Integer.parseInt(casilla[1]);
		partida.pruebaCasilla(fila, columna);
		
		
		
		response.setContentType("text/html;charset=UTF-8");
		
		RequestDispatcher vista = request.getRequestDispatcher("TableroActual.jsp");
		vista.forward(request, response);
	}

}

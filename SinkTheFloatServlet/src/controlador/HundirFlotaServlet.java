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
		Partida partida = (Partida) session.getAttribute("partida");
		if(partida == null) {
			 partida = new Partida(8,8,6);
			 System.out.println("Partida creada");
		} else {
			System.out.println("Casilla pulsada");
			
			String[] casilla = request.getParameter("casilla").split("#");
			System.out.println(casilla);
			int fila = Integer.parseInt(casilla[0]);
			int columna = Integer.parseInt(casilla[1]);
			if(partida.casillaDisparada(fila, columna)) {
				request.setAttribute("disparada", true);
			} else {
				request.setAttribute("disparada", false);
				int res = partida.pruebaCasilla(fila, columna);
				System.out.println(res);
				
				
			}
			request.setAttribute("fila", fila);
			request.setAttribute("columna", columna);
			
			
		}
		session.setAttribute("partida", partida);
		RequestDispatcher vista = request.getRequestDispatcher("TableroActual.jsp");
		vista.forward(request, response);
	}

}

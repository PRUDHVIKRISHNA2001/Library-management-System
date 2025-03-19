package Login;

import jakarta.servlet.RequestDispatcher;
import java.sql.*;
import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;


/**
 * Servlet implementation class StudentControllerServlet
 */
public class StudentControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String id = request.getParameter("student_id");
		String password = request.getParameter("student_password");
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library?characterEncoding=latin1","root","Agrawal1683");
			String query = "select * from Student where id = '"+id+"'";
			Statement ps = con.createStatement();
			//ps.setString(1, id);
			ResultSet rs = ps.executeQuery(query);
			rs.next();
			String pass = rs.getString(3);
			if(pass.equals(password)) {
				Student student = new Student();
				student.setId(id);
				student.setName(rs.getString(2));
				student.setPass(password);
				student.setNumber(rs.getLong(4));
				HttpSession session = request.getSession();
				session.setAttribute("student", student);
				RequestDispatcher rd = request.getRequestDispatcher("student-home.jsp");
				rd.forward(request, response);
			}
			else {
				out.println("Wrong Password!!");
				RequestDispatcher rd = request.getRequestDispatcher("login-error.jsp");
				rd.forward(request, response);
			}
		} catch (SQLException e) {
			out.println("Check username or contact librarian to get Registered");
		} 
		catch(Exception e){
			out.println("Unsuccessful!");
		}
	}

}

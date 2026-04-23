package servlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import action.*;
@WebServlet("*.do")  
public class ServletDispatcher extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }
    private void processRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getServletPath();
        Action action = null;
        switch(path) {
            case "/login.do":
                action = new LoginAction();
                break;
            case "/logout.do":
                action = new LogoutAction();
                break;
            case "/products.do":
            case "/admin.do":    
                action = new ProductListAction();
                break;
            case "/addProduct.do":
                action = new AddProductAction();
                break;
            case "/deleteProduct.do":
                action = new DeleteProductAction();
                break;
            case "/editProduct.do":
                action = new EditProductAction();
                break;
            default:
                action = new LoginAction();
        }
        
        String view = action.execute(request, response);
        
        if (view != null) {
            if (view.startsWith("redirect:")) {
                response.sendRedirect(view.substring(9));
            } else {request.getRequestDispatcher("/view/" + view).forward(request, response);}
        }}
}
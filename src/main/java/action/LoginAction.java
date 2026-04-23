package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import services.UserService;
import services.UserServiceImpl;

public class LoginAction implements Action {
    
    private UserService userService = new UserServiceImpl();
    
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        
        if ("GET".equals(req.getMethod())) {
            return "login.jsp";
        }
        
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        
        if (userService.authenticate(username, password)) {
            HttpSession session = req.getSession();
            session.setAttribute("user", username);
            session.setAttribute("role", userService.getRole(username)); 
            return "redirect:products.do";  
        } else {
            req.setAttribute("error", "Login ou mot de passe incorrect");
            return "login.jsp";
        }
    }
}
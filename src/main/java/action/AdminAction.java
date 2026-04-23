package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Produit;
import services.ProductService;
import services.ProductServiceImpl;
import java.util.List;

public class AdminAction implements Action {
    
    private ProductService productService = new ProductServiceImpl();
    
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            return "redirect:login.do";
        }
        
        List<Produit> products = productService.getAllProducts();
        req.setAttribute("products", products);
        return "admin.jsp";
    }
}
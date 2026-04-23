package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.ProductService;
import services.ProductServiceImpl;

public class ProductListAction implements Action {
    
    private ProductService productService = new ProductServiceImpl();
    
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        // Récupérer tous les produits
        req.setAttribute("products", productService.getAllProducts());
        
        // Une seule JSP pour tout le monde
        return "products.jsp";
    }
}
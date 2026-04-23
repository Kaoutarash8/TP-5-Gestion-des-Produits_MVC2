package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.ProductService;
import services.ProductServiceImpl;

public class DeleteProductAction implements Action {
    
    private ProductService productService = new ProductServiceImpl();
    
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        int id = Integer.parseInt(req.getParameter("id"));
        productService.deleteProduct(id);
        return "redirect:products.do";
    }
}
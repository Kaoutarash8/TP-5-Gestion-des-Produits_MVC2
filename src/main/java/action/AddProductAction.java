package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Produit;
import services.ProductService;
import services.ProductServiceImpl;

public class AddProductAction implements Action {
    
    private ProductService productService = new ProductServiceImpl();
    
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        
        if ("GET".equals(req.getMethod())) {
            return "addProduct.jsp";
        }
        
        String nom = req.getParameter("nom");
        double prix = Double.parseDouble(req.getParameter("prix"));
        int quantite = Integer.parseInt(req.getParameter("quantite"));
        
        Produit product = new Produit();
        product.setNom(nom);
        product.setPrix(prix);
        product.setQuantite(quantite);
        
        productService.addProduct(product);
        
        return "redirect:products.do";
    }
}
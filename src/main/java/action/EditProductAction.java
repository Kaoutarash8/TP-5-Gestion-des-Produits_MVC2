package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Produit;
import services.ProductService;
import services.ProductServiceImpl;

public class EditProductAction implements Action {
    
    private ProductService productService = new ProductServiceImpl();
    
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        
        if ("GET".equals(req.getMethod())) {
            int id = Integer.parseInt(req.getParameter("id"));
            Produit product = productService.getProductById(id);
            req.setAttribute("product", product);
            return "editProduct.jsp";
        }
        
        int id = Integer.parseInt(req.getParameter("id"));
        String nom = req.getParameter("nom");
        double prix = Double.parseDouble(req.getParameter("prix"));
        int quantite = Integer.parseInt(req.getParameter("quantite"));
        
        Produit product = new Produit();
        product.setId(id);
        product.setNom(nom);
        product.setPrix(prix);
        product.setQuantite(quantite);
        
        productService.updateProduct(product);
        
        return "redirect:products.do";
    }
}
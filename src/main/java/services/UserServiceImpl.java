package services;

import dao.UserDAO;
import dao.UserDAOImpl;
import model.User;

public class UserServiceImpl implements UserService {
    
    private UserDAO userDAO = new UserDAOImpl();
    
    @Override
    public boolean authenticate(String username, String password) {
        User user = userDAO.findByUsername(username);
        return user != null && user.getPassword().equals(password);
    }
    
    @Override
    public String getRole(String username) {
        User user = userDAO.findByUsername(username);
        return user != null ? user.getRole() : "USER";
    }
}
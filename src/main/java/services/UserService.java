package services;

public interface UserService {
    boolean authenticate(String username, String password);
    String getRole(String username);
}
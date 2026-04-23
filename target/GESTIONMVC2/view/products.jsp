<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Produits</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .header { background-color: #0d6efd; color: white; padding: 15px 0; margin-bottom: 30px; }
        .logout { color: white; text-decoration: none; }
        .logout:hover { color: #f8f9fa; text-decoration: underline; }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h3 class="mb-0">Gestion des Produits</h3>
                </div>
                <div class="col-md-6 text-end">
                    <span class="me-3">${sessionScope.user} (${sessionScope.role})</span>
                    <a href="logout.do" class="logout">Deconnexion</a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container">
        <!-- Bouton Ajouter : visible seulement pour ADMIN -->
        <c:if test="${sessionScope.role == 'ADMIN'}">
            <button class="btn btn-primary mb-3" onclick="openAddModal()">Ajouter un produit</button>
        </c:if>
        
        <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Nom du produit</th>
                        <th>Prix (DH)</th>
                        <th>Quantite</th>
                        <c:if test="${sessionScope.role == 'ADMIN'}">
                            <th>Actions</th>
                        </c:if>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty products}">
                            <tr>
                                <td colspan="${sessionScope.role == 'ADMIN' ? 5 : 4}" class="text-center text-muted py-4">
                                    Aucun produit trouve
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${products}" var="p">
                                <tr>
                                    <td>${p.id}</td>
                                    <td>${p.nom}</td>
                                    <td>${p.prix}</td>
                                    <td>${p.quantite}</td>
                                    <c:if test="${sessionScope.role == 'ADMIN'}">
                                        <td>
                                            <button class="btn btn-sm btn-warning" onclick="openEditModal(${p.id}, '${p.nom}', ${p.prix}, ${p.quantite})">Modifier</button>
                                            <button class="btn btn-sm btn-danger" onclick="confirmDelete(${p.id})">Supprimer</button>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- Modal Ajouter (visible seulement pour ADMIN) -->
    <c:if test="${sessionScope.role == 'ADMIN'}">
        <div class="modal fade" id="addModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">Ajouter un produit</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="addProduct.do" method="post">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Nom du produit</label>
                                <input type="text" class="form-control" name="nom" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Prix (DH)</label>
                                <input type="number" step="0.01" class="form-control" name="prix" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Quantite</label>
                                <input type="number" class="form-control" name="quantite" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                            <button type="submit" class="btn btn-primary">Ajouter</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Modal Modifier -->
        <div class="modal fade" id="editModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">Modifier le produit</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="editProduct.do" method="post">
                        <div class="modal-body">
                            <input type="hidden" name="id" id="editId">
                            <div class="mb-3">
                                <label class="form-label">Nom du produit</label>
                                <input type="text" class="form-control" name="nom" id="editNom" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Prix (DH)</label>
                                <input type="number" step="0.01" class="form-control" name="prix" id="editPrix" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Quantite</label>
                                <input type="number" class="form-control" name="quantite" id="editQuantite" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                            <button type="submit" class="btn btn-primary">Mettre a jour</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:if>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        <c:if test="${sessionScope.role == 'ADMIN'}">
        var addModal = new bootstrap.Modal(document.getElementById('addModal'));
        var editModal = new bootstrap.Modal(document.getElementById('editModal'));
        
        function openAddModal() {
            addModal.show();
        }
        
        function openEditModal(id, nom, prix, quantite) {
            document.getElementById('editId').value = id;
            document.getElementById('editNom').value = nom;
            document.getElementById('editPrix').value = prix;
            document.getElementById('editQuantite').value = quantite;
            editModal.show();
        }
        
        function confirmDelete(id) {
            if (confirm('Voulez-vous vraiment supprimer ce produit ?')) {
                window.location.href = 'deleteProduct.do?id=' + id;
            }
        }
        </c:if>
    </script>
</body>
</html>
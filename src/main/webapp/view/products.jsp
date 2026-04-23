<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Produits</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-white">

    <!-- En-tête bleu -->
    <div class="bg-primary text-white p-3 mb-4">
        <div class="container d-flex justify-content-between">
            <h4 class="m-0">Les Produits</h4>
            <div>
                ${sessionScope.user} (${sessionScope.role})
                <a href="logout.do" class="text-white ms-3">Deconnexion</a>
            </div>
        </div>
    </div>

    <div class="container">
        
        <c:if test="${sessionScope.role == 'ADMIN'}">
            <button class="btn btn-primary mb-3" onclick="openAddModal()">Ajouter</button>
        </c:if>

        <!-- Tableau -->
        <table class="table table-bordered">
            <thead class="table-primary">
                <tr>
                    <th>ID</th><th>Nom</th><th>Prix</th><th>Quantite</th>
                    <c:if test="${sessionScope.role == 'ADMIN'}"><th>Actions</th></c:if>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${products}" var="p">
                    <tr>
                        <td>${p.id}</td>
                        <td>${p.nom}</td>
                        <td>${p.prix}</td>
                        <td>${p.quantite}</td>
                        <c:if test="${sessionScope.role == 'ADMIN'}">
                            <td>
                                <button class="btn btn-primary btn-sm" onclick="openEditModal(${p.id}, '${p.nom}', ${p.prix}, ${p.quantite})">Modifier</button>
                                <button class="btn btn-primary btn-sm" onclick="confirmDelete(${p.id})">Supprimer</button>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
                <c:if test="${empty products}">
                    <tr><td colspan="5" class="text-center">Aucun produit</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- Modal Ajouter -->
    <c:if test="${sessionScope.role == 'ADMIN'}">
    <div class="modal fade" id="addModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Ajouter</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="addProduct.do" method="post">
                    <div class="modal-body">
                        <input type="text" name="nom" class="form-control mb-2" placeholder="Nom" required>
                        <input type="number" step="0.01" name="prix" class="form-control mb-2" placeholder="Prix" required>
                        <input type="number" name="quantite" class="form-control mb-2" placeholder="Quantite" required>
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
                    <h5 class="modal-title">Modifier</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="editProduct.do" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="id" id="editId">
                        <input type="text" name="nom" id="editNom" class="form-control mb-2" placeholder="Nom" required>
                        <input type="number" step="0.01" name="prix" id="editPrix" class="form-control mb-2" placeholder="Prix" required>
                        <input type="number" name="quantite" id="editQuantite" class="form-control mb-2" placeholder="Quantite" required>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                        <button type="submit" class="btn btn-primary">Modifier</button>
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
        
        function openAddModal() { addModal.show(); }
        function openEditModal(id, nom, prix, qte) {
            document.getElementById('editId').value = id;
            document.getElementById('editNom').value = nom;
            document.getElementById('editPrix').value = prix;
            document.getElementById('editQuantite').value = qte;
            editModal.show();
        }
        function confirmDelete(id) {
            if(confirm('Supprimer ?')) window.location.href = 'deleteProduct.do?id=' + id;
        }
        </c:if>
    </script>
</body>
</html>
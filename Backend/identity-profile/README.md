# Authentification et comptes

Responsable : Toute l’équipe — délégué oral : Ayoub.

Relier les comptes métier au fournisseur OIDC, gérer l’état des comptes, les rôles et les coordonnées privées. Le profil professionnel ne relève plus du socle commun : il appartient au service métier 6 d’Ayoub.

Socle commun hors décompte.

## Contrat et données

Voir openapi.json et schema.sql. Les modèles sont une conception, sans serveur métier implémenté.

## Communication synchrone

Le service d’Ayoub vérifie le compte actif avec GET /users/me; Notification récupère uniquement le contact privé autorisé par API interne.

## Événements

account.updated.v1

## Travail backend et frontend

Voir Documentation/Organisation/Mission_Ayoub_Backend_Frontend.md et Repartition_Backend_Frontend.md depuis la racine du projet.

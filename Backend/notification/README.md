# Notifications

Responsable : Oussama.

Statut : conception semaine 4, code applicatif à développer.

Créer une boîte de réception par utilisateur, appliquer les préférences et relancer les envois courriel.

## Décompte

Microservice métier 5 sur 6.

## Données et contrats

Base propriétaire : notification. Classes et API : diagramme de classes, openapi.json et schema.sql. Les clés étrangères restent locales.

## Communication synchrone

Le worker courriel récupère les coordonnées autorisées via une API interne limitée du socle Utilisateurs, puis contacte le fournisseur de messagerie.

## Communication asynchrone

notification.email.requested.v1.

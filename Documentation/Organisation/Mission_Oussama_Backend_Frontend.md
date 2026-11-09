# Mission de Oussama — Notifications

Classe SSA 9 · microservice métier 5 sur 6. Cette fiche décrit le travail à réaliser.

## Backend

Consommer les événements dans des files dédiées; gérer boîte, préférences, tentatives de livraison, déduplication, reprises et DLQ. Obtenir les coordonnées par le socle comptes avec une identité de service.

Données propriétaires : base `notification`. Le backend valide les entrées, vérifie l’identité et les droits sur chaque ressource, conserve ses données et renvoie des erreurs compréhensibles. Les références vers les autres services sont des identifiants externes.

Communication synchrone : Le worker courriel récupère les coordonnées autorisées via une API interne limitée du socle Utilisateurs, puis contacte le fournisseur de messagerie.

Communication asynchrone : notification.email.requested.v1. Les consommateurs utilisent des traitements idempotents et des reprises bornées.

## Frontend

Créer le centre de notifications, le compteur non lu, les actions de lecture et les préférences. Les liens ouvrent uniquement des ressources accessibles à l’utilisateur.

Les pages appartiennent à l’application Next.js commune et utilisent les API du backend via la Gateway. Elles doivent gérer chargement, données absentes, accès refusé et erreurs, ainsi que la navigation clavier et mobile.

## Écrans et contrats à relier

- `GET /notifications` : Lire ma boîte de réception — 200.
- `POST /notifications/{id}/read` : Marquer comme lue — 200.
- `GET /notification-preferences` : Lire mes préférences — 200.
- `PATCH /notification-preferences` : Modifier mes préférences — 200.

Les contrats complets, entrées, réponses et erreurs se trouvent dans `Documentation/Contrats/notification.openapi.json`.

## Ordre de réalisation proposé

1. Définir les règles métier et les modèles de données.
2. Implémenter les API, validations, autorisations et tests backend.
3. Réaliser les pages et le client API frontend avec les états d’erreur.
4. Intégrer les échanges avec les services concernés et les événements.
5. Vérifier le parcours complet, les accès refusés et les reprises.

## Critères de fin

- Un événement rejoué ne crée pas de doublon; les préférences sont respectées; les échecs finaux sont traçables.
- Les données appartiennent au service et les accès sont vérifiés côté backend.
- Les écrans et contrats décrivent les mêmes comportements et états.
- Une fonctionnalité IA future est appelée par ce backend, jamais directement par le frontend.
- Les tests métier et d’intégration sont réalisés avec l’implémentation.

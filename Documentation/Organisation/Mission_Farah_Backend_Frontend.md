# Mission de Farah — Communication

Classe SSA 9 · microservice métier 4 sur 6. Cette fiche décrit le travail à réaliser.

## Backend

Gérer conversations, participants, messages et pièces jointes. Vérifier les participants auprès du service Contrats et à chaque accès. Persister message et outbox avant de publier message.sent.

Données propriétaires : base `communication`. Le backend valide les entrées, vérifie l’identité et les droits sur chaque ressource, conserve ses données et renvoie des erreurs compréhensibles. Les références vers les autres services sont des identifiants externes.

Communication synchrone : Lit les participants du contrat par GET /contracts/{id} lors de l’ouverture; contrôle leur appartenance à chaque lecture/écriture.

Communication asynchrone : message.sent.v1. Les consommateurs utilisent des traitements idempotents et des reprises bornées.

## Frontend

Créer la liste des conversations, l’historique paginé, le formulaire de message, les pièces jointes et les états de lecture. Prévoir chargement, absence de messages et erreurs.

Les pages appartiennent à l’application Next.js commune et utilisent les API du backend via la Gateway. Elles doivent gérer chargement, données absentes, accès refusé et erreurs, ainsi que la navigation clavier et mobile.

## Écrans et contrats à relier

- `GET /conversations` : Lister mes conversations — 200.
- `GET /conversations/{id}/messages` : Historique paginé — 200.
- `POST /conversations/{id}/messages` : Envoyer un message — 201.
- `POST /messages/{id}/read` : Marquer la lecture — 200.

Les contrats complets, entrées, réponses et erreurs se trouvent dans `Documentation/Contrats/communication.openapi.json`.

## Ordre de réalisation proposé

1. Définir les règles métier et les modèles de données.
2. Implémenter les API, validations, autorisations et tests backend.
3. Réaliser les pages et le client API frontend avec les états d’erreur.
4. Intégrer les échanges avec les services concernés et les événements.
5. Vérifier le parcours complet, les accès refusés et les reprises.

## Critères de fin

- Un tiers ne peut lire ou envoyer de message; le texte du message ne circule pas dans les événements.
- Les données appartiennent au service et les accès sont vérifiés côté backend.
- Les écrans et contrats décrivent les mêmes comportements et états.
- Une fonctionnalité IA future est appelée par ce backend, jamais directement par le frontend.
- Les tests métier et d’intégration sont réalisés avec l’implémentation.

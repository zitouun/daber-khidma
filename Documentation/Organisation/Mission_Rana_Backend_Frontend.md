# Mission de Rana — Propositions et sélection

Classe SSA 9 · microservice métier 2 sur 6. Cette fiche décrit le travail à réaliser.

## Backend

Gérer les propositions, leurs versions, le retrait, la présélection et l’attribution. Vérifier le projet et son propriétaire auprès du catalogue; réserver avant de créer la sélection. Publier proposal.accepted et suivre la création du contrat.

Données propriétaires : base `proposal`. Le backend valide les entrées, vérifie l’identité et les droits sur chaque ressource, conserve ses données et renvoie des erreurs compréhensibles. Les références vers les autres services sont des identifiants externes.

Communication synchrone : Vérifie le projet et son propriétaire dans Catalog; réserve l’attribution avant le commit local de Selection et OutboxEvent.

Communication asynchrone : proposal.accepted.v1. Les consommateurs utilisent des traitements idempotents et des reprises bornées.

## Frontend

Créer les formulaires de candidature, la liste des propositions, leur comparaison et la sélection. Après un retour 202, afficher l’attente et interroger le statut de la sélection.

Les pages appartiennent à l’application Next.js commune et utilisent les API du backend via la Gateway. Elles doivent gérer chargement, données absentes, accès refusé et erreurs, ainsi que la navigation clavier et mobile.

## Écrans et contrats à relier

- `POST /projects/{id}/proposals` : Déposer une proposition — 201.
- `GET /projects/{id}/proposals` : Consulter les propositions autorisées — 200.
- `POST /proposals/{id}/shortlist` : Présélectionner — 200.
- `POST /proposals/{id}/withdraw` : Retirer sa proposition — 200.
- `POST /proposals/{id}/accept` : Lancer une attribution idempotente — 202.
- `GET /selections/{id}` : Suivre la création du contrat — 200.

Les contrats complets, entrées, réponses et erreurs se trouvent dans `Documentation/Contrats/proposal-selection.openapi.json`.

## Ordre de réalisation proposé

1. Définir les règles métier et les modèles de données.
2. Implémenter les API, validations, autorisations et tests backend.
3. Réaliser les pages et le client API frontend avec les états d’erreur.
4. Intégrer les échanges avec les services concernés et les événements.
5. Vérifier le parcours complet, les accès refusés et les reprises.

## Critères de fin

- Une seule proposition active par freelancer et projet; une seule attribution; une clé répétée ne crée pas de doublon.
- Les données appartiennent au service et les accès sont vérifiés côté backend.
- Les écrans et contrats décrivent les mêmes comportements et états.
- Une fonctionnalité IA future est appelée par ce backend, jamais directement par le frontend.
- Les tests métier et d’intégration sont réalisés avec l’implémentation.

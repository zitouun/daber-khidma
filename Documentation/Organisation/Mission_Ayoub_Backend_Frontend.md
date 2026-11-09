# Mission d’Ayoub — Profil professionnel, CV et matching

Classe SSA 9 · microservice métier 6 sur 6. Le socle authentification/comptes est commun et hors décompte. Cette fiche décrit le travail à réaliser.

## Backend

Ayoub réalise le backend métier Profil professionnel/CV/Matching, identifié par le dossier ai-matching. Les routes publiques sont servies par Spring Boot et passent par la Gateway. Le moteur Python/FastAPI est privé et séparé de ces routes.
La couche contrôleur reçoit et valide les DTO; la couche applicative orchestre les cas d’usage; le domaine impose propriété, confirmation et versions; les repositories conservent les données PostgreSQL. Un AIClient avec adaptateur HTTP est la seule dépendance vers le moteur privé. Un faux adaptateur déterministe doit permettre les tests sans modèle externe.
Gestion du profil : lire et modifier son titre, biographie, compétences, expériences, formations, langues, disponibilité et portfolio; vérifier les tailles et URLs; gérer visibilité privée/publique et expectedProfileVersion. GET /profiles/{id} retourne uniquement un profil autorisé ou public, sans CV ni contact privé du compte.
Gestion du CV : contrôler PDF/DOCX, taille, quarantaine et propriétaire; enregistrer objet et métadonnées; créer une tâche durable; exposer statut et suggestions; appliquer seulement les champs confirmés; permettre remplacement et suppression sans résurrection par un worker tardif.
Matching : lire le profil confirmé localement, appeler Catalog pour les offres, créer le job backend et faire appeler /v1/score par son worker. Valider les résultats, versionner profil/offre/modèle, persister les raisons et exposer les états et résultats par API métier. Un timeout ou 503 du moteur produit reprise puis échec visible, sans bloquer la recherche.
Fiabilité : transaction métier + outbox, inbox/déduplication, délais et retries bornés, DLQ et journaux sans CV. Le backend contrôle l’état du compte et la propriété à chaque accès. Il n’expose aucun rôle, contact vérifié ou credential IA dans un formulaire de profil.
Livrables backend : contrat OpenAPI public, contrat IA interne, modèles et migrations, contrôleurs/services/repositories, AIClient, workers, configuration privée, scénarios d’autorisation et de concurrence, tests d’intégration et guide de reprise. Ces éléments sont des travaux à implémenter; le pack fournit leur conception.

## Frontend

Ayoub réalise les pages du domaine dans le frontend Next.js partagé. Les appels utilisent un client API typé dirigé vers la Gateway et le backend métier. Aucun fetch vers FastAPI, aucune URL du moteur IA et aucun secret de service ne doivent apparaître dans le navigateur.
Éditeur de profil : sections titre et biographie, compétences et niveaux déclarés, expériences, formations, langues, disponibilité et portfolio. Permettre ajout, modification et suppression des éléments, afficher les validations et la version courante, sauvegarder par PATCH /profiles/me et préserver les saisies en cas d’erreur.
Import du CV : sélection d’un fichier, format et taille indiqués, message de confidentialité, progression de téléversement distincte du traitement. Après 202, suivre Location via le backend avec des requêtes bornées; afficher contrôle, attente, extraction, succès et erreur. Le navigateur ne sait pas quel moteur calcule en arrière-plan.
Relecture : présenter les suggestions champ par champ avec source et confiance indicative, permettre correction, sélection et exclusion. Rien n’est confirmé par défaut en silence. Le bouton de confirmation transmet resumeId, extractionVersion, expectedProfileVersion et confirmedFields au backend métier.
Profil public : fournir une prévisualisation et une commande explicite de visibilité. Montrer les informations professionnelles autorisées, sans fichier CV, adresse privée, rôles ou flags de sécurité. La saisie manuelle reste disponible si le CV échoue.
Recommandations : lancer POST /matches, afficher l’attente puis les offres classées, compétences communes/manquantes et versions. Permettre filtre vers une offre, accès au détail et candidature via le module de Rana. Signaler résultat obsolète et offrir un recalcul. La recherche Catalogue de Rayen reste utilisable sans IA.
Erreurs : 401 déclenche le parcours de connexion; 403/404 masque une ressource non autorisée; 409 propose de recharger et fusionner au lieu d’écraser; 413/415 explique le fichier refusé; 422 propose correction ou saisie manuelle; 429/503 fournit une reprise compréhensible. Les composants doivent être accessibles au clavier et sur mobile.
Livrables frontend : pages, formulaires et composants réutilisables, client API typé, gestion des jobs et états d’erreur, prévisualisation et recommandations, mocks cohérents avec les contrats et tests du parcours CV → profil confirmé → offres. Le frontend n’exécute aucune décision d’autorisation ou de scoring à la place du backend.

## Écrans et contrats à relier

| Écran | API du backend métier | Résultat attendu |
|---|---|---|
| Mon profil | GET /profiles/me | Charger les sections privées et leur version |
| Modifier mon profil | PATCH /profiles/me | Valider puis sauvegarder les champs modifiés |
| Importer mon CV | POST /resumes | 202 puis suivi de Location |
| Suivi du CV | GET /resumes/{id} | Montrer le traitement backend et ses erreurs |
| Relire les suggestions | GET /resumes/{id}/prefill | Proposer des champs modifiables et sélectionnables |
| Confirmer | POST /profiles/me/resume-fill | Persister uniquement les champs acceptés |
| Supprimer le CV | DELETE /resumes/{id} | Suppression traçable sans supprimer implicitement le profil |
| Profil public | GET /profiles/{id} | Afficher seulement les informations autorisées |
| Demander des offres | POST /matches | Créer le job backend et retourner 202 |
| Suivre les résultats | GET /matching-jobs/{id} et /results | Présenter recommandations et explications |

Le moteur privé expose seulement /v1/extract et /v1/score à l’adaptateur du backend. Ces deux routes ne figurent pas dans le client frontend.

## Ordre de réalisation proposé

1. Modèle de profil et CRUD manuel, droits et version optimiste.
2. Formulaire frontend et visibilité, sans dépendance IA.
3. Import privé, stockage et suivi de tâche avec faux adaptateur IA.
4. Liaison backend → moteur IA, extraction et relecture des suggestions.
5. Confirmation atomique, suppression et tests de reprises.
6. Lecture des offres, scoring interne et page de recommandations.
7. Intégration avec Catalogue, Propositions et Notifications, puis validation de bout en bout.

## Critères de fin

- Aucun appel frontend → moteur IA, aucune clé IA dans le bundle.
- Un utilisateur ne lit ni CV, ni profil privé, ni job d’un tiers.
- Le profil se modifie manuellement sans IA; le CV n’écrit rien sans confirmation.
- Un conflit 409 n’écrase pas le formulaire ou la version courante.
- Une suppression ou nouvelle version neutralise les résultats tardifs.
- Le matching utilise les champs confirmés et indique les versions et les raisons.
- Une panne IA n’interrompt pas profil, catalogue ou candidature.
- Les API, écrans, diagrammes et tests décrivent le même propriétaire des données.

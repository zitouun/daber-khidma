# Contrats HTTP et événements

Les 7 fichiers OpenAPI JSON sont importables dans Swagger Editor ou Postman. Ce sont des contrats de conception, sans serveur implémenté. Les fichiers Events sont des schémas JSON Schema 2020-12.

## Conventions

Préfixe public /api/v1. UUID pour les identifiants. Instant UTC ISO 8601. Valeurs monétaires décimales avec devise ISO 4217; stocker en NUMERIC(12,2), jamais float. Pagination page=0 et size=20, maximum 100. Pour ProjectInput, vérifier budgetMin <= budgetMax dans le domaine. Toute identité du propriétaire vient du JWT, jamais d’un champ libre du navigateur. Le rôle ADMIN n’autorise pas par défaut la lecture des messages privés.

POST accept exige Idempotency-Key; une même clé et une même charge retournent la sélection existante, une autre charge renvoie 409. POST /matches accepte un job puis fournit Location. Les routes /internal nécessitent un jeton de service et restent absentes du routage public. Les jetons doivent valider signature, expiration, issuer, audience et scopes. Les erreurs suivent Error(code,message,traceId).

## États distribués

Catalog détient le verrou d’attribution. La réservation passe OPEN à AWARD_PENDING dans une transaction locale. Annulation et réservation verrouillent le même projet. Proposal conserve une intention durable et la clé de réservation avant l’appel; après confirmation, il commit Selection(PENDING_CONTRACT) et l’outbox. Le client reçoit 202. Le consommateur Engagement crée un seul contrat par proposalId et publie contract.created. Catalog passe IN_PROGRESS, Proposal ACTIVE, Communication crée un fil idempotent.

Une panne entre réservation et commit exige une réconciliation avec la même clé. La réservation ne s’expire pas automatiquement : la libérer sans vérifier l’absence de contrat pourrait créer une double attribution. Un administrateur intervient seulement après rapprochement des trois services. La réponse UI reste « attribution en cours » tant que contractId est absent.

## Transport

Exchange topic durable dabber-khdma.events; une file durable par consommateur et événement (voir event-routing.json). Un même message est distribué à plusieurs files; les instances d’un seul consommateur partagent sa file. Outbox et données métier dans la même transaction, publication avec publisher confirms. L’inbox UNIQUE(consumer,eventId) et le commit métier précèdent ACK. Les notifications ont aussi UNIQUE(eventId,userId,type). Essais à t=0, puis 5/30/120 secondes; échec final en DLQ et alerte. La rediffusion conserve eventId. Un publisher confirm ne prouve pas le traitement par le consommateur.

Exclure mots de passe, jetons, texte des messages et fichiers des événements. Les UUID des utilisateurs sont des données à protéger. Le worker courriel résout les coordonnées via une API interne limitée.

## Propriété du profil et intégration IA

Les routes /profiles, /skills, /resumes, /matches et /matching-jobs appartiennent au backend métier 6 d’Ayoub. Le socle commun possède seulement /users et les contacts privés, sans profil professionnel.

La confirmation CV est locale au backend d’Ayoub : propriétaire, état READY et versions sont validés avant transaction profil + outbox. Le moteur IA ne modifie jamais le profil; il renvoie des suggestions au backend. Ses routes privées /v1/extract et /v1/score ne sont exposées ni par la Gateway ni au navigateur. Leur contrat est dans Internal/ai-engine.openapi.json.

POST /matches recommande les offres ouvertes au profil confirmé; projectId peut limiter à une offre. Les résultats référencent les versions de profil, d’offre et de modèle. Le frontend suit uniquement les jobs du backend métier.

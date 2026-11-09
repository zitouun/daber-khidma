# API Gateway prévue

Routage sous /api/v1 vers les services listés dans Documentation/Contrats. Priorité aux routes spécifiques : /projects/{id}/proposals vers Proposal avant /projects/** vers Catalog; /milestones/** vers Engagement; les API de profil, CV et matching vers le backend métier 6. Exclure /internal/** du routage externe.

Valider JWT, issuer et audience; limiter les requêtes, configurer CORS avec l’origine frontend exacte et propager traceId. Chaque service contrôle à nouveau l’autorisation. Le fournisseur OIDC gère login/logout/renouvellement; le socle comptes gère les comptes et rôles; le backend 6 d’Ayoub gère les profils professionnels. Implémentation et versions à verrouiller en S1.


Les routes /profiles/**, /skills, /resumes/**, /matches et /matching-jobs/** sont routées vers le backend métier 6. Aucune route vers ai-engine:8090 ni /v1/extract ou /v1/score. /users/** reste au socle comptes; les routes /internal/** ne sont pas publiques.

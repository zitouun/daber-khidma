# Infrastructure à configurer en S1

Cible : un réseau Docker privé, PostgreSQL avec une base et un rôle par service, RabbitMQ avec exchange topic et files décrites dans event-routing.json, MinIO avec buckets privés et fournisseur OIDC.

Variables prévues : DATABASE_URL, DATABASE_USER, DATABASE_PASSWORD, RABBITMQ_URL, OIDC_ISSUER_URI, OIDC_AUDIENCE, OBJECT_STORAGE_ENDPOINT, OBJECT_STORAGE_ACCESS_KEY, OBJECT_STORAGE_SECRET_KEY et FRONTEND_ORIGIN. .env.example liste les noms sans secret utilisable.

Verrouiller les versions compatibles, créer les migrations, fournir probes et volumes persistants avant la première démonstration. Les manifestes Docker Compose ne sont pas fournis ici pour éviter de prétendre que des services non implémentés démarrent. Le diagramme de déploiement représente cette cible.


Le moteur IA est placé sur un réseau privé accessible aux backends autorisés. Seul le backend fournit fichiers ou données minimisées au calcul. Aucun port public ni route Gateway vers le moteur. Les variables AI_ENGINE_BASE_URL, AI_ENGINE_AUDIENCE et AI_REQUEST_TIMEOUT_MS sont exclusivement backend. Le moteur ne reçoit aucun accès à PostgreSQL, MinIO ou RabbitMQ.

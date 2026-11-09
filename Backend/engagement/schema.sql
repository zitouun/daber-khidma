-- Conception semaine 4 : schéma principal à convertir en migrations après revue.
-- À exécuter uniquement dans la base du service engagement.
-- Aucun FK vers une autre base. Aucun déploiement effectué.

CREATE TABLE contract (
    id UUID PRIMARY KEY,
    proposal_id UUID NOT NULL UNIQUE,
    project_id UUID NOT NULL,
    client_id UUID NOT NULL,
    freelancer_id UUID NOT NULL,
    status TEXT NOT NULL
);

CREATE TABLE milestone (
    id UUID PRIMARY KEY,
    contract_id UUID NOT NULL,
    title TEXT NOT NULL,
    amount NUMERIC(12,2) NOT NULL,
    currency TEXT NOT NULL,
    status TEXT NOT NULL,
    CHECK (amount >= 0)
);

CREATE TABLE deliverable (
    id UUID PRIMARY KEY,
    milestone_id UUID NOT NULL,
    object_key TEXT NOT NULL,
    revision INTEGER NOT NULL,
    scan_status TEXT NOT NULL
);

CREATE TABLE dispute (
    id UUID PRIMARY KEY,
    contract_id UUID NOT NULL,
    reason TEXT NOT NULL,
    status TEXT NOT NULL,
    resolution TEXT
);

CREATE TABLE outbox_event (event_id UUID PRIMARY KEY, type TEXT NOT NULL, payload JSONB NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now(), published_at TIMESTAMPTZ);
CREATE TABLE inbox_event (consumer TEXT NOT NULL, event_id UUID NOT NULL, processed_at TIMESTAMPTZ NOT NULL DEFAULT now(), PRIMARY KEY (consumer, event_id));

-- FK internes à ajouter dans les migrations : relations du diagramme de classes.
-- Les enums et droits SQL doivent être précisés lors de la mise en œuvre.

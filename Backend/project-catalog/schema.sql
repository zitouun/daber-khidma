-- Conception semaine 4 : schéma principal à convertir en migrations après revue.
-- À exécuter uniquement dans la base du service catalog.
-- Aucun FK vers une autre base. Aucun déploiement effectué.

CREATE TABLE project (
    id UUID PRIMARY KEY,
    client_id UUID NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    budget_min NUMERIC(12,2) NOT NULL,
    budget_max NUMERIC(12,2) NOT NULL,
    currency TEXT NOT NULL,
    status TEXT NOT NULL,
    version BIGINT NOT NULL,
    CHECK (budget_min >= 0 AND budget_max >= budget_min)
);

CREATE TABLE project_skill (
    project_id UUID NOT NULL,
    skill_code TEXT NOT NULL,
    weight INTEGER NOT NULL,
    PRIMARY KEY (project_id, skill_code)
);

CREATE TABLE category (
    id UUID PRIMARY KEY,
    label TEXT NOT NULL
);

CREATE TABLE award_reservation (
    project_id UUID NOT NULL UNIQUE,
    proposal_id UUID NOT NULL,
    reservation_key UUID NOT NULL UNIQUE,
    status TEXT NOT NULL,
    PRIMARY KEY (project_id)
);

CREATE TABLE outbox_event (event_id UUID PRIMARY KEY, type TEXT NOT NULL, payload JSONB NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now(), published_at TIMESTAMPTZ);
CREATE TABLE inbox_event (consumer TEXT NOT NULL, event_id UUID NOT NULL, processed_at TIMESTAMPTZ NOT NULL DEFAULT now(), PRIMARY KEY (consumer, event_id));
-- SELECT ... FOR UPDATE sur project avant réservation ET annulation.

-- FK internes à ajouter dans les migrations : relations du diagramme de classes.
-- Les enums et droits SQL doivent être précisés lors de la mise en œuvre.

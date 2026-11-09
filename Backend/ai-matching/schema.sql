-- Service métier 6, Ayoub. Conception à transformer en migrations après revue.
CREATE TABLE resume_document (id UUID PRIMARY KEY, owner_id UUID NOT NULL, object_key TEXT NOT NULL, mime_type TEXT NOT NULL, size_bytes BIGINT NOT NULL CHECK(size_bytes > 0 AND size_bytes <= 5242880), version INTEGER NOT NULL CHECK(version > 0), status TEXT NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now(), deleted_at TIMESTAMPTZ);
CREATE TABLE extraction_job (id UUID PRIMARY KEY, resume_id UUID NOT NULL REFERENCES resume_document(id), status TEXT NOT NULL, extractor_version TEXT NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE profile_suggestion (id UUID PRIMARY KEY, job_id UUID NOT NULL REFERENCES extraction_job(id), field_key TEXT NOT NULL, value JSONB NOT NULL, confidence NUMERIC(4,3) CHECK(confidence BETWEEN 0 AND 1), source_page INTEGER CHECK(source_page > 0));
CREATE TABLE model_version (id TEXT PRIMARY KEY, algorithm TEXT NOT NULL, config JSONB NOT NULL);
CREATE TABLE matching_job (id UUID PRIMARY KEY, owner_id UUID NOT NULL, profile_version BIGINT NOT NULL, model_version TEXT NOT NULL REFERENCES model_version(id), status TEXT NOT NULL);
CREATE TABLE match_result (id UUID PRIMARY KEY, job_id UUID NOT NULL REFERENCES matching_job(id), project_id UUID NOT NULL, project_version BIGINT NOT NULL, profile_version BIGINT NOT NULL, score NUMERIC(5,4) CHECK(score BETWEEN 0 AND 1), explanation TEXT NOT NULL);
CREATE TABLE outbox_event (event_id UUID PRIMARY KEY, type TEXT NOT NULL, payload JSONB NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now(), published_at TIMESTAMPTZ);
CREATE TABLE inbox_event (consumer TEXT NOT NULL, event_id UUID NOT NULL, processed_at TIMESTAMPTZ NOT NULL DEFAULT now(), PRIMARY KEY(consumer,event_id));
-- Les transitions de statut, le contrôle du propriétaire et l’invalidation des versions sont des règles applicatives à implémenter.

-- Profil professionnel : propriété exclusive du service métier 6 d’Ayoub.
CREATE TABLE professional_profile (id UUID PRIMARY KEY, user_id UUID NOT NULL UNIQUE, display_name TEXT NOT NULL, headline TEXT NOT NULL DEFAULT '', bio TEXT NOT NULL DEFAULT '', availability TEXT NOT NULL DEFAULT 'AVAILABLE', visibility TEXT NOT NULL DEFAULT 'PRIVATE', version BIGINT NOT NULL DEFAULT 0, source_resume_id UUID REFERENCES resume_document(id), languages JSONB NOT NULL DEFAULT '[]');
CREATE TABLE skill (code TEXT PRIMARY KEY, label TEXT NOT NULL);
CREATE TABLE profile_skill (profile_id UUID NOT NULL REFERENCES professional_profile(id), skill_code TEXT NOT NULL REFERENCES skill(code), level INTEGER CHECK(level BETWEEN 1 AND 5), PRIMARY KEY(profile_id,skill_code));
CREATE TABLE experience (id UUID PRIMARY KEY, profile_id UUID NOT NULL REFERENCES professional_profile(id), title TEXT NOT NULL, organization TEXT, description TEXT);
CREATE TABLE education (id UUID PRIMARY KEY, profile_id UUID NOT NULL REFERENCES professional_profile(id), degree TEXT NOT NULL, institution TEXT);
CREATE TABLE portfolio_item (id UUID PRIMARY KEY, profile_id UUID NOT NULL REFERENCES professional_profile(id), title TEXT NOT NULL, url TEXT NOT NULL, description TEXT);
-- expectedProfileVersion protège PATCH et confirmation CV; une mutation incrémente version et crée une outbox dans la même transaction.

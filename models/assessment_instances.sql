CREATE TABLE IF NOT EXISTS assessment_instances (
    id BIGSERIAL PRIMARY KEY,
    tiid text UNIQUE, -- temporary, delete after Mongo import
    qids JSONB, -- temporary, delete after Mongo import
    obj JSONB, -- temporary, delete after Mongo import
    date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    mode enum_mode, -- mode at creation
    number INTEGER,
    open BOOLEAN DEFAULT TRUE,
    closed_at TIMESTAMP WITH TIME ZONE,
    instructor_opened BOOLEAN DEFAULT FALSE,
    duration INTERVAL DEFAULT INTERVAL '0 seconds',
    assessment_id BIGINT NOT NULL REFERENCES assessments ON DELETE CASCADE ON UPDATE CASCADE,
    user_id BIGINT NOT NULL REFERENCES users ON DELETE CASCADE ON UPDATE CASCADE,
    auth_user_id BIGINT REFERENCES users ON DELETE CASCADE ON UPDATE CASCADE,
    points DOUBLE PRECISION DEFAULT 0,
    points_in_grading DOUBLE PRECISION DEFAULT 0,
    max_points DOUBLE PRECISION,
    score_perc DOUBLE PRECISION DEFAULT 0,
    score_perc_in_grading DOUBLE PRECISION DEFAULT 0,
    UNIQUE (number, assessment_id, user_id)
);

DROP VIEW IF EXISTS student_assessment_scores CASCADE;
DROP VIEW IF EXISTS user_assessment_scores CASCADE;
ALTER TABLE assessment_instances ALTER COLUMN score_perc SET DATA TYPE DOUBLE PRECISION;
ALTER TABLE assessment_instances ALTER COLUMN score_perc_in_grading SET DATA TYPE DOUBLE PRECISION;

ALTER TABLE assessment_instances ADD COLUMN IF NOT EXISTS instructor_opened BOOLEAN DEFAULT FALSE;
ALTER TABLE assessment_instances DROP COLUMN IF EXISTS admin_opened;

ALTER TABLE assessment_instances ALTER COLUMN id SET DATA TYPE BIGINT;
ALTER TABLE assessment_instances ALTER COLUMN assessment_id SET DATA TYPE BIGINT;
ALTER TABLE assessment_instances ALTER COLUMN user_id SET DATA TYPE BIGINT;
ALTER TABLE assessment_instances ALTER COLUMN auth_user_id SET DATA TYPE BIGINT;
ALTER TABLE assessment_instances ALTER COLUMN tiid SET DATA TYPE TEXT;
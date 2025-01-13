-- 00_init.sql
-- Grant all privileges on the database and schema to the Django user

-- Grant privileges on the database
GRANT ALL PRIVILEGES ON DATABASE my_db TO postgres;

-- Grant privileges on the public schema
GRANT ALL PRIVILEGES ON SCHEMA public TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT ALL PRIVILEGES ON TABLES TO postgres;

-- Grant privileges on all existing tables, sequences, and functions
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgres;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO postgres;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO postgres;

-- Ensure privileges are granted to future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON FUNCTIONS TO postgres;

-- Create a dedicated replication user
CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'replicator_password';

-- Create a physical replication slot
SELECT pg_create_physical_replication_slot('replication_slot');

-- Grant privileges on the django_session table
GRANT ALL PRIVILEGES ON TABLE django_session TO postgres;
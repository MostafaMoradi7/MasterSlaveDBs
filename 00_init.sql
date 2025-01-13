-- 00_init.sql
-- Grant all privileges on the database and schema to the Django user

-- Grant privileges on the database
GRANT ALL PRIVILEGES ON DATABASE my_db TO postgres;
CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'replicator_password';

-- Grant privileges on the public schema
GRANT ALL PRIVILEGES ON SCHEMA public TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT ALL PRIVILEGES ON TABLES TO postgres;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT ALL PRIVILEGES ON TABLES TO replicator;


-- Grant privileges on all existing tables, sequences, and functions
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgres;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO postgres;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO postgres;

-- Ensure privileges are granted to future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON FUNCTIONS TO postgres;


GRANT ALL PRIVILEGES ON DATABASE my_db TO replicator;

-- Grant privileges on the public schema
GRANT ALL PRIVILEGES ON SCHEMA public TO replicator;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT ALL PRIVILEGES ON TABLES TO replicator;

-- Grant privileges on all existing tables, sequences, and functions
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO replicator;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO replicator;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO replicator;

-- Ensure privileges are granted to future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO replicator;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO replicator;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON FUNCTIONS TO replicator;


-- Create a physical replication slot
SELECT pg_create_physical_replication_slot('replication_slot');

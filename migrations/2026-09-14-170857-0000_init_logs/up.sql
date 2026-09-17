-- every transaction is logged in this table,
-- this allows time travel queries to reconstruct
-- the state of the database at any point in time
CREATE TABLE history (
    id SERIAL PRIMARY KEY
    , client_id VARCHAR NOT NULL
    , event_time TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- the dataset is a data product
-- the catalogue is a collection of datasets
CREATE TABLE dataset (
    id SERIAL PRIMARY KEY
    , name VARCHAR NOT NULL
    , description TEXT NOT NULL
    , creation_event INTEGER REFERENCES history(id) NOT NULL
    , deletion_event INTEGER REFERENCES history(id)
    , UNIQUE (name, deletion_event)
);
CREATE INDEX idx_dataset_name ON dataset(name);
CREATE INDEX idx_dataset_creation_event ON dataset(creation_event);
CREATE INDEX idx_dataset_deletion_event ON dataset(deletion_event);

-- a dataset is also a collection of data objects,
-- where a data object is a resource that can be located,
-- an object may be in more than a single dataset
CREATE TABLE object (
    id SERIAL PRIMARY KEY
    , url VARCHAR NOT NULL
    , creation_event INTEGER REFERENCES history(id) NOT NULL
    , deletion_event INTEGER REFERENCES history(id)
    , UNIQUE (url, deletion_event)
);
CREATE INDEX idx_object_url ON object(url);
CREATE INDEX idx_object_creation_event ON object(creation_event);
CREATE INDEX idx_object_deletion_event ON object(deletion_event);

-- a tag is a label on a dataset,
-- tags are used to categorise and then search for datasets
CREATE TABLE tag (
    id SERIAL PRIMARY KEY
    , name VARCHAR NOT NULL
    , description TEXT NOT NULL
    , creation_event INTEGER REFERENCES history(id) NOT NULL
    , deletion_event INTEGER REFERENCES history(id)
    , UNIQUE (name, deletion_event)
);
CREATE INDEX idx_tag_name ON tag(name);
CREATE INDEX idx_tag_creation_event ON tag(creation_event);
CREATE INDEX idx_tag_deletion_event ON tag(deletion_event);

-- the relationship between datasets and objects
CREATE TABLE dataset_objects (
    dataset_id INTEGER REFERENCES dataset(id) NOT NULL
    , object_id INTEGER REFERENCES object(id) NOT NULL
    , creation_event INTEGER REFERENCES history(id) NOT NULL
    , deletion_event INTEGER REFERENCES history(id)
    , PRIMARY KEY (dataset_id, object_id, deletion_event)
);
CREATE INDEX idx_dataset_objects ON dataset_objects(dataset_id, object_id);
CREATE INDEX idx_dataset_objects_creation_event ON dataset_objects(creation_event);
CREATE INDEX idx_dataset_objects_deletion_event ON dataset_objects(deletion_event);

-- the relationship between datasets and tags
CREATE TABLE dataset_tags (
    dataset_id INTEGER REFERENCES dataset(id) NOT NULL
    , tag_id INTEGER REFERENCES tag(id) NOT NULL
    , creation_event INTEGER REFERENCES history(id) NOT NULL
    , deletion_event INTEGER REFERENCES history(id)
    , PRIMARY KEY (dataset_id, tag_id, deletion_event)
);
CREATE INDEX idx_dataset_tags ON dataset_tags(dataset_id, tag_id);
CREATE INDEX idx_dataset_tags_creation_event ON dataset_tags(creation_event);
CREATE INDEX idx_dataset_tags_deletion_event ON dataset_tags(deletion_event);

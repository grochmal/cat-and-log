// @generated automatically by Diesel CLI.

diesel::table! {
    dataset (id) {
        id -> Int4,
        name -> Varchar,
        description -> Text,
        creation_event -> Int4,
        deletion_event -> Nullable<Int4>,
    }
}

diesel::table! {
    dataset_objects (dataset_id, object_id, deletion_event) {
        dataset_id -> Int4,
        object_id -> Int4,
        creation_event -> Int4,
        deletion_event -> Int4,
    }
}

diesel::table! {
    dataset_tags (dataset_id, tag_id, deletion_event) {
        dataset_id -> Int4,
        tag_id -> Int4,
        creation_event -> Int4,
        deletion_event -> Int4,
    }
}

diesel::table! {
    history (id) {
        id -> Int4,
        client_id -> Varchar,
        event_time -> Nullable<Timestamptz>,
    }
}

diesel::table! {
    object (id) {
        id -> Int4,
        url -> Varchar,
        creation_event -> Int4,
        deletion_event -> Nullable<Int4>,
    }
}

diesel::table! {
    tag (id) {
        id -> Int4,
        name -> Varchar,
        description -> Text,
        creation_event -> Int4,
        deletion_event -> Nullable<Int4>,
    }
}

diesel::joinable!(dataset_objects -> dataset (dataset_id));
diesel::joinable!(dataset_objects -> object (object_id));
diesel::joinable!(dataset_tags -> dataset (dataset_id));
diesel::joinable!(dataset_tags -> tag (tag_id));

diesel::allow_tables_to_appear_in_same_query!(
    dataset,
    dataset_objects,
    dataset_tags,
    history,
    object,
    tag,
);

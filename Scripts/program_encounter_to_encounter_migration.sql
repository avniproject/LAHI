-- env : prerelease

set role lahi;

-- program encounter which need to voided
select * from encounter_type where uuid = '3acfc167-0124-4292-8c66-8fdb3e34ef95';
-- id 1810

-- encounter which need to insert data from program encounter
select * from encounter_type where  uuid= 'a012fbf6-0d93-4bad-a341-625448586536';
-- id 2829


-- check if program encounter id is available or not in encounter
select *
from encounter where id in(select id
                           from program_encounter
                           where encounter_type_id = 1810);
-- should give count 0


-- if count is 0 then insert query
-- logic
-- 1. get all column of encounter in program_encounter
-- 2. write cte of program_encounter and change encounter_type_id as per general_encounter
with insert_data as(
    select
        id,
        observations,
        encounter_date_time,
        2829 as encounter_type_id,
        individual_id,
        uuid,
        version,
        organisation_id,
        is_voided,
        audit_id,
        encounter_location,
        earliest_visit_date_time,
        max_visit_date_time,
        cancel_date_time,
        cancel_observations,
        cancel_location,
        name,
        legacy_id,
        created_by_id,
        last_modified_by_id,
        created_date_time,
        last_modified_date_time,
        address_id,
        sync_concept_1_value,
        sync_concept_2_value,
        manual_update_history,
        filled_by_id
    from program_encounter
    where encounter_type_id = 1810
)insert into encounter
select *
from insert_data;

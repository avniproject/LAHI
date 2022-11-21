set  role lahi;

update program_encounter
set is_voided= false,
    last_modified_date_time=current_timestamp,
    last_modified_by_id=(select id from users where username = 'sachink@lahi')
from program_enrolment enl
where enl.id = program_encounter.program_enrolment_id
  and enl.is_voided = true
  and program_encounter.is_voided = true
  and enl.enrolment_date_time::date = '2022-11-11';


update program_enrolment
set is_voided              = false,
    last_modified_date_time=current_timestamp,
    last_modified_by_id=(select id from users where username = 'sachink@lahi')
where is_voided = true
  and enrolment_date_time::date = '2022-11-11';
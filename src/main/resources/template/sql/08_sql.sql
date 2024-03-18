--liquibase formatted sql
--changeset lc:migrate-master-scenario
update project set master_scenario = ms.scenario from (
    select min(id) as scenario, project_id as project_id from scenario where project_id in (select id from project) group by project_id
) ms where project.id = ms.project_id;
--rollback update project set master_scenario = null where true;

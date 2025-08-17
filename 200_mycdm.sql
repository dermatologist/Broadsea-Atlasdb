create schema my_cdm;
create schema my_cdm_results;

set search_path = my_cdm_results;

CREATE TABLE achilles_analysis
(
  analysis_id integer,
  analysis_name text,
  stratum_1_name text,
  stratum_2_name text,
  stratum_3_name text,
  stratum_4_name text,
  stratum_5_name text,
  is_default text,
  category text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE achilles_analysis
  OWNER TO postgres;

CREATE TABLE achilles_heel_results
(
  analysis_id integer,
  achilles_heel_warning character varying(255),
  rule_id integer,
  record_count numeric
)
WITH (
  OIDS=FALSE
);
ALTER TABLE achilles_heel_results
  OWNER TO postgres;

CREATE TABLE achilles_results
(
  analysis_id integer,
  stratum_1 character varying,
  stratum_2 character varying,
  stratum_3 character varying,
  stratum_4 character varying,
  stratum_5 character varying,
  count_value bigint
)
WITH (
  OIDS=FALSE
);
ALTER TABLE achilles_results
  OWNER TO postgres;

CREATE INDEX idx_ar_aid
  ON achilles_results
  USING btree
  (analysis_id);

CREATE INDEX idx_ar_aid_s1
  ON achilles_results
  USING btree
  (analysis_id, stratum_1 COLLATE pg_catalog."default");

CREATE INDEX idx_ar_aid_s1234
  ON achilles_results
  USING btree
  (analysis_id, stratum_1 COLLATE pg_catalog."default", stratum_2 COLLATE pg_catalog."default", stratum_3 COLLATE pg_catalog."default", stratum_4 COLLATE pg_catalog."default");

CREATE INDEX idx_ar_s1
  ON achilles_results
  USING btree
  (stratum_1 COLLATE pg_catalog."default");

CREATE INDEX idx_ar_s2
  ON achilles_results
  USING btree
  (stratum_2 COLLATE pg_catalog."default");

CREATE TABLE achilles_results_derived
(
  analysis_id integer,
  stratum_1 character varying(255),
  stratum_2 character varying(255),
  statistic_value numeric,
  measure_id character varying
)
WITH (
  OIDS=FALSE
);
ALTER TABLE achilles_results_derived
  OWNER TO postgres;

CREATE TABLE achilles_results_dist
(
  analysis_id integer,
  stratum_1 character varying,
  stratum_2 character varying,
  stratum_3 character varying,
  stratum_4 character varying,
  stratum_5 character varying,
  count_value bigint,
  min_value numeric,
  max_value numeric,
  avg_value numeric,
  stdev_value numeric,
  median_value numeric,
  p10_value numeric,
  p25_value numeric,
  p75_value numeric,
  p90_value numeric
)
WITH (
  OIDS=FALSE
);
ALTER TABLE achilles_results_dist
  OWNER TO postgres;

CREATE INDEX idx_ard_aid
  ON achilles_results_dist
  USING btree
  (analysis_id);

CREATE INDEX idx_ard_s1
  ON achilles_results_dist
  USING btree
  (stratum_1 COLLATE pg_catalog."default");

CREATE INDEX idx_ard_s2
  ON achilles_results_dist
  USING btree
  (stratum_2 COLLATE pg_catalog."default");

CREATE TABLE achilles_result_concept_count
(
  concept_id integer,
  record_count numeric,
  descendant_record_count numeric,
  person_count numeric,
  descendant_person_count numeric
)
WITH (
  OIDS=FALSE
);
ALTER TABLE achilles_result_concept_count
  OWNER TO postgres;

set search_path = my_cdm;

CREATE TABLE concept_recommended
(
    concept_id_1 bigint,
    concept_id_2 bigint,
    relationship_id character varying(20)
)


set datestyle to 'ymd';
copy concept_recommended from PROGRAM 'gunzip -c /tmp/concept_recommended.csv.gz' with csv header;

-- load cdm tables that have data


-- copy care_site from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/care_site.csv.gz' with csv header;
-- copy cdm_source from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/cdm_source.csv.gz' with csv header;
--copy cohort_definition from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/cohort_definition.csv.gz' with csv header;
--copy cohort from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/cohort.csv.gz' with csv header;
copy concept_ancestor from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/concept_ancestor.csv.gz' with csv header;
copy concept_class from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/concept_class.csv.gz' with csv header;
copy concept_relationship from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/concept_relationship.csv.gz' with csv header;
copy concept_synonym from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/concept_synonym.csv.gz' with csv header;
copy concept from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/concept.csv.gz' with csv header;
--copy concept from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/omop_generated_metadata_concepts.csv.gz' with csv header;
-- copy condition_era from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/condition_era.csv.gz' with csv header;
-- copy condition_occurrence from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/condition_occurrence.csv.gz' with csv header;
-- copy cost from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/cost.csv.gz' with csv header;
-- copy death from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/death.csv.gz' with csv header;
-- copy device_exposure from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/device_exposure.csv.gz' with csv header;
copy domain from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/domain.csv.gz'  with csv header;
-- copy dose_era from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/dose_era.csv.gz'  with csv header;
-- copy drug_era from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/drug_era.csv.gz' with csv header;
-- copy drug_exposure from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/drug_exposure.csv.gz' with csv header;
-- copy drug_strength from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/drug_strength.csv.gz' with csv header;
--copy episode_event from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/episode_event.csv.gz' with csv header;
--copy episode from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/episode.csv.gz' with csv header;
-- copy fact_relationship from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/fact_relationship.csv.gz' with csv header;
-- copy location from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/location.csv.gz' with csv header;
-- copy measurement from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/measurement.csv.gz' with csv header;
-- copy metadata from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/metadata.csv.gz' with csv header;
-- copy note_nlp from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/note_nlp.csv.gz' with csv header;
-- copy note from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/note.csv.gz' with csv header;
-- copy observation_period from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/observation_period.csv.gz' with csv header;
-- copy observation from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/observation.csv.gz' with csv header;
-- copy payer_plan_period from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/payer_plan_period.csv.gz' with csv header;
-- copy person from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/person.csv.gz' with csv header;
-- copy procedure_occurrence from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/procedure_occurrence.csv.gz' with csv header;
-- copy provider from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/provider.csv.gz' with csv header;
copy relationship from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/relationship.csv.gz' with csv header;
-- copy source_to_concept_map from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/source_to_concept_map.csv.gz' with csv header;
-- copy specimen from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/specimen.csv.gz' with csv header;
-- copy visit_detail from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/visit_detail.csv.gz' with csv header;
-- copy visit_occurrence from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/visit_occurrence.csv.gz' with csv header;
copy vocabulary from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/vocabulary.csv.gz' with csv header;


-- load demo cdm achilles data into cdm results achilles tables

set search_path = my_cdm_results;
--
copy achilles_analysis from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/achilles_analysis.csv.gz' with csv header;
--copy achilles_heel_results from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/achilles_heel_results.csv.gz' with csv header;
copy achilles_results from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/achilles_results.csv.gz' with csv header;
--copy achilles_results_derived from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/achilles_results_derived.csv.gz' with csv header;
copy achilles_results_dist from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/achilles_results_dist.csv.gz' with csv header;
copy achilles_result_concept_count from PROGRAM 'gunzip -c /tmp/demo_cdm_csv_files/achilles_result_concept_count.csv.gz' with csv header;
--
set search_path = my_cdm;


--postgresql CDM Primary Key Constraints for OMOP Common Data Model 5.4

ALTER TABLE PERSON ADD CONSTRAINT xpk_PERSON PRIMARY KEY (person_id);

ALTER TABLE OBSERVATION_PERIOD ADD CONSTRAINT xpk_OBSERVATION_PERIOD PRIMARY KEY (observation_period_id);

ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT xpk_VISIT_OCCURRENCE PRIMARY KEY (visit_occurrence_id);

ALTER TABLE VISIT_DETAIL ADD CONSTRAINT xpk_VISIT_DETAIL PRIMARY KEY (visit_detail_id);

ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT xpk_CONDITION_OCCURRENCE PRIMARY KEY (condition_occurrence_id);

ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT xpk_DRUG_EXPOSURE PRIMARY KEY (drug_exposure_id);

ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT xpk_PROCEDURE_OCCURRENCE PRIMARY KEY (procedure_occurrence_id);

ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT xpk_DEVICE_EXPOSURE PRIMARY KEY (device_exposure_id);

ALTER TABLE MEASUREMENT ADD CONSTRAINT xpk_MEASUREMENT PRIMARY KEY (measurement_id);

ALTER TABLE OBSERVATION ADD CONSTRAINT xpk_OBSERVATION PRIMARY KEY (observation_id);

ALTER TABLE NOTE ADD CONSTRAINT xpk_NOTE PRIMARY KEY (note_id);

ALTER TABLE NOTE_NLP ADD CONSTRAINT xpk_NOTE_NLP PRIMARY KEY (note_nlp_id);

ALTER TABLE SPECIMEN ADD CONSTRAINT xpk_SPECIMEN PRIMARY KEY (specimen_id);

ALTER TABLE LOCATION ADD CONSTRAINT xpk_LOCATION PRIMARY KEY (location_id);

ALTER TABLE CARE_SITE ADD CONSTRAINT xpk_CARE_SITE PRIMARY KEY (care_site_id);

ALTER TABLE PROVIDER ADD CONSTRAINT xpk_PROVIDER PRIMARY KEY (provider_id);

ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT xpk_PAYER_PLAN_PERIOD PRIMARY KEY (payer_plan_period_id);

ALTER TABLE COST ADD CONSTRAINT xpk_COST PRIMARY KEY (cost_id);

ALTER TABLE DRUG_ERA ADD CONSTRAINT xpk_DRUG_ERA PRIMARY KEY (drug_era_id);

ALTER TABLE DOSE_ERA ADD CONSTRAINT xpk_DOSE_ERA PRIMARY KEY (dose_era_id);

ALTER TABLE CONDITION_ERA ADD CONSTRAINT xpk_CONDITION_ERA PRIMARY KEY (condition_era_id);

ALTER TABLE EPISODE ADD CONSTRAINT xpk_EPISODE PRIMARY KEY (episode_id);

ALTER TABLE METADATA ADD CONSTRAINT xpk_METADATA PRIMARY KEY (metadata_id);

ALTER TABLE CONCEPT ADD CONSTRAINT xpk_CONCEPT PRIMARY KEY (concept_id);

ALTER TABLE VOCABULARY ADD CONSTRAINT xpk_VOCABULARY PRIMARY KEY (vocabulary_id);

ALTER TABLE DOMAIN ADD CONSTRAINT xpk_DOMAIN PRIMARY KEY (domain_id);

ALTER TABLE CONCEPT_CLASS ADD CONSTRAINT xpk_CONCEPT_CLASS PRIMARY KEY (concept_class_id);

ALTER TABLE RELATIONSHIP ADD CONSTRAINT xpk_RELATIONSHIP PRIMARY KEY (relationship_id);

/*postgresql OMOP CDM Indices

  There are no unique indices created because it is assumed that the primary key constraints have been run prior to
  implementing indices.
*/


/************************

Standardized clinical data

************************/

CREATE INDEX idx_person_id  ON person  (person_id ASC);
CLUSTER person  USING idx_person_id ;
CREATE INDEX idx_gender ON person (gender_concept_id ASC);

CREATE INDEX idx_observation_period_id_1  ON observation_period  (person_id ASC);
CLUSTER observation_period  USING idx_observation_period_id_1 ;

CREATE INDEX idx_visit_person_id_1  ON visit_occurrence  (person_id ASC);
CLUSTER visit_occurrence  USING idx_visit_person_id_1 ;
CREATE INDEX idx_visit_concept_id_1 ON visit_occurrence (visit_concept_id ASC);

CREATE INDEX idx_visit_det_person_id_1  ON visit_detail  (person_id ASC);
CLUSTER visit_detail  USING idx_visit_det_person_id_1 ;
CREATE INDEX idx_visit_det_concept_id_1 ON visit_detail (visit_detail_concept_id ASC);
CREATE INDEX idx_visit_det_occ_id ON visit_detail (visit_occurrence_id ASC);

CREATE INDEX idx_condition_person_id_1  ON condition_occurrence  (person_id ASC);
CLUSTER condition_occurrence  USING idx_condition_person_id_1 ;
CREATE INDEX idx_condition_concept_id_1 ON condition_occurrence (condition_concept_id ASC);
CREATE INDEX idx_condition_visit_id_1 ON condition_occurrence (visit_occurrence_id ASC);

CREATE INDEX idx_drug_person_id_1  ON drug_exposure  (person_id ASC);
CLUSTER drug_exposure  USING idx_drug_person_id_1 ;
CREATE INDEX idx_drug_concept_id_1 ON drug_exposure (drug_concept_id ASC);
CREATE INDEX idx_drug_visit_id_1 ON drug_exposure (visit_occurrence_id ASC);

CREATE INDEX idx_procedure_person_id_1  ON procedure_occurrence  (person_id ASC);
CLUSTER procedure_occurrence  USING idx_procedure_person_id_1 ;
CREATE INDEX idx_procedure_concept_id_1 ON procedure_occurrence (procedure_concept_id ASC);
CREATE INDEX idx_procedure_visit_id_1 ON procedure_occurrence (visit_occurrence_id ASC);

CREATE INDEX idx_device_person_id_1  ON device_exposure  (person_id ASC);
CLUSTER device_exposure  USING idx_device_person_id_1 ;
CREATE INDEX idx_device_concept_id_1 ON device_exposure (device_concept_id ASC);
CREATE INDEX idx_device_visit_id_1 ON device_exposure (visit_occurrence_id ASC);

CREATE INDEX idx_measurement_person_id_1  ON measurement  (person_id ASC);
CLUSTER measurement  USING idx_measurement_person_id_1 ;
CREATE INDEX idx_measurement_concept_id_1 ON measurement (measurement_concept_id ASC);
CREATE INDEX idx_measurement_visit_id_1 ON measurement (visit_occurrence_id ASC);

CREATE INDEX idx_observation_person_id_1  ON observation  (person_id ASC);
CLUSTER observation  USING idx_observation_person_id_1 ;
CREATE INDEX idx_observation_concept_id_1 ON observation (observation_concept_id ASC);
CREATE INDEX idx_observation_visit_id_1 ON observation (visit_occurrence_id ASC);

CREATE INDEX idx_death_person_id_1  ON death  (person_id ASC);
CLUSTER death  USING idx_death_person_id_1 ;

CREATE INDEX idx_note_person_id_1  ON note  (person_id ASC);
CLUSTER note  USING idx_note_person_id_1 ;
CREATE INDEX idx_note_concept_id_1 ON note (note_type_concept_id ASC);
CREATE INDEX idx_note_visit_id_1 ON note (visit_occurrence_id ASC);

CREATE INDEX idx_note_nlp_note_id_1  ON note_nlp  (note_id ASC);
CLUSTER note_nlp  USING idx_note_nlp_note_id_1 ;
CREATE INDEX idx_note_nlp_concept_id_1 ON note_nlp (note_nlp_concept_id ASC);

CREATE INDEX idx_specimen_person_id_1  ON specimen  (person_id ASC);
CLUSTER specimen  USING idx_specimen_person_id_1 ;
CREATE INDEX idx_specimen_concept_id_1 ON specimen (specimen_concept_id ASC);

CREATE INDEX idx_fact_relationship_id1 ON fact_relationship (domain_concept_id_1 ASC);
CREATE INDEX idx_fact_relationship_id2 ON fact_relationship (domain_concept_id_2 ASC);
CREATE INDEX idx_fact_relationship_id3 ON fact_relationship (relationship_concept_id ASC);

/************************

Standardized health system data

************************/

CREATE INDEX idx_location_id_1  ON location  (location_id ASC);
CLUSTER location  USING idx_location_id_1 ;

CREATE INDEX idx_care_site_id_1  ON care_site  (care_site_id ASC);
CLUSTER care_site  USING idx_care_site_id_1 ;

CREATE INDEX idx_provider_id_1  ON provider  (provider_id ASC);
CLUSTER provider  USING idx_provider_id_1 ;

/************************

Standardized health economics

************************/

CREATE INDEX idx_period_person_id_1  ON payer_plan_period  (person_id ASC);
CLUSTER payer_plan_period  USING idx_period_person_id_1 ;

CREATE INDEX idx_cost_event_id  ON cost (cost_event_id ASC);

/************************

Standardized derived elements

************************/

CREATE INDEX idx_drug_era_person_id_1  ON drug_era  (person_id ASC);
CLUSTER drug_era  USING idx_drug_era_person_id_1 ;
CREATE INDEX idx_drug_era_concept_id_1 ON drug_era (drug_concept_id ASC);

CREATE INDEX idx_dose_era_person_id_1  ON dose_era  (person_id ASC);
CLUSTER dose_era  USING idx_dose_era_person_id_1 ;
CREATE INDEX idx_dose_era_concept_id_1 ON dose_era (drug_concept_id ASC);

CREATE INDEX idx_condition_era_person_id_1  ON condition_era  (person_id ASC);
CLUSTER condition_era  USING idx_condition_era_person_id_1 ;
CREATE INDEX idx_condition_era_concept_id_1 ON condition_era (condition_concept_id ASC);

/**************************

Standardized meta-data

***************************/

CREATE INDEX idx_metadata_concept_id_1  ON metadata  (metadata_concept_id ASC);
CLUSTER metadata  USING idx_metadata_concept_id_1 ;

/**************************

Standardized vocabularies

***************************/

CREATE INDEX idx_concept_concept_id  ON concept  (concept_id ASC);
CLUSTER concept  USING idx_concept_concept_id ;
CREATE INDEX idx_concept_code ON concept (concept_code ASC);
CREATE INDEX idx_concept_vocabluary_id ON concept (vocabulary_id ASC);
CREATE INDEX idx_concept_domain_id ON concept (domain_id ASC);
CREATE INDEX idx_concept_class_id ON concept (concept_class_id ASC);

CREATE INDEX idx_vocabulary_vocabulary_id  ON vocabulary  (vocabulary_id ASC);
CLUSTER vocabulary  USING idx_vocabulary_vocabulary_id ;

CREATE INDEX idx_domain_domain_id  ON domain  (domain_id ASC);
CLUSTER domain  USING idx_domain_domain_id ;

CREATE INDEX idx_concept_class_class_id  ON concept_class  (concept_class_id ASC);
CLUSTER concept_class  USING idx_concept_class_class_id ;

CREATE INDEX idx_concept_relationship_id_1  ON concept_relationship  (concept_id_1 ASC);
CLUSTER concept_relationship  USING idx_concept_relationship_id_1 ;
CREATE INDEX idx_concept_relationship_id_2 ON concept_relationship (concept_id_2 ASC);
CREATE INDEX idx_concept_relationship_id_3 ON concept_relationship (relationship_id ASC);

CREATE INDEX idx_relationship_rel_id  ON relationship  (relationship_id ASC);
CLUSTER relationship  USING idx_relationship_rel_id ;

CREATE INDEX idx_concept_synonym_id  ON concept_synonym  (concept_id ASC);
CLUSTER concept_synonym  USING idx_concept_synonym_id ;

CREATE INDEX idx_concept_ancestor_id_1  ON concept_ancestor  (ancestor_concept_id ASC);
CLUSTER concept_ancestor  USING idx_concept_ancestor_id_1 ;
CREATE INDEX idx_concept_ancestor_id_2 ON concept_ancestor (descendant_concept_id ASC);

CREATE INDEX idx_source_to_concept_map_3  ON source_to_concept_map  (target_concept_id ASC);
CLUSTER source_to_concept_map  USING idx_source_to_concept_map_3 ;
CREATE INDEX idx_source_to_concept_map_1 ON source_to_concept_map (source_vocabulary_id ASC);
CREATE INDEX idx_source_to_concept_map_2 ON source_to_concept_map (target_vocabulary_id ASC);
CREATE INDEX idx_source_to_concept_map_c ON source_to_concept_map (source_code ASC);

CREATE INDEX idx_drug_strength_id_1  ON drug_strength  (drug_concept_id ASC);
CLUSTER drug_strength  USING idx_drug_strength_id_1 ;
CREATE INDEX idx_drug_strength_id_2 ON drug_strength (ingredient_concept_id ASC);


--Additional v6.0 indices

--CREATE CLUSTERED INDEX idx_survey_person_id_1 ON survey_conduct (person_id ASC);


--CREATE CLUSTERED INDEX idx_episode_person_id_1 ON episode (person_id ASC);
--CREATE INDEX idx_episode_concept_id_1 ON episode (episode_concept_id ASC);

--CREATE CLUSTERED INDEX idx_episode_event_id_1 ON episode_event (episode_id ASC);
--CREATE INDEX idx_ee_field_concept_id_1 ON episode_event (event_field_concept_id ASC);

ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_gender_concept_id FOREIGN KEY (gender_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_race_concept_id FOREIGN KEY (race_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_ethnicity_concept_id FOREIGN KEY (ethnicity_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_location_id FOREIGN KEY (location_id) REFERENCES LOCATION (LOCATION_ID);

ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);

ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_care_site_id FOREIGN KEY (care_site_id) REFERENCES CARE_SITE (CARE_SITE_ID);

ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_gender_source_concept_id FOREIGN KEY (gender_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_race_source_concept_id FOREIGN KEY (race_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_ethnicity_source_concept_id FOREIGN KEY (ethnicity_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE OBSERVATION_PERIOD ADD CONSTRAINT fpk_OBSERVATION_PERIOD_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE OBSERVATION_PERIOD ADD CONSTRAINT fpk_OBSERVATION_PERIOD_period_type_concept_id FOREIGN KEY (period_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_visit_concept_id FOREIGN KEY (visit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_visit_type_concept_id FOREIGN KEY (visit_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);

ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_care_site_id FOREIGN KEY (care_site_id) REFERENCES CARE_SITE (CARE_SITE_ID);

ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_visit_source_concept_id FOREIGN KEY (visit_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_admitted_from_concept_id FOREIGN KEY (admitted_from_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_discharged_to_concept_id FOREIGN KEY (discharged_to_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_preceding_visit_occurrence_id FOREIGN KEY (preceding_visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);

ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_visit_detail_concept_id FOREIGN KEY (visit_detail_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_visit_detail_type_concept_id FOREIGN KEY (visit_detail_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);

ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_care_site_id FOREIGN KEY (care_site_id) REFERENCES CARE_SITE (CARE_SITE_ID);

ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_visit_detail_source_concept_id FOREIGN KEY (visit_detail_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_admitted_from_concept_id FOREIGN KEY (admitted_from_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_discharged_to_concept_id FOREIGN KEY (discharged_to_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_preceding_visit_detail_id FOREIGN KEY (preceding_visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);

ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_parent_visit_detail_id FOREIGN KEY (parent_visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);

ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);

ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_condition_concept_id FOREIGN KEY (condition_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_condition_type_concept_id FOREIGN KEY (condition_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_condition_status_concept_id FOREIGN KEY (condition_status_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);

ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);

ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_visit_detail_id FOREIGN KEY (visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);

ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_condition_source_concept_id FOREIGN KEY (condition_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_drug_concept_id FOREIGN KEY (drug_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_drug_type_concept_id FOREIGN KEY (drug_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_route_concept_id FOREIGN KEY (route_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);

ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);

ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_visit_detail_id FOREIGN KEY (visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);

ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_drug_source_concept_id FOREIGN KEY (drug_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_procedure_concept_id FOREIGN KEY (procedure_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_procedure_type_concept_id FOREIGN KEY (procedure_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_modifier_concept_id FOREIGN KEY (modifier_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);

ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);

ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_visit_detail_id FOREIGN KEY (visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);

ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_procedure_source_concept_id FOREIGN KEY (procedure_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_device_concept_id FOREIGN KEY (device_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_device_type_concept_id FOREIGN KEY (device_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);

ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);

ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_visit_detail_id FOREIGN KEY (visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);

ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_device_source_concept_id FOREIGN KEY (device_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_unit_concept_id FOREIGN KEY (unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_unit_source_concept_id FOREIGN KEY (unit_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_measurement_concept_id FOREIGN KEY (measurement_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_measurement_type_concept_id FOREIGN KEY (measurement_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_operator_concept_id FOREIGN KEY (operator_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_value_as_concept_id FOREIGN KEY (value_as_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_unit_concept_id FOREIGN KEY (unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);

ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);

ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_visit_detail_id FOREIGN KEY (visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);

ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_measurement_source_concept_id FOREIGN KEY (measurement_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_unit_source_concept_id FOREIGN KEY (unit_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_meas_event_field_concept_id FOREIGN KEY (meas_event_field_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_observation_concept_id FOREIGN KEY (observation_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_observation_type_concept_id FOREIGN KEY (observation_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_value_as_concept_id FOREIGN KEY (value_as_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_qualifier_concept_id FOREIGN KEY (qualifier_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_unit_concept_id FOREIGN KEY (unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);

ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);

ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_visit_detail_id FOREIGN KEY (visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);

ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_observation_source_concept_id FOREIGN KEY (observation_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_obs_event_field_concept_id FOREIGN KEY (obs_event_field_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DEATH ADD CONSTRAINT fpk_DEATH_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE DEATH ADD CONSTRAINT fpk_DEATH_death_type_concept_id FOREIGN KEY (death_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DEATH ADD CONSTRAINT fpk_DEATH_cause_concept_id FOREIGN KEY (cause_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DEATH ADD CONSTRAINT fpk_DEATH_cause_source_concept_id FOREIGN KEY (cause_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_note_type_concept_id FOREIGN KEY (note_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_note_class_concept_id FOREIGN KEY (note_class_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_encoding_concept_id FOREIGN KEY (encoding_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_language_concept_id FOREIGN KEY (language_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);

ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);

ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_visit_detail_id FOREIGN KEY (visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);

ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_note_event_field_concept_id FOREIGN KEY (note_event_field_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE NOTE_NLP ADD CONSTRAINT fpk_NOTE_NLP_section_concept_id FOREIGN KEY (section_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE NOTE_NLP ADD CONSTRAINT fpk_NOTE_NLP_note_nlp_concept_id FOREIGN KEY (note_nlp_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE NOTE_NLP ADD CONSTRAINT fpk_NOTE_NLP_note_nlp_source_concept_id FOREIGN KEY (note_nlp_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE SPECIMEN ADD CONSTRAINT fpk_SPECIMEN_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE SPECIMEN ADD CONSTRAINT fpk_SPECIMEN_specimen_concept_id FOREIGN KEY (specimen_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE SPECIMEN ADD CONSTRAINT fpk_SPECIMEN_specimen_type_concept_id FOREIGN KEY (specimen_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE SPECIMEN ADD CONSTRAINT fpk_SPECIMEN_unit_concept_id FOREIGN KEY (unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE SPECIMEN ADD CONSTRAINT fpk_SPECIMEN_anatomic_site_concept_id FOREIGN KEY (anatomic_site_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE SPECIMEN ADD CONSTRAINT fpk_SPECIMEN_disease_status_concept_id FOREIGN KEY (disease_status_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE FACT_RELATIONSHIP ADD CONSTRAINT fpk_FACT_RELATIONSHIP_domain_concept_id_1 FOREIGN KEY (domain_concept_id_1) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE FACT_RELATIONSHIP ADD CONSTRAINT fpk_FACT_RELATIONSHIP_domain_concept_id_2 FOREIGN KEY (domain_concept_id_2) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE FACT_RELATIONSHIP ADD CONSTRAINT fpk_FACT_RELATIONSHIP_relationship_concept_id FOREIGN KEY (relationship_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE LOCATION ADD CONSTRAINT fpk_LOCATION_country_concept_id FOREIGN KEY (country_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CARE_SITE ADD CONSTRAINT fpk_CARE_SITE_place_of_service_concept_id FOREIGN KEY (place_of_service_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CARE_SITE ADD CONSTRAINT fpk_CARE_SITE_location_id FOREIGN KEY (location_id) REFERENCES LOCATION (LOCATION_ID);

ALTER TABLE PROVIDER ADD CONSTRAINT fpk_PROVIDER_specialty_concept_id FOREIGN KEY (specialty_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PROVIDER ADD CONSTRAINT fpk_PROVIDER_care_site_id FOREIGN KEY (care_site_id) REFERENCES CARE_SITE (CARE_SITE_ID);

ALTER TABLE PROVIDER ADD CONSTRAINT fpk_PROVIDER_gender_concept_id FOREIGN KEY (gender_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PROVIDER ADD CONSTRAINT fpk_PROVIDER_specialty_source_concept_id FOREIGN KEY (specialty_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PROVIDER ADD CONSTRAINT fpk_PROVIDER_gender_source_concept_id FOREIGN KEY (gender_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_payer_concept_id FOREIGN KEY (payer_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_payer_source_concept_id FOREIGN KEY (payer_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_plan_concept_id FOREIGN KEY (plan_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_plan_source_concept_id FOREIGN KEY (plan_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_sponsor_concept_id FOREIGN KEY (sponsor_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_sponsor_source_concept_id FOREIGN KEY (sponsor_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_stop_reason_concept_id FOREIGN KEY (stop_reason_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_stop_reason_source_concept_id FOREIGN KEY (stop_reason_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE COST ADD CONSTRAINT fpk_COST_cost_domain_id FOREIGN KEY (cost_domain_id) REFERENCES DOMAIN (DOMAIN_ID);

ALTER TABLE COST ADD CONSTRAINT fpk_COST_cost_type_concept_id FOREIGN KEY (cost_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE COST ADD CONSTRAINT fpk_COST_currency_concept_id FOREIGN KEY (currency_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE COST ADD CONSTRAINT fpk_COST_revenue_code_concept_id FOREIGN KEY (revenue_code_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE COST ADD CONSTRAINT fpk_COST_drg_concept_id FOREIGN KEY (drg_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DRUG_ERA ADD CONSTRAINT fpk_DRUG_ERA_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE DRUG_ERA ADD CONSTRAINT fpk_DRUG_ERA_drug_concept_id FOREIGN KEY (drug_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DOSE_ERA ADD CONSTRAINT fpk_DOSE_ERA_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE DOSE_ERA ADD CONSTRAINT fpk_DOSE_ERA_drug_concept_id FOREIGN KEY (drug_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DOSE_ERA ADD CONSTRAINT fpk_DOSE_ERA_unit_concept_id FOREIGN KEY (unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CONDITION_ERA ADD CONSTRAINT fpk_CONDITION_ERA_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE CONDITION_ERA ADD CONSTRAINT fpk_CONDITION_ERA_condition_concept_id FOREIGN KEY (condition_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE EPISODE ADD CONSTRAINT fpk_EPISODE_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);

ALTER TABLE EPISODE ADD CONSTRAINT fpk_EPISODE_episode_concept_id FOREIGN KEY (episode_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE EPISODE ADD CONSTRAINT fpk_EPISODE_episode_object_concept_id FOREIGN KEY (episode_object_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE EPISODE ADD CONSTRAINT fpk_EPISODE_episode_type_concept_id FOREIGN KEY (episode_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE EPISODE ADD CONSTRAINT fpk_EPISODE_episode_source_concept_id FOREIGN KEY (episode_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE EPISODE_EVENT ADD CONSTRAINT fpk_EPISODE_EVENT_episode_id FOREIGN KEY (episode_id) REFERENCES EPISODE (EPISODE_ID);

ALTER TABLE EPISODE_EVENT ADD CONSTRAINT fpk_EPISODE_EVENT_episode_event_field_concept_id FOREIGN KEY (episode_event_field_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE METADATA ADD CONSTRAINT fpk_METADATA_metadata_concept_id FOREIGN KEY (metadata_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE METADATA ADD CONSTRAINT fpk_METADATA_metadata_type_concept_id FOREIGN KEY (metadata_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE METADATA ADD CONSTRAINT fpk_METADATA_value_as_concept_id FOREIGN KEY (value_as_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CDM_SOURCE ADD CONSTRAINT fpk_CDM_SOURCE_cdm_version_concept_id FOREIGN KEY (cdm_version_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CONCEPT ADD CONSTRAINT fpk_CONCEPT_domain_id FOREIGN KEY (domain_id) REFERENCES DOMAIN (DOMAIN_ID);

ALTER TABLE CONCEPT ADD CONSTRAINT fpk_CONCEPT_vocabulary_id FOREIGN KEY (vocabulary_id) REFERENCES VOCABULARY (VOCABULARY_ID);

ALTER TABLE CONCEPT ADD CONSTRAINT fpk_CONCEPT_concept_class_id FOREIGN KEY (concept_class_id) REFERENCES CONCEPT_CLASS (CONCEPT_CLASS_ID);

ALTER TABLE VOCABULARY ADD CONSTRAINT fpk_VOCABULARY_vocabulary_concept_id FOREIGN KEY (vocabulary_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DOMAIN ADD CONSTRAINT fpk_DOMAIN_domain_concept_id FOREIGN KEY (domain_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CONCEPT_CLASS ADD CONSTRAINT fpk_CONCEPT_CLASS_concept_class_concept_id FOREIGN KEY (concept_class_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CONCEPT_RELATIONSHIP ADD CONSTRAINT fpk_CONCEPT_RELATIONSHIP_concept_id_1 FOREIGN KEY (concept_id_1) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CONCEPT_RELATIONSHIP ADD CONSTRAINT fpk_CONCEPT_RELATIONSHIP_concept_id_2 FOREIGN KEY (concept_id_2) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CONCEPT_RELATIONSHIP ADD CONSTRAINT fpk_CONCEPT_RELATIONSHIP_relationship_id FOREIGN KEY (relationship_id) REFERENCES RELATIONSHIP (RELATIONSHIP_ID);

ALTER TABLE RELATIONSHIP ADD CONSTRAINT fpk_RELATIONSHIP_relationship_concept_id FOREIGN KEY (relationship_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CONCEPT_SYNONYM ADD CONSTRAINT fpk_CONCEPT_SYNONYM_concept_id FOREIGN KEY (concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CONCEPT_SYNONYM ADD CONSTRAINT fpk_CONCEPT_SYNONYM_language_concept_id FOREIGN KEY (language_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CONCEPT_ANCESTOR ADD CONSTRAINT fpk_CONCEPT_ANCESTOR_ancestor_concept_id FOREIGN KEY (ancestor_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE CONCEPT_ANCESTOR ADD CONSTRAINT fpk_CONCEPT_ANCESTOR_descendant_concept_id FOREIGN KEY (descendant_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE SOURCE_TO_CONCEPT_MAP ADD CONSTRAINT fpk_SOURCE_TO_CONCEPT_MAP_source_concept_id FOREIGN KEY (source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE SOURCE_TO_CONCEPT_MAP ADD CONSTRAINT fpk_SOURCE_TO_CONCEPT_MAP_target_concept_id FOREIGN KEY (target_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE SOURCE_TO_CONCEPT_MAP ADD CONSTRAINT fpk_SOURCE_TO_CONCEPT_MAP_target_vocabulary_id FOREIGN KEY (target_vocabulary_id) REFERENCES VOCABULARY (VOCABULARY_ID);

ALTER TABLE DRUG_STRENGTH ADD CONSTRAINT fpk_DRUG_STRENGTH_drug_concept_id FOREIGN KEY (drug_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DRUG_STRENGTH ADD CONSTRAINT fpk_DRUG_STRENGTH_ingredient_concept_id FOREIGN KEY (ingredient_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DRUG_STRENGTH ADD CONSTRAINT fpk_DRUG_STRENGTH_amount_unit_concept_id FOREIGN KEY (amount_unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DRUG_STRENGTH ADD CONSTRAINT fpk_DRUG_STRENGTH_numerator_unit_concept_id FOREIGN KEY (numerator_unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE DRUG_STRENGTH ADD CONSTRAINT fpk_DRUG_STRENGTH_denominator_unit_concept_id FOREIGN KEY (denominator_unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE COHORT_DEFINITION ADD CONSTRAINT fpk_COHORT_DEFINITION_definition_type_concept_id FOREIGN KEY (definition_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);

ALTER TABLE COHORT_DEFINITION ADD CONSTRAINT fpk_COHORT_DEFINITION_subject_concept_id FOREIGN KEY (subject_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
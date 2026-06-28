-- Vainqueur pronostiqué en cas de nul (phases finales à élimination directe)

ALTER TABLE PORTAIL_CLUB_cdm_predictions
  ADD COLUMN pred_winner VARCHAR(3) NULL DEFAULT NULL
  AFTER pred_away;

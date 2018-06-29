* Encoding: UTF-8.
GET
  FILE='C:\Praxisprojekt\TestSPSS.sav'.
DATASET NAME DataSet1 WINDOW=FRONT.

SELECT IF  time_diff >  100 OR time_diff < 0. 
TEMPORARY.
SELECT IF time_diff >  100 AND  runid1 = 'run_1'.
AGGREGATE  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /mean_run1 = mean(time_diff).

TEMPORARY.
SELECT IF time_diff >  100 AND runid1 EQ 'run_1'.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /sd_run1 = SD(time_diff).

TEMPORARY.
SELECT IF time_diff >  100 AND  runid1 EQ 'run_2'.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /mean_run2 = MEAN(time_diff).

TEMPORARY.
SELECT IF time_diff > 100 AND runid1 eq 'run_2'.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /sd_run2 = SD(time_diff).

TEMPORARY.
SELECT IF  time_diff > 100  AND seperateAttention1 NE 3 AND runid1 EQ 'run_3'.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
 /BREAK subject1
 /mean_run3selective = MEAN(time_diff).

TEMPORARY.
SELECT IF time_diff > 100  AND seperateAttention1 NE 3 and runid1 EQ 'run_3'.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /sd_run3selective = SD(time_diff).

TEMPORARY.
SELECT IF  time_diff > 100  AND seperateAttention1 = 3 AND runid1 EQ 'run_3'.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /mean_run3divided = MEAN(time_diff).

TEMPORARY.
SELECT IF time_diff > 100  AND seperateAttention1 = 3 and runid1 EQ 'run_3'.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /sd_run3divided = SD(time_diff).

select if (runid1 = 'run_1' AND time_diff > mean_run1 - 2 *sd_run1 AND time_diff < mean_run1 + 2 *sd_run1)
OR          (runid1 = 'run_2' AND time_diff > mean_run2 - 2 *sd_run2 AND time_diff < mean_run2 + 2 *sd_run2)
OR          (runid1 = 'run_3' AND seperateAttention1 NE 3 AND time_diff > mean_run3selective - 2 *sd_run3selective AND time_diff < mean_run3selective + 2 *sd_run3selective)
OR          (runid1 = 'run_3' AND seperateAttention1 EQ 3 AND time_diff > mean_run3divided - 2 *sd_run3divided AND time_diff < mean_run3divided + 2 *sd_run3divided)
OR          (time_diff < 0).

TEMPORARY.
SELECT IF runid1 = 'run_1' AND time_diff > 0.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /mean_run1cleaned = MEAN(time_diff).

TEMPORARY.
SELECT IF runid1 = 'run_2' AND time_diff > 0.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /mean_run2cleaned = MEAN(time_diff).

TEMPORARY.
SELECT IF runid1 = 'run_3' AND seperateAttention1 NE 3 AND time_diff > 0.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /mean_run3selectiveCleaned = MEAN(time_diff).

TEMPORARY.
SELECT IF runid1 = 'run_3' AND seperateAttention1 = 3 AND time_diff > 0.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /mean_run3dividedCleaned = MEAN(time_diff).


TEMPORARY.
SELECT IF runid1 = 'run_1' AND time_diff > 0.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /sd_run1cleaned = SD(time_diff).

TEMPORARY.
SELECT IF runid1 = 'run_2' AND time_diff > 0.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /sd_run2cleaned = SD(time_diff).

TEMPORARY.
SELECT IF runid1 = 'run_3' AND seperateAttention1 NE 3 AND time_diff > 0.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /sd_run3selectiveCleaned = SD(time_diff).

TEMPORARY.
SELECT IF runid1 = 'run_3' AND seperateAttention1 = 3 AND time_diff > 0.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /sd_run3dividedCleaned = SD(time_diff).

TEMPORARY.
SELECT IF runid1 = 'run_1' AND rm_type EQ 'rm_hit'.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /correct_run1= NU(rm_type).

TEMPORARY.
SELECT IF runid1 = 'run_1' AND (rm_type EQ 'rm_miss' OR rm_type EQ 'rm_false_alarm' OR rm_type EQ 'rm_incorrect').
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /error_run1= NU(rm_type).

TEMPORARY.
SELECT IF runid1 = 'run_2' AND rm_type EQ 'rm_hit'.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /correct_run2= NU(rm_type).

TEMPORARY.
SELECT IF runid1 = 'run_2' AND (rm_type EQ 'rm_miss' OR rm_type EQ 'rm_false_alarm' OR rm_type EQ 'rm_incorrect').
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /error_run2= NU(rm_type).

TEMPORARY.
SELECT IF runid1 = 'run_3' AND seperateAttention1 NE 3 AND rm_type EQ 'rm_hit'.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /correct_run3selective= NU(rm_type).

TEMPORARY.
SELECT IF runid1 = 'run_1' AND seperateAttention1 NE 3 AND (rm_type EQ 'rm_miss' OR rm_type EQ 'rm_false_alarm' OR rm_type EQ 'rm_incorrect').
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /error_run3selective= NU(rm_type).

TEMPORARY.
SELECT IF runid1 = 'run_3' AND seperateAttention1 EQ 3 AND rm_type EQ 'rm_hit'.
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /correct_run3divided= NU(rm_type).

TEMPORARY.
SELECT IF runid1 = 'run_3' AND seperateAttention1 EQ 3 AND (rm_type EQ 'rm_miss' OR rm_type EQ 'rm_false_alarm' OR rm_type EQ 'rm_incorrect').
AGGREGATE /OUTFILE=* MODE=ADDVARIABLES
  /BREAK subject1
  /error_run3divided= NU(rm_type).


DATASET ACTIVATE DataSet1.
AGGREGATE
  OUTFILE = 'C:\Praxisprojekt\aggr.sav'
  /BREAK=subject1
  /mean_run1=MEAN(mean_run1) 
  /mean_run1cleaned=MEAN(mean_run1cleaned) 
  /sd_run1=MEAN(sd_run1) 
  /sd_run1cleaned=MEAN(sd_run1cleaned) 
  /correct_run1=MEAN(correct_run1) 
  /error_run1=MEAN(error_run1) 
  /mean_run2=MEAN(mean_run2) 
  /mean_run2cleaned=MEAN(mean_run2cleaned) 
  /sd_run2=MEAN(sd_run2) 
  /sd_run2cleaned=MEAN(sd_run2cleaned) 
  /correct_run2=MEAN(correct_run2) 
  /error_run2=MEAN(error_run2) 
  /mean_run3selective=MEAN(mean_run3selective) 
  /mean_run3selectiveCleaned=MEAN(mean_run3selectiveCleaned) 
  /sd_run3selective=MEAN(sd_run3selective) 
  /sd_run3selectiveCleaned=MEAN(sd_run3selectiveCleaned) 
  /correct_run3selective=MEAN(correct_run3selective) 
  /error_run3selective=MEAN(error_run3selective) 
  /mean_run3divided=MEAN(mean_run3divided) 
  /mean_run3dividedCleaned=MEAN(mean_run3dividedCleaned)
  /sd_run3divided=MEAN(sd_run3divided) 
  /sd_run3dividedCleaned=MEAN(sd_run3dividedCleaned) 
  /correct_run3divided=MEAN(correct_run3divided) 
  /error_run3divided=MEAN(error_run3divided).

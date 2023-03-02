/* Generated Code (IMPORT) */
/* Source File: SAS_Data.xlsx */
/* Source Path: /home/u60812288 */
/* Code generated on: 3/02/23, 04:57 PM */

%web_drop_table(WORK.IMPORT);

FILENAME REFFILE '/home/u60812288/SAS_Data.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

/*See Contents*/
PROC CONTENTS DATA=WORK.IMPORT; RUN;

/*Summary Statistics*/
PROC MEANS DATA=WORK.IMPORT CHARTYPE N MEAN MAX MIN RANGE STD FW=5;
	VAR Age	Sex	BMI_Categories	YearsOfEducation	SocialStatus_Categories	Residence_Categories	Employment_Categories	VO2_mL_Kg_Min_1	VO2_mL_Kg_Min_2	RestHR	MaxHR;
	TITLE 'BASELINE CHARACTERISTICS';
RUN;

/*Summary Statistics By Category*/
PROC MEANS DATA=WORK.IMPORT CHARTYPE N MEAN MAX MIN RANGE STD FW=5;
	VAR Age	Sex	BMI_Categories	YearsOfEducation	SocialStatus_Categories	Residence_Categories	Employment_Categories	VO2_mL_Kg_Min_1	VO2_mL_Kg_Min_2	RestHR	MaxHR;
	CLASS Fitness_Categories;
	TITLE 'BASELINE CHARACTERISTICS';
RUN;

/*Distribution Analysis*/
PROC UNIVARIATE DATA=WORK.IMPORT;
	VAR Age	Sex	BMI_Categories VO2_mL_Kg_Min_1 Fitness_Categories;
	HISTOGRAM Age	Sex	BMI_Categories VO2_mL_Kg_Min_1 Fitness_Categories;
RUN;

/*One-way Frequencies*/
PROC FREQ DATA=WORK.IMPORT;
	TABLES Age Fitness_Categories / PLOTS=(FREQPLOT CUMFREQPLOT);
RUN;

/*Correlation Analysis*/
PROC CORR DATA=WORK.IMPORT PEARSON SPEARMAN;
	VAR Age VO2_mL_Kg_Min_1;
RUN;

/*Paired t-test*/
PROC TTEST DATA=WORK.IMPORT;
	PAIRED VO2_mL_Kg_Min_1*VO2_mL_Kg_Min_2;
RUN;

/*Parametric One-way ANOVA*/
PROC GLM DATA=WORK.IMPORT;
	MODEL Fitness_Categories=Age;
RUN;

/*Non-parametric One-way ANOVA*/
PROC NPAR1WAY DATA=WORK.IMPORT;
	CLASS Fitness_Categories;
    VAR Age;
RUN;

/* Linear Regression */
PROC REG DATA=WORK.IMPORT;
	MODEL MaxHR=Age;
RUN;

PROC REG DATA=WORK.IMPORT;
	MODEL MaxHR=BMI_Categories;
RUN;

/* Linear Regression - stepwise */
PROC GLMSELECT DATA=WORK.IMPORT;
	MODEL MaxHR=Age BMI_Categories / selection=stepwise (select=sl slentry=.50 slstay=0.10) showpvalues;
RUN;

PROC GLMSELECT DATA=WORK.IMPORT;
	MODEL MaxHR=Age Sex BMI_Categories YearsOfEducation SocialStatus_Categories Residence_Categories Employment_Categories VO2_mL_Kg_Min_1 VO2_mL_Kg_Min_2 RestHR / selection=stepwise (select=sl slentry=0.50 slstay=0.30) showpvalues;
RUN;

%web_open_table(WORK.IMPORT);






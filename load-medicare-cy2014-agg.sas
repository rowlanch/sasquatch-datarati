
filename medicare ZIP 'C:\sasquatch-data\Medicare_Physician_and_Other_Supplier_NPI_Aggregate_CY2014.zip';

DATA project.MedicareAgg2014;
	LENGTH
		npi              					$ 10
		nppes_provider_last_org_name 		$ 70
		nppes_provider_first_name 			$ 20
		nppes_provider_mi					$ 1
		nppes_credentials 					$ 20
		nppes_provider_gender				$ 1
		nppes_entity_code 					$ 1
		nppes_provider_street1 				$ 55
		nppes_provider_street2				$ 55
		nppes_provider_city 				$ 40
		nppes_provider_zip 					$ 20
		nppes_provider_state				$ 2
		nppes_provider_country				$ 2
		provider_type 						$ 43
		medicare_participation_indicator 	$ 1
        number_of_hcpcs 					8
		total_services 						8
		total_unique_benes 					8
		total_submitted_chrg_amt 			8
		total_medicare_allowed_amt 			8
		total_medicare_payment_amt 			8
		total_medicare_stnd_amt				8
        drug_suppress_indicator 			$ 1
		number_of_drug_hcpcs 				8
		total_drug_services 				8
		total_drug_unique_benes 			8
        total_drug_submitted_chrg_amt 		8
		total_drug_medicare_allowed_amt 	8
		total_drug_medicare_payment_amt 	8
        total_drug_medicare_stnd_amt 		8
		med_suppress_indicator 				$ 1
		number_of_med_hcpcs 				8
		total_med_services 					8
		total_med_unique_benes 				8
		total_med_submitted_chrg_amt 		8
		total_med_medicare_allowed_amt 		8
		total_med_medicare_payment_amt 		8
		total_med_medicare_stnd_amt 		8
		beneficiary_average_age				8
		beneficiary_age_less_65_count 		8
		beneficiary_age_65_74_count 		8
		beneficiary_age_75_84_count			8
		beneficiary_age_greater_84_count 	8
		beneficiary_female_count 			8
		beneficiary_male_count				8
		beneficiary_race_white_count 		8
		beneficiary_race_black_count 		8
		beneficiary_race_api_count			8
		beneficiary_race_hispanic_count 	8
		beneficiary_race_natind_count 		8
		beneficiary_race_other_count		8
		beneficiary_nondual_count 			8
		beneficiary_dual_count 				8
		beneficiary_cc_afib_percent			8
		beneficiary_cc_alzrdsd_percent 		8
		beneficiary_cc_asthma_percent 		8
		beneficiary_cc_cancer_percent		8
		beneficiary_cc_chf_percent 			8
		beneficiary_cc_ckd_percent 			8
		beneficiary_cc_copd_percent			8
		beneficiary_cc_depr_percent 		8
		beneficiary_cc_diab_percent 		8
		beneficiary_cc_hyperl_percent		8
		beneficiary_cc_hypert_percent 		8
		beneficiary_cc_ihd_percent 			8
		beneficiary_cc_ost_percent			8
		beneficiary_cc_raoa_percent 		8
		beneficiary_cc_schiot_percent 		8
		beneficiary_cc_strk_percent			8
		beneficiary_average_risk_score		8;
	INFILE medicare (Medicare_Physician_and_Other_Supplier_NPI_Aggregate_CY2014.txt)

		lrecl=32767
		dlm='09'x
		pad missover
		firstobs = 2
		dsd;

	INPUT
		npi             
		nppes_provider_last_org_name 
		nppes_provider_first_name 
		nppes_provider_mi 
		nppes_credentials 
		nppes_provider_gender 
		nppes_entity_code 
		nppes_provider_street1 
		nppes_provider_street2 
		nppes_provider_city 
		nppes_provider_zip 
		nppes_provider_state 
		nppes_provider_country 
		provider_type 
		medicare_participation_indicator 
		number_of_hcpcs
		total_services
		total_unique_benes
		total_submitted_chrg_amt
		total_medicare_allowed_amt
		total_medicare_payment_amt
		total_medicare_stnd_amt
		drug_suppress_indicator
		number_of_drug_hcpcs
		total_drug_services
		total_drug_unique_benes
		total_drug_submitted_chrg_amt
		total_drug_medicare_allowed_amt
		total_drug_medicare_payment_amt
		total_drug_medicare_stnd_amt
		med_suppress_indicator
		number_of_med_hcpcs
		total_med_services
		total_med_unique_benes
		total_med_submitted_chrg_amt
		total_med_medicare_allowed_amt
		total_med_medicare_payment_amt
		total_med_medicare_stnd_amt
		beneficiary_average_age
		beneficiary_age_less_65_count
		beneficiary_age_65_74_count
		beneficiary_age_75_84_count
		beneficiary_age_greater_84_count
		beneficiary_female_count
		beneficiary_male_count
		beneficiary_race_white_count
		beneficiary_race_black_count
		beneficiary_race_api_count
		beneficiary_race_hispanic_count
		beneficiary_race_natind_count
		beneficiary_race_other_count
		beneficiary_nondual_count
		beneficiary_dual_count
		beneficiary_cc_afib_percent
		beneficiary_cc_alzrdsd_percent
		beneficiary_cc_asthma_percent
		beneficiary_cc_cancer_percent
		beneficiary_cc_chf_percent
		beneficiary_cc_ckd_percent
		beneficiary_cc_copd_percent
		beneficiary_cc_depr_percent
		beneficiary_cc_diab_percent
		beneficiary_cc_hyperl_percent
		beneficiary_cc_hypert_percent
		beneficiary_cc_ihd_percent
		beneficiary_cc_ost_percent
		beneficiary_cc_raoa_percent
		beneficiary_cc_schiot_percent
		beneficiary_cc_strk_percent
		beneficiary_average_risk_score
		;

	LABEL
		npi     							= "National Provider Identifier"       
		nppes_provider_last_org_name 		= "Last Name/Organization Name of the Provider"
		nppes_provider_first_name 			= "First Name of the Provider"
		nppes_provider_mi					= "Middle Initial of the Provider"
		nppes_credentials 					= "Credentials of the Provider"
		nppes_provider_gender 				= "Gender of the Provider"
		nppes_entity_code 					= "Entity Type of the Provider"
		nppes_provider_street1 				= "Street Address 1 of the Provider"
		nppes_provider_street2 				= "Street Address 2 of the Provider"
		nppes_provider_city 				= "City of the Provider"
		nppes_provider_zip 					= "Zip Code of the Provider"
		nppes_provider_state 				= "State Code of the Provider"
		nppes_provider_country 				= "Country Code of the Provider"
		provider_type	 					= "Provider Type of the Provider"
		medicare_participation_indicator 	= "Medicare Participation Indicator"
		number_of_hcpcs 					="Number of HCPCS"
		total_services 						="Number of Services"
		total_unique_benes 					="Number of Medicare Beneficiaries"
		total_submitted_chrg_amt 			="Total Submitted Charge Amount"
		total_medicare_allowed_amt 			="Total Medicare Allowed Amount"
		total_medicare_payment_amt 			="Total Medicare Payment Amount"
		total_medicare_stnd_amt				="Total Medicare Standardized Payment Amount"
		drug_suppress_indicator 			="Drug Suppress Indicator"
		number_of_drug_hcpcs 				="Number of HCPCS Associated With Drug Services"
		total_drug_services 				="Number of Drug Services"
		total_drug_unique_benes 			="Number of Medicare Beneficiaries With Drug Services"
		total_drug_submitted_chrg_amt 		="Total Drug Submitted Charge Amount"
		total_drug_medicare_allowed_amt 	="Total Drug Medicare Allowed Amount"
		total_drug_medicare_payment_amt 	="Total Drug Medicare Payment Amount"
		total_drug_medicare_stnd_amt 		="Total Drug Medicare Standardized Payment Amount"
		med_suppress_indicator 				="Medical Suppress Indicator"
		number_of_med_hcpcs 				="Number of HCPCS Associated With Medical Services"
		total_med_services 					="Number of Medical Services"
		total_med_unique_benes 				="Number of Medicare Beneficiaries With Medical Services"
		total_med_submitted_chrg_amt 		="Total Medical Submitted Charge Amount"
		total_med_medicare_allowed_amt 		="Total Medical Medicare Allowed Amount"
		total_med_medicare_payment_amt 		="Total Medical Medicare Payment Amount"
		total_med_medicare_stnd_amt 		="Total Medical Medicare Standardized Payment Amount"
		beneficiary_average_age				="Average Age of Beneficiaries"
		beneficiary_age_less_65_count 		="Number of Beneficiaries Age Less 65"
		beneficiary_age_65_74_count 		="Number of Beneficiaries Age 65 to 74"
		beneficiary_age_75_84_count			="Number of Beneficiaries Age 75 to 84"
		beneficiary_age_greater_84_count 	="Number of Beneficiaries Age Greater 84"
		beneficiary_female_count 			="Number of Female Beneficiaries"
		beneficiary_male_count				="Number of Male Beneficiaries"
		beneficiary_race_white_count 		="Number of Non-Hispanic White Beneficiaries"
		beneficiary_race_black_count 		="Number of Black or African American Beneficiaries"
		beneficiary_race_api_count			="Number of Asian Pacific Islander Beneficiaries"
		beneficiary_race_hispanic_count 	="Number of Hispanic Beneficiaries"
		beneficiary_race_natind_count 		="Number of American Indian/Alaska Native Beneficiaries"
		beneficiary_race_other_count		="Number of Beneficiaries With Race Not Elsewhere Classified"
		beneficiary_nondual_count 			="Number of Beneficiaries With Medicare Only Entitlement"
		beneficiary_dual_count 				="Number of Beneficiaries With Medicare & Medicaid Entitlement"
		beneficiary_cc_afib_percent			="Percent (%) of Beneficiaries Identified With Atrial Fibrillation"
		beneficiary_cc_alzrdsd_percent 		="Percent (%) of Beneficiaries Identified With Alzheimer’s Disease or Dementia"
		beneficiary_cc_asthma_percent 		="Percent (%) of Beneficiaries Identified With Asthma"
		beneficiary_cc_cancer_percent		="Percent (%) of Beneficiaries Identified With Cancer"
		beneficiary_cc_chf_percent 			="Percent (%) of Beneficiaries Identified With Heart Failure"
		beneficiary_cc_ckd_percent 			="Percent (%) of Beneficiaries Identified With Chronic Kidney Disease"
		beneficiary_cc_copd_percent			="Percent (%) of Beneficiaries Identified With Chronic Obstructive Pulmonary Disease"
		beneficiary_cc_depr_percent 		="Percent (%) of Beneficiaries Identified With Depression"
		beneficiary_cc_diab_percent 		="Percent (%) of Beneficiaries Identified With Diabetes"
		beneficiary_cc_hyperl_percent		="Percent (%) of Beneficiaries Identified With Hyperlipidemia"
		beneficiary_cc_hypert_percent 		="Percent (%) of Beneficiaries Identified With Hypertension"
		beneficiary_cc_ihd_percent 			="Percent (%) of Beneficiaries Identified With Ischemic Heart Disease"
		beneficiary_cc_ost_percent			="Percent (%) of Beneficiaries Identified With Osteoporosis"
		beneficiary_cc_raoa_percent 		="Percent (%) of Beneficiaries Identified With Rheumatoid Arthritis / Osteoarthritis"
		beneficiary_cc_schiot_percent 		="Percent (%) of Beneficiaries Identified With Schizophrenia / Other Psychotic Disorders"
		beneficiary_cc_strk_percent			="Percent (%) of Beneficiaries Identified With Stroke"
		Beneficiary_Average_Risk_Score		="Average HCC Risk Score of Beneficiaries"

;
RUN;


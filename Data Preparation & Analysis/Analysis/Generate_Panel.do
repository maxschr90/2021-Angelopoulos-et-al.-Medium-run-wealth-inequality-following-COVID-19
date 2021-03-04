/*****************************************************************************************
* GENERATE THE PANEL USED FOR FURTHER ANALYSIS											 *
*****************************************************************************************/
clear 
cls

// assign global macro to refer to Understanding Society data on your drive
global ukhls "D:\OneDrive - University of Glasgow\COVID 19 Project\HWI_WP\Data\Understanding Society (Waves 1-9)\UKDA-6614-stata\stata\stata11_se"
cd "$ukhls"
global data "C:\Users\maxsc\Documents\GitHub\Medium-run wealth inequality following COVID-19 (Angelopoulos et al. 2021)\Data Preparation & Analysis\Data"

//loop through each wave
foreach w in a b c d e f g h i  { // For fewer waves use only the wave prefix of the waves you need to merge
	
	// find the wave number
	local waveno=strpos("abcdefghijklmnopqrstuvwxyz","`w'")
	
	// open the individual level file

	use  pidp `w'_preason `w'_ppno `w'_ppid `w'_jbhas `w'_hiqual_dv `w'_istrtdaty `w'_sppid `w'_intdaty_dv `w'_jbseg_dv `w'_jbnssec*_dv `w'_fimnmisc_dv `w'_fimnnet_dv `w'_fimnsben_dv `w'_fimnpen_dv `w'_fimninvnet_dv `w'_fimnprben_dv `w'_paygu_dv `w'_fimnlabnet_dv `w'_fimnlabgrs_dv `w'_fimngrs_dv `w'_jbstat `w'_jbsat `w'_pno  `w'_sex `w'_jboffy `w'_jbsemp `w'_jbhrs `w'_jbot `w'_paygu_dv `w'_paynu_dv `w'_basrate `w'_age_dv `w'_gor_dv `w'_hidp  `w'_jbsoc00_cc `w'_jbsemp `w'_racel `w'_qfhigh using "$ukhls/ukhls_w`waveno'/`w'_indresp", clear

	merge n:1 `w'_hidp   using "$ukhls/ukhls_w`waveno'/`w'_hhresp"
		
	// drop the wave prefix from all variables
	rename `w'_* *
	
	// create a wave variable
	cap: gen wave=`waveno'
	
	// Create Individual Level Variables and aggregate to HH
	//do CreateHHVars
	// save one file for each wave
	save temp`w', replace
}

// open the file for the first wave (wave a_)
use tempa, clear

// loop through the remaining waves
foreach w in b c d e f g h i  {

	// append the files for the second wave onwards
	append using temp`w'
}

// check how many observations are available from each wave
tab wave

// save the long file
save "$data/Use/longfile.dta", replace

// erase temporary files
foreach w in a b c d e f g h i {
	erase temp`w'.dta
}

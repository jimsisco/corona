*** Settings ***
Library         ../lib/writedata.py
Library           SeleniumLibrary
Library        OperatingSystem
Library         Collections
Library         String



*** Variables ***
${BROWSER}        Chrome
${DELAY}          2
${DCURL}      https://govstatus.egov.com/OR-OHA-COVID-19

${RESULTS_DATE}      xpath://*[@id="collapseCases"]/div/table/thead/tr/th

${POS}     xpath://*[@id="collapseCases"]/div/table/tbody/tr[1]/td[2]/b
${NEG}      xpath://*[@id="collapseCases"]/div/table/tbody/tr[2]/td[2]
${TOTAl_TESTED}     xpath://*[@id="collapseCases"]/div/table/tbody/tr[3]/td[2]
${TOTAL_DEATHS}     xpath://*[@id="collapseCases"]/div/table/tbody/tr[4]/td[2]

${TOTAL_ADMITED}       xpath://*[@id="collapseOne"]/div/table[4]/tbody/tr[1]/td[2]
${TOTAL_NOT_ADMITED}        xpath://*[@id="collapseOne"]/div/table[4]/tbody/tr[2]/td[2]
${TOTAL_NOT_PROVIDED}       xpath://*[@id="collapseOne"]/div/table[4]/tbody/tr[3]/td[2]

${TOTAL_ICU_BEDS}                 xpath://*[@id="collapseOne"]/div/table[5]/tbody/tr[1]/td[2]
${TOTAL_ICU_BEDS_Total}           xpath://*[@id="collapseOne"]/div/table[5]/tbody/tr[1]/td[3]
${TOTAL_NON_ICU_BEDS}             xpath://*[@id="collapseOne"]/div/table[5]/tbody/tr[2]/td[2]
${TOTAL_NON_ICU_BEDS_Total}       xpath://*[@id="collapseOne"]/div/table[5]/tbody/tr[2]/td[3]

${PEDS_ICU_BEDS}     Xpath://*[@id="collapseOne"]/div/table[5]/tbody/tr[3]/td[2]
${PEDS_ICU_BEDS_TOTAL}     Xpath://*[@id="collapseOne"]/div/table[5]/tbody/tr[3]/td[3]

${PEDS_BEDS}        xpath://*[@id="collapseOne"]/div/table[5]/tbody/tr[4]/td[2]
${PEDS_BEDS_TOTAL}     Xpath://*[@id="collapseOne"]/div/table[5]/tbody/tr[4]/td[3]

${TOTAL_VENTS}          xpath://*[@id="collapseOne"]/div/table[5]/tbody/tr[5]/td[2]
${TOTAL_VENTS_TOTAL}          xpath://*[@id="collapseOne"]/div/table[5]/tbody/tr[5]/td[3]

${COVID_ADMITS}     xpath://*[@id="collapseOne"]/div/table[6]/tbody/tr[1]/td[2]
${COVID_ON_VENTS}     xpath://*[@id="collapseOne"]/div/table[6]/tbody/tr[2]/td[2]


*** Keywords ***


#Your need to run "pipenv sync" at a cmd prompt
#robot -d results resource/get_data_results.robot

*** Test Cases ***
Get Data from OHA
    open browser        ${DCURL}        ${BROWSER}      ${DELAY}
    Click Button    xpath://*[@id="prefix-dismissButton"]
    #get date
    ${DATE}      get text        ${RESULTS_DATE}
    ${RESULTSDATE} =        get substring              ${DATE}     6       15
    #get positive tests
    ${TOTALPOSITIVE}    get text        ${POS}
    #get negitive tests
    ${TOTALNEGITIVE}    get text        ${NEG}
    #get total tested
    ${TOTALTESTED}    get text        ${TOTAl_TESTED}
    #get total deaths
    ${TOTALDEATHS}      get text        ${TOTAL_DEATHS}
    #get rid of email dialog
    click element       xpath://*[@id="headingOne"]/h3/button/i
    wait until page contains element        ${TOTAL_ADMITED}
    #get    total admited
    ${TOTALADMITED}      get text        ${TOTAL_ADMITED}
     #get total not admitted
    ${TOTALNOTADMITED}      get text        ${TOTAL_NOT_ADMITED}
    #get provided
    ${TOTALNOTPROVIDED}      get text        ${TOTAL_NOT_PROVIDED}

    #get avaiable ICU beds
    ${TOTALICUBEDS}     get text        ${TOTAL_ICU_BEDS}
    #get TOTAL ICU beds
    ${TOTALICUBEDSTOTAL}     get text        ${TOTAL_ICU_BEDS_TOTAL}

    #get avaiable  non ICU beds
    ${TOTALNONICUBEDS}      get text        ${TOTAL_NON_ICU_BEDS}
    #get total  non ICU beds
    ${TOTALNONICUBEDSTOTAL}      get text        ${TOTAL_NON_ICU_BEDS_TOTAL}

    #peds beds
    ${PEDSBEDS}        get text        ${PEDS_BEDS}
    #peds beds
    ${PEDSBEDSTOTAL}        get text        ${PEDS_BEDS_TOTAL}
    #peds icu beds
    ${PEDSICUBEDS}      Get Text        ${PEDS_ICU_BEDS}
    #peds icu beds
    ${PEDSICUBEDSTOTAL}      Get Text        ${PEDS_ICU_BEDS_TOTAL}


    #get available Vents
    ${TOTALVENTS}       get text        ${TOTAL_VENTS}
    #get covid admits
    ${COVIDADMITS}      Get Text        ${COVID_ADMITS}
    #get covid vents
    ${COVIDONVENTS}      Get Text        ${COVID_ON_VENTS}

    #Create list and store results
    @{RESULTSLIST} =    Create List
    Append To List    ${RESULTSLIST}        ${RESULTSDATE}        ${TOTALPOSITIVE}    ${TOTALNEGITIVE}        ${TOTALTESTED}      ${TOTALDEATHS}        ${TOTALADMITED}       ${TOTALNOTADMITED}       ${TOTALNOTPROVIDED}      ${TOTALICUBEDS}     ${TOTALICUBEDSTOTAL}        ${TOTALNONICUBEDS}      ${TOTALNONICUBEDSTOTAL}     ${PEDSBEDS}     ${PEDSBEDSTOTAL}        ${PEDSICUBEDS}      ${PEDSICUBEDSTOTAL}     ${TOTALVENTS}       ${COVIDADMITS}      ${COVIDONVENTS}

    #make lists viewable in log and report.html
    log    csv = ${RESULTSLIST}
    log to console    csv= ${RESULTSLIST}

    #write to csv via writedata.W File
    w file    ${RESULTSLIST}

    #write to xlsx via writedata.X File
    convert to string    ${RESULTSLIST}
    Log    xksx=${RESULTSLIST}
    log to console    xlsx=${RESULTSLIST}


    x file    ${RESULTSLIST}

[teardown]
    Close Window

*** Settings ***
Documentation  Use this layer to get data from external files
Library    ../lib/writedata.py


*** Keywords ***
Write Results To CSV
    [Arguments]    ${RESULTSLIST}
    ${Data} =  append file      ${RESULTSLIST}

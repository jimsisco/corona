*** Settings ***
Documentation     A test suite foucsed on search for a center
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.

Resource          ../testcases/get_data_kw.robot


*** Test Cases ***
#Your need to run "pipenv sync" at a cmd prompt
#robot -d results resource/get_data_results.robot


Get Data from OHA
    I go to OHA site
    Get Results     ${RESULTSFILEPATH}

[teardown]
    Close Window
    Close Browser
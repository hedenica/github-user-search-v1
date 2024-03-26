*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${APP URL}    http://localhost:3000/
${BROWSER}    headlesschrome

*** Test Cases ***
User Search for Existing User
    # Arrange
    Open Browser To Initial Page
    
    # Act
    Search Username    torvalds
    
    # Assert
    ${page_value}=    Get Text    xpath://*[@id="root"]/div[2]/h1
    ${user_value}=    Get Text    xpath://*[@id="root"]/div[2]/div[1]/div/p[1]
    Should Be Equal    ${page_value}    Look who we found 🔥
    Should Be Equal    ${user_value}    Name: Linus Torvalds
    Capture Page Screenshot    existing_user_capture_{index}.png

    [Teardown]    Close Browser

User Search for Non Existing User
    # Arrange
    Open Browser To Initial Page
    
    # Act
    Search Username    wimpykiddiary
    
    # Assert
    ${page_value}=    Get Text    xpath://*[@id="root"]/div[2]/h2
    Should Be Equal    ${page_value}    Ops, something went wrong 😢
    Capture Page Screenshot    non_existing_user_capture_{index}.png

    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Initial Page
    Open Browser    ${APP URL}    ${BROWSER}
    Title Should Be    Github User Search

Search Username
    [Arguments]    ${username}
    Input Text      username    ${username}
    Click Button    search
    Wait Until Element Is Visible    xpath://button[contains(text(), 'Return')]


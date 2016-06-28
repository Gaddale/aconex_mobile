Feature: Login to Aconex

  Background: Test Data
    Given User Data 'UserA'
      | Fullname     | Username | Projects     | Organization           |
      | Jason Lowder | jlowder  | Emerald Mine | High Rise Architecture |

  Scenario: Successful Login
    Given login with correct username and password
    Then I should be logged into aconex
Feature: Send mail

  Background: Test Data
    Given User Data 'Sender'
      | Fullname     | Username | Projects     | Organization           |
      | Jason Lowder | jlowder  | Emerald Mine | High Rise Architecture |

    Given User Data 'Receiver'
      | Fullname     | Username | Projects     | Organization           |
      | Lewis Miller | lmiller  | Emerald Mine | High Rise Architecture |

    # Test data for mail
    Given Vertical Table 'mail_attributes'
      | To                  | Receiver             |
      | Mail Type           | Variation            |
      | Subject             | Send Mail Test       |
      | Attribute 2         | Budget               |
      | Mail Body           | Automation Test      |


  Scenario: Sending mail
    Given 'Sender' sends a mail with 'mail_attributes'
    Then 'Receiver' should receive the mail with 'mail_attributes'

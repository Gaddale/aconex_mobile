require 'base_page'
require 'appium_lib'

class MailInboxPage < BasePage

  TITLE = 'Inbox'

  def initialize (navigate = false)

    if navigate == true
      wait_for_element_to_be_visible(find(by_id('menu_mail')))
      find(by_id('menu_mail')).click
      wait_for_element_to_be_visible(find(by_id('mail_list_fragment_spnr_mail_box')))
      if  find(by_id('row_simple_spinner_item_tv_title')).text == 'Inbox'
        puts 'Already on Mail Inbox'
      else
        find(by_id('mail_list_fragment_spnr_mail_box')).click
        find("//*[@text='Inbox']").click
      end
    end
    wait_for_element_to_be_visible(find(by_id('mail_list_fragment_spnr_mail_box')))
    (find(by_id('row_simple_spinner_item_tv_title')).text.include? TITLE).should == true
  end

  def search_mail(subject)
    find(by_id('mail_list_fragment_et_super_search')).send_keys subject
    driver.hide_keyboard
    search_button
    wait_for_element_to_be_visible(find(by_id('mail_list_fragment_spnr_mail_box'))) ? (puts "Results visible with search criteria") : (puts "No search results")
    self
  end

  def search_button
    find("//*[@text='Refine']").click
    wait_for_element_to_be_visible(driver.button('Search')) ? find_button_by_text('Search').click : (raise "Search button not visible")
  end

  def open_mail
    wait_for_element_to_be_visible(find(by_id('row_mail_list_tv_mail_subject'))) ? find(by_id('row_mail_list_tv_mail_subject')).click : (raise "No search results found with mail subject")
    wait_for_element_to_be_visible(find(by_id('mail_detail_fragment_tv_mail_result')))
  end

  def verify_received_mail(mail_params)
    mail_params.each do |key, values|
      case key.downcase
        when 'mail type'
          (find(by_id('mail_detail_fragment_tv_mail_type')).text.include? values).should == true
        when 'to'
          (find(by_id('mail_detail_fragment_tv_to')).text.include? values).should == true
        when 'subject'
          (find(by_id('mail_detail_fragment_tv_subject')).text.include? values).should == true
        when 'attribute 2'
          (find(by_id('mail_detail_fragment_tv_arritubute_2')).text.include? values).should == true
        when 'mail body'
          (find(by_id('mail_detail_fragment_tv_message_body')).text.include? values).should == true
      end
    end

  end

end
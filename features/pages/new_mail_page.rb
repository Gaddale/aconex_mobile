require 'base_page'
require 'appium_lib'

class NewMailPage < BasePage

  TITLE = 'New Mail'

  def initialize (navigate = false)

    if navigate == true
      find(by_id('menu_mail')).click
      wait_for_element_to_be_visible(find(by_id('mail_list_fragment_imgbtn_new_mail'))) ? find(by_id('mail_list_fragment_imgbtn_new_mail')).click : (raise "New Mail Page not loaded")
    end
    (find(by_id('new_mail_tv_new_mail')).text.include? TITLE).should == true
  end

  def selectMailTypes
    return find(by_id('new_mail_spnr_type'))
  end

  def selectAttribute1
    return find(by_id('new_mail_spnr_attribute1'))
  end

  def selectAttribute2
    return find(by_id('new_mail_spnr_attribute2'))
  end
  def selectAttribute3
    return find(by_id('new_mail_spnr_attribute3'))
  end

  def select_mail_type(mail_type)
    select_List_view_item(selectMailTypes, mail_type.strip)
  end

  def scroll_to(text)
    text = %("#{text}")
    locator =  "new UiScrollable(new UiSelector().className(\"android.widget.ScrollView\")).getChildByText(new UiSelector().className(\"android.widget.TextView\"), #{text});"
    driver.find_element :uiautomator, locator
  end

  def add_recipients(recipients, type)
    find(by_id('new_mail_ibtn_user_directory_to')).click
    wait_for_element_to_be_visible(find(by_id('row_simple_spinner_item_tv_title')))
    (find(by_id('row_simple_spinner_item_tv_title')).text.include? 'Project Directory').should == true
    recipients.split(',').each do |username|
      search_user(username.strip, type)
    end
    find(by_id('directory_list_fragment_btn_done')).click
    recipients.split(',').each do |username|
      (find(by_id('new_mail_et_to')).text.include? username).should == true
    end
  end

  def search_user(full_name, type)
    raise Exception.new("Invalid full name: #{full_name}. => Must have first name and last name separated by space") unless full_name.include?(" ")
    find(by_id('directory_list_fragment_et_super_search')).send_keys full_name
    driver.hide_keyboard
    begin
      find_by_text full_name
      click_button_recipient_type(type)
    rescue
      find_button_by_text('Search Global Directory').click
      firstname, lastname = full_name.split(' ')
      find(by_id('directory_options_dialog_fragment_et_group_name')).send_keys firstname
      find(by_id('directory_options_dialog_fragment_et_family_name')).send_keys lastname
      driver.find_button_by_text('Search').click
      ele = driver.find_by_text full_name
      ele.text.include? full_name ? click_button_recipient_type(type) : (raise "User is not visible in global directory")
    end
  end

  def click_button_recipient_type(type)
    find_button_by_text(type.capitalize).click
  end

  def compose_mail(mail_params)

    mail_params.each do |key, values|
      case key.downcase
        when 'mail type'
          select_mail_type(values)
        when 'to'
          add_recipients(values, 'To')
        when 'subject'
          fill_in_subject(values)
        when 'attribute 1'
          select_List_view_item(selectAttribute1, values.strip)
        when 'attribute 2'
          select_List_view_item(selectAttribute2, values.strip)
        when 'attribute 3'
          select_List_view_item(selectAttribute3, values.strip)
        when 'mail body'
          set_mail_body(values)
      end
    end
  end

  def fill_in_subject(subject)
    @@subject = subject+'_'+Utils.genRandom(4)
    find(by_id('new_mail_et_subject')).send_keys @@subject
    driver.hide_keyboard
  end

  def set_mail_body(content)
    scroll_to('Message')
    ele = find(by_id('new_mail_et_message'))
    ele.send_keys content
    driver.hide_keyboard
  end

  def send_mail
    find_button_by_text('Send').click
    wait_for_element_to_be_visible(find('android:id/alertTitle')) ? (puts "Mail Sent successfully with Title Aconex") : (raise "Mail Sent with Title not visible")
    (find('android:id/alertTitle').text.include? 'Aconex').should == true
    (find('android:id/message').text.include? 'Mail sent').should == true
    find("//*[@text='OK']").click
    return @@subject
  end

end
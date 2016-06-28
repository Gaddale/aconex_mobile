require 'base_page'
  require 'user'

  class LoginPage < BasePage

    include RSpec::Expectations

    def  initialize
      find("//android.widget.Button[@text='Allow']").click
    end

    def as_mobile(user)
      wait_for_element_to_be_visible(find_button_by_text('Log in')) ? puts('Login Page visible') : (raise 'Login Page not loaded')
      find(by_id('login_activity_et_user_name')).send_keys user.username
      find(by_id('login_activity_et_pass')).send_keys user.password
      setLocation ENV['Location']
      find(by_class('EditText')).clear
      find(by_class('EditText')).send_keys ENV['APP_HOST']
      find_button_by_text('Ok').click
      find_button_by_text('Log in').click
      wait_for_element_to_be_visible(find(by_id('tasks_options_fragment_tv_lbl'))) ? puts("Logged in as #{user.fullname}") : (raise 'Task Page not loaded')
      return TaskPage.new
    end

    def setLocation(location)
      find(by_id('login_activity_tv_select_location')).click
      find("//*[@text='#{location}']").click
    end

  end
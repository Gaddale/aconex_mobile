require 'capybara/dsl'
require 'rspec/expectations'

class BasePage

  include Capybara::DSL
  include RSpec::Expectations

  def by_id(element_id)
    "com.aconex.aconexmobileandroid:id/"+element_id
  end

  def by_class(element_id)
    "android.widget."+element_id
  end

  def currentProject
    return find(by_id('row_project_list_tv_project'))
  end

  def find(args)
    ele = driver.tag(args) if (args.include? 'android.widget') && !(args.include? '//')
    ele = driver.find_element(:xpath, args) if args.include? '//'
    ele = driver.id(args) if args.include? 'android:id'
    return ele
  end

  def driver
    return $driver
  end

  def find_by_text(text)
    text = %("#{text}")
    locator =  "new UiScrollable(new UiSelector().className(\"android.widget.ListView\")).getChildByText(new UiSelector().className(\"android.widget.TextView\"), #{text});"
    driver.find_element :uiautomator, locator
  end

  def find_button_by_text(text)
    text = %("#{text}")
    locator =  "new UiScrollable(new UiSelector().className(\"android.widget.FrameLayout\")).getChildByText(new UiSelector().className(\"android.widget.Button\"), #{text});"
    driver.find_element :uiautomator, locator
  end

  def scroll_to(text)
    text = %("#{text}")
    locator =  "new UiScrollable(new UiSelector().className(\"android.widget.FrameLayout\")).getChildByText(new UiSelector().className(\"android.widget.TextView\"), #{text});"
    driver.find_element :uiautomator, locator
  end

  def switch_project_to(project_name)
    if (currentProject.text == project_name)
      puts "Project already set to #{project_name}"
    else
      currentProject.click
      find("//*[@text=\""+project_name+"\"]").click();
    end
  end


  def select_List_view_item(element, item)
    element.click
    text = %("#{item}")
    locator =  "new UiScrollable(new UiSelector().className(\"android.widget.ListView\")).getChildByText(new UiSelector().className(\"android.widget.TextView\"), #{text});"
    (driver.find_element :uiautomator, locator).click
    begin
      wait_for_element_to_be_visible(find(by_id('common_list_btn_done'))) ? (find(by_id('common_list_btn_done')).click) : (puts "Done button does not exists")
    rescue
      (puts "Done button does not exists")
    end
  end

  def wait_for_element_to_be_visible(ele)
    driver.exists(30) {  return ele }
  end

  def logout
    find("//android.widget.ImageButton[@content-desc='More options']").click
    find("//*[@text='Logout']").click
    wait_for_element_to_be_visible(find_button_by_text('Log in')) ? (puts 'Logged out successfully') : (raise "Not able to logout")
  end

end
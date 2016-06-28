require 'base_page'

class TaskPage < BasePage

  TITLE = 'Tasks'

  def initialize (navigate = false)

    if navigate == true
      find(by_id('menu_task')).click
    end
    (find(by_id('tasks_options_fragment_tv_lbl')).text.include? TITLE).should == true

  end

end


class ProjectDirectory < BasePage

  TITLE = 'Project Directory'

  def initialize (navigate = false)

    if navigate == true
      find(by_id('menu_directory')).click
    end
    (find(by_id('row_simple_spinner_item_tv_title')).text.include? TITLE).should == true
  end

end
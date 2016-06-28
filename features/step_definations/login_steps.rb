Given(/^login with correct username and password$/) do
  visit_mobile TaskPage, @UserA, @UserA.project do |page|
    puts "Hello World"
  end
end

Given(/^I should be logged into aconex$/) do
 # @task = TaskPage.new
end
class User

  # TO DO : Include Asset handling later

  @class_attribute_list = ['fullname', 'username', 'password', 'email', 'projects', 'organization']

  class << self
    attr_reader :class_attribute_list
  end

  # Accept following attributes for a user. Note that project has been handled differently and does not appear here.
  attr_accessor :fullname, :firstname, :lastname, :username, :password, :email, :organization

  def initialize(user_hash)

    expected_attributes = User.class_attribute_list.clone

    user_hash.each do |attribute, value|
      attribute = attribute.downcase
      raise Exception.new("Invalid Attribute for User => #{attribute}") unless User.class_attribute_list.include? attribute

      # if projects value is comma separated list then split it into an array
      if attribute == 'projects'
        self.projects= value.include?(',')? value.split(',').map {|project| project.strip} : Array.new(1, value.strip)
      end

      if attribute.downcase == 'fullname' && value.include?(' ')
        firstname, lastname = value.split(' ').each do |ele| ele.strip end
        instance_eval(%Q{@firstname = "#{firstname}"})
        instance_eval(%Q{@lastname = "#{lastname}"})
      end

      instance_eval(%Q{@#{attribute}= "#{value}"}) unless attribute == 'projects'

      expected_attributes.delete(attribute)
    end

    return if expected_attributes.empty?
    set_defaults(expected_attributes)

  end

  def set_defaults(remaining_attributes)
    defaults_list =['password', 'email', 'projects']
    remaining_attributes.each do |attribute|
      attribute = attribute.downcase
      raise Exception.new("No defaults for User attribute => #{attribute}") unless defaults_list.include? attribute
      instance_eval('@'+"#{attribute}= '#{ENV['password']}'") if attribute == 'password'
      instance_eval('@'+"#{attribute}= 'blackhole@aconex.com'") if attribute == 'email'
      puts "User #{self.fullname} does not belong to any projects" if attribute == 'projects'
    end
  end

  def projects=(projects)
    @projects = projects
  end

  def project(index=1)
    return if @projects.nil?
    raise Exception.new("Only #{@projects.length} projects defined for user. Unable to fetch project no: #{index}") if index> @projects.length
    return @projects[index-1]
  end

end

# Test this class using following
#
#some_hash = {'fullname'=> "Satish O'Leary", 'username' => 'sautade', 'password' => 'ac0n3x72', 'email' => 'sautade@aconex.com', 'organization'=> 'Aconex'}
#satish = User.new(some_hash)
#p satish.project

# run from command line using 'ruby /path/to/cyrus/features/pages/user.rb'
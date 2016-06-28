def login
  @login ||= LoginPage.new
end

def visit_mobile(page_class, user, project, &block)
  on_mobile page_class, user, project, true, &block
end

def on_mobile(page_class, user=nil, project=nil, navigate=nil, &block)

  login.as_mobile(user) unless user.nil?
  login.switch_project_to(project) unless project.nil?

    page = page_class.new navigate
    block.call page
  page
end

def set_instance_var(name, value)
  instance_variable_set '@'+name, value
end

def get_instance_var(var_name)
  instance_variable_get '@'+var_name
end

def add_params_to_hash(hash_name, key, value)
  get_instance_var(hash_name)[key] = value
end
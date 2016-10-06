module SimpleCommander
  def configure(*configuration_opts, &configuration_block)
    configuration_module = Module.new
    configuration_module.extend SimpleCommander::Methods

    configuration_module.class_exec(*configuration_opts, &configuration_block)

    configuration_module.class_exec do
      run!
    end
  end

  module_function :configure
end

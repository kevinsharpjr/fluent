module Fluent
  module WorkflowPaths
    def paths
      @paths
    end

    def paths=(workflow_path)
      @paths = workflow_path
    end
  end

  module Workflow
    
    def self.included(caller)
      Fluent.trace("#{caller.class} #{caller} is using workflows.")
      caller.extend Fluent::WorkflowPaths
      @def_caller = caller
    end
    
    def self.def_caller
      @def_caller
    end
    
  end
end
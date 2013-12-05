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
    extend WorkflowPaths
    
    
  end
end
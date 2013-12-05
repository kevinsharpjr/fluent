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
      caller.extend WorkflowPaths
      @def_caller = caller
    end
    
    def self.def_caller
      @def_caller
    end
    
    # @param definition [Object] definition object using the workflow
    # @param path_name [Hash] the name of the path to be used
    def workflow_for(definition, path_name = {:using => :default})
      path_name[:using] = :default unless path_name[:using]
      
      path_workflow = workflow_path_for(path_name)
      puts "*** Path Workflow: #{path_workflow}"
      
      workflow_goal = work_item_index_for(path_workflow, definition) #- 1
      puts "*** Workflow Goal: #{workflow_goal}"
      
      workflow_start = path_name[:from] ? path_workflow.find_index { |item| item[0] == how[:from]} : 0
      puts "*** Workflow Start: #{workflow_start}"
      
      perform_workflow(path_workflow[workflow_start..workflow_goal])
    end
    
    def workflow_path_for(path_name)
      # Since I am dealing with an array that contains a hash that, in
      # turn, contains an array of arrays, below I need to make sure I
      # index into the array before keying into the hash. That's the
      # purpose of the [0].
      path = Workflow.def_caller.paths[0][path_name[:using]]
      
      # TODO
      # Should raise an error here if the path cannot be established.
      
      path
    end
    
    def work_item_index_for(path_workflow, definition)
      path_workflow.find_index { |item| item[0] == definition }
    end
    
    def perform_workflow(definitions)
      definitions.each do |definition, action, *args|
        active = on(definition)
        
        # TODO
        # Should raise an error if the action is not defined on the
        # reference.
        
        active.send action unless args
        active.send action, *args if args
      end
    end
    
  end
end
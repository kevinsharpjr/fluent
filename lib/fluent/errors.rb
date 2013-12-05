module Fluent
  module Errors
    class NoUrlForDefinition < StandardError; end
    class NoTitleForDefinition < StandardError; end
    class TitleNotMatched < StandardError; end
    class UrlNotMatched < StandardError; end
    class UnableToCreatePlatform < StandardError; end
    class WorkflowPathNotFound < StandardError; end
    class WorkflowActionNotFound < StandardError; end
  end
end
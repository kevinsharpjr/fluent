module Fluent
  module Errors
    class NoUrlForDefinition < StandardError; end
    class NoTitleForDefinition < StandardError; end
    class NoDriverForDefinition < StandardError; end
    class TitleNotMatched < StandardError; end
    class UrlNotMatched < StandardError; end
    class UnableToCreatePlatform < StandardError; end
  end
end
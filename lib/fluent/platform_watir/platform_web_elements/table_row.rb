module Fluent
  module Platforms
    module WatirWebDriver
      module TableRow

        # @return [Fluent::WebElements::Cell]
        def [](index)
          index = find_by_title(index) if index.kind_of?(String)
          return nil unless index && columns >= index + 1
          ::Fluent::WebElements::Cell.new(web_element[index], :platform => :watir_webdriver)
        end

        def columns
          web_element.wd.find_elements(:xpath, cell_xpath).size
        end

        def find_by_title(column_text)
          table = web_element.parent
          table = table.parent if table.tag_name == 'tbody'
          first_row = table[0]
          first_row.cells.find_index {|column| column.text.include? column_text}
        end
        
      end
    end
  end
end
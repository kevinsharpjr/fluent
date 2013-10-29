module Fluent
  module Platforms
    module WatirWebDriver
      module Table

        def [](index)
          index = find_index_by_title(index) if index.kind_of?(String)
          return nil unless index
          initialize_row(web_element[index], :platform => :watir_webdriver)
        end
        
        def rows
          web_element.wd.find_elements(:xpath, row_xpath).size
        end

        def find_index_by_title(row_title)
          web_element.rows.find_index do |row|
            row.cells.any? { |col| col.text.include? row_title }
          end
        end
        
      end
    end
  end
end
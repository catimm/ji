require 'surveyor/helpers/surveyor_helper_methods'
module SurveyorHelper
  include Surveyor::Helpers::SurveyorHelperMethods
     
     def next_section
        # use copy in memory instead of making extra db calls
        @sections.last == @section ? submit_tag(t(@button_title).html_safe, :name => "finish", :class =>"inputButton3") : submit_tag(t('surveyor.next_section').html_safe, :name => "section[#{@sections[@sections.index(@section)+1].id}]")
      end 
end
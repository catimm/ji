require 'surveyor/helpers/surveyor_helper_methods'
module SurveyorHelper
  include Surveyor::Helpers::SurveyorHelperMethods
     def surveyor_includes
        if asset_pipeline_enabled?
          stylesheet_link_tag('surveyor_all') + javascript_include_tag('surveyor_all')
        else
          stylesheet_link_tag('surveyor/reset',
                              'surveyor/jquery-ui-1.10.0.custom',
                              'surveyor/jquery-ui-timepicker-addon',
                              'surveyor/ui.slider.extras',
                              'surveyor/results',
                              'surveyor',
                              'bootstrap-custom') +
          javascript_include_tag('surveyor/jquery-1.9.0',
                                  'surveyor/jquery-ui-1.10.0.custom',
                                  'surveyor/jquery-ui-timepicker-addon',
                                  'surveyor/jquery.selectToUISlider',
                                  'surveyor/jquery.surveyor',
                                  'surveyor/jquery.maskedinput')
        end
      end
     
     def next_section
        # use copy in memory instead of making extra db calls
        @sections.last == @section ? submit_tag(t(@button_title).html_safe, :name => "finish", :class =>"inputButton3") : submit_tag(t('surveyor.next_section').html_safe, :name => "section[#{@sections[@sections.index(@section)+1].id}]")
      end 
end
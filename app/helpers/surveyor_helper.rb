require 'surveyor/helpers/surveyor_helper_methods'
module SurveyorHelper
  include Surveyor::Helpers::SurveyorHelperMethods
     
     def next_section
        # use copy in memory instead of making extra db calls
        @sections.last == @section ? submit_tag(t('surveyor.next').html_safe, :name => "finish", :class =>"btn btn-success inputButton3 toStep3") : submit_tag(t('surveyor.next_section').html_safe, :name => "section[#{@sections[@sections.index(@section)+1].id}]")
     end 
     
     def get_survey(survey_access_code, exploration_user_id)
       surveys = Survey.where(:access_code => survey_access_code).order("survey_version DESC")
      if params[:survey_version].blank?
        @survey = surveys.first
      else
        @survey = surveys.where(:survey_version => params[:survey_version]).first
      end
      @response_set = ResponseSet.
        create(:survey => @survey, :user_id => exploration_user_id) #using exploration_user_id instead of user_id, but exploration_user_id has the user_id
      if (@survey && @response_set)
        @sections = SurveySection.where(survey_id: @response_set.survey_id).includes([:survey, {questions: [{answers: :question}, {question_group: :dependency}, :dependency]}]) 
        @section = @sections.first 
        @survey = @section.survey 
        set_dependents
      end
     end
     
    # @dependents are necessary in case the client does not have javascript enabled 
    # Whether or not javascript is enabled is determined by a hidden field set in the surveyor/edit.html form 
    def set_dependents 
      if session[:surveyor_javascript] && session[:surveyor_javascript] == "enabled" 
        @dependents = [] 
      else 
        @dependents = get_unanswered_dependencies_minus_section_questions 
      end 
    end 
    
    def get_unanswered_dependencies_minus_section_questions 
      @response_set.unanswered_dependencies - @section.questions || [] 
    end 


end
# encoding: UTF-8
# Question#is_mandatory is now false by default. The default_mandatory option allows you to set
#   is_mandatory for all questions in a survey.
survey "Kitchen Sink survey", :default_mandatory => false do

  section "Question 1 of 10" do
    # A label is a question that accepts no answers
    label "These questions are examples of the basic supported input types"

    # A basic question with radio buttons
    question "What is your favorite color?", :pick => :one
    answer "red"
    answer "blue"
    answer "green"
    answer "yellow"
    answer :other
    
  end
  
  section "Question 2 of 10" do

    # A basic question with checkboxes
    # The "question" and "answer" methods may be abbreviated as "q" and "a".
    # Append a reference identifier (a short string used for dependencies and validations) using the "_" underscore.
    # Question reference identifiers must be unique within a survey.
    # Answer reference identifiers must be unique within a question
    q_2 "Choose the colors you don't like", :pick => :any
    a_1 "red"
    a_2 "blue"
    a_3 "green"
    a_4 "yellow"
    a :omit
  
  end
  
  section "Question 3 of 3" do

    # A dependent question, with conditions and rule to logically join them
    # If the conditions, logically joined into the rule, are met, then the question will be shown.
    q_2a "Please explain why you don't like this color?"
    a_1 "explanation", :text, :help_text => "Please give an explanation for each color you don't like"
    dependency :rule => "A or B or C or D"
    condition_A :q_2, "==", :a_1
    condition_B :q_2, "==", :a_2
    condition_C :q_2, "==", :a_3
    condition_D :q_2, "==", :a_4
    
  end
end
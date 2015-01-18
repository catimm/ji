# The data-attribute having underscores is non-standard. 
# The default for HAML 4.0+ is dashes. To get the underscores, add the following line:

Haml::Template.options[:hyphenate_data_attrs] = false  
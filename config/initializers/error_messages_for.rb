module ActionView 
  module Helpers
    module ActiveRecordHelper 
      def error_messages_for(*params)
        options = params.extract_options!.symbolize_keys
        objects = params.collect {|name| instance_variable_get("@#{name}") }

        error_messages = objects.map {|o| o.errors.full_messages} 
        unless error_messages.flatten!.empty?
          if options[:partial]
            render :partial => options[:partial],
                    :locals => {:errors => error_messages}
          else
            header = "Whoops! Please correct the following errors:" 
            error_list = error_messages.map {|m| content_tag(:li, m)} 
            contents = '' 
            contents << content_tag(:h2, header)
            contents << content_tag(:ul, error_list) 
            content_tag(:div, contents,
                        :class => 'errorExplanation',
                        :id    => 'errorExplanation')
          end #if options[:partial] 
        else
          ''
        end #unless error_messages.flatten!.empty? 
      end # def error_messages_for(*params)
    end # module ActiveRecordHelper 
  end #  module Helpers  
end # module ActionView 
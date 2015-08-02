module ApplicationHelper
	def link_to_add_fields(name, f, association)
		new_object = f.object.class.reflect_on_association(association).klass.new
		build = "build_"
		if (new_object.is_a? AuthorBook)
			build += "author"
		else (new_object.is_a? BookCourse)
			build += "course"
		end

		new_object.send(build)
		fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
			render(association.to_s.singularize + "_fields", :f => builder)
		end
	    link_to(name, "#", "data-association" => "#{association}" , "data-content" => "#{fields}", :class => "hidden_fields_link", hidden: true )
	end
end

module ApplicationHelper
	def link_to_add_fields(name, f, association)
		new_object = f.object.class.reflect_on_association(association).klass.new
		fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
			render(association.to_s.singularize + "_fields", :f => builder)
		end
	    link_to(name, "#", "data-association" => "#{association}" , "data-content" => "#{fields}", :class => "hidden_fields_link", hidden: true )
	end

	BOOTSTRAP_FLASH_MSG = {
		success: 'alert-success',
		error: 'alert-error',
		alert: 'alert-block',
		notice: 'alert-info'
	}

	def bootstrap_class_for(flash_type)
		BOOTSTRAP_FLASH_MSG.fetch(flash_type, flash_type.to_s)
	end
end

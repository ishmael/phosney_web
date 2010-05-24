module CategoriesHelper
	def nodes(parent_category)
	  ret = ''
	  
    if  (parent_category.user_id == @current_user.id)
	  ret += '<li class="moveable button"><div class="categoryname"><div class="categorytext">'+  link_to( parent_category.name,category_path(parent_category.id))+ '</div>'
	  ret +=  link_to image_tag("/images/led-ico/delete.png",:alt =>I18n.t('layout.application.delete')),  category_path(parent_category.id) , {:confirm => I18n.t('layout.application.deletemessage'), :method => :delete ,:class => 'ico' , :title => I18n.t('layout.application.delete')} 
		ret +=  link_to image_tag("/images/led-ico/pencil.png",:alt => I18n.t('layout.application.edit')), edit_category_path(parent_category.id),{:class  =>'ico', :title => I18n.t('layout.application.edit')} 
		ret +=  link_to image_tag("/images/led-ico/arrow_divide.png",:alt => I18n.t('layout.application.share')), new_polymorphic_path([parent_category,:categories_user]),{:class  =>'ico', :title => I18n.t('layout.application.share')} 
	  else
	  ret += '<li class="button"><div class="categoryname"><div class="categorytext">'+  link_to( parent_category.name,category_path(parent_category.id))+ '</div>'
		 end 	  
	  ret +=  '</div>'
	  if  (parent_category.user_id == @current_user.id)
		ret += "<ul id=\"" +parent_category.id.to_s+ "\" class=\"catnestedlist droppable\">"
		  parent_category.children.each do |children|
        ret+= nodes(children)
      end
		ret +='</ul>'
	  end
		ret += '</li>'  
    return ret
	end
end

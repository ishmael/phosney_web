module CategoriesHelper
	def nodes(categories,parent_id)
	  ret = ''
	  tree= categories.select { |item| item.parent_id == parent_id } 
	  tree.sort_by(&:name).each do |categoria|
      if  (categoria.user_id == @current_user.id)
    	  ret += '<li class="moveable droppable "><div class="categoryname button"><div class="categorytext">'+  link_to( categoria.name,category_path(categoria.id))+ '</div>'
    	  ret +=  link_to image_tag("/images/led-ico/delete.png",:alt =>I18n.t('layout.application.delete')),  category_path(categoria.id) , {:confirm => I18n.t('layout.application.deletemessage'), :method => :delete ,:class => 'ico' , :title => I18n.t('layout.application.delete')} 
    		ret +=  link_to image_tag("/images/led-ico/pencil.png",:alt => I18n.t('layout.application.edit')), edit_category_path(categoria.id),{:class  =>'ico', :title => I18n.t('layout.application.edit')} 
    		ret +=  link_to image_tag("/images/led-ico/arrow_divide.png",:alt => I18n.t('layout.application.share')), new_polymorphic_path([categoria,:categories_user]),{:class  =>'ico', :title => I18n.t('layout.application.share')} 
  	  else
    	  ret += '<li><div class="categoryname button"><div class="categorytext">'+  link_to( categoria.name,category_path(categoria.id))+ '</div>'
      end 	  
  	  ret +=  '</div>'
  	  if  (categoria.user_id == @current_user.id)
    		ret += "<ul id=\"" +categoria.id.to_s+ "\" class=\"catnestedlist droppable\">"
  		  ret+= nodes(categories,categoria.id)
    		ret +='</ul>'
  	  end
    		ret += '</li>' 
    end 
    return ret
	end
end

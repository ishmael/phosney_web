module CategoriesHelper
	def nodes(categories,parent_id,index)
	  ret = ''
	  tree= categories.select { |item| item.parent_id == parent_id } 
	  unicos = tree.uniq
	  unicos.sort_by(&:name).each_with_index do |categoria,indice|
	      totais_categoria = categories.select { |cate| cate.id == categoria.id } 
	      totais_hash = Hash.new
	      
	      totais_categoria.each do |total|
	        if totais_hash.has_key?(total.currency)
	          total_linha = totais_hash.fetch(total.currency)
	        else
	          total_linha = Array.new(6,0)
	        end
	          total_linha[0]+= total.month5.to_i
	          total_linha[1]+=total.month4.to_i
	          total_linha[2]+=total.month3.to_i
	          total_linha[3]+=total.month2.to_i
	          total_linha[4]+=total.month1.to_i
	          total_linha[5]+=total.month0.to_i
	          totais_hash[total.currency] = total_linha          	          	          	          	        	      

	      end
	      cssclass = ''
	       if indice== 0 and index==1 
	        cssclass= 'first'
	       else 
	         cssclass=  cycle('even', 'odd',:name=> "categories") 
	      end
	      ret += '<tr class="'+cssclass+'">'
        ret += '<td  style="padding-left:'+(10*index).to_s+'px">'+ categoria.name + '</td>'
            soma_linha = Array.new(6,'')
            totais_hash.each_pair {|key, value|  

                  total_individual = value
                  
                  total_individual.each_with_index do |tot_indiv,i|
                    if key !=nil and tot_indiv != 0
    					        soma_linha[i]+= Money.new(tot_indiv,key).format + '<br>'
    					      else
    					        soma_linha[i]+= '0' + '<br>'
                    end  
    				      end

    				}										
    				soma_linha.each do |soma|
                    ret+='<td class="categoryamount">'  + soma  				
	          				ret+='</td'
	          end
					    ret +='<td>  '
					    if  (categoria.user_id == @current_user.id)		
    						ret +=	'<ul class="actions">'
    						ret +=		'<li>' + link_to( image_tag("/images/led-ico/delete.png",:alt =>I18n.t('layout.application.delete')),  new_category_path , {:confirm => I18n.t('layout.application.deletemessage'), :method => :delete ,:class => 'ico' , :title => I18n.t('layout.application.delete')}) +'</li>'
						    ret +=	'<li>'+ 	link_to(image_tag("/images/led-ico/pencil.png",:alt => I18n.t('layout.application.edit')), new_category_path,{:class  =>'ico', :title => I18n.t('layout.application.edit')}) + '</li>'
						    ret +=	'<li>' +  link_to(image_tag("/images/led-ico/arrow_divide.png",:alt => I18n.t('layout.application.share')), new_category_path,{:class  =>'ico', :title => I18n.t('layout.application.share')}) +'</li>'
             		ret +=	'</ul>'
              end
						ret +='</td>'
					ret +='</tr>'
          ret +=nodes(categories,categoria.id,index+1)
    end
    
    return ret
	end
end

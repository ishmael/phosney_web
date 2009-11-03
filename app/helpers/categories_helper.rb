module CategoriesHelper
def categorynumber
		if not @category.nil?
			@category.pseudo_id
		end
	end
end

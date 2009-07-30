module CategoriesHelper
def categorynumber
		if not @category.nil?
			if @category.id.nil?
			0
			else
			@category.id
			end
		end
	end
end

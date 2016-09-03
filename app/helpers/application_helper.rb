module ApplicationHelper
	def mana_cost_to_icons(mana_cost)
		mana_cost.scan(/\d+/).each do |value|
      mana_cost.gsub!(%r{\{#{value}\}}, '<i class="mi mi-mana mi-shadow mi-'+value+'"></i> ')
    end

    mana_cost.scan(/[a-zA-Z]+/).each do |value|
      mana_cost.gsub!(%r{\{#{value}\}}, '<i class="mi mi-'+value.downcase+' mi-mana mi-shadow"></i> ')
    end
    mana_cost
	end
end

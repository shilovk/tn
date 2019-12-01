# frozen_string_literal: true

# Show attributes with values
module Show
  def show
    hash = instance_variables.each_with_object({}) do |el, memo|
      i_v = instance_variable_get(el)
      memo[el] = i_v.is_a?(Array) ? i_v.map(&:show) : i_v
    end
    {self.class => hash}
  end
end

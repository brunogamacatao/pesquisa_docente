module ApplicationHelper
  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end
  
  def barra_de_progresso(valor_da_barra, valor_do_label = nil)
    valor = number_to_percentage valor_da_barra, :precision => 0
    p = content_tag(:p, (number_with_precision valor_do_label, :precision => 1, :separator => ',')) if valor_do_label
    inner_div = content_tag(:div, p || '', :style => "width: #{valor}", :class => "bar")
    content_tag(:div, inner_div, :class => "progress progress-alert")
  end
end

class BasePresenter
  def initialize(object, template)
    @object = object
    @template = template
  end
  
  def barra_progresso_nota(nota)
    h.barra_de_progresso(nota * 10, nota)
  end
private
  def self.presents(name)
    define_method(name) do
      @object
    end
  end
  
  def h
    @template
  end
  
  def method_missing(*args, &block)
    @template.send(*args, block)
  end
end
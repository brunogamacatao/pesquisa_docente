class Ability
  include CanCan::Ability

  def initialize(usuario)
    usuario ||= Usuario.new
    
    if usuario.coordenador
      can :ver, usuario.coordenador.curso
    else
      Curso.all.each do |curso|
        can :ver, curso
      end
      can :admin, :all
    end
  end
end

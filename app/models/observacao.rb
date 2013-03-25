class Observacao < ActiveRecord::Base
  belongs_to :aluno
  belongs_to :turma
  belongs_to :professor
end

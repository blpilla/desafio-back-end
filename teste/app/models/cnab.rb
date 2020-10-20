class Cnab < ApplicationRecord

  scope :group_by_stores, -> do
    select('cnabs.*, sum(1) as operacoes, printf("%.2f", 
    (
      COALESCE(
        (SELECT 
          sum(c1.valor) 
          from cnabs c1 
          where c1.loja = cnabs.loja and 
                c1.tipo in(1,4,5,6,7,8) 
          group by c1.loja), 
        0) -
      COALESCE(
        (SELECT 
          sum(c2.valor) 
          from cnabs c2 
          where c2.loja = cnabs.loja and 
                c2.tipo in(2,3,9) 
          group by c2.loja),
        0)
      )) as total
    ').group("cnabs.loja")
  end

  def self.list_by_store(id)
    where("loja = (select loja from cnabs where id = #{id})")
  end
 
  validates_presence_of :hora, :loja, message: 'não pode ser deixada em branco.'
  validates :tipo, :cpf, format: { with: /\A\d+\z/, message: "aceita somente valores numéricos." }
  validates_presence_of :tipo, :dono, :cartao, message: 'não pode ser deixado em branco.'
  validates_numericality_of :valor, message: 'deve ser um valor numérico.'

  def dataViewPt
    attributes['data'].strftime("%d/%m/%Y")
  end

  def horaView
    "#{attributes['hora'][0..1]}:#{attributes['hora'][2..3]}:#{attributes['hora'][4..5]}".
    to_time.strftime("%H:%M:%S")
  end

  def valorView
    case attributes['tipo']
      when 2,3,9
        "-#{attributes['valor']}"
      else
        attributes['valor']
    end
  end

  def tipoView
    case attributes['tipo']
      when 1
        "Débito" 
      when 2
        "Boleto"
      when 3
        "Financiamento"
      when 4
        "Crédito"
      when 5
        "Recebimento Empréstimo"
      when 6
        "Vendas"
      when 7
        "Recebimento TED"
      when 8
        "Recebimento DOC"
      when 9
        "Aluguel"
      else
        ""
    end
  end

  def tipoList
    {
      attributes['tipo'].presence || 'Selecione' => attributes['tipo'], 
      'Débito' => 1,
      'Boleto' => 2,
      'Financiamento' => 3,
      'Crédito' => 4,
      'Recebimento Empréstimo' => 5,
      'Vendas' => 6,
      'Recebimento TED' => 7,
      'Recebimento DOC' => 8,
      'Aluguel' => 9
    }
  end

end

# encoding: UTF-8
module BrFormOptionsHelper
  ESTADOS_BRASILEIROS = [%w(Acre AC),
                         %w(Alagoas AL),
                         %w(Amapá AP),
                         %w(Amazonas AM),
                         %w(Bahia BA),
                         %w(Ceará CE),
                         ['Distrito Federal', 'DF'],
                         ["Espírito Santo", 'ES'],
                         %w(Goiás GO),
                         %w(Maranhão MA),
                         ['Mato Grosso', 'MT'],
                         ['Mato Grosso do Sul', 'MS'],
                         ['Minas Gerais', 'MG'],
                         %w(Pará PA),
                         %w(Paraíba PB),
                         %w(Paraná PR),
                         %w(Pernambuco PE),
                         %w(Piauí PI),
                         ['Rio de Janeiro', 'RJ'],
                         ['Rio Grande do Norte', 'RN'],
                         ['Rio Grande do Sul', 'RS'],
                         %w(Rondônia RO),
                         %w(Roraima RR),
                         ['Santa Catarina', 'SC'],
                         ["São Paulo", 'SP'],
                         %w(Sergipe SE),
                         %w(Tocantins TO)].freeze unless const_defined?('ESTADOS_BRASILEIROS')

  # Helper para montar um select para seleção de estados brasileiros por nome,
  # mas com armazenamento da sigla.
  def select_estado(object, method, options = {}, html_options = {})
    select object, method, ESTADOS_BRASILEIROS, options, html_options
  end

  # Helper para montar um select para seleção de estados brasileiros por sigla.
  def select_uf(object, method, options = {}, html_options = {})
    select object, method, ESTADOS_BRASILEIROS.collect { |_estado, sigla| sigla }, options, html_options
  end

  # Retorna uma string com a lista de estados brasileiros para usar em uma tag select,
  # com exibição do nome do estado, mas armazenando a sigla.
  def option_estados_for_select
    options_for_select ESTADOS_BRASILEIROS
  end

  # Retorna uma string com a lista de estados brasileiros para usar em uma tag select,
  # com exibição e armazenamento a sigla.
  def option_uf_for_select
    options_for_select ESTADOS_BRASILEIROS.collect { |_nome, sigla| sigla }
  end

  # Helper para montar um select para seleção de sexo, armazenando apenas a
  # inicial.
  def select_sexo(object, method, options = {}, html_options = {})
    select object, method, [%w(Masculino M), %w(Feminino F)], options, html_options
  end
end

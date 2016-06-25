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

  def select_estado(object, method, options = {}, html_options = {})
    select object, method, ESTADOS_BRASILEIROS, options, html_options
  end

  def select_uf(object, method, options = {}, html_options = {})
    select object, method, ESTADOS_BRASILEIROS.collect { |_estado, sigla| sigla }, options, html_options
  end

  def option_estados_for_select
    options_for_select ESTADOS_BRASILEIROS
  end

  def option_uf_for_select
    options_for_select ESTADOS_BRASILEIROS.collect { |_nome, sigla| sigla }
  end

  def select_sexo(object, method, options = {}, html_options = {})
    select object, method, [%w(Masculino M), %w(Feminino F)], options, html_options
  end
end

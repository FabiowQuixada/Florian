BR_STATES = [%w(Alagoas AL),
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
             %w(Tocantins TO)].freeze

ADMIN_EMAIL = 'ftquixada@gmail.com'.freeze
SYSTEM_EMAIL = (Rails.env == 'showcase' ? 'sistema@florian.com' : 'apoioaoqueimado@yahoo.com.br').freeze

SHOWCASE_USER = 'Visitante'.freeze
SHOWCASE_EMAIL = 'visitante@florian.com'.freeze
SHOWCASE_PASSWORD = 'visitante'.freeze

NUMBER_OF_BILLS = 3
NUMBER_OF_WEEKS = 5

ANALYSIS_EMAIL = (Rails.env == 'production' ? 'edmarmaciel@gmail.com' : 'ftquixada@gmail.com')

DEFAULT_COMPANY_CITY = 'Fortaleza'.freeze
DEFAULT_COMPANY_STATE = 'CE'.freeze

PHONE_FORMAT = /\A(\(\d{2}\))? \d{4}-\d{4}\Z/
CELPHONE_FORMAT = /\A(\(\d{2}\))? (\d )?\d{4}-\d{4}\Z/

ADMIN_ROLE = 'Admin'.freeze
GUEST_ROLE = 'Visitante'.freeze

SAMPLE_RECIPIENTS = 'exemplo@gmail.com,exemplo2@yahoo.com.br'.freeze

NGO_NAME = (Rails.env == 'showcase' ? 'Sirius' : 'IAQ')
NGO_ADDRESS = 'Sirius Ltda.'.freeze
NGO_FULL_NAME = ''.freeze
NGO_HQ_CITY = 'Fortaleza'.freeze

GUEST_USERS_NUMBERS = [1909, 1224, 2043, 2049, 1166, 1890, 1811, 2462, 2321, 1725, 2658, 1538, 1229, 2775, 2685, 2265, 1887, 2808, 1874, 2071].freeze

NGO_BANK = 'Itaú (341)'.freeze
NGO_AGENCY =  (Rails.env == 'showcase' ? '1234' : '8373')
NGO_ACCOUNT = (Rails.env == 'showcase' ? '12345-6' : '14373-7')

SSETTINGS_PSE_TITLE_PREFIX = 'Relatório de Produtos e Serviços - '.freeze
SSETTINGS_PSE_TITLE = SSETTINGS_PSE_TITLE_PREFIX + '#competencia'
SSETTINGS_PSE_BODY = 'Segue em anexo o relatório de produtos e serviços referente a #competencia.'.freeze
SSETTINGS_PSE_BODY_WEEK = 'Segue em anexo o relatório de produtos e serviços referente ao período #competencia.'.freeze
SSETTINGS_RE_TITLE = 'Recibo de Doação ' + NGO_NAME + ' #mantenedora - #competencia'.freeze
SSETTINGS_RE_BODY = 'Prezados, segue em anexo o recibo de doação da #mantenedora, no valor de #valor referente a #competencia.'.freeze

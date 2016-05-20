BR_STATES = [["Alagoas", "AL"],
    ["Amapá", "AP"],
    ["Amazonas", "AM"],
    ["Bahia", "BA"],
    ["Ceará", "CE"],
    ["Distrito Federal", "DF"],
    ["Espírito Santo", "ES"],
    ["Goiás", "GO"],
    ["Maranhão", "MA"],
    ["Mato Grosso", "MT"],
    ["Mato Grosso do Sul", "MS"],
    ["Minas Gerais", "MG"],
    ["Pará", "PA"],
    ["Paraíba", "PB"],
    ["Paraná", "PR"],
    ["Pernambuco", "PE"],
    ["Piauí", "PI"],
    ["Rio de Janeiro", "RJ"],
    ["Rio Grande do Norte", "RN"],
    ["Rio Grande do Sul", "RS"],
    ["Rondônia", "RO"],
    ["Roraima", "RR"],
    ["Santa Catarina", "SC"],
    ["São Paulo", "SP"],
    ["Sergipe", "SE"],
    ["Tocantins", "TO"]]

ADMIN_EMAIL = "ftquixada@gmail.com"
SYSTEM_EMAIL = "apoioaoqueimado@yahoo.com.br"

NUMBER_OF_BILLS = 3
NUMBER_OF_WEEKS = 5

ANALYSIS_EMAIL = (Rails.env == "production" ? "ftquixada@gmail.com" : "ftquixada@gmail.com")

DEFAULT_COMPANY_CITY = "Fortaleza"
DEFAULT_COMPANY_STATE = "CE"

PHONE_FORMAT = /(\(\d{2}\))? \d{4,5}-\d{4}/

ADMIN_ROLE = "Admin"

SSETTINGS_PSE_RECIPIENTS = 'exemplo@gmail.com'
SSETTINGS_PSE_DAY = 1
SSETTINGS_PSE_TITLE = 'Relatório de Produtos e Serviços - ' + '#competencia'.capitalize
SSETTINGS_PSE_BODY = 'Segue em anexo o relatório de produtos e serviços referente a #competencia.'
SSETTINGS_RE_TITLE = 'Recibo de Doação IAQ #mantenedora - ' + '#competencia'.capitalize
SSETTINGS_RE_BODY = 'Prezados, segue em anexo o recibo de doação da #mantenedora, no valor de #valor referente a #competencia.'
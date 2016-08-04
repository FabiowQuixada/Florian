class FlorianDateHelper

  def self.competence_to_date(competence)
    Date.strptime('{ 1, ' + competence[0..1] + ', ' + competence[3, 6] + '}', '{ %d, %m, %Y }')
  end

end

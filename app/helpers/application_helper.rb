module ApplicationHelper
  # Convertir en nombre de jours
  def duration_in_days(start_date, end_date)
    (end_date - start_date).to_i
  end
end

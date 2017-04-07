ForecastIO.configure do |configuration|
  configuration.api_key = Rails.application.secrets.secret_key_forecast_io
end
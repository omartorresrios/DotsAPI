Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "966816232567-2nbdd6sn02nk2cmmtq2m76rg6dg5t83v.apps.googleusercontent.com", "XA1PELDUSxC2CvFWoHVcZGVI"
end